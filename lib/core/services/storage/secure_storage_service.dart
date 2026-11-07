import 'package:booknow_mobile/core/structures/enums/prefs_keys.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Keychain- and Keystore-backed storage for the session tokens.
///
/// Tokens live here rather than in shared preferences because preferences are
/// plain files on disk, readable on a rooted or jailbroken device.
class SecureStorageService {
  SecureStorageService({FlutterSecureStorage? storage})
    : _storage =
          storage ??
          const FlutterSecureStorage(
            iOptions: IOSOptions(
              accessibility: KeychainAccessibility.first_unlock,
            ),
          );

  final FlutterSecureStorage _storage;

  Future<String?> get accessToken =>
      _storage.read(key: PrefsKey.accessToken.value);

  Future<String?> get refreshToken =>
      _storage.read(key: PrefsKey.refreshToken.value);

  Future<String?> get idToken => _storage.read(key: PrefsKey.idToken.value);

  Future<void> saveTokens({
    required String accessToken,
    String? refreshToken,
    String? idToken,
  }) async {
    await _storage.write(key: PrefsKey.accessToken.value, value: accessToken);
    if (refreshToken != null) {
      await _storage.write(
        key: PrefsKey.refreshToken.value,
        value: refreshToken,
      );
    }
    if (idToken != null) {
      await _storage.write(key: PrefsKey.idToken.value, value: idToken);
    }
  }

  Future<bool> get hasSession async => (await accessToken)?.isNotEmpty ?? false;

  /// Wipes the session. Called on sign-out and on a 401 the refresh couldn't
  /// recover from.
  Future<void> clear() async {
    await _storage.delete(key: PrefsKey.accessToken.value);
    await _storage.delete(key: PrefsKey.refreshToken.value);
    await _storage.delete(key: PrefsKey.idToken.value);
  }
}
