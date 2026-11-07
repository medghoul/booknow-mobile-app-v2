import 'package:booknow_mobile/core/structures/enums/booking_status.dart';
import 'package:booknow_mobile/data/dtos/index.dart';
import 'package:booknow_mobile/features/bookings/widgets/past_bookings_list.dart';
import 'package:booknow_mobile/features/bookings/widgets/upcoming_booking_card.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'customer_booking_test.dart' show at, booking, bookingJson;
import 'theme_test.dart' show pumpThemed;

/// Who a booking is with, in the customer's bookings (providers §11).
void main() {
  final t = AppLocale.en.buildSync();
  final withMarco = t.shopScreen.withWhom(name: 'Marco');

  group('who it is with', () {
    test('is read from the booking', () {
      final read = BookingDto.fromJson({
        ...bookingJson(),
        'providerName': 'Marco',
      }).toDomain()!;

      expect(read.providerName, 'Marco');
      expect(read.withWhom, 'Marco');
    });

    // A shop of one sends its own name: saying "with Barbieri Navona" on a
    // booking at Barbieri Navona tells the customer nothing.
    test("is left out when it is the shop's own name", () {
      expect(
        booking().copyWith(providerName: 'Barbieri Navona').withWhom,
        isNull,
      );
    });

    test('is left out for a booking from before providers', () {
      expect(booking().withWhom, isNull);
      expect(booking().copyWith(providerName: '  ').withWhom, isNull);
    });
  });

  testWidgets('the upcoming card names them', (tester) async {
    await pumpThemed(
      tester,
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          UpcomingBookingCard(
            booking: booking().copyWith(providerName: 'Marco'),
            now: at('08:00'),
            onTap: () {},
            onPay: () {},
          ),
        ],
      ),
    );

    expect(find.textContaining('Taglio · $withMarco · '), findsOneWidget);
  });

  testWidgets('the upcoming card says nothing more for a shop of one', (
    tester,
  ) async {
    await pumpThemed(
      tester,
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          UpcomingBookingCard(
            booking: booking().copyWith(providerName: 'Barbieri Navona'),
            now: at('08:00'),
            onTap: () {},
            onPay: () {},
          ),
        ],
      ),
    );

    expect(find.textContaining(t.shopScreen.withWhom(name: '')), findsNothing);
  });

  testWidgets('past bookings name them', (tester) async {
    await pumpThemed(
      tester,
      SingleChildScrollView(
        child: PastBookingsList(
          bookings: [
            booking(
              status: BookingStatus.completed,
            ).copyWith(providerName: 'Marco'),
          ],
          onRepeat: (_) {},
          onTap: (_) {},
        ),
      ),
    );

    expect(find.textContaining('Taglio · $withMarco · '), findsOneWidget);
  });
}
