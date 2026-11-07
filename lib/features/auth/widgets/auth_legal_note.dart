import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// "By continuing you accept the Terms and the Privacy policy."
///
/// The two links are built by finding their words inside the sentence rather
/// than by concatenating fragments, so translators can move them wherever the
/// grammar needs them without the code having to change.
class AuthLegalNote extends StatefulWidget {
  const AuthLegalNote({super.key, this.onOpenTerms, this.onOpenPrivacy});

  final VoidCallback? onOpenTerms;
  final VoidCallback? onOpenPrivacy;

  @override
  State<AuthLegalNote> createState() => _AuthLegalNoteState();
}

class _AuthLegalNoteState extends State<AuthLegalNote> {
  final List<TapGestureRecognizer> _recognizers = [];

  @override
  void dispose() {
    for (final recognizer in _recognizers) {
      recognizer.dispose();
    }
    super.dispose();
  }

  TapGestureRecognizer _recognizer(VoidCallback? onTap) {
    final recognizer = TapGestureRecognizer()..onTap = onTap;
    _recognizers.add(recognizer);
    return recognizer;
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.auth.signIn;
    final baseStyle = context.textTheme.bodySmall?.copyWith(
      color: context.colorScheme.onSurfaceVariant,
    );
    final linkStyle = baseStyle?.copyWith(
      color: context.colorScheme.primary,
      fontWeight: FontWeight.w700,
      decoration: TextDecoration.underline,
      decorationColor: context.colorScheme.primary,
    );

    return Text.rich(
      TextSpan(
        children: _spansFor(
          sentence: t.terms,
          links: {
            t.termsLink: widget.onOpenTerms,
            t.privacyLink: widget.onOpenPrivacy,
          },
          baseStyle: baseStyle,
          linkStyle: linkStyle,
        ),
      ),
      textAlign: TextAlign.center,
    );
  }

  /// Splits [sentence] on each link word, in the order they appear, and marks
  /// those pieces up as taps. A word the translator dropped simply doesn't
  /// become a link — the sentence still reads correctly.
  List<InlineSpan> _spansFor({
    required String sentence,
    required Map<String, VoidCallback?> links,
    TextStyle? baseStyle,
    TextStyle? linkStyle,
  }) {
    final positions = <int, MapEntry<String, VoidCallback?>>{};
    for (final link in links.entries) {
      final index = sentence.indexOf(link.key);
      if (index != -1) positions[index] = link;
    }

    final spans = <InlineSpan>[];
    var cursor = 0;

    for (final index in positions.keys.toList()..sort()) {
      final link = positions[index]!;
      if (index > cursor) {
        spans.add(
          TextSpan(text: sentence.substring(cursor, index), style: baseStyle),
        );
      }
      spans.add(
        TextSpan(
          text: link.key,
          style: linkStyle,
          recognizer: _recognizer(link.value),
        ),
      );
      cursor = index + link.key.length;
    }

    if (cursor < sentence.length) {
      spans.add(TextSpan(text: sentence.substring(cursor), style: baseStyle));
    }

    return spans;
  }
}
