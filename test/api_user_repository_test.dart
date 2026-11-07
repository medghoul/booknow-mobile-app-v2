import 'dart:typed_data';

import 'package:booknow_mobile/core/structures/enums/device_platform.dart';
import 'package:booknow_mobile/core/structures/enums/reminder_lead.dart';
import 'package:booknow_mobile/data/dio_client/dio_client.dart';
import 'package:booknow_mobile/data/entities/api_endpoints.dart';
import 'package:booknow_mobile/data/interceptors/locale_interceptor.dart';
import 'package:booknow_mobile/features/auth/repositories/api_user_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

/// Answers every request with an empty `200` and keeps what was asked.
///
/// The repository is exercised through the real [DioClient] and the real
/// interceptors, so what this captures is the request the API would receive.
class _CapturingAdapter implements HttpClientAdapter {
  RequestOptions? seen;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    seen = options;
    return ResponseBody.fromString('', 200);
  }

  @override
  void close({bool force = false}) {}
}

void main() {
  late _CapturingAdapter adapter;
  late ApiUserRepository repository;

  setUp(() {
    adapter = _CapturingAdapter();
    final dio = Dio()..httpClientAdapter = adapter;

    repository = ApiUserRepository(
      DioClient(
        // The language interceptor is part of what is being tested: the
        // device's language is not in the body, it is this header.
        interceptors: [LocaleInterceptor(() => 'en')],
        dio: dio,
      ),
    );
  });

  group('PUT /me/devices', () {
    test('sends the token and the platform', () async {
      await repository.registerDevice(
        token: 'fcm-1',
        platform: DevicePlatform.ios,
      );

      final request = adapter.seen!;
      expect(request.method, 'PUT');
      expect(request.path, ApiEndpoints.myDevices);
      expect(request.data, {'token': 'fcm-1', 'platform': 'ios'});
    });

    test('an Android device says so', () async {
      await repository.registerDevice(
        token: 'fcm-1',
        platform: DevicePlatform.android,
      );

      expect((adapter.seen!.data as Map)['platform'], 'android');
    });

    // What the API stores as this device's language, because a push is sent
    // long after any request of its own. Re-registering is therefore how a
    // language change reaches the server — and it only works if the header
    // is on this particular call.
    test('carries the language in Accept-Language', () async {
      await repository.registerDevice(
        token: 'fcm-1',
        platform: DevicePlatform.ios,
      );

      expect(adapter.seen!.headers['Accept-Language'], 'en');
    });
  });

  group('PATCH /me/notification-preferences', () {
    // The flat arguments the screen has become the nested object the API
    // documents — and only the field that changed is in it.
    test('a nested field is sent nested, on its own', () async {
      await repository.updateNotificationPreferences(summaryTime: '07:30');

      final request = adapter.seen!;
      expect(request.method, 'PATCH');
      expect(request.path, ApiEndpoints.myNotificationPreferences);
      expect(request.data, {
        'dailySummary': {'time': '07:30'},
      });
    });

    test('both halves of one object travel together', () async {
      await repository.updateNotificationPreferences(
        dailySummary: true,
        summaryTime: '08:15',
      );

      expect(adapter.seen!.data, {
        'dailySummary': {'enabled': true, 'time': '08:15'},
      });
    });

    test('the lead goes as the offset the API names', () async {
      await repository.updateNotificationPreferences(
        reminderLead: ReminderLead.oneDay,
      );

      expect(adapter.seen!.data, {
        'reminder': {'offset': '1d'},
      });
    });

    test("an owner's switches are flat booleans", () async {
      await repository.updateNotificationPreferences(newBooking: false);
      expect(adapter.seen!.data, {'newBooking': false});

      await repository.updateNotificationPreferences(cancellation: false);
      expect(adapter.seen!.data, {'cancellation': false});
    });

    // `{"dailySummary": {}}` is a field with no instruction in it. Nothing
    // asked for means nothing sent, which the server answers with the profile
    // as it stands.
    test('an untouched object is left out entirely', () async {
      await repository.updateNotificationPreferences(reminder: true);

      final data = adapter.seen!.data as Map;
      expect(data.containsKey('dailySummary'), isFalse);
      expect(data, {
        'reminder': {'enabled': true},
      });
    });
  });

  test('DELETE /me/devices/{token} names the token in the path', () async {
    await repository.removeDevice('fcm-1');

    expect(adapter.seen!.method, 'DELETE');
    expect(adapter.seen!.path, '/me/devices/fcm-1');
  });
}
