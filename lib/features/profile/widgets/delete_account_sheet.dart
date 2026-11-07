import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// One thing deleting the account costs.
///
/// Spelling the consequences out is the whole point of the sheet. "Sei
/// sicuro?" asks the user to confirm something they were never told, and the
/// answer to it is always yes.
@immutable
class DeleteConsequence {
  /// Something taken away — a cross, in the danger colour.
  const DeleteConsequence.loss(this.text, {this.emphasis}) : isLoss = true;

  /// Something that simply will not change — a check, in the quiet colour.
  /// Money already paid is the design's example: not a loss caused by
  /// deleting, but not coming back either.
  const DeleteConsequence.fact(this.text, {this.emphasis}) : isLoss = false;

  final String text;

  /// A span of [text] to set in bold: the shop's name, a booking's time. The
  /// line the user has to actually read is the one naming their own thing.
  final String? emphasis;

  final bool isLoss;
}

/// The confirmation for deleting an account.
///
/// A sheet rather than the dialog the rest of the app confirms with, and
/// deliberately: the design puts the destructive button above the safe one so
/// its buttons sit mid-screen, side by side, and the one a thumb reaches
/// first is a coin toss.
class DeleteAccountSheet extends StatelessWidget {
  const DeleteAccountSheet({super.key, required this.consequences});

  final List<DeleteConsequence> consequences;

  static Future<bool> confirm(
    BuildContext context, {
    required List<DeleteConsequence> consequences,
  }) async {
    final confirmed = await AppBottomSheet.show<bool>(
      context,
      builder: (_) => DeleteAccountSheet(consequences: consequences),
    );
    return confirmed ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.profile.deleteSheet;
    final tint = context.status.error;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Semantics(
          header: true,
          child: Text(t.title, style: context.textTheme.titleMedium),
        ),
        const SizedBox(height: 14),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: tint.background,
            borderRadius: context.radii.mdR,
          ),
          child: Text(
            [for (final item in consequences) item.text, t.body].join(' '),
            style: context.textTheme.labelMedium?.copyWith(
              fontSize: 14.sp,
              color: tint.foreground,
            ),
          ),
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 50.h,
          child: ElevatedButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(t.keep),
          ),
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 48,
          child: TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: tint.foreground),
            child: Text(t.confirm),
          ),
        ),
      ],
    );
  }
}
