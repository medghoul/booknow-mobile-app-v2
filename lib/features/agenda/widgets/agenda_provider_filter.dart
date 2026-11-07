import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/features/agenda/cubit/owner_agenda_cubit.dart';
import 'package:booknow_mobile/features/agenda/cubit/owner_agenda_state.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// "Everyone", then one chip per person: whose day the agenda shows.
///
/// Only drawn for a shop with a team. A shop of one has nobody to choose
/// between, and its agenda reads exactly as it did before (providers §0).
class AgendaProviderFilter extends StatelessWidget {
  const AgendaProviderFilter({super.key, this.padding});

  /// Around the chips; the screen gutter by default, for a filter that runs
  /// edge to edge under the date strip.
  final EdgeInsetsGeometry? padding;

  /// Whether the filter has anything to offer for [state].
  static bool showsFor(OwnerAgendaState state) =>
      (state.day?.hasTeam ?? false) || state.providerId != null;

  /// The name to put on [row], or null when the day is one person's anyway.
  static String? labelFor(OwnerAgendaState state, AgendaRow row) {
    final day = state.day;
    if (day == null || !day.hasTeam || state.providerId != null) return null;
    return day.nameOf(row.providerId);
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<OwnerAgendaCubit>().state;
    final providers = state.day?.providers ?? const <AgendaProvider>[];
    final cubit = context.read<OwnerAgendaCubit>();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          _Chip(
            label: context.t.agenda.everyone,
            isSelected: state.providerId == null,
            onTap: () => cubit.showProvider(null),
          ),
          for (final provider in providers) ...[
            SizedBox(width: context.spacing.sm.w),
            _Chip(
              label: provider.name ?? '',
              isSelected: state.providerId == provider.id,
              onTap: () => cubit.showProvider(provider.id),
            ),
          ],
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      showCheckmark: false,
      onSelected: (_) => onTap(),
    );
  }
}
