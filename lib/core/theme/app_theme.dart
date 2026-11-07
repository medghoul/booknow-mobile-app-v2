import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:booknow_mobile/core/constants/app_colors.dart';
import 'package:booknow_mobile/core/constants/app_component_sizes.dart';
import 'package:booknow_mobile/core/extensions/color_extension.dart';
import 'package:booknow_mobile/core/theme/extensions/theme_extensions.dart';
import 'package:booknow_mobile/core/theme/text_theme.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// The light and dark [ThemeData] for the app.
///
/// Light and dark are two separate palettes, never inversions of each other —
/// dark elevation is carried by a lighter surface rather than a heavier shadow.
///
/// Neither getter is `const`: the theme extensions read `AppRadii` and
/// `AppSpacing`, whose responsive `.r` / `.w` getters are resolved at runtime.
class AppTheme {
  static ThemeData get light => _build(
    brightness: Brightness.light,
    textTheme: AppTextTheme.lightTextTheme,
    background: AppColors.lightBg,
    surface: AppColors.lightSurface,
    surfaceElevated: AppColors.lightSurfaceElevated,
    text: AppColors.lightText,
    textSecondary: AppColors.lightTextSecondary,
    primary: AppColors.lightPrimary,
    onPrimary: AppColors.lightOnPrimary,
    accent: AppColors.lightAccent,
    danger: AppColors.lightDangerFill,
    onDanger: AppColors.lightOnDanger,
    border: AppColors.lightBorder,
    borderStrong: AppColors.lightBorderStrong,
    onAccent: AppColors.lightOnPrimary,
    primaryContainer: AppColors.lightPrimaryContainer,
    secondaryContainer: AppColors.lightSecondaryContainer,
    onSecondaryContainer: AppColors.lightOnSecondaryContainer,
    extensions: [
      AppSpacing.standard,
      AppRadii.standard,
      AppFontSizes.standard,
      AppIconSizes.standard,
      AppMotion.standard,
      AppShadows.light,
      AppDecorations.light,
      AppStatusColors.light,
      QueueColors.light,
      AppProviderColors.light,
    ],
  );

  static ThemeData get dark => _build(
    brightness: Brightness.dark,
    textTheme: AppTextTheme.darkTextTheme,
    background: AppColors.darkBg,
    surface: AppColors.darkSurface,
    surfaceElevated: AppColors.darkSurfaceElevated,
    text: AppColors.darkText,
    textSecondary: AppColors.darkTextSecondary,
    primary: AppColors.darkPrimary,
    onPrimary: AppColors.darkOnPrimary,
    accent: AppColors.darkAccent,
    danger: AppColors.darkDangerFill,
    onDanger: AppColors.darkOnDanger,
    border: AppColors.darkBorder,
    borderStrong: AppColors.darkBorderStrong,
    onAccent: AppColors.darkOnAccent,
    primaryContainer: AppColors.darkPrimaryContainer,
    secondaryContainer: AppColors.darkSecondaryContainer,
    onSecondaryContainer: AppColors.darkOnSecondaryContainer,
    extensions: [
      AppSpacing.standard,
      AppRadii.standard,
      AppFontSizes.standard,
      AppIconSizes.standard,
      AppMotion.standard,
      AppShadows.dark,
      AppDecorations.dark,
      AppStatusColors.dark,
      QueueColors.dark,
      AppProviderColors.dark,
    ],
  );

  static ThemeData _build({
    required Brightness brightness,
    required TextTheme textTheme,
    required Color background,
    required Color surface,
    required Color surfaceElevated,
    required Color text,
    required Color textSecondary,
    required Color primary,
    required Color onPrimary,
    required Color accent,
    required Color danger,
    required Color onDanger,
    required Color border,
    required Color borderStrong,
    required Color onAccent,
    required Color primaryContainer,
    required Color secondaryContainer,
    required Color onSecondaryContainer,
    required List<ThemeExtension<dynamic>> extensions,
  }) {
    final radii = AppRadii.standard;
    final spacing = AppSpacing.standard;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      extensions: extensions,
      textTheme: textTheme,
      scaffoldBackgroundColor: background,
      canvasColor: background,
      dividerColor: border,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: primary,
        onPrimary: onPrimary,
        primaryContainer: primaryContainer,
        onPrimaryContainer: text,
        secondary: accent,
        onSecondary: onAccent,
        secondaryContainer: secondaryContainer,
        onSecondaryContainer: onSecondaryContainer,
        error: danger,
        onError: onDanger,
        surface: surfaceElevated,
        onSurface: text,
        surfaceContainerLowest: surfaceElevated,
        surfaceContainerLow: background,
        surfaceContainer: surface,
        surfaceContainerHigh: surface,
        surfaceContainerHighest: surface,
        onSurfaceVariant: textSecondary,
        outline: borderStrong,
        outlineVariant: border,
        shadow: AppColors.black,
      ),
      iconTheme: IconThemeData(color: text),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: accent,
        selectionColor: accent.withOpacityValue(0.3),
        selectionHandleColor: accent,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: brightness == Brightness.light
            ? primary
            : surfaceElevated,
        surfaceTintColor: brightness == Brightness.light
            ? primary
            : surfaceElevated,
        foregroundColor: brightness == Brightness.light ? onPrimary : text,
        systemOverlayStyle: brightness == Brightness.light
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.light,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w800,
          color: brightness == Brightness.light ? onPrimary : text,
        ),
        iconTheme: IconThemeData(
          color: brightness == Brightness.light ? onPrimary : text,
        ),
      ),
      cardTheme: CardThemeData(
        color: surfaceElevated,
        surfaceTintColor: surfaceElevated,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: radii.xlR),
      ),
      dividerTheme: DividerThemeData(color: border, thickness: 1),
      listTileTheme: ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(horizontal: spacing.lg.w),
        textColor: text,
        iconColor: text,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(color: primary),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: onPrimary,
          disabledBackgroundColor: surface,
          disabledForegroundColor: textSecondary,
          elevation: 0,
          minimumSize: Size(0, AppComponentSizes.buttonNormalHeight.h),
          padding: EdgeInsets.symmetric(horizontal: spacing.xl.w),
          textStyle: textTheme.labelLarge,
          shape: RoundedRectangleBorder(borderRadius: radii.mdR),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: text,
          disabledForegroundColor: text.withOpacityValue(
            AppComponentSizes.disabledOpacity,
          ),
          minimumSize: Size(0, AppComponentSizes.buttonNormalHeight.h),
          padding: EdgeInsets.symmetric(horizontal: spacing.xl.w),
          textStyle: textTheme.labelLarge,
          side: BorderSide(
            color: borderStrong,
            width: AppComponentSizes.outlinedButtonBorderWidth,
          ),
          shape: RoundedRectangleBorder(borderRadius: radii.mdR),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: accent,
          overlayColor: accent.withOpacityValue(0.1),
          textStyle: textTheme.labelLarge,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        constraints: BoxConstraints(minHeight: AppComponentSizes.fieldHeight.h),
        fillColor: surface,
        prefixIconColor: textSecondary,
        suffixIconColor: textSecondary,
        labelStyle: textTheme.bodyMedium?.copyWith(color: textSecondary),
        hintStyle: textTheme.bodyMedium?.copyWith(color: textSecondary),
        errorStyle: textTheme.bodySmall?.copyWith(color: danger),
        errorMaxLines: 2,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        border: OutlineInputBorder(
          borderRadius: radii.mdR,
          borderSide: BorderSide(color: border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: radii.mdR,
          borderSide: BorderSide(color: border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: radii.mdR,
          borderSide: BorderSide(color: accent, width: 1.5.w),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: radii.mdR,
          borderSide: BorderSide(color: danger, width: 1.5.w),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: radii.mdR,
          borderSide: BorderSide(color: danger, width: 2.0.w),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: radii.mdR,
          borderSide: BorderSide(color: border),
        ),
      ),
      // Sheets continue a task; dialogs stop and confirm. Their shapes say so.
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: surfaceElevated,
        surfaceTintColor: surfaceElevated,
        elevation: 0,
        showDragHandle: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: radii.xxlRadius),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: surfaceElevated,
        surfaceTintColor: surfaceElevated,
        elevation: 0,
        titleTextStyle: textTheme.displaySmall,
        contentTextStyle: textTheme.bodyMedium?.copyWith(color: textSecondary),
        shape: RoundedRectangleBorder(borderRadius: radii.xxlR),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        contentTextStyle: textTheme.bodyMedium,
        shape: RoundedRectangleBorder(borderRadius: radii.smR),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: surface,
        side: BorderSide(color: border),
        labelStyle: textTheme.labelMedium,
        shape: RoundedRectangleBorder(borderRadius: radii.pillR),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: surfaceElevated,
        selectedItemColor: text,
        unselectedItemColor: textSecondary,
        selectedLabelStyle: textTheme.labelSmall,
        unselectedLabelStyle: textTheme.labelSmall,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected) ? onAccent : text,
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected) ? accent : surface,
        ),
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(color: text, borderRadius: radii.smR),
        textStyle: textTheme.bodySmall?.copyWith(color: background),
      ),
    );
  }
}
