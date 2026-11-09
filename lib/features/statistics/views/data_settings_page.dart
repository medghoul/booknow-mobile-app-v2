import 'package:auto_route/auto_route.dart';
import 'package:booknow_mobile/core/di/dependency_injection.dart';
import 'package:booknow_mobile/core/error/error_messages.dart';
import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/domain/models/statistics.dart';
import 'package:booknow_mobile/domain/repositories/statistics_repository.dart';
import 'package:booknow_mobile/features/statistics/cubit/statistics_lists_cubits.dart';
import 'package:booknow_mobile/features/statistics/widgets/statistics_parts.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// Settings > Data: what is stored, and for how long (statistics §11).
@RoutePage()
class DataSettingsPage extends StatelessWidget {
  const DataSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t;

    return BlocProvider(
      create: (_) => DataSettingsCubit(di<StatisticsRepository>())..load(),
      child: AppScaffold(
        padding: EdgeInsets.zero,
        appBar: AppAppBar(
          title: t.statistics.data.title,
          backTooltip: t.common.back,
        ),
        body: const DataSettingsView(),
      ),
    );
  }
}

class DataSettingsView extends StatelessWidget {
  const DataSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<
      DataSettingsCubit,
      StatisticsLoadState<StatisticsSettings>
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
        final settings = state.data;

        if (settings == null) {
          return state.isLoading
              ? const AppLoader.centered()
              : AppErrorState(
                  message: state.failure?.localized(context) ?? '',
                  retryLabel: t.common.retry,
                  onRetry: context.read<DataSettingsCubit>().load,
                );
        }

        return _Settings(settings: settings, busy: state.busy);
      },
    );
  }
}

class _Settings extends StatelessWidget {
  const _Settings({required this.settings, required this.busy});

  final StatisticsSettings settings;
  final bool busy;

  /// Shortening deletes history that cannot be brought back, so it asks first.
  Future<void> _choose(BuildContext context, int months) async {
    final t = context.t.statistics.data;
    final cubit = context.read<DataSettingsCubit>();

    if (months < settings.retentionMonths) {
      final confirmed = await AppDialog.show(
        context,
        title: t.shortenTitle(months: months),
        message: t.shortenBody,
        confirmLabel: t.shortenConfirm,
        cancelLabel: context.t.common.cancel,
        isDestructive: true,
      );
      if (!confirmed) return;
    }
    await cubit.setRetention(months);
  }

  /// Comparing named staff is worker monitoring, so it is never one stray tap.
  Future<void> _toggleStaff(BuildContext context, bool value) async {
    final t = context.t.statistics.data;
    final cubit = context.read<DataSettingsCubit>();

    if (value) {
      final confirmed = await AppDialog.show(
        context,
        title: t.staffConfirmTitle,
        message: t.staffConfirmBody,
        confirmLabel: t.staffConfirm,
        cancelLabel: context.t.common.cancel,
      );
      if (!confirmed) return;
    }
    await cubit.setStaffStatistics(value);
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.statistics.data;
    final scheme = context.colorScheme;
    final note = context.textTheme.bodySmall?.copyWith(
      color: scheme.onSurfaceVariant,
    );

    return ListView(
      padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 24.h),
      children: [
        StatCard(
          title: t.storedTitle,
          children: [
            Text(t.storedBody, style: context.textTheme.bodyMedium),
            SizedBox(height: 8.h),
            Text(t.notStored, style: context.textTheme.bodyMedium),
          ],
        ),
        SizedBox(height: 12.h),
        StatCard(
          title: t.retentionTitle,
          children: [
            Text(t.retentionBody, style: note),
            SizedBox(height: 10.h),
            for (final months in settings.retentionChoices)
              _Choice(
                label: t.months(n: months),
                selected: months == settings.retentionMonths,
                enabled: !busy,
                onTap: () => _choose(context, months),
              ),
          ],
        ),
        SizedBox(height: 12.h),
        StatCard(
          title: t.staffTitle,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(t.staffBody, style: context.textTheme.bodyMedium),
                ),
                const SizedBox(width: 12),
                AppSwitch(
                  value: settings.staffStatistics,
                  semanticLabel: t.staffTitle,
                  onChanged: busy ? null : (on) => _toggleStaff(context, on),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Text(t.staffNote, style: note),
          ],
        ),
      ],
    );
  }
}

class _Choice extends StatelessWidget {
  const _Choice({
    required this.label,
    required this.selected,
    required this.enabled,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return Semantics(
      button: true,
      selected: selected,
      child: InkWell(
        onTap: selected || !enabled ? null : onTap,
        borderRadius: context.radii.smR,
        child: Container(
          constraints: const BoxConstraints(minHeight: 48),
          child: Row(
            children: [
              Expanded(child: Text(label, style: context.textTheme.bodyMedium)),
              if (selected)
                AppLineIcon(AppLineIcons.check, color: scheme.secondary),
            ],
          ),
        ),
      ),
    );
  }
}
