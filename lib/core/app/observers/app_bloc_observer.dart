import 'package:booknow_mobile/core/services/logger/app_logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Logs what every cubit and bloc does.
///
/// Registered in `main` and only in debug builds — the logger's own filter
/// silences it in production, but attaching the observer at all costs a little
/// on every state change, so it is not worth doing there.
///
/// Errors are logged at error level: a cubit that throws would otherwise fail
/// silently, since nothing awaits the state it never emitted.
class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    AppLogger.debug('${bloc.runtimeType} → ${change.nextState.runtimeType}');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    AppLogger.error('${bloc.runtimeType} threw', error, stackTrace);
    super.onError(bloc, error, stackTrace);
  }
}
