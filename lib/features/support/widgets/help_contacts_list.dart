import 'package:booknow_mobile/core/config/app_config.dart';
import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/core/services/launcher/link_service.dart';
import 'package:booknow_mobile/core/structures/enums/user_role.dart';
import 'package:booknow_mobile/features/support/widgets/contact_support_sheet.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// The help screen's body: the four questions, the two ways to reach someone,
/// and the small print.
///
/// One screen for both roles, as the design has it. What differs is what it
/// can offer: the call row needs a shop to call, and the write row needs a
/// support address in the build's configuration. A row with nothing behind it
/// is not shown greyed out — it is not shown.
class HelpContactsList extends StatefulWidget {
  const HelpContactsList({
    super.key,
    this.appVersion,
    this.shopPhone,
    this.replyTo,
    this.role,
    this.links = const LinkService(),
  });

  /// Printed in the footer, so a bug report can say which build it came from.
  final String? appVersion;

  /// The shop behind the user's appointment, when there is one.
  ///
  /// Null today for everybody: a customer's shop comes from their booking and
  /// the bookings screen is still a placeholder, and an owner has no shop to
  /// call but their own. The row exists for the moment bookings land — one
  /// argument from the page — rather than being bolted on then.
  final String? shopPhone;

  /// Where support's answer would go. Shown in the sheet, not here.
  final String? replyTo;

  final UserRole? role;
  final LinkService links;

  @override
  State<HelpContactsList> createState() => _HelpContactsListState();
}

const String _phoneIcon =
    'M22 16.9v3a2 2 0 0 1-2.2 2 19.8 19.8 0 0 1-8.6-3 19.5 19.5 0 0 1-6-6 19.8 19.8 0 0 1-3-8.7A2 2 0 0 1 4.1 2h3a2 2 0 0 1 2 1.7c.1 1 .4 1.9.7 2.8a2 2 0 0 1-.5 2.1L8.1 9.9a16 16 0 0 0 6 6l1.3-1.3a2 2 0 0 1 2.1-.4c.9.3 1.8.6 2.8.7a2 2 0 0 1 1.7 2z';
const String _chatIcon =
    'M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z';

class _HelpContactsListState extends State<HelpContactsList> {
  /// Which answer is open — one at a time, so the card stays a list of
  /// questions rather than becoming a page of prose.
  ///
  /// Starts on the first, as the design draws it: the fee is the question the
  /// payment screen raises, and it is why most people open this screen.
  int _open = 0;

  /// The questions, in the design's order: what the booking and payment
  /// screens leave people wondering about.
  List<(String, String)> _questions(Translations t) {
    final faq = t.help.faq;

    return [
      (faq.feeQuestion, faq.feeAnswer),
      (faq.cancelQuestion, faq.cancelAnswer),
      (faq.refundQuestion, faq.refundAnswer),
      (faq.lateQuestion, faq.lateAnswer),
    ];
  }

  Future<void> _call(String phone) async {
    // Spacing and brackets are how the number is written, not how it is
    // dialled.
    final digits = phone.replaceAll(RegExp(r'[^\d+]'), '');
    final opened = await widget.links.open(Uri(scheme: 'tel', path: digits));
    if (opened || !mounted) return;

    AppSnackBar.error(context, context.t.help.callFailed);
  }

  Future<void> _write(String supportEmail) async {
    final sent = await ContactSupportSheet.open(
      context,
      supportEmail: supportEmail,
      replyTo: widget.replyTo,
      role: widget.role,
      appVersion: widget.appVersion,
      links: widget.links,
    );
    if (!(sent ?? false) || !mounted) return;

    AppSnackBar.success(context, context.t.help.write.opened);
  }

  Future<void> _openLink(String url) async {
    final opened = await widget.links.open(Uri.parse(url));
    if (opened || !mounted) return;

    AppSnackBar.error(context, context.t.help.linkFailed);
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.help;
    final questions = _questions(context.t);
    final supportEmail = AppConfig.supportEmail;
    final phone = widget.shopPhone;

    final contacts = <Widget>[
      if (phone != null)
        AppSettingsRow(
          icon: _phoneIcon,
          label: t.callShop,
          value: t.callShopSubtitle,
          onTap: () => _call(phone),
        ),
      if (supportEmail.isNotEmpty)
        AppSettingsRow(
          icon: _chatIcon,
          label: t.writeUs,
          value: t.writeUsSubtitle,
          onTap: () => _write(supportEmail),
        ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppSectionTitle(t.faqSection),
                SizedBox(height: 10.h),
                AppSettingsCard(
                  children: [
                    for (final (index, (question, answer)) in questions.indexed)
                      _FaqRow(
                        question: question,
                        answer: answer,
                        isOpen: index == _open,
                        onTap: () =>
                            setState(() => _open = index == _open ? -1 : index),
                      ),
                  ],
                ),
                SizedBox(height: context.spacing.xl.h),

                // The heading and the card go together: a build with neither
                // a shop to call nor a support address would otherwise draw
                // "Serve altro?" over an empty rounded box.
                if (contacts.isNotEmpty) ...[
                  AppSectionTitle(t.needMore),
                  SizedBox(height: context.spacing.sm.h),
                  AppSettingsCard(children: contacts),
                  SizedBox(height: context.spacing.xl.h),
                ],
              ],
            ),
          ),
        ),
        _LegalFooter(appVersion: widget.appVersion, onOpenLink: _openLink),
      ],
    );
  }
}

/// One question, and its answer when it is the open one.
///
/// The answer expands in place rather than opening a screen: these are three
/// lines each, and a screen per line would turn four questions into four
/// navigations.
class _FaqRow extends StatelessWidget {
  const _FaqRow({
    required this.question,
    required this.answer,
    required this.isOpen,
    required this.onTap,
  });

  final String question;
  final String answer;
  final bool isOpen;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      expanded: isOpen,
      container: true,
      child: AppPressScale.tap(
        onTap: onTap,
        child: AnimatedSize(
          duration: context.motion.fast,
          alignment: Alignment.topCenter,
          child: Container(
            width: double.infinity,
            constraints: BoxConstraints(minHeight: 52.h),
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  question,
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (isOpen) ...[
                  const SizedBox(height: 6),
                  Text(
                    answer,
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontSize: 14.sp,
                      height: 1.4,
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Terms, privacy and the build, under everything else.
///
/// The two documents are links only where the build knows their addresses.
/// An app that shows "Termini" and opens nothing is worse than one that shows
/// only its version.
class _LegalFooter extends StatelessWidget {
  const _LegalFooter({required this.appVersion, required this.onOpenLink});

  final String? appVersion;
  final ValueChanged<String> onOpenLink;

  @override
  Widget build(BuildContext context) {
    final t = context.t.help;
    final terms = AppConfig.termsUrl;
    final privacy = AppConfig.privacyUrl;

    return Padding(
      padding: EdgeInsets.only(
        bottom: context.spacing.lg.h + context.mediaQuery.padding.bottom,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (terms.isNotEmpty)
            _LegalLink(label: t.terms, onTap: () => onOpenLink(terms)),
          if (privacy.isNotEmpty)
            _LegalLink(label: t.privacy, onTap: () => onOpenLink(privacy)),
          SizedBox(width: context.spacing.sm.w),
          if (appVersion != null)
            Text(
              t.version(version: appVersion!),
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
        ],
      ),
    );
  }
}

/// One of the two documents, underlined.
///
/// Underlined and in the action colour because that is how the app marks a
/// link in running text — the sign-in screen's legal note sets the same two
/// words the same way, and a user who has seen one should recognise the other.
class _LegalLink extends StatelessWidget {
  const _LegalLink({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = context.colorScheme.primary;

    return Semantics(
      link: true,
      child: AppPressScale.tap(
        onTap: onTap,
        child: Padding(
          // Padding rather than a bare word: the footer's type is small, and
          // a link still has to be a 44-point target.
          padding: EdgeInsets.symmetric(
            horizontal: context.spacing.md.w,
            vertical: context.spacing.md.h,
          ),
          child: Text(
            label,
            style: context.textTheme.bodySmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
              decoration: TextDecoration.underline,
              decorationColor: color,
            ),
          ),
        ),
      ),
    );
  }
}
