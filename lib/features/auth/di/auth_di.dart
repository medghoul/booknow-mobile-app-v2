import 'package:booknow_mobile/data/dio_client/dio_client.dart';
import 'package:booknow_mobile/features/auth/repositories/api_user_repository.dart';
import 'package:booknow_mobile/core/services/storage/secure_storage_service.dart';
import 'package:booknow_mobile/core/services/push/push_service.dart';
import 'package:booknow_mobile/core/services/storage/prefs_service.dart';
import 'package:booknow_mobile/domain/repositories/user_repository.dart';
import 'package:booknow_mobile/domain/repositories/shop_repository.dart';
import 'package:booknow_mobile/features/auth/cubit/auth_cubit.dart';
import 'package:booknow_mobile/domain/repositories/auth_repository.dart';
import 'package:booknow_mobile/features/auth/repositories/cognito_auth_repository.dart';
import 'package:get_it/get_it.dart';

/// Registers the auth feature.
///
/// [AuthCubit] is a singleton, not a factory: the splash screen restores the
/// session into it before any auth screen is built, and the role and profile
/// screens go on reading the same one.
///
/// There is one [AuthRepository] and it is the real one. A build without
/// Cognito's client id used to fall back to a stub that fabricated a session;
/// `AppConfig.assertConfigured` now refuses to start instead, because that
/// fallback was silent in exactly the build where it mattered.
void registerAuthFeature(GetIt di) {
  di.registerLazySingleton<UserRepository>(
    () => ApiUserRepository(di<DioClient>()),
  );
  di.registerLazySingleton<AuthRepository>(
    () => CognitoAuthRepository(di<SecureStorageService>()),
  );
  di.registerLazySingleton<AuthCubit>(
    () => AuthCubit(
      auth: di<AuthRepository>(),
      users: di<UserRepository>(),
      shops: di<ShopRepository>(),
      prefs: di<PrefsService>(),
      push: di<PushService>(),
    ),
  );
}
