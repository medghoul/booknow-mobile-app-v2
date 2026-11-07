import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

/// Hands a URI to the phone: the dialler for `tel:`, the mail app for
/// `mailto:`, the browser for anything else.
///
/// A class around one call rather than calling `launchUrl` from the screens,
/// so the screens stay testable: a test passes a fake that records what it
/// was asked to open instead of reaching for a platform channel that is not
/// there.
class LinkService {
  const LinkService();

  /// Whether the phone took it.
  ///
  /// False means nothing opened — no mail app configured, no dialler on a
  /// tablet — and the caller says so rather than closing as though the
  /// message had gone. The platform raises that case as an exception on
  /// Android and as a false on iOS, so both are folded into the one answer.
  Future<bool> open(Uri uri) async {
    try {
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    } on PlatformException {
      return false;
    }
  }
}
