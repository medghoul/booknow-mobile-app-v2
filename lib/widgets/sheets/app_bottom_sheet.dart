import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// A modal bottom sheet.
///
/// Sheets mean "continue a task" — picking a slot, editing a detail, choosing
/// a payment method. For a choice that stops the user and asks them to
/// confirm, use [AppDialog] instead.
class AppBottomSheet extends StatelessWidget {
  const AppBottomSheet({
    super.key,
    required this.child,
    this.title,
    this.isScrollControlled = false,
  });

  final Widget child;
  final String? title;
  final bool isScrollControlled;

  /// Presents [builder]'s widget as a modal sheet and resolves to whatever it
  /// pops with.
  static Future<T?> show<T>(
    BuildContext context, {
    required WidgetBuilder builder,
    String? title,
    bool isScrollControlled = true,
    bool isDismissible = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollControlled,
      isDismissible: isDismissible,
      enableDrag: isDismissible,
      useSafeArea: true,
      sheetAnimationStyle: AnimationStyle(
        duration: context.motion.normal,
        curve: context.motion.curveEmphasized,
        reverseDuration: context.motion.fast,
        reverseCurve: context.motion.curve,
      ),
      builder: (sheetContext) => AppBottomSheet(
        title: title,
        isScrollControlled: isScrollControlled,
        child: Builder(builder: builder),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Lifts the sheet clear of the keyboard when it holds a field.
      padding: EdgeInsets.only(bottom: context.keyboardInset),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 10, 16.w, 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: context.colorScheme.outline,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              if (title != null) ...[
                Text(title!, style: context.textTheme.titleMedium),
                const SizedBox(height: 14),
              ],
              Flexible(child: child),
            ],
          ),
        ),
      ),
    );
  }
}
