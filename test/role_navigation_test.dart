import 'package:booknow_mobile/core/structures/enums/queue_enums.dart';
import 'package:booknow_mobile/features/queue/cubit/shop_mode_notifier.dart';
import 'package:auto_route/auto_route.dart';
import 'package:booknow_mobile/core/di/dependency_injection.dart';
import 'package:booknow_mobile/core/error/api_result.dart';
import 'package:booknow_mobile/core/structures/enums/shop_status.dart';
import 'package:booknow_mobile/core/theme/app_theme.dart';
import 'package:booknow_mobile/core/structures/enums/user_role.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/domain/repositories/agenda_repository.dart';
import 'package:booknow_mobile/domain/repositories/booking_repository.dart';
import 'package:booknow_mobile/domain/repositories/customer_home_repository.dart';
import 'package:booknow_mobile/features/agenda/cubit/owner_agenda_cubit.dart';
import 'package:booknow_mobile/features/chairs/cubit/owner_chairs_cubit.dart';
import 'package:booknow_mobile/domain/repositories/chairs_repository.dart';
import 'package:booknow_mobile/domain/repositories/queue_repository.dart';
import 'package:booknow_mobile/features/auth/cubit/auth_cubit.dart';
import 'package:booknow_mobile/features/queue/cubit/live_status_cubit.dart';
import 'package:booknow_mobile/features/queue/cubit/next_booking_cubit.dart';
import 'package:booknow_mobile/features/bookings/cubit/bookings_cubit.dart';
import 'package:booknow_mobile/features/auth/cubit/auth_state.dart';
import 'package:booknow_mobile/features/auth/routing/auth_destination.dart';
import 'package:booknow_mobile/features/home/cubit/customer_home_cubit.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/routing/app_router.dart';
import 'package:booknow_mobile/routing/app_router.gr.dart';
import 'package:booknow_mobile/routing/guards/role_guard.dart';
import 'package:booknow_mobile/routing/nav_destinations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

import 'auth_router_test.dart' show profile, shop;
import 'theme_test.dart' show pumpThemed;

/// The live bar only reads a place when there is a session; these have none.
class _StubChairs implements ChairsRepository {
  @override
  Future<ApiResult<ChairBoard>> board() async => const Success(
    ChairBoard(localDate: '2026-11-09', timeZone: 'UTC', chairs: []),
  );

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

class _StubQueue implements QueueRepository {
  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

/// Only the state matters: the guard reads it and calls nothing on the cubit.
class _StubAuthCubit extends Cubit<AuthState> implements AuthCubit {
  _StubAuthCubit(super.state);

  void become(AuthState next) => emit(next);

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

/// A home that loads, so the customer's first tab renders its content rather
/// than an error state. What it holds does not matter here — these tests are
/// about which screen a role lands on, not what that screen says.
class _StubHomeRepository implements CustomerHomeRepository {
  @override
  Future<ApiResult<CustomerHome>> load({double? lat, double? lng}) async =>
      const Success(
        CustomerHome(
          nextBooking: null,
          freeToday: [],
          freeTodayTotal: 0,
          shops: [],
        ),
      );
}

/// Bookings that load, so the customer's second tab renders a list rather than
/// an error state. Empty, for the same reason as the home above.
class _StubBookingRepository implements BookingRepository {
  @override
  Future<ApiResult<List<Booking>>> list(BookingScope scope) async =>
      const Success([]);

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

/// An agenda that loads, so the owner's first tab renders its timeline rather
/// than an error state. Empty: these tests are about which screen a role lands
/// on, not what that screen says.
class _StubAgendaRepository implements AgendaRepository {
  @override
  Future<ApiResult<AgendaDay>> day({String? date, String? providerId}) async =>
      Success(
        AgendaDay(
          date: date ?? '2026-10-03',
          timeZone: 'Europe/Rome',
          closed: false,
          closure: false,
          openingHours: const [],
          summary: const AgendaSummary(booked: 0, free: 0, toCollectCents: 0),
          days: const [],
          rows: const [],
        ),
      );

  @override
  Future<ApiResult<TimeBlock>> block({
    required DateTime startUtc,
    required DateTime endUtc,
    String? note,
    String? providerId,
  }) async => throw UnimplementedError();

  @override
  Future<ApiResult<void>> unblock({
    required String blockId,
    required String date,
  }) async => throw UnimplementedError();

  @override
  Future<ApiResult<void>> markArrived(String bookingId) async =>
      const ApiResult<void>.success(null);

  @override
  Future<ApiResult<void>> markNoShow(String bookingId) async =>
      const ApiResult<void>.success(null);

  @override
  Future<ApiResult<void>> cancelBooking(String bookingId) async =>
      const ApiResult<void>.success(null);
}

void main() {
  final t = AppLocale.en.buildSync().nav;

  Future<List<AppNavDestination>> destinations(
    WidgetTester tester,
    UserRole role,
  ) async {
    late List<AppNavDestination> result;
    await pumpThemed(
      tester,
      Builder(
        builder: (context) {
          result = navDestinationsFor(context, role);
          return const SizedBox.shrink();
        },
      ),
    );
    return result;
  }

  group('navDestinationsFor', () {
    // Two different bars, not one with a hidden tab: a customer books and
    // reads their own bookings, an owner runs an agenda.
    testWidgets('a customer gets discover, activity and profile', (
      tester,
    ) async {
      final result = await destinations(tester, UserRole.customer);

      expect(result.map((destination) => destination.tab.label), [
        t.discover,
        t.activity,
        t.profile,
      ]);
    });

    testWidgets('an owner gets today, calendar and shop', (tester) async {
      final result = await destinations(tester, UserRole.owner);

      expect(result.map((destination) => destination.tab.label), [
        t.today,
        t.calendar,
        t.shop,
      ]);
    });

    testWidgets('profile is the last destination for both roles', (
      tester,
    ) async {
      for (final role in UserRole.values) {
        final result = await destinations(tester, role);
        expect(result.last.route, isA<ProfileRoute>(), reason: '$role');
      }
    });

    // The reason the two are one object. They used to be separate per-role
    // positional lists, which is how a bar ends up labelling the wrong screen.
    testWidgets('every tab is paired with the route it names', (tester) async {
      final owner = await destinations(tester, UserRole.owner);
      final customer = await destinations(tester, UserRole.customer);

      expect(owner.first.tab.label, t.today);
      expect(owner.first.route, isA<OwnerTodayRoute>());
      expect(owner[1].tab.label, t.calendar);
      expect(owner[1].route, isA<OwnerAgendaRoute>());
      expect(customer[1].tab.label, t.activity);
      expect(customer[1].route, isA<BookingsRoute>());
    });
  });

  group('RoleGuard.redirectFor', () {
    AuthState signedIn({required UserRole role, ShopStatus? shopStatus}) =>
        AuthState(
          profile: profile(role: role),
          shop: shopStatus == null ? null : shop(status: shopStatus),
        );

    test('an owner with a published shop belongs in the owner shell', () {
      expect(
        RoleGuard.redirectFor(
          UserRole.owner,
          signedIn(role: UserRole.owner, shopStatus: ShopStatus.active),
        ),
        isNull,
      );
    });

    test('a customer belongs in the customer shell', () {
      expect(
        RoleGuard.redirectFor(
          UserRole.customer,
          signedIn(role: UserRole.customer),
        ),
        isNull,
      );
    });

    // The point of the guard: a link, not a widget, asked for this.
    test('a customer is turned away from the owner shell', () {
      expect(
        RoleGuard.redirectFor(
          UserRole.owner,
          signedIn(role: UserRole.customer),
        ),
        isA<CustomerShellRoute>(),
      );
    });

    test('an owner is turned away from the customer shell', () {
      expect(
        RoleGuard.redirectFor(
          UserRole.customer,
          signedIn(role: UserRole.owner, shopStatus: ShopStatus.active),
        ),
        isA<OwnerShellRoute>(),
      );
    });

    test('no session may browse the customer side', () {
      expect(
        RoleGuard.redirectFor(UserRole.customer, const AuthState()),
        isNull,
      );
    });

    test('no session is turned away from the owner side', () {
      expect(
        RoleGuard.redirectFor(UserRole.owner, const AuthState()),
        isA<CustomerShellRoute>(),
      );
    });

    test('no role yet goes to the role screen', () {
      expect(
        RoleGuard.redirectFor(UserRole.customer, AuthState(profile: profile())),
        isA<RoleRoute>(),
      );
    });

    // Role alone is not enough. A deep link skips every screen in between, so
    // the agenda would open with no shop behind it.
    test('an owner mid-wizard goes to the wizard, not to their own shell', () {
      expect(
        RoleGuard.redirectFor(
          UserRole.owner,
          signedIn(role: UserRole.owner, shopStatus: ShopStatus.draft),
        ),
        isA<ShopSetupRoute>(),
      );
    });

    test('a customer who has not seen the profile step stays put', () {
      expect(
        RoleGuard.redirectFor(
          UserRole.customer,
          AuthState(
            profile: profile(role: UserRole.customer, profileSetupSeen: false),
          ),
        ),
        isNull,
      );
    });
  });

  group('mounted on the real router', () {
    /// Pumps the app's own route table, entered by [at] as a deep link —
    /// which is the thing being tested: a path that arrives from outside the
    /// app rather than from a widget. The splash never builds, so none of the
    /// session restore it does needs standing in for.
    Future<AppRouter> pumpAt(
      WidgetTester tester,
      PageRouteInfo<dynamic> at, {
      required AuthState auth,
    }) async {
      di.registerSingleton<AuthCubit>(_StubAuthCubit(auth));
      // A customer landing here opens the home tab for real, and `HomePage`
      // builds its cubit out of the container. Without this the tab throws
      // `Object/factory with type CustomerHomeCubit is not registered` and
      // the broken tree it leaves behind fails the next test too.
      di.registerFactory<CustomerHomeCubit>(
        () => CustomerHomeCubit(_StubHomeRepository()),
      );
      // The customer's second tab builds one too.
      di.registerFactory<BookingsCubit>(
        () => BookingsCubit(_StubBookingRepository()),
      );

      di.registerSingleton<LiveStatusCubit>(LiveStatusCubit(_StubQueue()));
      di.registerSingleton<NextBookingCubit>(NextBookingCubit(_StubBookings()));

      // Same for the owner's first tab, which builds its own cubit too.
      di.registerFactory<OwnerChairsCubit>(
        () => OwnerChairsCubit(_StubChairs(), _StubQueue()),
      );
      di.registerFactory<OwnerAgendaCubit>(
        () => OwnerAgendaCubit(_StubAgendaRepository()),
      );
      // The owner's first tab shows the queue or the agenda by the shop's
      // mode; set to bookings, it never reads the shop.
      di.registerSingleton<ShopModeNotifier>(
        ShopModeNotifier()..value = ShopMode.booking,
      );
      final router = AppRouter();

      await tester.pumpWidget(
        AppScreenInit(
          designSize: const Size(390, 844),
          builder: (context, _) => TranslationProvider(
            child: MaterialApp.router(
              theme: AppTheme.light,
              // The fades would leave a pending timer behind; the same switch
              // the system's Reduce Motion setting flips, so the path under
              // test is a real one.
              builder: (context, child) => MediaQuery(
                data: MediaQuery.of(context).copyWith(disableAnimations: true),
                child: child!,
              ),
              routerConfig: router.config(
                deepLinkBuilder: (_) => DeepLink([at]),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      return router;
    }

    tearDown(() async => di.reset());

    group('a guest', () {
      const guest = AuthState(destination: SignInDestination());

      testWidgets('browses the customer tabs', (tester) async {
        final router = await pumpAt(
          tester,
          const CustomerShellRoute(),
          auth: guest,
        );

        expect(router.current.name, CustomerShellRoute.name);
      });

      testWidgets('who signs in as an owner moves to the owner app', (
        tester,
      ) async {
        final router = await pumpAt(
          tester,
          const CustomerShellRoute(),
          auth: guest,
        );

        (di<AuthCubit>() as _StubAuthCubit).become(
          AuthState(
            destination: const OwnerAgendaDestination(),
            profile: profile(role: UserRole.owner),
            shop: shop(status: ShopStatus.active),
          ),
        );
        await tester.pumpAndSettle();

        expect(router.current.name, OwnerShellRoute.name);
      });

      testWidgets('who signs in as a customer stays where they are', (
        tester,
      ) async {
        final router = await pumpAt(
          tester,
          const CustomerShellRoute(),
          auth: guest,
        );

        (di<AuthCubit>() as _StubAuthCubit).become(
          AuthState(
            destination: const CustomerHomeDestination(),
            profile: profile(role: UserRole.customer),
          ),
        );
        await tester.pumpAndSettle();

        expect(router.current.name, CustomerShellRoute.name);
      });
    });

    final ownerAuth = AuthState(
      profile: profile(role: UserRole.owner),
      shop: shop(status: ShopStatus.active),
    );
    final customerAuth = AuthState(profile: profile(role: UserRole.customer));

    testWidgets('an owner lands on Today, with their three tabs', (
      tester,
    ) async {
      await pumpAt(tester, const OwnerShellRoute(), auth: ownerAuth);

      expect(find.text(t.today), findsOneWidget);
      expect(find.text(t.calendar), findsOneWidget);
      expect(find.text(t.shop), findsOneWidget);
      // A customer's tabs are not merely hidden — they are not in this tree.
      expect(find.text(t.home), findsNothing);
      expect(find.text(t.bookings), findsNothing);
    });

    // The guard, through the router rather than through its own function: a
    // link asked for someone else's half of the app.
    testWidgets('a customer sent to the owner shell lands on their own', (
      tester,
    ) async {
      final router = await pumpAt(
        tester,
        const OwnerShellRoute(),
        auth: customerAuth,
      );

      expect(router.currentUrl, '/customer/home');
      expect(find.text(t.activity), findsOneWidget);
      expect(find.text(t.calendar), findsNothing);
    });

    testWidgets('tapping a tab swaps the page under the bar', (tester) async {
      final router = await pumpAt(
        tester,
        const CustomerShellRoute(),
        auth: customerAuth,
      );

      await tester.tap(find.text(t.activity));
      await tester.pumpAndSettle();

      expect(router.currentUrl, '/customer/bookings');
    });
  });

  group('the route tree', () {
    final routes = AppRouter().routes;

    AutoRoute shellFor(String name) =>
        routes.firstWhere((route) => route.name == name);

    List<String> childNamesOf(String shell) =>
        (shellFor(shell).children ?? const <AutoRoute>[])
            .map((route) => route.name)
            .toList();

    // The security claim. A shell with no guard is a deep link straight into
    // someone else's half of the app.
    test('both shells are guarded for their own role', () {
      for (final (shell, role) in [
        (OwnerShellRoute.name, UserRole.owner),
        (CustomerShellRoute.name, UserRole.customer),
      ]) {
        final guards = shellFor(shell).guards;
        expect(guards, hasLength(1), reason: shell);
        expect((guards.single as RoleGuard).allowed, role, reason: shell);
        expect(RoleGuard.shellNameFor(role), shell);
      }
    });

    // `AutoTabsRouter` is handed the routes from `navDestinationsFor` and
    // requires every one of them to be a declared child of the shell it is
    // in. A mismatch is a crash on the first build of the shell, not a
    // warning, so the two lists are checked against each other here.
    testWidgets('each shell declares exactly its role\'s destinations', (
      tester,
    ) async {
      for (final (shell, role) in [
        (OwnerShellRoute.name, UserRole.owner),
        (CustomerShellRoute.name, UserRole.customer),
      ]) {
        final wanted = (await destinations(
          tester,
          role,
        )).map((destination) => destination.route.routeName).toList();

        expect(childNamesOf(shell), wanted, reason: shell);
      }
    });

    // A tab reachable at the top level is a tab reachable with no guard above
    // it and no bar under it.
    test('no tab is also a root route', () {
      final tabs = {
        ...childNamesOf(OwnerShellRoute.name),
        ...childNamesOf(CustomerShellRoute.name),
      };

      expect(
        routes.map((route) => route.name).toSet().intersection(tabs),
        isEmpty,
      );
    });

    // One tab per shell has to be the initial one or the shell opens empty.
    test('every shell has an initial tab', () {
      for (final shell in [OwnerShellRoute.name, CustomerShellRoute.name]) {
        final children = shellFor(shell).children!;
        expect(
          children.where((route) => route.initial),
          hasLength(1),
          reason: shell,
        );
        expect(children.first.initial, isTrue, reason: shell);
      }
    });
  });
}

class _StubBookings implements BookingRepository {
  @override
  Future<ApiResult<List<Booking>>> list(BookingScope scope) async =>
      const Success([]);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
