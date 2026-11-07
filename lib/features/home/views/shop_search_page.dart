import 'package:auto_route/auto_route.dart';
import 'package:booknow_mobile/core/di/dependency_injection.dart';
import 'package:booknow_mobile/core/error/error_messages.dart';
import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/core/services/storage/prefs_service.dart';
import 'package:booknow_mobile/core/utils/ui/debouncer.dart';
import 'package:booknow_mobile/domain/models/shop_summary.dart';
import 'package:booknow_mobile/features/home/cubit/shop_search_cubit.dart';
import 'package:booknow_mobile/features/home/widgets/shop_summary_card.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// Finding a shop by name or street, in a sheet over Discover.
///
/// While nothing is typed it offers the shops opened lately, then the rest.
class ShopSearchSheet extends StatelessWidget {
  const ShopSearchSheet._();

  static Future<void> show(BuildContext context) => AppBottomSheet.show<void>(
    context,
    builder: (_) => BlocProvider(
      create: (_) => ShopSearchCubit(di())..search(''),
      child: const ShopSearchSheet._(),
    ),
  );

  @override
  Widget build(BuildContext context) => const _SearchBody();
}

class _SearchBody extends StatefulWidget {
  const _SearchBody();

  @override
  State<_SearchBody> createState() => _SearchBodyState();
}

class _SearchBodyState extends State<_SearchBody> {
  final Debouncer _debouncer = Debouncer();
  String _query = '';

  @override
  void dispose() {
    _debouncer.dispose();
    super.dispose();
  }

  void _onChanged(String query) {
    setState(() => _query = query);
    _debouncer.run(() => context.read<ShopSearchCubit>().search(query));
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final scheme = context.colorScheme;
    final height = context.mediaQuery.size.height;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(t.search.title, style: context.textTheme.titleMedium),
        const SizedBox(height: 14),
        Container(
          height: 50,
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: context.radii.mdR,
            border: Border.all(color: scheme.secondary, width: 1.5),
          ),
          child: Row(
            children: [
              AppLineIcon(
                AppLineIcons.search,
                size: 18,
                color: scheme.onSurfaceVariant,
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: TextField(
                  autofocus: true,
                  onChanged: _onChanged,
                  style: context.textTheme.bodyMedium,
                  decoration: InputDecoration(
                    hintText: t.search.hint,
                    isCollapsed: true,
                    filled: false,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: 240.h,
            maxHeight: height * 0.5,
          ),
          child: BlocBuilder<ShopSearchCubit, ShopSearchState>(
            builder: (context, state) => switch (state) {
              ShopSearchLoading() => const AppLoader.centered(),
              ShopSearchFailure(:final error) => AppErrorState(
                message: error.localized(context),
                retryLabel: t.common.retry,
                onRetry: () => context.read<ShopSearchCubit>().search(_query),
              ),
              ShopSearchLoaded(:final shops) when shops.isEmpty => Padding(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: Text(
                  t.search.noResults,
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontSize: 14.sp,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ),
              ShopSearchLoaded(:final shops) => _Results(
                shops: shops,
                showRecent: _query.trim().isEmpty,
              ),
            },
          ),
        ),
      ],
    );
  }
}

/// The results, with the shops opened lately first while nothing is typed.
///
/// Recent ones are stored as ids and read out of the directory, so a shop that
/// closed or changed name is never shown stale.
class _Results extends StatelessWidget {
  const _Results({required this.shops, required this.showRecent});

  final List<ShopSummary> shops;
  final bool showRecent;

  Future<void> _open(BuildContext context, ShopSummary shop) async {
    final router = context.router;
    final navigator = Navigator.of(context);
    await di<PrefsService>().addRecentShop(shop.id);
    navigator.pop();

    await router.push(shopRoute(shop));
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.search;
    final byId = {for (final shop in shops) shop.id: shop};
    final recent = showRecent
        ? [for (final id in di<PrefsService>().recentShopIds) ?byId[id]]
        : const <ShopSummary>[];
    final others = shops.where((shop) => !recent.contains(shop)).toList();

    Widget row(ShopSummary shop) =>
        _ResultRow(shop: shop, onTap: () => _open(context, shop));

    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      children: [
        if (recent.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: AppSectionTitle(t.recent),
          ),
          ...recent.map(row),
          if (others.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 14, bottom: 4),
              child: AppSectionTitle(t.allShops),
            ),
        ],
        ...others.map(row),
      ],
    );
  }
}

class _ResultRow extends StatelessWidget {
  const _ResultRow({required this.shop, required this.onTap});

  final ShopSummary shop;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;
    final where = shopWhere(context, shop);

    return InkWell(
      onTap: onTap,
      child: Container(
        constraints: BoxConstraints(minHeight: 60.h),
        padding: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: scheme.outlineVariant)),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox.square(
                dimension: 44,
                child: ShopPhoto(
                  url: shop.photoUrl,
                  category: categoryOf(shop.category),
                ),
              ),
            ),
            SizedBox(width: context.spacing.md.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    shop.name ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.titleSmall?.copyWith(
                      fontSize: context.fonts.s.sp,
                    ),
                  ),
                  if (where.isNotEmpty)
                    Text(
                      where,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
