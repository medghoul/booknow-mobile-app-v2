import 'dart:async';

import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/core/services/push/push_service.dart';
import 'package:booknow_mobile/core/structures/push_payload.dart';
import 'package:booknow_mobile/features/notifications/widgets/push_banner.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

/// How long a banner stays before it withdraws on its own.
///
/// Long enough to read a title and a line of body, short enough that it is
/// gone by the time anyone reaches for it to get it out of the way.
const Duration _visibleFor = Duration(seconds: 5);

/// Shows arriving pushes over the app, and opens the ones that are tapped.
///
/// Sits above the router rather than on a screen: a push can arrive on any of
/// them, and the banner has to outlive the navigation a tap on it causes.
///
/// Two streams, two different jobs. [PushService.messages] is a push that
/// arrived while the app was in front — the operating system shows nothing
/// then, so the banner *is* the notification. [PushService.taps] is a
/// notification the user has already seen and acted on, from the lock screen
/// or the notification centre, so there is nothing to show and only somewhere
/// to go.
///
/// Where that is belongs to the caller: opening a screen needs the router and
/// the signed-in role, and neither is this widget's business.
class PushListener extends StatefulWidget {
  const PushListener({
    super.key,
    required this.push,
    required this.onOpen,
    required this.child,
  });

  final PushService push;

  /// Open what the push is about. Only called for a payload this build
  /// understands — see [PushPayload.from].
  final ValueChanged<PushPayload> onOpen;

  final Widget child;

  @override
  State<PushListener> createState() => _PushListenerState();
}

class _PushListenerState extends State<PushListener> {
  final List<StreamSubscription<RemoteMessage>> _subscriptions = [];

  _Arrival? _arrival;
  Timer? _withdraw;

  @override
  void initState() {
    super.initState();
    _subscriptions.addAll([
      widget.push.messages.listen(_show),
      widget.push.taps.listen(_opened),
    ]);
  }

  @override
  void dispose() {
    _withdraw?.cancel();
    for (final subscription in _subscriptions) {
      subscription.cancel();
    }
    super.dispose();
  }

  /// A push arrived with the app in front.
  ///
  /// A message with no `notification` block has nothing to draw — it is a
  /// data-only push, which v0 does not send but FCM allows — so it is
  /// recorded and dropped rather than shown as an empty bar.
  void _show(RemoteMessage message) {
    final title = message.notification?.title;
    if (title == null || title.isEmpty) return;

    setState(() {
      _arrival = _Arrival(
        title: title,
        body: message.notification?.body,
        payload: PushPayload.from(message.data),
      );
    });

    _withdraw?.cancel();
    _withdraw = Timer(_visibleFor, _hide);
  }

  /// The user tapped the notification itself, outside the app.
  void _opened(RemoteMessage message) {
    final payload = PushPayload.from(message.data);
    if (payload != null) widget.onOpen(payload);
  }

  void _hide() {
    _withdraw?.cancel();
    if (mounted) setState(() => _arrival = null);
  }

  /// The banner was tapped: it goes, and then the screen it points at opens.
  void _openBanner(PushPayload payload) {
    _hide();
    widget.onOpen(payload);
  }

  @override
  Widget build(BuildContext context) {
    final arrival = _arrival;

    return Stack(
      children: [
        Positioned.fill(child: widget.child),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          // Every branch is keyed. `AnimatedSwitcher` keys its transition off
          // the child's key and drops an outgoing child whose key matches the
          // incoming one, so unkeyed branches would cross-fade nothing and a
          // second push would replace the first without animating.
          child: AnimatedSwitcher(
            duration: context.motion.normal,
            switchInCurve: context.motion.curveEmphasized,
            switchOutCurve: context.motion.curve,
            transitionBuilder: (child, animation) => SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, -1),
                end: Offset.zero,
              ).animate(animation),
              child: FadeTransition(opacity: animation, child: child),
            ),
            child: arrival == null
                ? const SizedBox.shrink(key: ValueKey('no-push'))
                : PushBanner(
                    key: ValueKey(arrival.key),
                    title: arrival.title,
                    body: arrival.body,
                    onTap: arrival.payload == null
                        ? null
                        : () => _openBanner(arrival.payload!),
                    onDismissed: _hide,
                  ),
          ),
        ),
      ],
    );
  }
}

/// What is on screen right now.
@immutable
class _Arrival {
  const _Arrival({required this.title, this.body, this.payload});

  final String title;
  final String? body;

  /// Null for a type this build does not know: it is shown, but tapping it
  /// leads nowhere, because nothing here can say where that would be.
  final PushPayload? payload;

  /// Identity for the switcher. The copy, not the payload: the daily summary
  /// carries no booking id, so two of them would otherwise look identical.
  String get key => '$title|$body';
}
