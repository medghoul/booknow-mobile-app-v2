import 'package:booknow_mobile/core/error/api_result.dart';
import 'package:booknow_mobile/core/structures/enums/booking_status.dart';
import 'package:booknow_mobile/core/structures/enums/shop_status.dart';
import 'package:booknow_mobile/core/structures/enums/weekday.dart';
import 'package:booknow_mobile/data/dtos/index.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/domain/repositories/booking_repository.dart';
import 'package:booknow_mobile/features/booking_flow/widgets/day_plan.dart';
import 'package:booknow_mobile/features/booking_flow/widgets/slot_grid.dart';
import 'package:booknow_mobile/features/bookings/cubit/bookings_cubit.dart';
import 'package:booknow_mobile/features/bookings/cubit/bookings_state.dart';
import 'package:flutter_test/flutter_test.dart';

/// Rome is on summer time on the fixture Saturday, so 09:00 local is 07:00Z.
DateTime at(String hhmm, {String date = '2026-10-03'}) =>
    DateTime.parse('${date}T$hhmm:00.000Z').subtract(const Duration(hours: 2));

Map<String, dynamic> bookingJson({
  String status = 'confirmed',
  String start = '2026-10-03T08:30:00.000Z',
  Object? holdExpiresAt,
  Object? freeUntil = '2026-10-03T06:30:00.000Z',
}) => {
  'bookingId': 'booking-1',
  'status': status,
  'startUtc': start,
  'endUtc': '2026-10-03T09:00:00.000Z',
  'durationMin': 30,
  'timeZone': 'Europe/Rome',
  'shopId': 'shop-1',
  'shopName': 'Barbieri Navona',
  'shopAddressLine': 'Via dei Coronari 18',
  'shopPhone': '+39 06 6880 1234',
  'serviceId': 'service-1',
  'serviceName': 'Taglio',
  'priceCents': 1800,
  'feeAmountCents': 149,
  'freeCancellationUntilUtc': freeUntil,
  'holdExpiresAt': holdExpiresAt,
  'cardBrand': 'visa',
  'cardLast4': '4417',
  'refunded': false,
};

Booking booking({
  BookingStatus status = BookingStatus.confirmed,
  DateTime? holdExpiresAt,
  DateTime? freeUntil,
}) => Booking(
  id: 'booking-1',
  status: status,
  startUtc: at('10:30'),
  endUtc: at('11:00'),
  durationMinutes: 30,
  timeZone: 'Europe/Rome',
  shopId: 'shop-1',
  shopName: 'Barbieri Navona',
  shopAddressLine: 'Via dei Coronari 18',
  shopPhone: null,
  serviceId: 'service-1',
  serviceName: 'Taglio',
  priceCents: 1800,
  feeCents: 149,
  freeCancellationUntilUtc: freeUntil ?? at('08:30'),
  holdExpiresAt: holdExpiresAt,
  cardBrand: null,
  cardLast4: null,
  cancelledBy: null,
  refunded: false,
);

Shop shop({
  List<TimeRange> saturday = const [
    TimeRange(from: '09:00', to: '13:00'),
    TimeRange(from: '15:00', to: '19:00'),
  ],
  List<String> closures = const [],
}) => Shop(
  id: 'shop-1',
  status: ShopStatus.active,
  name: 'Barbieri Navona',
  openingHours: OpeningHours({Weekday.saturday: saturday}),
  closures: closures,
  services: const [
    ShopService(
      id: 'service-1',
      name: 'Taglio',
      durationMinutes: 30,
      priceCents: 1800,
      isActive: true,
    ),
  ],
);

class _StubBookingRepository implements BookingRepository {
  _StubBookingRepository({this.upcoming = const [], this.past = const []});

  List<Booking> upcoming;
  List<Booking> past;
  int cancels = 0;
  int lists = 0;

  @override
  Future<ApiResult<List<Booking>>> list(BookingScope scope) async {
    lists += 1;
    return Success(scope == BookingScope.upcoming ? upcoming : past);
  }

  @override
  Future<ApiResult<Booking>> cancel(String bookingId) async {
    cancels += 1;
    upcoming = const [];
    past = [booking(status: BookingStatus.cancelled)];
    return Success(booking(status: BookingStatus.cancelled));
  }

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  group('the booking the wire sends', () {
    test('reads the whole appointment', () {
      final read = BookingDto.fromJson(bookingJson()).toDomain()!;

      expect(read.id, 'booking-1');
      expect(read.status, BookingStatus.confirmed);
      expect(read.startUtc, at('10:30'));
      expect(read.durationMinutes, 30);
      expect(read.shopName, 'Barbieri Navona');
      expect(read.priceCents, 1800);
      expect(read.feeCents, 149);
      expect(read.cardLast4, '4417');
    });

    test('keeps the price and the fee apart', () {
      final read = BookingDto.fromJson(bookingJson()).toDomain()!;

      // The two are never summed anywhere: one is paid in the shop, the other
      // was charged by the app.
      expect(read.priceCents, isNot(read.feeCents));
      expect(read.priceCents + read.feeCents, 1949);
    });

    test('is dropped when it has no start', () {
      final json = bookingJson()..remove('startUtc');

      expect(BookingDto.fromJson(json).toDomain(), isNull);
    });

    test('falls back to the shop timezone rather than the device', () {
      final json = bookingJson()..remove('timeZone');

      expect(BookingDto.fromJson(json).toDomain()!.timeZone, 'Europe/Rome');
    });

    /// The deadline is the server's arithmetic. Falling back to it locally
    /// keeps an older build from printing a date it invented.
    test(
      'computes the free-cancellation deadline when the server omits it',
      () {
        final json = bookingJson(freeUntil: null);

        expect(
          BookingDto.fromJson(json).toDomain()!.freeCancellationUntilUtc,
          at('08:30'),
        );
      },
    );

    test('reads a list and drops what it cannot', () {
      final list = BookingListDto.fromJson({
        'scope': 'upcoming',
        'bookings': [
          bookingJson(),
          {'status': 'confirmed'},
        ],
      }).toDomain();

      expect(list, hasLength(1));
    });

    test('accepts no payment only when there is nothing to charge', () {
      final free = BookingHoldDto.fromJson({
        'booking': bookingJson(status: 'pending_payment'),
        'feeAmountCents': 0,
      }).toDomain();

      expect(free, isNotNull);
      expect(free!.clientSecret, isEmpty);
    });

    test('refuses a hold with no payment behind it', () {
      final hold = BookingHoldDto.fromJson({
        'booking': bookingJson(status: 'pending_payment'),
        'holdExpiresAt': '2026-10-03T08:40:00.000Z',
        'feeAmountCents': 149,
      }).toDomain();

      expect(hold, isNull);
    });

    test('reads a hold with one', () {
      final hold = BookingHoldDto.fromJson({
        'booking': bookingJson(status: 'pending_payment'),
        'clientSecret': 'pi_1_secret_x',
        'holdExpiresAt': '2026-10-03T08:40:00.000Z',
        'feeAmountCents': 149,
      }).toDomain()!;

      expect(hold.clientSecret, 'pi_1_secret_x');
      expect(hold.feeCents, 149);
    });
  });

  group('what a booking says about itself', () {
    test('is refundable more than two hours out', () {
      expect(booking().refundableAt(at('08:29')), isTrue);
    });

    test('stops being refundable inside the window', () {
      expect(booking().refundableAt(at('08:31')), isFalse);
    });

    test('can be cancelled until it starts', () {
      expect(booking().cancellableAt(at('10:29')), isTrue);
      expect(booking().cancellableAt(at('10:31')), isFalse);
    });

    test('cannot be cancelled unless it is confirmed', () {
      final held = booking(status: BookingStatus.pendingPayment);

      expect(held.cancellableAt(at('09:00')), isFalse);
    });

    test('counts down only while it is held', () {
      final held = booking(
        status: BookingStatus.pendingPayment,
        holdExpiresAt: at('09:10'),
      );

      expect(held.holdLeftAt(at('09:04')), const Duration(minutes: 6));
      expect(booking().holdLeftAt(at('09:04')), isNull);
    });

    test('never counts below zero', () {
      final held = booking(
        status: BookingStatus.pendingPayment,
        holdExpiresAt: at('09:10'),
      );

      expect(held.holdLeftAt(at('09:20')), Duration.zero);
    });
  });

  group('the day the picker draws', () {
    DayPlan planFor({
      List<DateTime> starts = const [],
      DateTime? selected,
      String? date,
      Shop? withShop,
    }) => DayPlan.from(
      shop: withShop ?? shop(),
      date: date ?? '2026-10-03',
      timeZone: 'Europe/Rome',
      availability: Availability(
        date: date ?? '2026-10-03',
        timeZone: 'Europe/Rome',
        durationMinutes: 30,
        starts: starts,
      ),
      selected: selected,
      now: at('08:00'),
    );

    test('splits the shop day into morning and afternoon', () {
      final plan = planFor();

      // 09:00–13:00 is sixteen quarter hours, 15:00–19:00 another sixteen.
      expect(plan.morning, hasLength(16));
      expect(plan.afternoon, hasLength(16));
    });

    test('names the lunch break instead of leaving a hole', () {
      final plan = planFor();

      expect(plan.breakFrom, '13:00');
      expect(plan.breakTo, '15:00');
    });

    test('has no break when the shop opens once', () {
      final plan = planFor(
        withShop: shop(
          saturday: const [TimeRange(from: '09:00', to: '19:00')],
        ),
      );

      expect(plan.breakFrom, isNull);
    });

    test('marks the times the server offered as free', () {
      final plan = planFor(starts: [at('10:00'), at('10:30')]);

      expect(
        plan.morning.where((slot) => slot.state == SlotState.free),
        hasLength(2),
      );
    });

    /// Everything the server left out is somebody else's slot, as far as the
    /// customer is concerned.
    test('strikes through the times it did not', () {
      final plan = planFor(starts: [at('10:00')]);

      expect(
        plan.morning.where((slot) => slot.state == SlotState.taken),
        hasLength(15),
      );
    });

    test('fades what has already gone', () {
      final plan = DayPlan.from(
        shop: shop(),
        date: '2026-10-03',
        timeZone: 'Europe/Rome',
        availability: Availability(
          date: '2026-10-03',
          timeZone: 'Europe/Rome',
          durationMinutes: 30,
          starts: [at('11:00')],
        ),
        selected: null,
        now: at('10:00'),
      );

      // 09:00 to 10:00 inclusive is five quarter marks behind the clock.
      expect(
        plan.morning.where((slot) => slot.state == SlotState.past),
        hasLength(5),
      );
    });

    test('shows which one is chosen', () {
      final plan = planFor(
        starts: [at('10:00'), at('10:30')],
        selected: at('10:30'),
      );

      final selected = plan.morning.where(
        (slot) => slot.state == SlotState.selected,
      );
      expect(selected, hasLength(1));
      expect(selected.first.startUtc, at('10:30'));
    });

    test('says a closed day is closed rather than empty', () {
      final plan = planFor(withShop: shop(closures: const ['2026-10-03']));

      expect(plan.closed, isTrue);
      expect(plan.isEmpty, isTrue);
    });

    test('is closed on a weekday with no hours', () {
      // The fixture only opens on Saturday, so Sunday has nothing.
      final plan = planFor(date: '2026-10-04');

      expect(plan.closed, isTrue);
    });
  });

  group('the two lists', () {
    test(
      'load together, so neither says empty while the other answers',
      () async {
        final repository = _StubBookingRepository(
          upcoming: [booking()],
          past: [booking(status: BookingStatus.completed)],
        );
        final cubit = BookingsCubit(repository);
        addTearDown(cubit.close);
        final states = <BookingsState>[];
        final sub = cubit.stream.listen(states.add);
        addTearDown(sub.cancel);

        await cubit.loadAll();
        await Future<void>.delayed(Duration.zero);

        expect(states.first.isLoading, isTrue);
        expect(states, hasLength(2));
        expect(states.last.upcoming, hasLength(1));
        expect(states.last.past, hasLength(1));
        expect(states.last.isLoading, isFalse);
      },
    );

    test('open on what can still be acted on', () async {
      final repository = _StubBookingRepository(upcoming: [booking()]);
      final cubit = BookingsCubit(repository);

      await cubit.load();

      expect(cubit.state.upcoming, hasLength(1));
      expect(cubit.state.scope, BookingScope.upcoming);
      await cubit.close();
    });

    test('badge the tab only when there is something on it', () async {
      final repository = _StubBookingRepository();
      final cubit = BookingsCubit(repository);

      await cubit.load();
      expect(cubit.state.upcomingBadge, isNull);

      repository.upcoming = [booking()];
      await cubit.load();
      expect(cubit.state.upcomingBadge, 1);
      await cubit.close();
    });

    test('read history the first time it is asked for', () async {
      final repository = _StubBookingRepository(past: [booking()]);
      final cubit = BookingsCubit(repository);

      await cubit.load();
      final before = repository.lists;
      await cubit.show(BookingScope.past);

      expect(repository.lists, before + 1);
      expect(cubit.state.visible, hasLength(1));
      await cubit.close();
    });

    /// Cancelling frees the slot and moves the booking across, and the server
    /// is what orders both lists — so both are read again rather than patched.
    test('re-read both lists after a cancellation', () async {
      final repository = _StubBookingRepository(upcoming: [booking()]);
      final cubit = BookingsCubit(repository);

      await cubit.load();
      final before = repository.lists;
      final cancelled = await cubit.cancel('booking-1');

      expect(cancelled?.status, BookingStatus.cancelled);
      expect(repository.cancels, 1);
      expect(repository.lists, before + 2);
      expect(cubit.state.upcoming, isEmpty);
      expect(cubit.state.past, hasLength(1));
      await cubit.close();
    });
  });
}
