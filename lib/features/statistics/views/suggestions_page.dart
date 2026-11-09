import 'package:auto_route/auto_route.dart';
import 'package:booknow_mobile/core/di/dependency_injection.dart';
import 'package:booknow_mobile/core/error/error_messages.dart';
import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/domain/models/statistics.dart';
import 'package:booknow_mobile/domain/repositories/statistics_repository.dart';
import 'package:booknow_mobile/features/agenda/widgets/owner_today_parts.dart';
import 'package:booknow_mobile/features/statistics/cubit/statistics_lists_cubits.dart';
import 'package:booknow_mobile/features/statistics/widgets/statistics_parts.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// "Fade takes 36 minutes, your menu says 30." Never changes the menu by itself.
@RoutePage()
class SuggestionsPage extends StatelessWidget {
  const SuggestionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t;

    return BlocProvider(
      create: (_) => SuggestionsCubit(di<StatisticsRepository>())..load(),
      child: AppScaffold(
        padding: EdgeInsets.zero,
        appBar: AppAppBar(
          title: t.statistics.suggestions.title,
          backTooltip: t.common.back,
        ),
        body: const SuggestionsView(),
      ),
    );
  }
}

class SuggestionsView extends StatelessWidget {
  const SuggestionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<
      SuggestionsCubit,
      StatisticsLoadState<List<DurationSuggestion>>
    >(
      listenWhen: (before, after) =>
          before.failure != after.failure && after.data != null,
      listener: (context, state) {
        if (state.failure case final failure?) {
          AppSnackBar.error(context, failure.localized(context));
        }
      },
      builder: (context, state) {
        final t = context.t;
        final suggestions = t.statistics.suggestions;
        final items = state.data;

        if (items == null) {
          return state.isLoading
              ? const AppLoader.centered()
              : AppErrorState(
                  message: state.failure?.localized(context) ?? '',
                  retryLabel: t.common.retry,
                  onRetry: context.read<SuggestionsCubit>().load,
                );
        }
        if (items.isEmpty) {
          return AppEmptyState(
            icon: Icons.check_circle_outline_rounded,
            title: suggestions.emptyTitle,
            message: suggestions.emptyBody,
          );
        }

        return ListView(
          padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 24.h),
          children: [
            for (final item in items) ...[
              _SuggestionCard(item: item, busy: state.busy),
              SizedBox(height: 12.h),
            ],
            Text(
              suggestions.note,
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _SuggestionCard extends StatelessWidget {
  const _SuggestionCard({required this.item, required this.busy});

  final DurationSuggestion item;
  final bool busy;

  @override
  Widget build(BuildContext context) {
    final t = context.t.statistics.suggestions;
    final scheme = context.colorScheme;
    final cubit = context.read<SuggestionsCubit>();

    return StatCard(
      title: t.takes(name: item.name, real: item.realMin),
      children: [
        Text(
          t.menuSays(menu: item.menuMin, samples: item.samples),
          style: context.textTheme.bodyMedium?.copyWith(
            color: scheme.onSurfaceVariant,
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: busy ? null : () => cubit.dismiss(item),
                style: OutlinedButton.styleFrom(
                  minimumSize: Size.fromHeight(50.h),
                  foregroundColor: scheme.onSurface,
                  shape: RoundedRectangleBorder(
                    borderRadius: context.radii.mdR,
                  ),
                  textStyle: context.textTheme.labelLarge?.copyWith(
                    fontSize: context.fonts.s.sp,
                  ),
                ),
                child: Text(t.keep(minutes: item.menuMin)),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: TodayActionButton(
                label: t.accept(minutes: item.suggestedMin),
                isLoading: busy,
                onPressed: () async {
                  final saved = await cubit.accept(item);
                  if (saved && context.mounted) {
                    AppSnackBar.success(context, t.accepted);
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
