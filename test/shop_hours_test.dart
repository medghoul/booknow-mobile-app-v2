import 'package:booknow_mobile/core/error/api_result.dart';
import 'package:booknow_mobile/core/error/network_exception.dart';
import 'package:booknow_mobile/core/structures/enums/shop_setup_step.dart';
import 'package:booknow_mobile/core/structures/enums/shop_status.dart';
import 'package:booknow_mobile/core/extensions/weekday_extension.dart';
import 'package:booknow_mobile/core/structures/enums/weekday.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/domain/repositories/shop_repository.dart';
import 'package:booknow_mobile/features/shop_setup/cubit/shop_setup_cubit.dart';
import 'package:booknow_mobile/features/shop_setup/widgets/index.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'theme_test.dart' show pumpThemed;

const _morning = TimeRange(from: '09:00', to: '13:00');
const _afternoon = TimeRange(from: '15:00', to: '19:30');
const _allDay = TimeRange(from: '08:30', to: '18:00');

const _week = OpeningHours({
  Weekday.tuesday: [_morning, _afternoon],
  Weekday.saturday: [_allDay],
});

Shop _shopWith(OpeningHours hours) => Shop(
  id: 's',
  status: ShopStatus.active,
  name: 'Barbieri Navona',
  openingHours: hours,
);

class _FakeShopRepository implements ShopRepository {
  _FakeShopRepository({OpeningHours hours = _week, this.failSave = false})
    : _hours = hours;

  final bool failSave;
  OpeningHours _hours;

  int updateCalls = 0;
  OpeningHours? lastHours;

  @override
  Future<ApiResult<Shop?>> getMyShop() async =>
      ApiResult.success(_shopWith(_hours));

  @override
  Future<ApiResult<Shop>> updateShop({
    String? name,
    String? phone,
    String? placeId,
    OpeningHours? openingHours,
    List<String>? closures,
  }) async {
    updateCalls++;
    lastHours = openingHours;

    if (failSave) return const ApiResult.failure(NoInternetConnection());

    if (openingHours != null) _hours = openingHours;
    return ApiResult.success(_shopWith(_hours));
  }

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  final t = AppLocale.en.buildSync();
  final hours = t.shopSetup.hours;

  group('OpeningHours.copyDay', () {
    test('writes the source ranges onto the days chosen', () {
      final next = _week.copyDay(Weekday.tuesday, [
        Weekday.wednesday,
        Weekday.thursday,
      ]);

      expect(next.rangesOn(Weekday.wednesday), [_morning, _afternoon]);
      expect(next.rangesOn(Weekday.thursday), [_morning, _afternoon]);
    });

    test('leaves every other day alone', () {
      final next = _week.copyDay(Weekday.tuesday, [Weekday.wednesday]);

      expect(next.rangesOn(Weekday.saturday), [_allDay]);
      expect(next.isOpenOn(Weekday.monday), isFalse);
    });

    // Choosing a closed day is how an owner opens it.
    test('a closed target opens', () {
      final next = _week.copyDay(Weekday.tuesday, [Weekday.monday]);

      expect(next.isOpenOn(Weekday.monday), isTrue);
    });

    test('the source is never one of its own targets', () {
      final next = _week.copyDay(Weekday.tuesday, Weekday.values);

      expect(next.rangesOn(Weekday.tuesday), [_morning, _afternoon]);
    });

    // "Copy" from a shut day would mean shutting six others.
    test('a closed source copies nothing', () {
      final next = _week.copyDay(Weekday.monday, [Weekday.tuesday]);

      expect(next, _week);
    });
  });

  group('ShopHoursList.summaryOf', () {
    test('two ranges are written out in full', () {
      expect(
        ShopHoursList.summaryOf(const [_morning, _afternoon], t),
        '09:00–13:00 · 15:00–19:30',
      );
    });

    // One range and two look alike at a glance, and the difference is whether
    // the shop shuts for lunch.
    test('one range is just the range', () {
      expect(ShopHoursList.summaryOf(const [_allDay], t), '08:30–18:00');
    });

    test('a closed day has no summary', () {
      expect(ShopHoursList.summaryOf(const [], t), isNull);
    });
  });

  group('saveOpeningHours', () {
    late _FakeShopRepository shops;
    late ShopSetupCubit cubit;

    Future<void> build({bool failSave = false}) async {
      shops = _FakeShopRepository(failSave: failSave);
      cubit = ShopSetupCubit(shops, startAt: ShopSetupStep.hours);
      await cubit.start();
    }

    tearDown(() => cubit.close());

    test('sends the week and says so', () async {
      await build();

      final saved = await cubit.saveOpeningHours(
        _week.setDay(Weekday.monday, const [_allDay]),
      );

      expect(saved, isTrue);
      expect(shops.lastHours?.rangesOn(Weekday.monday), [_allDay]);
      expect(cubit.state.shop?.openingHours.isOpenOn(Weekday.monday), isTrue);
      expect(cubit.state.isSaving, isFalse);
    });

    // This screen is not a step; advancing would drop the owner into publish.
    test('stays where it is instead of advancing a wizard', () async {
      await build();
      await cubit.saveOpeningHours(_week);

      expect(cubit.state.step, ShopSetupStep.hours);
    });

    test('a failure is reported, not swallowed', () async {
      await build(failSave: true);

      final saved = await cubit.saveOpeningHours(_week);

      expect(saved, isFalse);
      expect(cubit.state.failure, isNotNull);
      expect(cubit.state.isSaving, isFalse);
    });

    test('a second save while one is in flight is ignored', () async {
      await build();

      final first = cubit.saveOpeningHours(_week);
      final second = cubit.saveOpeningHours(const OpeningHours());

      expect(await Future.wait([first, second]), [true, false]);
      expect(shops.updateCalls, 1);
    });
  });

  group('ShopHoursList', () {
    late _FakeShopRepository shops;
    late ShopSetupCubit cubit;

    Future<void> pumpList(
      WidgetTester tester, {
      OpeningHours week = _week,
    }) async {
      shops = _FakeShopRepository(hours: week);
      cubit = ShopSetupCubit(shops, startAt: ShopSetupStep.hours);
      await cubit.start();

      await pumpThemed(
        tester,
        BlocProvider.value(value: cubit, child: const ShopHoursList()),
      );
    }

    tearDown(() => cubit.close());

    // The question this screen answers is "when am I open", and a week with
    // days missing cannot answer it.
    testWidgets('lists all seven days', (tester) async {
      await pumpList(tester);

      for (final day in Weekday.values) {
        expect(find.text(day.shortName(t)), findsOneWidget);
      }
    });

    testWidgets('an open day shows its hours', (tester) async {
      await pumpList(tester);

      expect(find.text('09:00–13:00 · 15:00–19:30'), findsOneWidget);
      expect(find.text('08:30–18:00'), findsOneWidget);
    });

    testWidgets('a closed day says so, with a word and not only a colour', (
      tester,
    ) async {
      await pumpList(tester);

      // Monday, Wednesday, Thursday, Friday and Sunday are shut.
      expect(find.text(hours.closed), findsNWidgets(5));
    });

    testWidgets('tapping a day opens its editor', (tester) async {
      await pumpList(tester);

      await tester.tap(find.text(Weekday.tuesday.shortName(t)));
      await tester.pumpAndSettle();

      expect(find.text(Weekday.tuesday.fullName(t)), findsOneWidget);
      expect(find.text(hours.slots), findsOneWidget);
    });
  });

  group('DayHoursSheet', () {
    late _FakeShopRepository shops;
    late ShopSetupCubit cubit;

    Future<void> pumpSheet(
      WidgetTester tester, {
      Weekday day = Weekday.tuesday,
      OpeningHours week = _week,
      bool failSave = false,
    }) async {
      shops = _FakeShopRepository(hours: week, failSave: failSave);
      cubit = ShopSetupCubit(shops, startAt: ShopSetupStep.hours);
      await cubit.start();

      await pumpThemed(
        tester,
        BlocProvider.value(
          value: cubit,
          child: DayHoursSheet(day: day),
        ),
      );
    }

    tearDown(() => cubit.close());

    testWidgets('opens on the day it was given', (tester) async {
      await pumpSheet(tester);

      expect(find.text(Weekday.tuesday.fullName(t)), findsOneWidget);
      expect(find.text('09:00'), findsOneWidget);
      expect(find.text('13:00'), findsOneWidget);
      expect(find.text('15:00'), findsOneWidget);
      expect(find.text('19:30'), findsOneWidget);
    });

    testWidgets('a closed day opens with no slots and nothing to copy', (
      tester,
    ) async {
      await pumpSheet(tester, day: Weekday.monday);

      expect(find.text(hours.slots), findsNothing);
      expect(find.text(hours.copyTo), findsNothing);
      expect(find.text(hours.addSlot), findsNothing);
    });

    testWidgets('the switch opens a day on the usual hours', (tester) async {
      await pumpSheet(tester, day: Weekday.monday);

      await tester.tap(find.byType(AppSwitch));
      await tester.pumpAndSettle();

      expect(find.text(hours.slots), findsOneWidget);
      expect(find.text(TimeRange.defaultDay.first.from), findsOneWidget);
    });

    testWidgets('adding a slot starts where the last one ended', (
      tester,
    ) async {
      await pumpSheet(tester);

      await tester.tap(find.text(hours.addSlot));
      await tester.pumpAndSettle();

      // Two 19:30s now: the second range ends the first one's end.
      expect(find.text('19:30'), findsNWidgets(2));
      expect(find.text('20:30'), findsOneWidget);
    });

    testWidgets('removing a slot drops it', (tester) async {
      await pumpSheet(tester);

      await tester.tap(find.byIcon(Icons.close_rounded).last);
      await tester.pumpAndSettle();

      expect(find.text('15:00'), findsNothing);
      expect(find.text('09:00'), findsOneWidget);
    });

    testWidgets('saving sends the day as it stands', (tester) async {
      await pumpSheet(tester);

      await tester.tap(find.byIcon(Icons.close_rounded).last);
      await tester.pumpAndSettle();
      await tester.tap(find.text(t.common.save));
      await tester.pumpAndSettle();

      expect(shops.lastHours?.rangesOn(Weekday.tuesday), [_morning]);
      // The rest of the week is untouched.
      expect(shops.lastHours?.rangesOn(Weekday.saturday), [_allDay]);
    });

    testWidgets('switching a day off saves it closed', (tester) async {
      await pumpSheet(tester);

      await tester.tap(find.byType(AppSwitch));
      await tester.pumpAndSettle();
      await tester.tap(find.text(t.common.save));
      await tester.pumpAndSettle();

      expect(shops.lastHours?.isOpenOn(Weekday.tuesday), isFalse);
    });

    testWidgets('copying puts the same hours on the days chosen', (
      tester,
    ) async {
      await pumpSheet(tester);

      await tester.tap(find.text(hours.copyTo));
      await tester.pumpAndSettle();
      await tester.tap(find.text(Weekday.wednesday.shortName(t)));
      await tester.pumpAndSettle();

      // The row reports what it will copy onto before anything is saved —
      // the chip the owner tapped, and the value beside the label.
      expect(find.text(Weekday.wednesday.shortName(t)), findsNWidgets(2));
      expect(find.text(hours.copyNone), findsNothing);

      await tester.tap(find.text(t.common.save));
      await tester.pumpAndSettle();

      expect(shops.lastHours?.rangesOn(Weekday.wednesday), [
        _morning,
        _afternoon,
      ]);
    });

    testWidgets('nothing is chosen to copy onto until the owner says so', (
      tester,
    ) async {
      await pumpSheet(tester);

      expect(find.text(hours.copyNone), findsOneWidget);

      await tester.tap(find.text(t.common.save));
      await tester.pumpAndSettle();

      expect(shops.lastHours?.isOpenOn(Weekday.wednesday), isFalse);
    });

    // Both of these are reachable with the time picker alone, so the sheet
    // says which one it is rather than only greying Save out.
    testWidgets('overlapping slots are named and block the save', (
      tester,
    ) async {
      await pumpSheet(
        tester,
        week: const OpeningHours({
          Weekday.tuesday: [_morning, TimeRange(from: '12:00', to: '14:00')],
        }),
      );

      expect(find.text(hours.overlap), findsOneWidget);

      await tester.tap(find.text(t.common.save));
      await tester.pumpAndSettle();

      expect(shops.updateCalls, 0);
    });

    testWidgets('a slot that ends before it starts is named too', (
      tester,
    ) async {
      await pumpSheet(
        tester,
        week: const OpeningHours({
          Weekday.tuesday: [TimeRange(from: '13:00', to: '09:00')],
        }),
      );

      expect(find.text(hours.backwards), findsOneWidget);

      await tester.tap(find.text(t.common.save));
      await tester.pumpAndSettle();

      expect(shops.updateCalls, 0);
    });

    testWidgets('a failed save keeps the sheet open', (tester) async {
      await pumpSheet(tester, failSave: true);

      await tester.tap(find.text(t.common.save));
      await tester.pumpAndSettle();

      expect(find.text(hours.slots), findsOneWidget);
    });
  });
}
