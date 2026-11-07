import 'package:booknow_mobile/core/error/api_result.dart';
import 'package:booknow_mobile/core/structures/enums/booking_status.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/domain/repositories/booking_repository.dart';
import 'package:booknow_mobile/features/queue/cubit/next_booking_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

Booking _booking(
  String id,
  DateTime start, {
  BookingStatus status = BookingStatus.confirmed,
}) => Booking(
  id: id,
  status: status,
  startUtc: start,
  endUtc: start.add(const Duration(minutes: 30)),
  durationMinutes: 30,
  timeZone: 'Europe/Rome',
  shopId: 's',
  shopName: 'Studio',
  shopAddressLine: null,
  shopPhone: null,
  serviceId: 'c',
  serviceName: 'Fade',
  priceCents: 2000,
  feeCents: 149,
  freeCancellationUntilUtc: start.subtract(const Duration(hours: 2)),
  holdExpiresAt: null,
  cardBrand: null,
  cardLast4: null,
  cancelledBy: null,
  refunded: false,
);

class _Bookings implements BookingRepository {
  _Bookings(this.upcoming);

  final List<Booking> upcoming;

  @override
  Future<ApiResult<List<Booking>>> list(BookingScope scope) async =>
      Success(upcoming);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  group('a price a customer reads', () {
    test('whole euros go without the cents', () {
      expect(Money.shortCents(2800), '€28');
    });

    test('the fee keeps them', () {
      expect(Money.shortCents(149), '€1,49');
    });
  });

  group('the next visit on the bar', () {
    final soon = DateTime.now().toUtc().add(const Duration(days: 1));
    final later = soon.add(const Duration(days: 5));

    test('is the soonest confirmed one', () async {
      final cubit = NextBookingCubit(
        _Bookings([_booking('later', later), _booking('soon', soon)]),
      );
      await cubit.refresh();

      expect(cubit.state?.id, 'soon');
      await cubit.close();
    });

    test('skips one still waiting to be paid', () async {
      final cubit = NextBookingCubit(
        _Bookings([
          _booking('unpaid', soon, status: BookingStatus.pendingPayment),
        ]),
      );
      await cubit.refresh();

      expect(cubit.state, isNull);
      await cubit.close();
    });
  });
}
