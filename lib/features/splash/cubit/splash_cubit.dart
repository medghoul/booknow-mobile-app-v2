import 'package:booknow_mobile/core/structures/enums/user_role.dart';
import 'package:booknow_mobile/features/auth/cubit/auth_cubit.dart';
import 'package:booknow_mobile/features/auth/cubit/auth_state.dart';
import 'package:booknow_mobile/features/queue/cubit/live_status_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// What the splash resolves to.
///
/// Either the onboarding deck, which `AuthCubit` knows nothing about, or
enum SplashDestination { onboarding, authenticated }

/// Decides the first real screen.
///
/// It deliberately restores the session *before* looking at onboarding: a user
/// who is already signed in has plainly seen the app before, so replaying the
/// intro at them would be wrong even if the flag were somehow missing.
class SplashCubit extends Cubit<SplashDestination?> {
  SplashCubit({required AuthCubit auth, LiveStatusCubit? live})
    : _auth = auth,
      _live = live,
      super(null);

  final AuthCubit _auth;
  final LiveStatusCubit? _live;

  /// How long the place in line may hold the splash up: it is a nicety, and the
  /// app says the same thing once it opens.
  static const Duration _liveBudget = Duration(milliseconds: 900);

  /// Long enough to read "You're #3 at…" before the splash leaves.
  static const Duration _liveLinger = Duration(milliseconds: 700);

  /// A beat of brand before the app moves on. Without it the splash flashes
  /// and reads as a glitch. The design budgets a cold start at ~800 ms.
  static const Duration _minimumDisplay = Duration(milliseconds: 1250);

  Future<void> resolve() async {
    final started = DateTime.now();

    await _auth.restore();
    final destination = _destinationFor(_auth.state);

    final live = _live;
    final isCustomer = _auth.state.profile?.role == UserRole.customer;
    var wait = _minimumDisplay;
    if (live != null && isCustomer) {
      await live.refresh().timeout(_liveBudget, onTimeout: () {});
      if (live.state != null) {
        final read = DateTime.now().difference(started);
        if (read + _liveLinger > wait) wait = read + _liveLinger;
      }
    }

    final elapsed = DateTime.now().difference(started);
    if (elapsed < wait) await Future<void>.delayed(wait - elapsed);

    if (!isClosed) emit(destination);
  }

  /// Straight to the app: browsing it is the introduction.
  SplashDestination _destinationFor(AuthState auth) =>
      SplashDestination.authenticated;
}
