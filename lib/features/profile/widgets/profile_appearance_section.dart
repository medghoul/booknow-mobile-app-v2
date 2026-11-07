import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// Light or dark, switched in place. Per device, so it is stored locally.
///
/// Until someone chooses, the app follows the phone, and the control shows
/// whichever of the two that currently is.
class ProfileAppearanceSection extends StatelessWidget {
  const ProfileAppearanceSection({
    super.key,
    required this.themeMode,
    required this.onThemeModeChanged,
  });

  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeModeChanged;

  @override
  Widget build(BuildContext context) {
    final t = context.t.profile;
    final showing = switch (themeMode) {
      ThemeMode.light => ThemeMode.light,
      ThemeMode.dark => ThemeMode.dark,
      ThemeMode.system =>
        MediaQuery.platformBrightnessOf(context) == Brightness.dark
            ? ThemeMode.dark
            : ThemeMode.light,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        AppSectionTitle(t.appearanceSection),
        SizedBox(height: context.spacing.sm.h),
        AppSegmentedControl<ThemeMode>(
          value: showing,
          onChanged: onThemeModeChanged,
          segments: [
            AppSegment(value: ThemeMode.light, label: t.themeLight),
            AppSegment(value: ThemeMode.dark, label: t.themeDark),
          ],
        ),
      ],
    );
  }
}
