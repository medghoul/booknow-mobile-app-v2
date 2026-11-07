import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:booknow_mobile/core/services/push/push_service.dart';
import 'package:booknow_mobile/core/structures/enums/push_type.dart';
import 'package:booknow_mobile/core/structures/enums/user_role.dart';
import 'package:booknow_mobile/core/structures/push_payload.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/features/auth/cubit/auth_cubit.dart';
import 'package:booknow_mobile/features/auth/cubit/auth_state.dart';
import 'package:booknow_mobile/features/notifications/data/push_tap_handler.dart';
import 'package:booknow_mobile/features/notifications/widgets/index.dart';
import 'package:booknow_mobile/routing/app_router.gr.dart';
import 'package:booknow_mobile/routing/push_destinations.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'theme_test.dart' show pumpThemed;

/// The streams the listener reads, under the test's control.
class _FakePushService extends PushService {
  final StreamController<RemoteMessage> _messages =
      StreamController<RemoteMessage>.broadcast();
  final StreamController<RemoteMessage> _taps =
      StreamController<RemoteMessage>.broadcast();

  @override
  Stream<RemoteMessage> get messages => _messages.stream;

  @override
  Stream<RemoteMessage> get taps => _taps.stream;

  /// A push that arrived with the app in front.
  void arrive(RemoteMessage message) => _messages.add(message);

  /// A notification the user tapped outside the app.
  void tapped(RemoteMessage message) => _taps.add(message);

  @override
  Future<void> dispose() async {
    await _messages.close();
    await _taps.close();
  }
}

/// Only the state matters: the handler reads the role and listens for the
/// moment one appears.
class _StubAuthCubit extends Cubit<AuthState> implements AuthCubit {
  _StubAuthCubit(super.state);

  void arriveAt(AuthState state) => emit(state);

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

RemoteMessage push({
  String? type = 'BOOKING_CONFIRMED',
  String? bookingId = 'bk-1',
  String? title = 'Nuova prenotazione',
  String? body = 'Marco · Taglio uomo · sab 3 ott, 10:30',
}) => RemoteMessage(
  data: {'type': ?type, 'bookingId': ?bookingId},
  notification: title == null
      ? null
      : RemoteNotification(title: title, body: body),
);

UserProfile profileWith(UserRole role) => UserProfile(
  id: 'u1',
  name: 'Marco',
  email: 'marco@example.com',
  role: role,
  profileSetupSeen: true,
);

void main() {
  group('PushType', () {
    // The wire names are the API's, not this enum's: §3.4 of the
    // notifications spec. A rename here must not change what is understood.
    test('reads every type the API sends', () {
      expect(PushType.fromWire('BOOKING_CONFIRMED'), PushType.bookingConfirmed);
      expect(
        PushType.fromWire('BOOKING_CANCELLED_BY_CUSTOMER'),
        PushType.bookingCancelledByCustomer,
      );
      expect(
        PushType.fromWire('BOOKING_CANCELLED_BY_SHOP'),
        PushType.bookingCancelledByShop,
      );
      expect(
        PushType.fromWire('BOOKING_LATE_REFUND'),
        PushType.bookingLateRefund,
      );
      expect(PushType.fromWire('DAILY_SUMMARY'), PushType.dailySummary);
      expect(PushType.fromWire('BOOKING_REMINDER'), PushType.bookingReminder);
    });

    test('each type belongs to the role it is sent to', () {
      expect(
        PushType.values
            .where((type) => type.recipient == UserRole.owner)
            .map((type) => type.wireName),
        ['BOOKING_CONFIRMED', 'BOOKING_CANCELLED_BY_CUSTOMER', 'DAILY_SUMMARY'],
      );
      expect(
        PushType.values
            .where((type) => type.recipient == UserRole.customer)
            .map((type) => type.wireName),
        [
          'BOOKING_CANCELLED_BY_SHOP',
          'BOOKING_LATE_REFUND',
          'BOOKING_REMINDER',
        ],
      );
    });

    // A newer server sending a type this build has never heard of is not a
    // crash: the push was delivered and shown, and only the tap is lost.
    test('an unknown or absent type is no type at all', () {
      expect(PushType.fromWire('BOOKING_RESCHEDULED'), isNull);
      expect(PushType.fromWire(null), isNull);
      expect(PushType.fromWire(42), isNull);
    });
  });

  group('PushPayload', () {
    test('reads the type and the booking', () {
      final payload = PushPayload.from({
        'type': 'BOOKING_REMINDER',
        'bookingId': 'bk-9',
      });

      expect(payload?.type, PushType.bookingReminder);
      expect(payload?.bookingId, 'bk-9');
    });

    // The daily summary is about a day, not a booking.
    test('a payload with no booking is still a payload', () {
      final payload = PushPayload.from({'type': 'DAILY_SUMMARY'});

      expect(payload?.type, PushType.dailySummary);
      expect(payload?.bookingId, isNull);
    });

    test('an empty booking id reads as none', () {
      expect(
        PushPayload.from({'type': 'DAILY_SUMMARY', 'bookingId': ''})?.bookingId,
        isNull,
      );
    });

    test('no payload without a type this build knows', () {
      expect(PushPayload.from({'bookingId': 'bk-1'}), isNull);
      expect(PushPayload.from({'type': 'SOMETHING_NEW'}), isNull);
      expect(PushPayload.from(null), isNull);
    });
  });

  group('pushDestinationFor', () {
    // The booking detail screens are not built, so a booking push lands on
    // the list it belongs to — the screen the detail would be pushed from.
    test('an owner is sent to their agenda', () {
      for (final type in PushType.values.where(
        (type) => type.recipient == UserRole.owner,
      )) {
        final destination = pushDestinationFor(
          PushPayload(type: type),
          UserRole.owner,
        );

        expect(destination, isA<OwnerShellRoute>(), reason: type.wireName);
        expect(
          destination?.initialChildren?.single,
          isA<OwnerAgendaRoute>(),
          reason: type.wireName,
        );
      }
    });

    test('a customer is sent to their bookings', () {
      for (final type in PushType.values.where(
        (type) => type.recipient == UserRole.customer,
      )) {
        final destination = pushDestinationFor(
          PushPayload(type: type),
          UserRole.customer,
        );

        expect(destination, isA<CustomerShellRoute>(), reason: type.wireName);
        expect(
          destination?.initialChildren?.single,
          isA<BookingsRoute>(),
          reason: type.wireName,
        );
      }
    });

    // A phone can hold a notification for the account that was signed in
    // before this one. `RoleGuard` would turn the navigation away; this never
    // starts it.
    test('the other role\'s push opens nothing', () {
      expect(
        pushDestinationFor(
          const PushPayload(type: PushType.bookingConfirmed),
          UserRole.customer,
        ),
        isNull,
      );
      expect(
        pushDestinationFor(
          const PushPayload(type: PushType.bookingReminder),
          UserRole.owner,
        ),
        isNull,
      );
    });

    test('no role means nothing below the shells is reachable', () {
      expect(
        pushDestinationFor(
          const PushPayload(type: PushType.bookingConfirmed),
          null,
        ),
        isNull,
      );
    });
  });

  group('PushTapHandler', () {
    late _StubAuthCubit auth;
    late List<PageRouteInfo<dynamic>> navigated;
    late PushTapHandler handler;

    void build(AuthState state) {
      auth = _StubAuthCubit(state);
      navigated = [];
      handler = PushTapHandler(auth: auth, navigate: navigated.add);
      addTearDown(handler.dispose);
      addTearDown(auth.close);
    }

    test('opens the screen the push points at', () {
      build(AuthState(profile: profileWith(UserRole.owner)));

      handler.open(const PushPayload(type: PushType.dailySummary));

      expect(navigated.single, isA<OwnerShellRoute>());
    });

    // What `getInitialMessage` delivers: the app was closed, the user tapped
    // a notification, and the splash has not restored the session yet. The
    // tap is not lost — it is honoured the moment the role is known.
    test('a tap before the session resolves is held, then honoured', () async {
      build(const AuthState());

      handler.open(const PushPayload(type: PushType.bookingReminder));
      expect(navigated, isEmpty, reason: 'nowhere to go yet');

      auth.arriveAt(AuthState(profile: profileWith(UserRole.customer)));
      await pumpEventQueue();

      expect(navigated.single, isA<CustomerShellRoute>());
    });

    test('only the last held tap is honoured', () async {
      build(const AuthState());

      handler
        ..open(const PushPayload(type: PushType.bookingReminder))
        ..open(const PushPayload(type: PushType.bookingLateRefund));

      auth.arriveAt(AuthState(profile: profileWith(UserRole.customer)));
      await pumpEventQueue();

      expect(navigated, hasLength(1));
    });

    test('a resolved session with the wrong role honours nothing', () async {
      build(const AuthState());

      handler.open(const PushPayload(type: PushType.bookingConfirmed));
      auth.arriveAt(AuthState(profile: profileWith(UserRole.customer)));
      await pumpEventQueue();

      expect(navigated, isEmpty);
    });
  });

  group('PushListener', () {
    late _FakePushService service;
    late List<PushPayload> opened;

    Future<void> pumpListener(WidgetTester tester) async {
      service = _FakePushService();
      opened = [];
      addTearDown(service.dispose);

      await pumpThemed(
        tester,
        PushListener(
          push: service,
          onOpen: opened.add,
          child: const Center(child: Text('screen')),
        ),
      );
    }

    testWidgets('a push that arrives in front is shown over the screen', (
      tester,
    ) async {
      await pumpListener(tester);

      service.arrive(push());
      await tester.pumpAndSettle();

      expect(find.text('Nuova prenotazione'), findsOneWidget);
      expect(
        find.text('Marco · Taglio uomo · sab 3 ott, 10:30'),
        findsOneWidget,
      );
      expect(find.text('screen'), findsOneWidget, reason: 'over, not instead');
    });

    testWidgets('tapping the banner opens what it is about', (tester) async {
      await pumpListener(tester);

      service.arrive(push());
      await tester.pumpAndSettle();
      await tester.tap(find.byType(PushBanner));
      await tester.pumpAndSettle();

      expect(opened, [
        const PushPayload(type: PushType.bookingConfirmed, bookingId: 'bk-1'),
      ]);
      expect(find.byType(PushBanner), findsNothing, reason: 'it withdraws');
    });

    testWidgets('swiping it up dismisses it without opening anything', (
      tester,
    ) async {
      await pumpListener(tester);

      service.arrive(push());
      await tester.pumpAndSettle();
      await tester.fling(find.byType(PushBanner), const Offset(0, -200), 800);
      await tester.pumpAndSettle();

      expect(find.byType(PushBanner), findsNothing);
      expect(opened, isEmpty);
    });

    testWidgets('it withdraws on its own', (tester) async {
      await pumpListener(tester);

      service.arrive(push());
      await tester.pumpAndSettle();
      expect(find.byType(PushBanner), findsOneWidget);

      await tester.pump(const Duration(seconds: 6));
      await tester.pumpAndSettle();

      expect(find.byType(PushBanner), findsNothing);
    });

    // The notification was already seen and acted on outside the app, so
    // there is nothing to announce — only somewhere to go.
    testWidgets('a tap from outside opens without showing a banner', (
      tester,
    ) async {
      await pumpListener(tester);

      service.tapped(push());
      await tester.pumpAndSettle();

      expect(find.byType(PushBanner), findsNothing);
      expect(opened, hasLength(1));
    });

    testWidgets('a type this build does not know still shows, inert', (
      tester,
    ) async {
      await pumpListener(tester);

      service.arrive(push(type: 'BOOKING_RESCHEDULED'));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(PushBanner));
      await tester.pumpAndSettle();

      expect(find.text('Nuova prenotazione'), findsOneWidget);
      expect(opened, isEmpty);
    });

    // FCM allows a data-only message, and a `notification` block whose title
    // is an empty string. v0 sends neither, and an empty bar over the screen
    // would be worse than nothing.
    testWidgets('a message with nothing to draw is not drawn', (tester) async {
      await pumpListener(tester);

      service.arrive(push(title: null));
      await tester.pumpAndSettle();
      expect(find.byType(PushBanner), findsNothing, reason: 'no notification');

      service.arrive(push(title: ''));
      await tester.pumpAndSettle();
      expect(find.byType(PushBanner), findsNothing, reason: 'an empty title');
    });

    testWidgets('a second push replaces the first', (tester) async {
      await pumpListener(tester);

      service.arrive(push());
      await tester.pumpAndSettle();
      service.arrive(push(title: 'Prenotazione annullata', bookingId: 'bk-2'));
      await tester.pumpAndSettle();

      expect(find.text('Prenotazione annullata'), findsOneWidget);
      expect(find.text('Nuova prenotazione'), findsNothing);
      expect(find.byType(PushBanner), findsOneWidget);
    });
  });
}
