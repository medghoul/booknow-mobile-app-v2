import 'package:booknow_mobile/core/constants/app_component_sizes.dart';
import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// The app's on/off control.
///
/// Drawn rather than themed. Material's switch has a different anatomy — the
/// thumb shrinks when it is off, and the track carries an icon — and no
/// amount of [SwitchThemeData] turns that into the design's plain capsule with
/// a thumb that only moves.
///
/// Off is an outlined track, not merely a paler one: on the recessed surface
/// a filled-but-unfilled capsule reads as a gap in the card.
class AppSwitch extends StatelessWidget {
  const AppSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.semanticLabel,
  });

  final bool value;

  /// Null disables the control. A switch that cannot move is dimmed rather
  /// than hidden: the setting still exists, it is simply not the user's to
  /// change right now.
  final ValueChanged<bool>? onChanged;

  /// What the switch is for, where the row around it does not already say so
  /// to a screen reader.
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final isEnabled = onChanged != null;
    final scheme = context.colorScheme;

    final track = AnimatedContainer(
      duration: context.motion.fast,
      curve: context.motion.curve,
      width: 52,
      height: 32,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: value ? scheme.secondary : scheme.outline,
        borderRadius: BorderRadius.circular(16),
      ),
      child: AnimatedAlign(
        duration: context.motion.fast,
        curve: context.motion.curve,
        alignment: value ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          width: 26,
          height: 26,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: scheme.surface,
          ),
        ),
      ),
    );

    return Semantics(
      label: semanticLabel,
      toggled: value,
      enabled: isEnabled,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: isEnabled
            ? () {
                HapticFeedback.selectionClick();
                onChanged!(!value);
              }
            : null,
        child: SizedBox(
          // The capsule is 30 tall; the target it sits in is not.
          height: AppComponentSizes.filledIconButtonSize.h,
          child: Center(
            child: isEnabled
                ? track
                : Opacity(
                    opacity: AppComponentSizes.disabledOpacity,
                    child: track,
                  ),
          ),
        ),
      ),
    );
  }
}
