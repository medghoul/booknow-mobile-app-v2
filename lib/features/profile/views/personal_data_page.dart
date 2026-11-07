import 'package:auto_route/auto_route.dart';
import 'package:booknow_mobile/core/di/dependency_injection.dart';
import 'package:booknow_mobile/core/error/error_messages.dart';
import 'package:booknow_mobile/core/structures/enums/user_role.dart';
import 'package:booknow_mobile/features/auth/cubit/auth_cubit.dart';
import 'package:booknow_mobile/features/auth/cubit/auth_state.dart';
import 'package:booknow_mobile/features/profile/widgets/index.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Editing the signed-in user's own details, reached from the profile tab.
///
/// Reads and writes through [AuthCubit] rather than a cubit of its own: the
/// profile it edits is the session's, every screen in the app reads it from
/// there, and a second copy here would be one that goes stale the moment this
/// screen saves.
///
/// The title is the role's. A customer opened "Modifica profilo" from the
/// pencil on their identity card; an owner opened "Dati personali" from the
/// avatar, where the words have to tell their own details apart from the
/// shop's.
@RoutePage()
class PersonalDataPage extends StatelessWidget {
  const PersonalDataPage({super.key, this.shopName});

  /// Named under the avatar for an owner. Passed in rather than fetched —
  /// the profile tab has the shop already, and this screen opening must not
  /// wait on a request for one line of copy.
  final String? shopName;

  @override
  Widget build(BuildContext context) {
    final auth = di<AuthCubit>();

    return BlocBuilder<AuthCubit, AuthState>(
      bloc: auth,
      builder: (context, state) {
        final user = state.profile;
        final t = context.t.profile;

        // The session went away under the screen. `AuthStepListener` on the
        // tab below is already routing out of here.
        if (user == null) {
          return const AppScaffold(body: Center(child: AppLoader()));
        }

        return AppScaffold(
          appBar: AppAppBar(
            title: user.role == UserRole.owner ? t.personalData : t.editProfile,
          ),
          body: PersonalDataView(
            user: user,
            provider: state.session?.provider,
            shopName: shopName,
            isSaving: state.isSubmitting,
            onCancel: () => context.router.maybePop(),
            onSaved: ({required name, required phone}) =>
                _save(context, name: name, phone: phone),
          ),
        );
      },
    );
  }

  /// Saves, then leaves — but only on success.
  ///
  /// The confirmation is raised after the pop so it lands on the profile the
  /// user is looking at, the way the shop's details screen does it. A failure
  /// keeps them here with what they typed, and says why.
  Future<void> _save(
    BuildContext context, {
    required String name,
    required String phone,
  }) async {
    final auth = di<AuthCubit>();
    final saved = await auth.editProfile(name: name, phone: phone);
    if (!context.mounted) return;

    if (!saved) {
      final failure = auth.state.failure;
      if (failure != null) {
        AppSnackBar.error(context, failure.localized(context));
      }
      return;
    }

    final message = context.t.profile.personal.saved;
    await context.router.maybePop();
    if (context.mounted) AppSnackBar.success(context, message);
  }
}
