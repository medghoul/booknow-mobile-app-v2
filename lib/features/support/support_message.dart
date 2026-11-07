import 'package:booknow_mobile/core/structures/enums/user_role.dart';
import 'package:booknow_mobile/localization/localization.dart';

/// What a message to support is about.
///
/// Asked before the message is written because it is the only routing there
/// is: it becomes the subject line, and a refund question and a lost password
/// are read by different people.
enum SupportTopic { payment, booking, account, other }

extension SupportTopicLabel on SupportTopic {
  String label(Translations t) => switch (this) {
    SupportTopic.payment => t.help.topics.payment,
    SupportTopic.booking => t.help.topics.booking,
    SupportTopic.account => t.help.topics.account,
    SupportTopic.other => t.help.topics.other,
  };
}

/// A message to support, ready to hand to the mail app.
///
/// There is no support endpoint in the API, so a message leaves through the
/// user's own mail client rather than through the server. That is also why
/// [from], [role] and [appVersion] are written into the body: there is no
/// ticket for anyone to look them up against afterwards, and "non funziona"
/// from an unknown build is not answerable.
class SupportMessage {
  const SupportMessage({
    required this.topic,
    required this.body,
    this.from,
    this.role,
    this.appVersion,
  });

  final SupportTopic topic;

  /// What the user typed. Trimmed on the way into the mail, never altered.
  final String body;

  /// The account's address — where the reply goes. Null while the profile is
  /// still loading, which only drops a line from the footer.
  final String? from;

  final UserRole? role;
  final String? appVersion;

  /// `mailto:` with the subject and body filled in.
  ///
  /// Built by hand rather than through `Uri(queryParameters:)`, which encodes
  /// a space as `+`: mail clients show that literally, so the subject would
  /// arrive as "BookNow+—+Pagamento".
  Uri mailto(String address, Translations t) {
    final subject = t.help.mail.subject(topic: topic.label(t));

    return Uri.parse(
      'mailto:$address'
      '?subject=${Uri.encodeComponent(subject)}'
      '&body=${Uri.encodeComponent(_body(t))}',
    );
  }

  /// The message, then a rule, then what support would otherwise have to ask
  /// for.
  String _body(Translations t) {
    final mail = t.help.mail;
    final footer = [
      if (from != null) '${mail.account}: $from',
      if (role != null)
        '${mail.role}: '
            '${role == UserRole.owner ? mail.roleOwner : mail.roleCustomer}',
      if (appVersion != null) '${mail.appVersion}: $appVersion',
    ];

    if (footer.isEmpty) return body.trim();

    return '${body.trim()}\n\n---\n${footer.join('\n')}';
  }
}
