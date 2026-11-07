import 'package:booknow_mobile/widgets/buttons/app_outlined_button.dart';
import 'package:booknow_mobile/widgets/states/app_empty_state.dart';
import 'package:flutter/material.dart';

/// The "that didn't work" state, with a way back.
///
/// [message] must already be localised — callers map a `NetworkException` to
/// copy before they get here, so nothing surfaces a raw exception or an API
/// error code to the user.
class AppErrorState extends StatelessWidget {
  const AppErrorState({
    super.key,
    required this.message,
    required this.retryLabel,
    this.title,
    this.onRetry,
    this.icon = Icons.cloud_off,
  });

  final String message;
  final String retryLabel;
  final String? title;
  final VoidCallback? onRetry;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return AppEmptyState(
      icon: icon,
      title: title ?? message,
      message: title == null ? null : message,
      action: onRetry == null
          ? null
          : AppOutlinedButton(
              label: retryLabel,
              icon: Icons.refresh,
              onPressed: onRetry,
            ),
    );
  }
}
