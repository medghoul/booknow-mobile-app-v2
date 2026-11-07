import 'package:auto_route/auto_route.dart';
import 'package:booknow_mobile/core/di/dependency_injection.dart';
import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/core/services/push/push_service.dart';
import 'package:booknow_mobile/core/structures/enums/user_role.dart';
import 'package:booknow_mobile/features/auth/cubit/auth_cubit.dart';
import 'package:booknow_mobile/features/auth/widgets/auth_step_listener.dart';
import 'package:booknow_mobile/features/notifications/widgets/notification_preview.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// Explains push before the system prompt, and only then asks.
///
/// iOS shows its prompt exactly once per install: a refusal is permanent.
/// That is why this screen exists at all, and why it is reached at the moment
/// the answer means something rather than at launch, where the user has no
/// idea what BookNow would send them.
///
/// The moment is per role — §4.4 of the notifications spec. An owner arrives
/// here at the end of publishing, from `AuthRouter.destinationFor`: the shop
/// is live and the next thing to happen is a booking. A customer arrives after
/// their first confirmed booking, from `AuthCubit.askForNotifications`, with
/// an appointment to actually be reminded about.
///
/// Same layout for both roles, different reason. For a customer notifications
/// are a convenience; for a barber a missed booking is only discovered by
/// opening the agenda, so the owner's copy says that plainly.
///
/// Skipping is a real answer. Either way the step is marked handled and never
/// shown again.
@RoutePage()
class NotificationPermissionPage extends StatefulWidget {
  const NotificationPermissionPage({super.key});

  @override
  State<NotificationPermissionPage> createState() =>
      _NotificationPermissionPageState();
}

class _NotificationPermissionPageState
    extends State<NotificationPermissionPage> {
  bool _isAsking = false;

  Future<void> _allow() async {
    setState(() => _isAsking = true);

    await di<PushService>().requestPermission();

    // The token only exists if permission was granted; `notificationsHandled`
    // registers it when there is one and simply moves on when there isn't.
    await di<AuthCubit>().notificationsHandled();
  }

  Future<void> _skip() => di<AuthCubit>().notificationsHandled();

  @override
  Widget build(BuildContext context) {
    final t = context.t.notifications;
    final isOwner = di<AuthCubit>().state.profile?.role == UserRole.owner;

    // slang generates a class per branch, so the two cannot be read through
    // one variable without flattening them here first.
    final copy = isOwner
        ? (
            title: t.owner.title,
            body: t.owner.body,
            pointOne: t.owner.pointOne,
            pointTwo: t.owner.pointTwo,
            firstTitle: t.owner.firstTitle,
            firstBody: t.owner.firstBody,
            firstWhen: t.owner.firstWhen,
            secondTitle: t.owner.secondTitle,
            secondBody: t.owner.secondBody,
            secondWhen: t.owner.secondWhen,
          )
        : (
            title: t.customer.title,
            body: t.customer.body,
            pointOne: t.customer.pointOne,
            pointTwo: t.customer.pointTwo,
            firstTitle: t.customer.firstTitle,
            firstBody: t.customer.firstBody,
            firstWhen: t.customer.firstWhen,
            secondTitle: t.customer.secondTitle,
            secondBody: t.customer.secondBody,
            secondWhen: t.customer.secondWhen,
          );

    return AuthStepListener(
      child: AppScaffold(
        canPop: false,
        padding: EdgeInsets.zero,
        useSafeArea: false,
        body: Stack(
          children: [
            // The blob picks up the role's own colour: sage behind the owner,
            // warm behind the customer.
            Positioned(
              top: -120.h,
              right: -110.w,
              child: Container(
                width: 330.w,
                height: 330.w,
                decoration: BoxDecoration(
                  color: isOwner
                      ? context.decorations.blobSage
                      : context.decorations.blobWarm,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: context.spacing.screenGutter,
                child: AppDockedColumn(
                  docked: Column(
                    children: [
                      AppElevatedButton(
                        label: t.allow,
                        icon: Icons.notifications_none,
                        expand: true,
                        isLoading: _isAsking,
                        onPressed: _allow,
                      ),
                      SizedBox(height: context.spacing.sm.h),
                      AppTextButton(
                        label: t.skip,
                        // Ink, not terracotta. Terracotta is the one action
                        // colour and it is already spent on the button above;
                        // skipping should read as equally easy, not as a
                        // second thing being sold.
                        foregroundColor: context.colorScheme.onSurface,
                        onPressed: _isAsking ? null : _skip,
                      ),
                    ],
                  ),
                  children: [
                    SizedBox(height: context.spacing.huge.h),
                    NotificationPreview(
                      title: copy.firstTitle,
                      body: copy.firstBody,
                      when: copy.firstWhen,
                    ),
                    SizedBox(height: context.spacing.sm.h),
                    Padding(
                      // Inset and dimmed, so the pair reads as a stack of
                      // arriving notifications rather than two equal cards.
                      padding: EdgeInsets.symmetric(
                        horizontal: context.spacing.md.w,
                      ),
                      child: NotificationPreview(
                        title: copy.secondTitle,
                        body: copy.secondBody,
                        when: copy.secondWhen,
                        isMuted: true,
                      ),
                    ),
                    SizedBox(height: context.spacing.xxl.h),
                    Text(copy.title, style: context.textTheme.displayLarge),
                    SizedBox(height: context.spacing.md.h),
                    Text(
                      copy.body,
                      style: context.textTheme.bodyLarge?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    SizedBox(height: context.spacing.xl.h),
                    NotificationPoint(copy.pointOne),
                    NotificationPoint(copy.pointTwo),
                    SizedBox(height: context.spacing.lg.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
