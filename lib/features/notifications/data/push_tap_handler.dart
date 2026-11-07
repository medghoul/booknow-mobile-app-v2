import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:booknow_mobile/core/services/logger/app_logger.dart';
import 'package:booknow_mobile/core/structures/push_payload.dart';
import 'package:booknow_mobile/features/auth/cubit/auth_cubit.dart';
import 'package:booknow_mobile/routing/push_destinations.dart';

/// Turns a tapped push into a screen.
///
/// Where a push opens depends on the signed-in role, and at the one moment it
/// matters most — a notification tapped while the app was closed, which is
/// what `getInitialMessage` delivers — the role is not known yet: the splash
/// is still restoring the session. Navigating then would either go nowhere or
/// be turned away by `RoleGuard`, and the tap would be lost.
///
/// So a tap that cannot be honoured is held, and honoured as soon as the
/// session resolves. One tap is held, not a queue: the user tapped one
/// notification, and the last one they tapped is the one they meant.
class PushTapHandler {
  PushTapHandler({required AuthCubit auth, required this.navigate})
    : _auth = auth {
    _session = _auth.stream.listen((state) {
      if (state.profile != null) _flush();
    });
  }

  final AuthCubit _auth;

  /// Kept as a function rather than the router itself: this has one thing to
  /// say to it, and a test can hear it without mounting one.
  final void Function(PageRouteInfo<dynamic> route) navigate;

  late final StreamSubscription<void> _session;

  PushPayload? _pending;

  /// Opens the screen the push points at, or holds it until that is possible.
  void open(PushPayload payload) {
    final destination = pushDestinationFor(payload, _auth.state.profile?.role);

    if (destination == null) {
      // No role yet, or the push belongs to the role that used to be signed
      // in on this phone. The first case is worth waiting for; the second
      // resolves to the same thing, because a payload for the other role
      // never produces a destination however long it is held.
      _pending = payload;
      AppLogger.debug('[push] tap held: ${payload.type.wireName}');
      return;
    }

    _pending = null;
    navigate(destination);
  }

  void _flush() {
    final pending = _pending;
    if (pending == null) return;

    _pending = null;
    open(pending);
  }

  Future<void> dispose() => _session.cancel();
}
