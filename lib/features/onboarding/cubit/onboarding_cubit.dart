import 'package:booknow_mobile/core/services/storage/prefs_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Tracks which onboarding slide is showing.
///
/// Reaching the end is what marks onboarding as seen — and so does skipping,
/// because a user who skips has made a decision and should not be asked again.
class OnboardingCubit extends Cubit<int> {
  OnboardingCubit(this._prefs) : super(0);

  final PrefsService _prefs;

  /// Slides in the deck. The page view and the dots both read this, so adding
  /// a slide is a change in one place.
  static const int slideCount = 3;

  bool get isLastSlide => state == slideCount - 1;

  void onPageChanged(int index) => emit(index);

  /// Marks onboarding complete. Called when the deck is finished *or* skipped.
  Future<void> complete() => _prefs.setOnboardingSeen();
}
