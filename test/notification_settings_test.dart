import 'dart:async';

import 'package:booknow_mobile/core/error/api_result.dart';
import 'package:booknow_mobile/core/error/network_exception.dart';
import 'package:booknow_mobile/core/services/launcher/system_settings_service.dart';
import 'package:booknow_mobile/core/services/push/push_service.dart';
import 'package:booknow_mobile/core/structures/enums/reminder_lead.dart';
import 'package:booknow_mobile/core/structures/enums/user_role.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/domain/repositories/user_repository.dart';
import 'package:booknow_mobile/features/auth/cubit/auth_cubit.dart';
import 'package:booknow_mobile/features/auth/cubit/auth_state.dart';
import 'package:booknow_mobile/features/notifications/cubit/notification_settings_cubit.dart';
import 'package:booknow_mobile/features/notifications/widgets/index.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'theme_test.dart' show pumpThemed;

/// Answers about the OS permission without a platform channel. Constructing
/// the real one is safe — it only reaches for Firebase when used — but
/// `hasPermission` would.
class _FakePush extends PushService {
  _FakePush({this.isAllowed = true});

  final bool isAllowed;

  @override
  Future<bool> hasPermission() async => isAllowed;
}

/// Records that the screen sent the user to the phone's own settings.
class _FakeSystemSettings extends SystemSettingsService {
  _FakeSystemSettings();

  int opened = 0;

  @override
  Future<void> openNotifications() async => opened++;
}

/// `PATCH /me/notification-preferences`, as the server behaves: it merges the
/// fields it was given into what it already holds, and answers with the whole
/// profile.
///
/// [patches] is one entry per request, holding only the arguments that were
/// actually passed — which is the point of the method. A screen that sends a
/// field belonging to the other role gets a 400 from the real API, so "only
/// this one went" is the assertion worth making.
class _FakeUsers implements UserRepository {
  _FakeUsers({NotificationPreferences? preferences})
    : profile = _profile(preferences ?? const NotificationPreferences());

  UserProfile profile;

  /// Returned instead of the merged profile, for showing that the state
  /// follows the server rather than the tap.
  UserProfile? answerWith;

  NetworkException? nextFailure;

  /// Held open to catch the screen between the tap and the reply.
  Completer<void>? gate;

  final List<Map<String, Object?>> patches = [];

  @override
  Future<ApiResult<UserProfile>> updateNotificationPreferences({
    bool? newBooking,
    bool? cancellation,
    bool? dailySummary,
    String? summaryTime,
    bool? reminder,
    ReminderLead? reminderLead,
  }) async {
    patches.add({
      'newBooking': ?newBooking,
      'cancellation': ?cancellation,
      'dailySummary': ?dailySummary,
      'summaryTime': ?summaryTime,
      'reminder': ?reminder,
      'reminderLead': ?reminderLead?.wireName,
    });

    await gate?.future;

    final failure = nextFailure;
    if (failure != null) return ApiResult.failure(failure);

    final current = profile.notificationPrefs;
    profile = profile.copyWith(
      notificationPrefs: current.copyWith(
        newBookings: newBooking ?? current.newBookings,
        cancellations: cancellation ?? current.cancellations,
        dailySummary: dailySummary ?? current.dailySummary,
        summaryTime: summaryTime ?? current.summaryTime,
        appointmentReminder: reminder ?? current.appointmentReminder,
        reminderLead: reminderLead ?? current.reminderLead,
      ),
    );

    return ApiResult.success(answerWith ?? profile);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

/// Holds the profile the screen reads, and records what is handed back to it.
class _StubAuth extends Cubit<AuthState> implements AuthCubit {
  _StubAuth(super.state);

  final List<UserProfile> updates = [];

  @override
  void profileUpdated(UserProfile profile) {
    updates.add(profile);
    emit(state.copyWith(profile: profile));
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

UserProfile _profile(NotificationPreferences preferences) => UserProfile(
  id: 'u1',
  name: 'Marco',
  email: 'marco@example.com',
  role: UserRole.owner,
  profileSetupSeen: true,
  notificationPrefs: preferences,
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final t = AppLocale.en.buildSync();
  final settings = t.notificationSettings;

  late _FakeUsers users;
  late _StubAuth auth;

  /// Seeds the profile the screen opens on — the API returns these with
  /// `GET /me`, so they are already in hand before the screen is built.
  void seed([
    NotificationPreferences preferences = const NotificationPreferences(),
  ]) {
    users = _FakeUsers(preferences: preferences);
    auth = _StubAuth(AuthState(profile: users.profile));
    addTearDown(auth.close);
  }

  setUp(seed);

  group('NotificationPreferences.quarterHour', () {
    // The API schedules the summary rather than polling for it, so it takes
    // `:00`, `:15`, `:30` or `:45` and nothing else. The platform's picker
    // offers every minute.
    test('a picked minute lands on the nearest quarter', () {
      expect(NotificationPreferences.quarterHour(8, 0), '08:00');
      expect(NotificationPreferences.quarterHour(8, 7), '08:00');
      expect(NotificationPreferences.quarterHour(8, 8), '08:15');
      expect(NotificationPreferences.quarterHour(8, 22), '08:15');
      expect(NotificationPreferences.quarterHour(8, 23), '08:30');
      expect(NotificationPreferences.quarterHour(8, 45), '08:45');
    });

    test('rounding up past the hour carries', () {
      expect(NotificationPreferences.quarterHour(8, 53), '09:00');
    });

    // 24:00 is not a time the server's pattern accepts.
    test('the last minutes of the day wrap to midnight, not to 24:00', () {
      expect(NotificationPreferences.quarterHour(23, 58), '00:00');
    });

    test('a single digit is padded on both halves', () {
      expect(NotificationPreferences.quarterHour(7, 30), '07:30');
      expect(NotificationPreferences.quarterHour(0, 0), '00:00');
    });
  });

  group('NotificationSettingsCubit', () {
    NotificationSettingsCubit build({
      bool isAllowed = true,
      SystemSettingsService? system,
    }) {
      final cubit = NotificationSettingsCubit(
        auth: auth,
        users: users,
        push: _FakePush(isAllowed: isAllowed),
        settings: system ?? _FakeSystemSettings(),
      );
      addTearDown(cubit.close);
      return cubit;
    }

    // The preferences are the server's, and they arrive with the profile —
    // so the screen opens on the real answer with nothing to wait for.
    test('the screen opens on the profile, not on the defaults', () {
      seed(
        const NotificationPreferences(
          appointmentReminder: false,
          reminderLead: ReminderLead.oneDay,
          newBookings: false,
          summaryTime: '07:30',
        ),
      );

      final preferences = build().state.preferences;

      expect(preferences.appointmentReminder, isFalse);
      expect(preferences.reminderLead, ReminderLead.oneDay);
      expect(preferences.newBookings, isFalse);
      expect(preferences.summaryTime, '07:30');
    });

    test('no profile yet is the defaults, not an empty screen', () {
      auth = _StubAuth(const AuthState());
      addTearDown(auth.close);

      expect(build().state.preferences, const NotificationPreferences());
    });

    // The screen has no Salva button, so every change has to reach the server
    // on its own.
    test('a switch is sent as it is flipped', () async {
      final cubit = build();

      await cubit.setNewBookings(false);

      expect(cubit.state.preferences.newBookings, isFalse);
      expect(users.profile.notificationPrefs.newBookings, isFalse);
    });

    // A flip that waits for the network before moving reads as a tap the app
    // ignored, and this is used over a phone connection.
    test('the switch moves before the server has answered', () async {
      final cubit = build();
      users.gate = Completer<void>();

      final pending = cubit.setNewBookings(false);
      await Future<void>.delayed(Duration.zero);

      expect(cubit.state.preferences.newBookings, isFalse);

      users.gate!.complete();
      await pending;
    });

    // Each row sends its own field and nothing else. The server merges, so a
    // request carrying the whole object would overwrite a switch set
    // somewhere else — and it would carry the other role's fields, which it
    // refuses with a 400.
    test('each setter sends only its own field', () async {
      final cubit = build();

      await cubit.setNewBookings(false);
      expect(users.patches.last, {'newBooking': false});

      await cubit.setCancellations(false);
      expect(users.patches.last, {'cancellation': false});

      await cubit.setDailySummary(false);
      expect(users.patches.last, {'dailySummary': false});

      await cubit.setSummaryTime('07:30');
      expect(users.patches.last, {'summaryTime': '07:30'});

      await cubit.setAppointmentReminder(false);
      expect(users.patches.last, {'reminder': false});

      await cubit.setReminderLead(ReminderLead.oneDay);
      expect(users.patches.last, {'reminderLead': '1d'});
    });

    // Turning the summary off must not take its time with it: the field is
    // left out of the request, and the server keeps what it holds.
    test('switching the summary off keeps the time it was set to', () async {
      seed(const NotificationPreferences(summaryTime: '07:30'));
      final cubit = build();

      await cubit.setDailySummary(false);

      expect(cubit.state.preferences.summaryTime, '07:30');
      expect(users.profile.notificationPrefs.summaryTime, '07:30');
    });

    // The reply is what will actually happen, including the defaults the API
    // fills in for anything never set.
    test('the state follows the server, not the tap', () async {
      final cubit = build();
      users.answerWith = _profile(
        const NotificationPreferences(summaryTime: '09:45'),
      );

      await cubit.setSummaryTime('07:30');

      expect(cubit.state.preferences.summaryTime, '09:45');
    });

    // `PATCH` answers with the whole profile for exactly this reason: one copy
    // of it, not a second behind this screen.
    test('the profile every screen reads is updated from the reply', () async {
      final cubit = build();

      await cubit.setNewBookings(false);

      expect(users.patches, hasLength(1));
      expect(auth.updates.single.notificationPrefs.newBookings, isFalse);
      expect(auth.state.profile!.notificationPrefs.newBookings, isFalse);
    });

    test('a change that did not land is put back, with the reason', () async {
      final cubit = build();
      users.nextFailure = const NoInternetConnection();

      await cubit.setNewBookings(false);

      expect(cubit.state.preferences.newBookings, isTrue);
      expect(cubit.state.failure, isA<NoInternetConnection>());
      expect(auth.updates, isEmpty);
    });

    test('a phone that blocks notifications is reported as blocking', () async {
      final cubit = build(isAllowed: false);
      expect(cubit.state.isSystemAllowed, isTrue, reason: 'before the check');

      await cubit.refreshSystemPermission();

      expect(cubit.state.isSystemAllowed, isFalse);
    });

    test('the app cannot grant permission, only open Settings', () async {
      final system = _FakeSystemSettings();

      await build(system: system).openSystemSettings();

      expect(system.opened, 1);
    });
  });

  group('NotificationSettingsView', () {
    late _FakeSystemSettings system;
    late NotificationSettingsCubit cubit;

    Future<void> pumpSettings(
      WidgetTester tester, {
      UserRole role = UserRole.customer,
      bool isAllowed = true,
    }) async {
      system = _FakeSystemSettings();
      cubit = NotificationSettingsCubit(
        auth: auth,
        users: users,
        push: _FakePush(isAllowed: isAllowed),
        settings: system,
      );
      addTearDown(cubit.close);

      await pumpThemed(
        tester,
        BlocProvider.value(
          value: cubit,
          child: NotificationSettingsView(role: role),
        ),
      );
      await tester.pumpAndSettle();
    }

    testWidgets('a customer gets the customer list, not the owner one', (
      tester,
    ) async {
      await pumpSettings(tester);

      expect(find.text(settings.customer.reminder), findsOneWidget);
      expect(find.text(settings.owner.newBookings), findsNothing);
    });

    testWidgets('an owner gets the agenda and the summary', (tester) async {
      await pumpSettings(tester, role: UserRole.owner);

      expect(find.text(settings.owner.newBookings), findsOneWidget);
      expect(find.text(settings.owner.summaryTime), findsOneWidget);
      expect(find.text(defaultSummaryTime), findsOneWidget);
      expect(find.text(settings.customer.reminder), findsNothing);
    });

    // Cancellations and refunds are about money, so they are not the
    // customer's to turn off — and a disabled switch reads as "off", which
    // would be a lie.
    testWidgets('the cancellations row is a label, not a switch', (
      tester,
    ) async {
      await pumpSettings(tester);

      expect(find.text(settings.customer.cancellations), findsOneWidget);
      expect(find.text(settings.customer.cancellationsLocked), findsOneWidget);
      expect(find.byType(NotificationLockedBadge), findsOneWidget);
      // The reminder is the customer's only switch: the design leaves them
      // the one choice and locks the row that is about their money.
      expect(find.byType(AppSwitch), findsOneWidget);
    });

    // The agenda is two events — a slot paid for, a slot given back — and the
    // summary is the third switch. A reminder before each appointment is not
    // on this screen.
    testWidgets('an owner gets three switches, not four', (tester) async {
      await pumpSettings(tester, role: UserRole.owner);

      expect(find.text(settings.owner.cancellations), findsOneWidget);
      expect(find.byType(AppSwitch), findsNWidgets(3));
    });

    testWidgets('flipping a switch reaches the API', (tester) async {
      await pumpSettings(tester, role: UserRole.owner);

      await tester.tap(
        find.descendant(
          of: find.ancestor(
            of: find.text(settings.owner.newBookings),
            matching: find.byType(NotificationToggleRow),
          ),
          matching: find.byType(AppSwitch),
        ),
      );
      await tester.pumpAndSettle();

      expect(users.patches.single, {'newBooking': false});
      expect(users.profile.notificationPrefs.newBookings, isFalse);
    });

    // A timing for a reminder nobody receives is a setting with no effect.
    testWidgets('the reminder timing goes with the reminder', (tester) async {
      await pumpSettings(tester);

      expect(find.text(settings.lead.twoHours), findsOneWidget);

      await tester.tap(
        find.descendant(
          of: find.ancestor(
            of: find.text(settings.customer.reminder),
            matching: find.byType(NotificationToggleRow),
          ),
          matching: find.byType(AppSwitch),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text(settings.lead.twoHours), findsNothing);
    });

    testWidgets('choosing a lead sends it as the API names it', (tester) async {
      await pumpSettings(tester);

      await tester.tap(find.text(settings.lead.oneDay));
      await tester.pumpAndSettle();

      expect(users.patches.single, {'reminderLead': '1d'});
      expect(users.profile.notificationPrefs.reminderLead, ReminderLead.oneDay);
    });

    // The row goes back on its own, so the reason has to be said out loud.
    testWidgets('a change that did not land says so', (tester) async {
      await pumpSettings(tester, role: UserRole.owner);
      users.nextFailure = const NoInternetConnection();

      await tester.tap(
        find.descendant(
          of: find.ancestor(
            of: find.text(settings.owner.newBookings),
            matching: find.byType(NotificationToggleRow),
          ),
          matching: find.byType(AppSwitch),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text(t.errors.noConnection), findsOneWidget);
    });

    testWidgets('no banner while the phone is delivering', (tester) async {
      await pumpSettings(tester);

      expect(find.byType(NotificationsBlockedBanner), findsNothing);
    });

    // An owner reads what it costs them, not which permission is missing.
    testWidgets('a blocked phone is named, with the way to fix it', (
      tester,
    ) async {
      await pumpSettings(tester, role: UserRole.owner, isAllowed: false);

      expect(find.text(settings.blocked.title), findsOneWidget);
      expect(find.text(settings.blocked.bodyOwner), findsOneWidget);

      await tester.tap(find.text(settings.blocked.action));
      await tester.pumpAndSettle();

      expect(system.opened, 1);
    });

    testWidgets('a blocked customer is told what they are missing', (
      tester,
    ) async {
      await pumpSettings(tester, isAllowed: false);

      expect(find.text(settings.blocked.bodyCustomer), findsOneWidget);
    });

    // With the summary off there is nothing to set a time for.
    testWidgets('the sending time follows the summary', (tester) async {
      await pumpSettings(tester, role: UserRole.owner);

      await tester.tap(
        find.descendant(
          of: find.ancestor(
            of: find.text(settings.owner.dailySummary),
            matching: find.byType(NotificationToggleRow),
          ),
          matching: find.byType(AppSwitch),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text(settings.owner.summaryTime));
      await tester.pumpAndSettle();

      // No picker: the row is inert while the summary is off.
      expect(find.byType(TimePickerDialog), findsNothing);
    });

    // The picker offers every minute; the API takes the quarter hour.
    testWidgets('a picked time is snapped before it is sent', (tester) async {
      await pumpSettings(tester, role: UserRole.owner);

      await tester.tap(find.text(settings.owner.summaryTime));
      await tester.pumpAndSettle();

      // The dial is awkward to drive; the keyboard entry mode is a text field.
      await tester.tap(find.byIcon(Icons.keyboard_outlined));
      await tester.pumpAndSettle();

      final fields = find.byType(TextField);
      await tester.enterText(fields.first, '7');
      await tester.enterText(fields.last, '37');
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      expect(users.patches.single, {'summaryTime': '07:30'});
      expect(find.text('07:30'), findsOneWidget);
    });
  });
}
