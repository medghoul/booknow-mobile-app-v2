import 'package:booknow_mobile/core/constants/app_component_sizes.dart';
import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/core/structures/enums/ui_enums.dart';
import 'package:booknow_mobile/widgets/animations/index.dart';
import 'package:booknow_mobile/widgets/brand/index.dart';
import 'package:flutter/material.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// "Continue with Apple" / "Continue with Google".
///
/// The colours come from [AppProviderColors] rather than the palette because
/// both providers require their button to keep their own black/white
/// treatment; retinting it to the app's terracotta would fail review.
///
/// The mark itself is [AppProviderGlyph], which carries the rules about how
/// each company's artwork may be drawn.
class AppProviderButton extends StatelessWidget {
  const AppProviderButton({
    super.key,
    required this.provider,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
  });

  final AuthProviderKind provider;

  /// Provided by the caller so the copy stays localised.
  final String label;

  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final providers = context.providers;
    final (background, foreground, border) = switch (provider) {
      AuthProviderKind.apple => (
        providers.appleBackground,
        providers.appleForeground,
        providers.appleBorder,
      ),
      AuthProviderKind.google => (
        providers.googleBackground,
        providers.googleForeground,
        providers.googleBorder,
      ),
    };

    return AppPressScale(
      builder: (context, states) => SizedBox(
        width: double.infinity,
        height: AppComponentSizes.providerButtonHeight.h,
        child: OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          statesController: states,
          style: OutlinedButton.styleFrom(
            backgroundColor: background,
            foregroundColor: foreground,
            disabledBackgroundColor: background,
            disabledForegroundColor: foreground,
            side: BorderSide(
              color: border,
              width: AppComponentSizes.providerButtonBorderWidth,
            ),
            shape: RoundedRectangleBorder(borderRadius: context.radii.mdR),
          ),
          child: isLoading
              ? SizedBox(
                  width: context.icons.s.w,
                  height: context.icons.s.w,
                  child: CircularProgressIndicator(
                    strokeWidth: AppComponentSizes.progressIndicatorStrokeWidth,
                    valueColor: AlwaysStoppedAnimation<Color>(foreground),
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppProviderGlyph(provider: provider, color: foreground),
                    SizedBox(width: context.spacing.sm.w),
                    Flexible(
                      child: Text(
                        label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.labelLarge?.copyWith(
                          color: foreground,
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
