import 'package:booknow_mobile/core/structures/enums/queue_enums.dart';
import 'package:booknow_mobile/core/structures/enums/booking_status.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/features/bookings/widgets/upcoming_booking_card.dart';
import 'package:booknow_mobile/features/home/widgets/next_booking_card.dart';
import 'package:booknow_mobile/features/home/widgets/shop_summary_card.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'customer_booking_test.dart' show at, booking;
import 'theme_test.dart' show pumpThemed;

/// `en` is the base locale, so the tree renders English — and the expected
/// strings are taken from the same source the widgets read, so a copy change
/// is not also a test change.
final _t = AppLocale.en.buildSync();

ShopSummary summary({
  bool openNow = true,
  String? closesAt = '19:30',
  String? opensAt,
  int services = 4,
  int? fromPriceCents = 1000,
  int? distanceMeters,
}) => ShopSummary(
  id: 'shop-1',
  name: 'Barbieri Navona',
  addressLine: 'Via dei Coronari 18',
  city: 'Roma',
  distanceMeters: distanceMeters,
  openNow: openNow,
  closesAt: closesAt,
  opensAt: opensAt,
  activeServices: services,
  fromPriceCents: fromPriceCents,
  photoUrl: null,
);

void main() {
  group('the next booking card', () {
    testWidgets('names the shop, the service and the status', (tester) async {
      await pumpThemed(
        tester,
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [NextBookingCard(booking: booking(), onDetails: () {})],
        ),
      );

      expect(find.textContaining('Barbieri Navona'), findsOneWidget);
      expect(find.textContaining('Taglio'), findsOneWidget);
      expect(find.text(_t.bookingStatus.confirmed), findsOneWidget);
    });

    testWidgets('prints the time in the shop clock, not the device one', (
      tester,
    ) async {
      await pumpThemed(
        tester,
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [NextBookingCard(booking: booking(), onDetails: () {})],
        ),
      );

      // The fixture is 08:30Z, which is 10:30 in Rome.
      expect(find.text('10:30'), findsOneWidget);
    });
  });

  group('the upcoming card', () {
    Future<void> pump(WidgetTester tester, Booking which, DateTime now) =>
        pumpThemed(
          tester,
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              UpcomingBookingCard(
                booking: which,
                now: now,
                onTap: () {},
                onPay: () {},
              ),
            ],
          ),
        );

    testWidgets('counts a hold down and offers the payment', (tester) async {
      final held = booking(
        status: BookingStatus.pendingPayment,
        holdExpiresAt: at('09:10'),
      );

      await pump(tester, held, at('09:01'));

      expect(find.text(_t.bookings.payNow), findsOneWidget);
      expect(find.textContaining('Expires in'), findsOneWidget);
    });

    testWidgets('says so when the hold has run out', (tester) async {
      final held = booking(
        status: BookingStatus.pendingPayment,
        holdExpiresAt: at('09:10'),
      );

      await pump(tester, held, at('09:11'));

      expect(find.text(_t.bookings.holdLapsed), findsOneWidget);
    });

    /// The fee is what is at stake while it is unpaid; the shop price is what
    /// is at stake once it is not.
    testWidgets('shows the fee while unpaid and the price once paid', (
      tester,
    ) async {
      await pump(tester, booking(), at('09:00'));
      expect(find.textContaining('€18 in shop'), findsOneWidget);

      await pump(
        tester,
        booking(
          status: BookingStatus.pendingPayment,
          holdExpiresAt: at('09:10'),
        ),
        at('09:01'),
      );
      expect(find.textContaining('€1,49'), findsOneWidget);
    });
  });

  group('the shop card', () {
    Future<List<String>> pumpWays(
      WidgetTester tester,
      ShopMode mode, {
      bool tomorrow = false,
    }) async {
      final tapped = <String>[];
      await pumpThemed(
        tester,
        ShopFeedCard(
          shop: summary().copyWith(mode: mode),
          tomorrow: tomorrow,
          onOpen: () {},
          onJoin: () => tapped.add('join'),
          onBook: () => tapped.add('book'),
        ),
      );
      return tapped;
    }

    testWidgets('a shop taking both offers each way in', (tester) async {
      final tapped = await pumpWays(tester, ShopMode.both);

      await tester.tap(find.text(_t.home.joinLine));
      await tester.tap(find.text(_t.home.bookTime));

      expect(tapped, ['join', 'book']);
    });

    testWidgets('a shop with one way shows only that one', (tester) async {
      await pumpWays(tester, ShopMode.queue);
      expect(find.text(_t.home.joinLine), findsOneWidget);
      expect(find.text(_t.home.bookTime), findsNothing);

      await pumpWays(tester, ShopMode.booking);
      expect(find.text(_t.home.joinLine), findsNothing);
      expect(find.text(_t.home.bookTime), findsOneWidget);
    });

    testWidgets('tomorrow has no line to join', (tester) async {
      await pumpWays(tester, ShopMode.both, tomorrow: true);

      expect(find.text(_t.home.joinLine), findsNothing);
      expect(find.text(_t.home.bookTime), findsOneWidget);
    });

    testWidgets('says when it closes while it is open', (tester) async {
      await pumpThemed(
        tester,
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ShopFeedCard(
              shop: summary(),
              onOpen: () {},
              onJoin: () {},
              onBook: () {},
            ),
          ],
        ),
      );

      expect(
        find.textContaining(_t.home.openUntil(time: '19:30')),
        findsOneWidget,
      );
    });

    testWidgets('says when it opens while it is shut', (tester) async {
      await pumpThemed(
        tester,
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ShopFeedCard(
              shop: summary(openNow: false, closesAt: null, opensAt: '9:00'),
              onOpen: () {},
              onJoin: () {},
              onBook: () {},
            ),
          ],
        ),
      );

      expect(
        find.textContaining(_t.home.closedUntil(time: '9:00')),
        findsOneWidget,
      );
    });

    /// Without the location prompt there is no distance to print, and a card
    /// that invented one would be worse than a card without.
    testWidgets('leaves the distance out when there is none', (tester) async {
      await pumpThemed(
        tester,
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ShopFeedCard(
              shop: summary(),
              onOpen: () {},
              onJoin: () {},
              onBook: () {},
            ),
          ],
        ),
      );

      expect(find.text('Via dei Coronari 18'), findsOneWidget);
    });

    testWidgets('prints it when there is', (tester) async {
      await pumpThemed(
        tester,
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ShopFeedCard(
              shop: summary(distanceMeters: 350),
              onOpen: () {},
              onJoin: () {},
              onBook: () {},
            ),
          ],
        ),
      );

      expect(find.text('Via dei Coronari 18 · 350 m'), findsOneWidget);
    });
  });
}
