import 'package:booknow_mobile/core/error/api_result.dart';
import 'package:booknow_mobile/core/structures/enums/device_platform.dart';
import 'package:booknow_mobile/core/structures/enums/reminder_lead.dart';
import 'package:booknow_mobile/core/structures/enums/user_role.dart';
import 'package:booknow_mobile/data/dio_client/dio_client.dart';
import 'package:booknow_mobile/data/dtos/index.dart';
import 'package:booknow_mobile/data/entities/api_endpoints.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/domain/repositories/user_repository.dart';

/// The real `/me` endpoints.
class ApiUserRepository implements UserRepository {
  const ApiUserRepository(this._client);

  final DioClient _client;

  @override
  Future<ApiResult<UserProfile>> getMe() async {
    final result = await _client.get<Map<String, dynamic>>(ApiEndpoints.me);
    return result._profile();
  }

  @override
  Future<ApiResult<UserProfile>> setRole(UserRole role) async {
    final result = await _client.post<Map<String, dynamic>>(
      ApiEndpoints.myRole,
      data: {'role': role.wireName},
    );
    return result._profile();
  }

  @override
  Future<ApiResult<UserProfile>> updateProfile({
    String? name,
    String? phone,
    bool profileSetupSeen = false,
  }) async {
    final result = await _client.patch<Map<String, dynamic>>(
      ApiEndpoints.me,
      // An explicit empty string clears the number; omitting the key leaves
      // it untouched. The two are different requests.
      //
      // `false` is left out rather than sent: the server only accepts `true`,
      // because nothing can un-answer the step.
      data: {
        'name': ?name,
        'phone': ?phone,
        if (profileSetupSeen) 'profileSetupSeen': true,
      },
    );
    return result._profile();
  }

  @override
  Future<ApiResult<UserProfile>> updateNotificationPreferences({
    bool? newBooking,
    bool? cancellation,
    bool? dailySummary,
    String? summaryTime,
    bool? reminder,
    ReminderLead? reminderLead,
  }) async {
    final result = await _client.patch<Map<String, dynamic>>(
      ApiEndpoints.myNotificationPreferences,
      // A nested field is only sent when something inside it changed: an
      // empty `dailySummary` would be a field with no instruction in it, and
      // the server would be right to ask what it meant.
      data: {
        'newBooking': ?newBooking,
        'cancellation': ?cancellation,
        if (dailySummary != null || summaryTime != null)
          'dailySummary': {'enabled': ?dailySummary, 'time': ?summaryTime},
        if (reminder != null || reminderLead != null)
          'reminder': {'enabled': ?reminder, 'offset': ?reminderLead?.wireName},
      },
    );
    return result._profile();
  }

  @override
  Future<ApiResult<void>> registerDevice({
    required String token,
    required DevicePlatform platform,
  }) => _client.put<void>(
    ApiEndpoints.myDevices,
    // The device's language is not in the body: it rides on
    // `Accept-Language`, which `LocaleInterceptor` puts on every request.
    data: {'token': token, 'platform': platform.wireName},
  );

  @override
  Future<ApiResult<void>> removeDevice(String fcmToken) =>
      _client.delete<void>(ApiEndpoints.myDevice(fcmToken));

  @override
  Future<ApiResult<void>> deleteAccount() =>
      _client.delete<void>(ApiEndpoints.me);
}

extension on ApiResult<Map<String, dynamic>> {
  ApiResult<UserProfile> _profile() =>
      parsed((json) => UserProfileDto.fromJson(json).toDomain());
}
