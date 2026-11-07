import 'package:booknow_mobile/core/constants/app_component_sizes.dart';
import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/core/services/launcher/link_service.dart';
import 'package:booknow_mobile/core/structures/enums/user_role.dart';
import 'package:booknow_mobile/features/support/support_message.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// Writing to support: what it is about, what happened, send.
///
/// A sheet, as the design draws it — writing a message continues the task the
/// help screen started, and the FAQ the user has just read stays visible
/// behind it.
///
/// It composes a `mailto:` and hands it to the mail app, because the API has
/// no support endpoint. That is the one real deviation from the design, and it
/// is why the sheet says so up front and why Invia reports "pronto nella tua
/// app email" rather than "inviato": the app cannot claim to have sent
/// something it handed to another app.
class ContactSupportSheet extends StatefulWidget {
  const ContactSupportSheet({
    super.key,
    required this.supportEmail,
    this.replyTo,
    this.role,
    this.appVersion,
    this.links = const LinkService(),
  });

  /// Where the message goes. The sheet is never opened without one — the row
  /// that opens it is hidden while the address is unconfigured.
  final String supportEmail;

  /// The account's address, shown so the user knows where the answer lands.
  final String? replyTo;

  final UserRole? role;
  final String? appVersion;
  final LinkService links;

  /// Opens the sheet and resolves to true once the mail app has the message.
  static Future<bool?> open(
    BuildContext context, {
    required String supportEmail,
    String? replyTo,
    UserRole? role,
    String? appVersion,
    LinkService links = const LinkService(),
  }) {
    return AppBottomSheet.show<bool>(
      context,
      builder: (_) => ContactSupportSheet(
        supportEmail: supportEmail,
        replyTo: replyTo,
        role: role,
        appVersion: appVersion,
        links: links,
      ),
    );
  }

  @override
  State<ContactSupportSheet> createState() => _ContactSupportSheetState();
}

class _ContactSupportSheetState extends State<ContactSupportSheet> {
  final _message = TextEditingController();

  /// Nothing is picked to begin with, where the design shows "Pagamento"
  /// already selected. A prefilled topic is the one nobody corrects, and it
  /// decides which queue the mail lands in — so a refund question arriving
  /// labelled "Pagamento" by default is worse than one more tap.
  SupportTopic? _topic;

  @override
  void initState() {
    super.initState();
    _message.addListener(_onTyped);
  }

  @override
  void dispose() {
    _message.removeListener(_onTyped);
    _message.dispose();
    super.dispose();
  }

  /// Invia turns on and off as the field fills and empties.
  void _onTyped() => setState(() {});

  bool get _canSend => _topic != null && _message.text.trim().isNotEmpty;

  Future<void> _send() async {
    final t = context.t;
    final message = SupportMessage(
      topic: _topic!,
      body: _message.text,
      from: widget.replyTo,
      role: widget.role,
      appVersion: widget.appVersion,
    );

    final opened = await widget.links.open(
      message.mailto(widget.supportEmail, t),
    );
    if (!mounted) return;

    if (!opened) {
      // The message stays in the sheet: closing it would throw away what the
      // user wrote in exchange for an error.
      AppSnackBar.error(
        context,
        t.help.write.noMailApp(email: widget.supportEmail),
      );
      return;
    }

    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.help.write;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Flexible(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(t.title, style: context.textTheme.displaySmall),
                SizedBox(height: context.spacing.xs.h),
                Text(
                  widget.replyTo == null
                      ? t.replyGeneric
                      : t.replyTo(email: widget.replyTo!),
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: context.spacing.lg.h),

                Text(
                  t.topicLabel,
                  style: context.textTheme.labelMedium?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: context.spacing.sm.h),
                Wrap(
                  spacing: context.spacing.sm.w,
                  runSpacing: context.spacing.sm.h,
                  children: [
                    for (final topic in SupportTopic.values)
                      _TopicChip(
                        topic: topic,
                        isSelected: topic == _topic,
                        onTap: () => setState(() => _topic = topic),
                      ),
                  ],
                ),
                SizedBox(height: context.spacing.lg.h),

                AppTextField(
                  controller: _message,
                  label: t.messageLabel,
                  hint: t.messageHint,
                  maxLines: 4,
                  keyboardType: TextInputType.multiline,
                ),
                SizedBox(height: context.spacing.md.h),

                _AttachNote(note: t.attach),
              ],
            ),
          ),
        ),
        SizedBox(height: context.spacing.lg.h),
        AppElevatedButton(
          label: t.send,
          expand: true,
          isDisabled: !_canSend,
          onPressed: _send,
        ),
      ],
    );
  }
}

/// One topic. Selected is the filled pill with a tick — the design's way of
/// showing which of four is in force, the same as the duration chips.
class _TopicChip extends StatelessWidget {
  const _TopicChip({
    required this.topic,
    required this.isSelected,
    required this.onTap,
  });

  final SupportTopic topic;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final label = topic.label(context.t);

    return Semantics(
      button: true,
      selected: isSelected,
      child: AppPressScale.tap(
        onTap: onTap,
        child: AnimatedContainer(
          duration: context.motion.fast,
          constraints: BoxConstraints(
            minHeight: AppComponentSizes.chipMinHeight.h,
          ),
          // No `alignment` here: a Container that is given one expands to
          // whatever its parent allows, which inside a Wrap is the full row —
          // four chips stacked one per line instead of the design's two by
          // two. The Row centres its own content within the minimum height.
          padding: EdgeInsets.symmetric(horizontal: context.spacing.lg.w),
          decoration: BoxDecoration(
            color: isSelected
                ? context.colorScheme.primary
                : context.colorScheme.surfaceContainerHighest,
            // The unselected chip is outlined as well as filled: on the
            // recessed surface alone it would disappear into the sheet.
            border: isSelected
                ? null
                : Border.all(
                    color: context.colorScheme.outlineVariant,
                    width: AppComponentSizes.chipBorderWidth,
                  ),
            borderRadius: context.radii.pillR,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isSelected) ...[
                Icon(
                  Icons.check_rounded,
                  size: context.icons.xs.w,
                  color: context.colorScheme.onPrimary,
                ),
                SizedBox(width: context.spacing.xs.w),
              ],
              Text(
                label,
                style: context.textTheme.labelMedium?.copyWith(
                  color: isSelected
                      ? context.colorScheme.onPrimary
                      : context.colorScheme.onSurface,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// What travels with the message without the user typing it.
///
/// The design promises the booking and the receipt; this says what is
/// actually appended, which is the account and the build. The app has no
/// booking to attach yet — there is no booking screen reading
/// `GET /me/bookings` — and a note that overstates what support receives is
/// how a ticket starts with "which booking?".
class _AttachNote extends StatelessWidget {
  const _AttachNote({required this.note});

  final String note;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.spacing.md.w,
        vertical: context.spacing.sm.h,
      ),
      decoration: context.decorations.cardFlat,
      child: Row(
        children: [
          Icon(
            Icons.attach_file_rounded,
            size: context.icons.s.w,
            color: context.colorScheme.onSurfaceVariant,
          ),
          SizedBox(width: context.spacing.sm.w),
          Expanded(
            child: Text(
              note,
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
