import 'package:auto_route/auto_route.dart';
import 'package:booknow_mobile/core/constants/app_colors.dart';
import 'package:booknow_mobile/core/di/dependency_injection.dart';
import 'package:booknow_mobile/core/services/location/location_service.dart';
import 'package:booknow_mobile/core/error/error_messages.dart';
import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/core/services/clock/shop_clock.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/features/auth/cubit/auth_cubit.dart';
import 'package:booknow_mobile/features/auth/cubit/auth_state.dart';
import 'package:booknow_mobile/features/auth/widgets/sign_in_sheet.dart';
import 'package:booknow_mobile/features/home/cubit/customer_home_cubit.dart';
import 'package:booknow_mobile/features/home/views/shop_map_page.dart';
import 'package:booknow_mobile/features/home/views/shop_search_page.dart';
import 'package:booknow_mobile/features/home/widgets/index.dart';
import 'package:booknow_mobile/features/queue/cubit/live_status_cubit.dart';
import 'package:booknow_mobile/features/queue/cubit/next_booking_cubit.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// Discover: the header, then the shops ranked by how soon you can be seen.
///
/// The choices live here because the header and the feed both read them.
class CustomerHomeView extends StatefulWidget {
  const CustomerHomeView({super.key});

  @override
  State<CustomerHomeView> createState() => _CustomerHomeViewState();
}

class _CustomerHomeViewState extends State<CustomerHomeView> {
  static const double _shrinkAfter = 40;
  static const double _growDelta = 8;
  static const double _shrinkDelta = 2;

  bool _mini = false;
  bool _showMap = false;
  double _lastOffset = 0;
  ShopCategory? _category;
  HomeIntent? _intent;
  String? _city;
  bool _nearby = false;

  bool _onScroll(ScrollNotification notification) {
    // The horizontal rows report here too; only the page itself counts.
    if (notification.depth != 0 ||
        notification.metrics.axis != Axis.vertical ||
        notification is! ScrollUpdateNotification) {
      return false;
    }

    final offset = notification.metrics.pixels;
    final delta = offset - _lastOffset;
    _lastOffset = offset;

    if (!_mini && offset > _shrinkAfter && delta > _shrinkDelta) {
      setState(() => _mini = true);
    } else if (_mini && (-delta > _growDelta || offset <= 0)) {
      setState(() => _mini = false);
    }
    return false;
  }

  /// With nobody able to see them now, opening on an empty "Right now" would
  /// greet the customer with nothing, so it opens on today instead.
  HomeIntent _effectiveIntent(CustomerHomeLoaded? state) {
    final chosen = _intent;
    if (chosen != null) return chosen;
    final hasLine =
        state?.data.shops.any((shop) => shop.mode.runsQueue) ?? false;
    return hasLine ? HomeIntent.now : HomeIntent.today;
  }

  /// The city a list starts on: the one most of the shops are in.
  String? _homeCity(List<ShopSummary> shops) {
    final seen = <String, int>{};
    for (final shop in shops) {
      if (shop.city case final city?) seen[city] = (seen[city] ?? 0) + 1;
    }
    if (seen.isEmpty) return null;
    return seen.entries.reduce((a, b) => b.value > a.value ? b : a).key;
  }

  void _pickCity(List<ShopSummary> shops) {
    final t = context.t.home;
    final scheme = context.colorScheme;
    final cities = {for (final shop in shops) ?shop.city}.toList()..sort();
    final current = _city ?? _homeCity(shops);

    AppBottomSheet.show<void>(
      context,
      title: t.whereTitle,
      builder: (sheet) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Material(
            color: scheme.surface,
            shape: RoundedRectangleBorder(
              borderRadius: context.radii.mdR,
              side: BorderSide(color: scheme.outlineVariant),
            ),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () {
                Navigator.of(sheet).pop();
                _useLocation();
              },
              child: Container(
                constraints: BoxConstraints(minHeight: 56.h),
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                child: Row(
                  children: [
                    AppLineIcon(AppLineIcons.locate, color: scheme.secondary),
                    SizedBox(width: context.spacing.md.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            t.useLocation,
                            style: context.textTheme.titleSmall?.copyWith(
                              fontSize: context.fonts.s.sp,
                            ),
                          ),
                          Text(
                            t.useLocationLine,
                            style: context.textTheme.bodySmall?.copyWith(
                              color: scheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (_nearby)
                      AppLineIcon(
                        AppLineIcons.check,
                        color: scheme.secondary,
                        strokeWidth: 2.5,
                      ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          for (final city in cities)
            InkWell(
              onTap: () {
                final cubit = context.read<CustomerHomeCubit>();
                if (_nearby) cubit.useOrigin(null);
                setState(() {
                  _city = city;
                  _nearby = false;
                });
                Navigator.of(sheet).pop();
              },
              child: Container(
                constraints: BoxConstraints(minHeight: 52.h),
                padding: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: scheme.outlineVariant),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        city,
                        style: context.textTheme.bodyMedium?.copyWith(
                          fontWeight: city == current && !_nearby
                              ? FontWeight.w700
                              : FontWeight.w500,
                        ),
                      ),
                    ),
                    if (city == current && !_nearby)
                      AppLineIcon(
                        AppLineIcons.check,
                        color: scheme.secondary,
                        strokeWidth: 2.5,
                      ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _useLocation() async {
    final cubit = context.read<CustomerHomeCubit>();
    final here = await di<LocationService>().current();
    if (!mounted) return;

    if (here == null) {
      AppSnackBar.error(context, context.t.home.locationFailed);
      return;
    }

    setState(() {
      _city = null;
      _nearby = true;
    });
    await cubit.useOrigin(here);
  }

  String _headline(int count, HomeIntent intent) {
    final t = context.t.home;
    return switch (intent) {
      HomeIntent.now => t.headlineNow(n: count),
      HomeIntent.today => t.headlineToday(n: count),
      HomeIntent.tomorrow => t.headlineTomorrow(n: count),
    };
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;

    return BlocBuilder<CustomerHomeCubit, CustomerHomeState>(
      builder: (context, state) {
        final loaded = state is CustomerHomeLoaded ? state : null;
        final intent = _effectiveIntent(loaded);
        final nextSlots = firstSlots(loaded?.data.freeToday ?? const []);
        final all = loaded?.data.shops ?? const <ShopSummary>[];
        // Near you is ordered by distance across every city.
        final city = _nearby ? null : _city ?? _homeCity(all);
        final categorised =
            all.isNotEmpty && all.every((shop) => shop.category != null);
        final counts = !categorised
            ? null
            : {
                for (final item in ShopCategory.values)
                  item: visibleShops(
                    all,
                    city: city,
                    category: item,
                    intent: intent,
                    queues: loaded?.queues ?? const {},
                    nextSlots: nextSlots,
                  ).length,
              };
        final shops = visibleShops(
          all,
          city: city,
          category: _category,
          intent: intent,
          queues: loaded?.queues ?? const {},
          nextSlots: nextSlots,
        );

        return AppScaffold(
          padding: EdgeInsets.zero,
          // The header paints behind the status bar itself.
          useSafeArea: false,
          body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BlocBuilder<AuthCubit, AuthState>(
                  bloc: di<AuthCubit>(),
                  buildWhen: (a, b) =>
                      a.profile != b.profile || a.session != b.session,
                  builder: (context, auth) {
                    final name = (auth.profile ?? auth.session?.profile)?.name;
                    final first = name?.trim().split(RegExp(r'\s+')).first;

                    return HomeHeader(
                      greeting: first == null || first.isEmpty
                          ? t.home.greetingNoName
                          : t.home.greeting(name: first),
                      headline: loaded == null
                          ? ''
                          : _headline(shops.length, intent),
                      mini: _mini,
                      category: _category,
                      counts: counts,
                      location: _nearby ? t.home.nearYou : city ?? '',
                      onCategory: (category) => setState(
                        () =>
                            _category = _category == category ? null : category,
                      ),
                      onClearCategory: () => setState(() => _category = null),
                      onLocation: () =>
                          _pickCity(loaded?.data.shops ?? const []),
                      onSearch: () => ShopSearchSheet.show(context),
                    );
                  },
                ),
                Expanded(
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: AnimatedSwitcher(
                          duration: context.motion.normal,
                          child: _showMap
                              ? ShopMapView(
                                  key: const ValueKey('map'),
                                  shops: shops,
                                  queues: loaded?.queues ?? const {},
                                  nextSlots: nextSlots,
                                  intent: intent,
                                  onOpen: (shop) => _goToShop(
                                    context,
                                    shopRoute(
                                      shop,
                                      line:
                                          shop.mode.runsQueue &&
                                          intent != HomeIntent.tomorrow,
                                      slot: intent == HomeIntent.tomorrow
                                          ? null
                                          : nextSlots[shop.id],
                                      initialDate: _tomorrowDate(intent),
                                    ),
                                  ),
                                )
                              : switch (state) {
                                  // Browsing needs the API to answer without a token. Until it does, a
                                  // guest is asked to sign in rather than shown an error.
                                  CustomerHomeFailure()
                                      when di<AuthCubit>().state.session ==
                                          null =>
                                    AppErrorState(
                                      message: t.home.guestBlocked,
                                      retryLabel: t.guest.signIn,
                                      onRetry: () async {
                                        final cubit = context
                                            .read<CustomerHomeCubit>();
                                        final signedIn = await ensureSignedIn(
                                          context,
                                          title: t.guest.signInTitle,
                                          body: t.guest.body,
                                        );
                                        if (signedIn) await cubit.load();
                                      },
                                    ),
                                  CustomerHomeFailure(:final error) =>
                                    AppErrorState(
                                      message: error.localized(context),
                                      retryLabel: t.common.retry,
                                      onRetry: () => context
                                          .read<CustomerHomeCubit>()
                                          .load(),
                                    ),
                                  _ => NotificationListener<ScrollNotification>(
                                    onNotification: _onScroll,
                                    child: _Feed(
                                      key: const ValueKey('feed'),
                                      loaded: loaded,
                                      shops: shops,
                                      intent: intent,
                                      nextSlots: nextSlots,
                                      categoryPicked: _category != null,
                                      onIntent: (value) =>
                                          setState(() => _intent = value),
                                    ),
                                  ),
                                },
                        ),
                      ),
                      Positioned(
                        bottom: 20.h,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: _MapToggle(
                            showingMap: _showMap,
                            onTap: () => setState(() => _showMap = !_showMap),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _MapToggle extends StatelessWidget {
  const _MapToggle({required this.showingMap, required this.onTap});

  final bool showingMap;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final t = context.t;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: AppLineIcon(
          showingMap ? AppLineIcons.list : AppLineIcons.map,
          size: 18,
          color: context.colorScheme.onPrimary,
        ),
        label: Text(showingMap ? t.home.list : t.home.map),
        style: ElevatedButton.styleFrom(
          minimumSize: Size(96.w, 44),
          padding: EdgeInsets.zero,
          shape: const StadiumBorder(),
          textStyle: context.textTheme.labelMedium?.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

Future<void> _goToShop(
  BuildContext context,
  PageRouteInfo<dynamic> route,
) async {
  await context.router.push(route);
  // Back from a flow is when a new place in line or booking appears.
  if (!context.mounted) return;
  await di<LiveStatusCubit>().refresh();
  await di<NextBookingCubit>().refresh();
  if (context.mounted) {
    await context.read<CustomerHomeCubit>().load(refresh: true);
  }
}

/// The day a shop opens on when the customer is looking at tomorrow.
String? _tomorrowDate(HomeIntent intent) => intent == HomeIntent.tomorrow
    ? ShopClock.dateOf(
        DateTime.now().toUtc().add(const Duration(days: 1)),
        'Europe/Rome',
      )
    : null;

class _Feed extends StatelessWidget {
  const _Feed({
    super.key,
    required this.loaded,
    required this.shops,
    required this.intent,
    required this.nextSlots,
    required this.categoryPicked,
    required this.onIntent,
  });

  /// Null while the first read is running.
  final CustomerHomeLoaded? loaded;
  final List<ShopSummary> shops;
  final HomeIntent intent;
  final Map<String, FreeSlot> nextSlots;
  final bool categoryPicked;
  final ValueChanged<HomeIntent> onIntent;

  void _open(BuildContext context, ShopSummary shop, {required bool line}) {
    _goToShop(
      context,
      shopRoute(
        shop,
        line: line,
        slot: intent == HomeIntent.tomorrow ? null : nextSlots[shop.id],
        initialDate: _tomorrowDate(intent),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.home;
    final gutter = EdgeInsets.symmetric(horizontal: context.spacing.lg.w);
    final state = loaded;
    final title = switch (intent) {
      HomeIntent.now => t.feedNow,
      HomeIntent.today => t.feedToday,
      HomeIntent.tomorrow => t.feedTomorrow,
    };
    final categoriesKnown = state?.data.shops.any((s) => s.category != null);

    return RefreshIndicator(
      onRefresh: () => context.read<CustomerHomeCubit>().load(refresh: true),
      child: CustomScrollView(
        // Always scrollable, so pull-to-refresh works on a short screen too.
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: _PinnedSwitch(
              height: 52 + 22.h,
              child: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                padding: EdgeInsets.fromLTRB(
                  context.spacing.lg.w,
                  14.h,
                  context.spacing.lg.w,
                  8.h,
                ),
                child: IntentSwitch(selected: intent, onSelected: onIntent),
              ),
            ),
          ),
          SliverPadding(
            padding: gutter.copyWith(top: 4.h),
            sliver: SliverToBoxAdapter(
              child: Text(
                title,
                style: context.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          if (categoryPicked && categoriesKnown == false)
            SliverPadding(
              padding: EdgeInsets.fromLTRB(
                context.spacing.lg.w,
                context.spacing.xs.h,
                context.spacing.lg.w,
                0,
              ),
              sliver: SliverToBoxAdapter(
                child: Text(
                  t.categoryNotice,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(
              context.spacing.lg.w,
              context.spacing.md.h,
              context.spacing.lg.w,
              // Clear of the floating map toggle.
              88.h,
            ),
            sliver: SliverToBoxAdapter(
              child: state == null
                  ? const ShopFeedSkeleton()
                  : shops.isEmpty
                  ? _Empty(intent: intent, onIntent: onIntent)
                  : AppStaggeredShops(
                      children: [
                        for (final shop in shops)
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: context.spacing.md.h,
                            ),
                            child: ShopFeedCard(
                              shop: shop,
                              queue: state.queues[shop.id],
                              nextSlot: nextSlots[shop.id],
                              tomorrow: intent == HomeIntent.tomorrow,
                              onOpen: () => _open(
                                context,
                                shop,
                                line:
                                    shop.mode.runsQueue &&
                                    intent != HomeIntent.tomorrow,
                              ),
                              onJoin: () => _open(context, shop, line: true),
                              onBook: () => _open(context, shop, line: false),
                            ),
                          ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

/// The cards arrive one after another rather than all at once.
class AppStaggeredShops extends StatelessWidget {
  const AppStaggeredShops({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final (index, child) in children.indexed)
          AppFadeIn.up(delay: 40 * index.clamp(0, 5), child: child),
      ],
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty({required this.intent, required this.onIntent});

  final HomeIntent intent;
  final ValueChanged<HomeIntent> onIntent;

  @override
  Widget build(BuildContext context) {
    final t = context.t.home;
    final isNow = intent == HomeIntent.now;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.spacing.xxl.h),
      child: Column(
        children: [
          CategoryPicture(category: ShopCategory.more, size: 72.w),
          SizedBox(height: context.spacing.md.h),
          Text(
            isNow ? t.emptyNowTitle : t.noShops,
            textAlign: TextAlign.center,
            style: context.textTheme.titleSmall,
          ),
          if (isNow) ...[
            SizedBox(height: context.spacing.xs.h),
            Text(
              t.emptyNowBody,
              textAlign: TextAlign.center,
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: context.spacing.md.h),
            AppOutlinedButton(
              label: t.emptyNowCta,
              onPressed: () => onIntent(HomeIntent.today),
            ),
          ],
        ],
      ),
    );
  }
}

class _PinnedSwitch extends SliverPersistentHeaderDelegate {
  const _PinnedSwitch({required this.height, required this.child});

  final double height;
  final Widget child;

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) => child;

  @override
  bool shouldRebuild(_PinnedSwitch old) =>
      old.height != height || old.child != child;
}
