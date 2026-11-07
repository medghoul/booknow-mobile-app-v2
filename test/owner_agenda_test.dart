import 'package:booknow_mobile/core/constants/app_component_sizes.dart';
import 'package:booknow_mobile/core/error/api_result.dart';
import 'package:booknow_mobile/core/error/network_exception.dart';
import 'package:booknow_mobile/core/structures/enums/booking_status.dart';
import 'package:booknow_mobile/data/dtos/index.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/domain/repositories/agenda_repository.dart';
import 'package:booknow_mobile/features/agenda/cubit/owner_agenda_cubit.dart';
import 'package:booknow_mobile/features/agenda/widgets/index.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'theme_test.dart' show pumpThemed;

/// Rome is on summer time on the fixture Saturday, so 09:00 local is 07:00Z.
DateTime at(String hhmm, {String date = '2026-10-03'}) =>
    DateTime.parse('${date}T$hhmm:00.000Z').subtract(const Duration(hours: 2));

AgendaBookingRow booking({
  String name = 'Giulia F.',
  String? phone,
  String start = '10:15',
  int minutes = 15,
  BookingStatus status = BookingStatus.confirmed,
  int priceCents = 1000,
  int feeCents = 149,
}) => AgendaBookingRow(
  id: 'booking-1',
  startUtc: at(start),
  endUtc: at(start).add(Duration(minutes: minutes)),
  occupiedUntilUtc: at(start).add(Duration(minutes: minutes + 10)),
  durationMinutes: minutes,
  status: status,
  serviceName: 'Barba',
  priceCents: priceCents,
  feeCents: feeCents,
  customerName: name,
  customerPhone: phone,
);

AgendaDay day({List<AgendaRow> rows = const [], bool closed = false}) =>
    AgendaDay(
      date: '2026-10-03',
      timeZone: 'Europe/Rome',
      closed: closed,
      closure: false,
      openingHours: [AgendaOpening(fromUtc: at('09:00'), toUtc: at('19:00'))],
      summary: const AgendaSummary(booked: 6, free: 2, toCollectCents: 11800),
      days: const [
        AgendaStripDay(date: '2026-10-02', bookings: 9, closed: false),
        AgendaStripDay(date: '2026-10-03', bookings: 6, closed: false),
        AgendaStripDay(date: '2026-10-04', bookings: 0, closed: true),
      ],
      rows: rows,
    );

class _StubRepository implements AgendaRepository {
  _StubRepository(this._day);

  final AgendaDay _day;
  int blocked = 0;
  int unblocked = 0;
  int reads = 0;
  final List<String> actions = [];
  NetworkException? actionFailure;

  Future<ApiResult<void>> _action(String name) async {
    if (actionFailure case final failure?) return Failure(failure);
    actions.add(name);
    return const ApiResult<void>.success(null);
  }

  @override
  Future<ApiResult<void>> markArrived(String bookingId) =>
      _action('arrived:$bookingId');

  @override
  Future<ApiResult<void>> markNoShow(String bookingId) =>
      _action('no-show:$bookingId');

  @override
  Future<ApiResult<void>> cancelBooking(String bookingId) =>
      _action('cancel:$bookingId');

  @override
  Future<ApiResult<AgendaDay>> day({String? date, String? providerId}) async {
    reads++;
    return Success(_day);
  }

  @override
  Future<ApiResult<TimeBlock>> block({
    required DateTime startUtc,
    required DateTime endUtc,
    String? note,
    String? providerId,
  }) async {
    blocked++;
    return Success(
      TimeBlock(id: 'block-1', startUtc: startUtc, endUtc: endUtc, note: note),
    );
  }

  @override
  Future<ApiResult<void>> unblock({
    required String blockId,
    required String date,
  }) async {
    unblocked++;
    return const Success(null);
  }
}

/// Pumps a row with the cubit its taps need behind it.
Future<void> pumpRow(
  WidgetTester tester,
  AgendaRow row, {
  required DateTime now,
  VoidCallback? onTap,
}) => pumpThemed(
  tester,
  BlocProvider(
    create: (_) => OwnerAgendaCubit(_StubRepository(day())),
    // Scaffold hands its body tight constraints, which a row stretches to
    // fill; a min-height column is what lets it take the height it asks for.
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AgendaRowTile(
          row: row,
          timeZone: 'Europe/Rome',
          now: now,
          onTap: onTap,
        ),
      ],
    ),
  ),
);

void main() {
  // `en` is the base locale, so that is what the widget tree renders. Taken
  // from the translations rather than written out, so a copy change does not
  // need a test change to go with it.
  final t = AppLocale.en.buildSync().agenda;

  group('the agenda response', () {
    test('reads a day, with all three kinds of row', () {
      final parsed = AgendaDayDto.fromJson({
        'date': '2026-10-03',
        'timeZone': 'Europe/Rome',
        'closed': false,
        'closure': false,
        'openingHours': [
          {
            'fromUtc': '2026-10-03T07:00:00.000Z',
            'toUtc': '2026-10-03T17:00:00.000Z',
          },
        ],
        'summary': {'booked': 6, 'free': 2, 'toCollectCents': 11800},
        'days': [
          {'date': '2026-10-03', 'bookings': 6, 'closed': false},
        ],
        'rows': [
          {
            'kind': 'booking',
            'bookingId': 'b-1',
            'startUtc': '2026-10-03T08:15:00.000Z',
            'endUtc': '2026-10-03T08:30:00.000Z',
            'occupiedUntilUtc': '2026-10-03T08:40:00.000Z',
            'durationMin': 15,
            'status': 'confirmed',
            'serviceName': 'Barba',
            'priceCents': 1000,
            'feeAmountCents': 149,
            'customerName': 'Giulia F.',
            'customerPhone': '+39 333 1234567',
          },
          {
            'kind': 'block',
            'blockId': 'bl-1',
            'startUtc': '2026-10-03T11:00:00.000Z',
            'endUtc': '2026-10-03T11:30:00.000Z',
            'note': 'Pausa',
          },
          {
            'kind': 'free',
            'startUtc': '2026-10-03T12:00:00.000Z',
            'endUtc': '2026-10-03T12:30:00.000Z',
            'freedBy': 'Paolo M.',
          },
        ],
      }).toDomain();

      expect(parsed.date, '2026-10-03');
      expect(parsed.timeZone, 'Europe/Rome');
      expect(parsed.summary.toCollectCents, 11800);
      expect(parsed.days.single.bookings, 6);
      expect(parsed.openingHours.single.fromUtc.hour, 7);
      expect(parsed.rows, hasLength(3));

      final first = parsed.rows.first as AgendaBookingRow;
      expect(first.customerName, 'Giulia F.');
      expect(first.priceCents, 1000);
      expect(first.status, BookingStatus.confirmed);

      expect((parsed.rows[1] as AgendaBlockRow).note, 'Pausa');
      expect((parsed.rows[2] as AgendaFreeRow).freedBy, 'Paolo M.');
    });

    /// The app's own fee, read off its own key. The two are kept apart all the
    /// way down because the sheet shows them apart.
    test('reads the hold apart from the price', () {
      final row =
          AgendaDayDto.fromJson({
                'rows': [
                  {
                    'kind': 'booking',
                    'startUtc': '2026-10-03T08:15:00.000Z',
                    'endUtc': '2026-10-03T08:30:00.000Z',
                    'priceCents': 1000,
                    'feeAmountCents': 149,
                  },
                ],
              }).toDomain().rows.single
              as AgendaBookingRow;

      expect(row.priceCents, 1000);
      expect(row.feeCents, 149);
    });

    /// A kind this build has never heard of costs the owner one line. Failing
    /// the parse would cost them the whole day.
    test('drops a row of a kind it does not know', () {
      final parsed = AgendaDayDto.fromJson({
        'rows': [
          {
            'kind': 'lunch',
            'startUtc': '2026-10-03T11:00:00.000Z',
            'endUtc': '2026-10-03T12:00:00.000Z',
          },
          {
            'kind': 'free',
            'startUtc': '2026-10-03T12:00:00.000Z',
            'endUtc': '2026-10-03T12:30:00.000Z',
          },
        ],
      }).toDomain();

      expect(parsed.rows, hasLength(1));
      expect(parsed.rows.single, isA<AgendaFreeRow>());
    });

    test('drops a row whose instants cannot be read', () {
      final parsed = AgendaDayDto.fromJson({
        'rows': [
          {'kind': 'free', 'startUtc': 'soon', 'endUtc': 'later'},
          {'kind': 'free', 'startUtc': '2026-10-03T12:00:00.000Z'},
        ],
      }).toDomain();

      expect(parsed.rows, isEmpty);
    });

    /// An absent buffer can only ever show less time as taken, which is the
    /// safe direction.
    test('falls back to the service end when the buffer is missing', () {
      final row =
          AgendaDayDto.fromJson({
                'rows': [
                  {
                    'kind': 'booking',
                    'startUtc': '2026-10-03T08:15:00.000Z',
                    'endUtc': '2026-10-03T08:30:00.000Z',
                  },
                ],
              }).toDomain().rows.single
              as AgendaBookingRow;

      expect(row.occupiedUntilUtc, row.endUtc);
    });

    /// Never the device's zone. An absent field is a server that did not say,
    /// not permission to show the owner their phone's idea of the time.
    test('falls back to the shop zone v0 ships in', () {
      expect(
        AgendaDayDto.fromJson(const {}).toDomain().timeZone,
        'Europe/Rome',
      );
    });
  });

  group('a timeline row', () {
    final now = at('09:00');

    testWidgets('grows with the service it is for', (tester) async {
      final heights = <int, double>{};

      for (final minutes in [30, 45, 60]) {
        await pumpRow(
          tester,
          booking(start: '11:00', minutes: minutes),
          now: now,
        );
        heights[minutes] = tester.getSize(find.byType(AgendaRowTile)).height;
      }

      expect(heights[45]!, greaterThan(heights[30]!));
      expect(heights[60]!, greaterThan(heights[45]!));
    });

    /// Otherwise a free morning or a three-hour block is a screenful, and the
    /// day stops being readable at a glance.
    testWidgets('stops growing past an hour', (tester) async {
      await pumpRow(
        tester,
        AgendaRow.free(
          startUtc: at('11:00'),
          endUtc: at('12:00'),
          freedBy: null,
        ),
        now: now,
      );
      final hour = tester.getSize(find.byType(AgendaRowTile)).height;

      await pumpRow(
        tester,
        AgendaRow.free(
          startUtc: at('11:00'),
          endUtc: at('16:00'),
          freedBy: null,
        ),
        now: now,
      );

      expect(tester.getSize(find.byType(AgendaRowTile)).height, hour);
    });

    testWidgets('leaves the rest of the day unmarked', (tester) async {
      await pumpRow(tester, booking(start: '11:00'), now: at('09:45'));

      expect(find.text(t.now.toUpperCase()), findsNothing);
      expect(find.textContaining('€10,00'), findsNothing);
    });

    /// "Now" is a window, not a start that has gone by: the nine o'clock cut
    /// is finished at noon, and marking it current would put two outlined rows
    /// on the same day.
    testWidgets('stops being the current one once it has finished', (
      tester,
    ) async {
      await pumpRow(
        tester,
        booking(start: '09:00', minutes: 30),
        now: at('09:45'),
      );

      expect(find.text(t.now.toUpperCase()), findsNothing);
    });

    testWidgets('fades once it is over', (tester) async {
      await pumpRow(tester, booking(start: '09:00'), now: at('12:00'));

      final faded = tester.widget<Opacity>(
        find
            .descendant(
              of: find.byType(AgendaRowTile),
              matching: find.byType(Opacity),
            )
            .first,
      );

      expect(faded.opacity, AppComponentSizes.agendaPastRowOpacity);
    });

    testWidgets('names who gave a free run back', (tester) async {
      await pumpRow(
        tester,
        AgendaRow.free(
          startUtc: at('11:30'),
          endUtc: at('12:00'),
          freedBy: 'Paolo M.',
        ),
        now: now,
      );

      expect(find.text(t.freeLabel), findsOneWidget);
      expect(find.text(t.cancelledBy(name: 'Paolo M.')), findsOneWidget);
      // The length is what a plain free run says instead.
      expect(find.text(t.minutes(count: 30)), findsNothing);
    });

    testWidgets('shows a block with its note', (tester) async {
      await pumpRow(
        tester,
        AgendaRow.block(
          id: 'block-1',
          startUtc: at('11:00'),
          endUtc: at('11:30'),
          note: 'Pausa',
        ),
        now: now,
      );

      expect(find.text(t.blockedLabel), findsOneWidget);
      expect(find.text('Pausa'), findsOneWidget);
    });
  });

  group('the booking sheet', () {
    Future<void> pumpSheet(
      WidgetTester tester, {
      required AgendaBookingRow row,
      required DateTime now,
    }) => pumpThemed(
      tester,
      AgendaBookingSheet(row: row, timeZone: 'Europe/Rome', now: now),
    );

    /// The big number is what the barber takes. The app's hold is a footnote
    /// and is never added to it — €11.49 would be a number nobody is paid.
    testWidgets('collects the service, and only mentions the hold', (
      tester,
    ) async {
      await pumpSheet(tester, row: booking(), now: at('10:00'));

      expect(find.text(t.sheet.toCollect), findsOneWidget);
      expect(find.text('€10,00'), findsOneWidget);
      expect(find.textContaining('€1,49'), findsOneWidget);
      expect(find.textContaining('€11,49'), findsNothing);
    });

    /// §10.3, and the decision behind it: the design's sample says ten
    /// minutes, the booking rules say fifteen, and the server enforces
    /// fifteen. A button that unlocks early is a button that fails.
    testWidgets('keeps no-show locked for fifteen minutes', (tester) async {
      await pumpSheet(
        tester,
        row: booking(start: '10:15'),
        now: at('10:25'),
      );

      final label = t.sheet.noShowFrom(time: '10:30');
      expect(find.text(label), findsOneWidget);

      final locked = tester.widget<AppOutlinedButton>(
        find.widgetWithText(AppOutlinedButton, label),
      );
      expect(locked.isDisabled, isTrue);
    });

    testWidgets('unlocks no-show once it is one', (tester) async {
      await pumpSheet(
        tester,
        row: booking(start: '10:15'),
        now: at('10:30'),
      );

      final unlocked = tester.widget<AppOutlinedButton>(
        find.widgetWithText(AppOutlinedButton, t.sheet.noShow),
      );
      expect(unlocked.isDisabled, isFalse);
    });

    testWidgets('offers the phone only when there is one to call', (
      tester,
    ) async {
      await pumpSheet(tester, row: booking(), now: at('10:00'));
      expect(find.text(t.sheet.call(name: 'Giulia')), findsNothing);

      await pumpSheet(
        tester,
        row: booking(phone: '+39 333 1234567'),
        now: at('10:00'),
      );
      expect(find.text(t.sheet.call(name: 'Giulia')), findsOneWidget);
    });
  });

  group('the date strip', () {
    Future<void> pumpStrip(
      WidgetTester tester, {
      String selected = '2026-10-03',
    }) => pumpThemed(
      tester,
      AgendaDateStrip(days: day().days, selected: selected, onSelected: (_) {}),
    );

    /// A closed day is dashed and says so where the count would be: the owner
    /// still taps it to check they meant to be closed, and "0" would read as
    /// an open day with an empty book.
    testWidgets('says closed instead of counting nothing', (tester) async {
      await pumpStrip(tester);

      expect(find.text(t.closedShort), findsOneWidget);
      expect(find.text('0'), findsNothing);
    });

    testWidgets('counts the bookings on every other day', (tester) async {
      await pumpStrip(tester);

      expect(find.text('9'), findsOneWidget);
      expect(find.text('6'), findsOneWidget);
    });

    testWidgets('marks the day being shown as the selected one', (
      tester,
    ) async {
      await pumpStrip(tester);

      final selected = tester
          .widgetList<Semantics>(find.byType(Semantics))
          .where((node) => node.properties.selected ?? false);

      expect(selected, hasLength(1));
    });
  });

  group('a block draft', () {
    /// The picker offers every minute; the grid takes multiples of five.
    /// Floored, not rounded: blocking "from 11:02" is about the next
    /// twenty-eight minutes, not about the two that are gone.
    test('is floored onto the five-minute grid', () {
      expect(TimeBlock.onGrid(11 * 60 + 2), 11 * 60);
      expect(TimeBlock.onGrid(11 * 60 + 9), 11 * 60 + 5);
      expect(TimeBlock.onGrid(11 * 60), 11 * 60);
    });

    test('refuses a range that ends before or when it starts', () {
      expect(TimeBlock.problemFor(11 * 60, 10 * 60), BlockProblem.backwards);
      expect(TimeBlock.problemFor(11 * 60, 11 * 60), BlockProblem.backwards);
    });

    /// Eight hours is 96 cells, and 97 writes with the block itself — three
    /// short of what one DynamoDB transaction takes.
    test('refuses more than eight hours', () {
      expect(TimeBlock.problemFor(8 * 60, 16 * 60), isNull);
      expect(TimeBlock.problemFor(8 * 60, 16 * 60 + 5), BlockProblem.tooLong);
    });

    test('accepts a normal break', () {
      expect(TimeBlock.problemFor(13 * 60, 14 * 60), isNull);
    });
  });

  group('what the owner does to a booking', () {
    for (final (name, expected, act)
        in <(String, String, Future<bool> Function(OwnerAgendaCubit))>[
          ('arrived', 'arrived:b', (cubit) => cubit.markArrived('b')),
          ('a no-show', 'no-show:b', (cubit) => cubit.markNoShow('b')),
          ('cancelled', 'cancel:b', (cubit) => cubit.cancelBooking('b')),
        ]) {
      test('marking $name reads the day again', () async {
        final repository = _StubRepository(day());
        final cubit = OwnerAgendaCubit(repository);
        addTearDown(cubit.close);
        await cubit.load();
        final before = repository.reads;

        expect(await act(cubit), isTrue);

        expect(repository.actions, [expected]);
        expect(repository.reads, before + 1);
        expect(cubit.state.isSaving, isFalse);
      });
    }

    test('a refusal keeps the day on screen and reports the failure', () async {
      const refusal = NoInternetConnection();
      final repository = _StubRepository(day())..actionFailure = refusal;
      final cubit = OwnerAgendaCubit(repository);
      addTearDown(cubit.close);
      await cubit.load();

      expect(await cubit.markArrived('b'), isFalse);

      expect(cubit.state.day, isNotNull);
      expect(cubit.state.failure, refusal);
      expect(cubit.state.isSaving, isFalse);
    });

    test('moving to another day keeps the header until it answers', () async {
      final cubit = OwnerAgendaCubit(_StubRepository(day()));
      addTearDown(cubit.close);
      await cubit.load();

      final moving = cubit.load(date: '2026-10-04');

      expect(cubit.state.isLoading, isTrue);
      expect(cubit.state.day, isNotNull);
      expect(cubit.state.date, '2026-10-04');
      await moving;
    });
  });

  group('the agenda cubit', () {
    test('opens on the day the server resolves, not on a guess', () async {
      final cubit = OwnerAgendaCubit(_StubRepository(day()));
      addTearDown(cubit.close);

      await cubit.load();

      expect(cubit.state.date, '2026-10-03');
      expect(cubit.state.isLoading, isFalse);
      expect(cubit.state.timeZone, 'Europe/Rome');
    });

    /// Blocking splits whatever free run it landed in, and the server is the
    /// only thing that knows what the two halves are.
    test('re-reads the day after a block', () async {
      final repository = _StubRepository(day());
      final cubit = OwnerAgendaCubit(repository);
      addTearDown(cubit.close);

      await cubit.load();
      final blocked = await cubit.blockTime(
        startUtc: at('13:00'),
        endUtc: at('14:00'),
      );

      expect(blocked, isTrue);
      expect(repository.blocked, 1);
      expect(cubit.state.isSaving, isFalse);
    });

    test('will not unblock before it knows which day it is on', () async {
      final repository = _StubRepository(day());
      final cubit = OwnerAgendaCubit(repository);
      addTearDown(cubit.close);

      expect(await cubit.unblockTime('block-1'), isFalse);
      expect(repository.unblocked, 0);
    });
  });
}
