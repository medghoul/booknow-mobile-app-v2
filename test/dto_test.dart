import 'package:booknow_mobile/core/error/api_result.dart';
import 'package:booknow_mobile/core/error/network_exception.dart';
import 'package:booknow_mobile/core/structures/enums/device_platform.dart';
import 'package:booknow_mobile/core/structures/enums/reminder_lead.dart';
import 'package:booknow_mobile/core/structures/enums/shop_status.dart';
import 'package:booknow_mobile/core/structures/enums/user_role.dart';
import 'package:booknow_mobile/core/structures/enums/weekday.dart';
import 'package:booknow_mobile/data/dtos/index.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  _parsingGuard();

  // `PUT /me/devices` is hand-written rather than generated from a DTO, so
  // the two values it can send are pinned here. The enum's own names are not
  // the wire format: renaming a case must not change the request.
  group('DevicePlatform', () {
    test('sends the names the API expects', () {
      expect(DevicePlatform.ios.wireName, 'ios');
      expect(DevicePlatform.android.wireName, 'android');
    });

    test('is one of the two the app ships on', () {
      expect(DevicePlatform.current, isIn(DevicePlatform.values));
    });
  });

  group('ShopDto', () {
    test('reads the full body the API sends', () {
      final result = ShopDto.fromJson({
        'shopId': 'abc',
        'status': 'active',
        'name': 'Il salotto',
        'phone': '3284463373',
        'address': {
          'line': 'Via dei Coronari 18',
          'city': 'Roma',
          'zip': '00186',
          'country': 'IT',
        },
        'location': {'lat': 41.9028, 'lng': 12.4964},
        'openingHours': {
          'mon': <dynamic>[],
          'tue': [
            {'from': '09:00', 'to': '13:00'},
            {'from': '15:00', 'to': '19:30'},
          ],
        },
        'closures': ['2026-12-25'],
        'services': [
          {
            'serviceId': 's1',
            'name': 'Taglio uomo',
            'durationMin': 30,
            'priceCents': 1500,
            'active': true,
            'order': 1,
          },
        ],
      }).toDomain();

      expect(result.id, 'abc');
      expect(result.status, ShopStatus.active);
      expect(result.address?.isGeocoded, isTrue);
      expect(result.address?.latitude, 41.9028);
      // Monday is empty, so it is closed and not carried as an open day.
      expect(result.openingHours.isOpenOn(Weekday.monday), isFalse);
      expect(result.openingHours.rangesOn(Weekday.tuesday), hasLength(2));
      expect(result.closures, ['2026-12-25']);
      expect(result.services.single.durationMinutes, 30);
      expect(result.canPublish, isTrue);
    });

    test('an empty body yields a draft rather than throwing', () {
      final result = ShopDto.fromJson(const {}).toDomain();

      expect(result.id, '');
      expect(result.status, ShopStatus.draft);
      expect(result.address, isNull);
      expect(result.services, isEmpty);
      expect(result.openingHours.hasAnyOpenDay, isFalse);
    });

    test('an unknown status degrades to draft, never to active', () {
      final result = ShopDto.fromJson(const {'status': 'archived'}).toDomain();
      expect(result.status, ShopStatus.draft);
    });

    test('accepts `id` where the server sends no `shopId`', () {
      expect(ShopDto.fromJson(const {'id': 'x'}).toDomain().id, 'x');
    });

    test('a day the app does not know is skipped, not fatal', () {
      final result = ShopDto.fromJson(const {
        'openingHours': {
          'funday': [
            {'from': '09:00', 'to': '10:00'},
          ],
          'mon': [
            {'from': '09:00', 'to': '10:00'},
          ],
        },
      }).toDomain();

      expect(result.openingHours.openDays, [Weekday.monday]);
    });

    test('a backwards range is dropped on the way in', () {
      final result = ShopDto.fromJson(const {
        'openingHours': {
          'mon': [
            {'from': '19:00', 'to': '09:00'},
          ],
        },
      }).toDomain();

      expect(result.openingHours.isOpenOn(Weekday.monday), isFalse);
    });

    test('numbers sent as strings still parse', () {
      final service = ServiceDto.fromJson(const {
        'serviceId': 's1',
        'durationMin': '45',
        'priceCents': '2500',
      }).toDomain();

      expect(service.durationMinutes, 45);
      expect(service.priceCents, 2500);
    });

    test('a missing `active` means active', () {
      expect(
        ServiceDto.fromJson(const {'id': 's'}).toDomain().isActive,
        isTrue,
      );
    });
  });

  group('UserProfileDto', () {
    test('prefers sub over id and maps the role', () {
      final profile = UserProfileDto.fromJson(const {
        'sub': 'cognito-sub',
        'id': 'other',
        'name': 'Marco',
        'email': 'm@x.it',
        'role': 'owner',
      }).toDomain();

      expect(profile.id, 'cognito-sub');
      expect(profile.role, UserRole.owner);
    });

    test('a null role is a user who has not chosen yet', () {
      final profile = UserProfileDto.fromJson(const {'sub': 'x'}).toDomain();
      expect(profile.role, isNull);
      expect(profile.hasRole, isFalse);
    });

    // The nested wire shape flattened into the one list the screen draws.
    test('the notification switches come in with the profile', () {
      final profile = UserProfileDto.fromJson(const {
        'sub': 'x',
        'notificationPrefs': {
          'newBooking': false,
          'cancellation': true,
          'dailySummary': {'enabled': false, 'time': '07:30'},
          'reminder': {'enabled': true, 'offset': '1d'},
        },
      }).toDomain();

      final preferences = profile.notificationPrefs;
      expect(preferences.newBookings, isFalse);
      expect(preferences.cancellations, isTrue);
      expect(preferences.dailySummary, isFalse);
      expect(preferences.summaryTime, '07:30');
      expect(preferences.appointmentReminder, isTrue);
      expect(preferences.reminderLead, ReminderLead.oneDay);
    });

    // An older deployment, or one that has not been asked yet. Off is a
    // promise the server has not made, so a missing switch is the default.
    test('an absent switch is the default, not off', () {
      final profile = UserProfileDto.fromJson(const {'sub': 'x'}).toDomain();

      expect(profile.notificationPrefs, const NotificationPreferences());
    });

    test('an offset this build does not know falls back', () {
      final profile = UserProfileDto.fromJson(const {
        'sub': 'x',
        'notificationPrefs': {
          'reminder': {'enabled': true, 'offset': '15m'},
        },
      }).toDomain();

      expect(profile.notificationPrefs.reminderLead, ReminderLead.twoHours);
    });

    // A nested field sent as something other than an object must not throw:
    // the fields inside it are simply unanswered.
    test('a malformed nested object reads as no answer', () {
      final profile = UserProfileDto.fromJson(const {
        'sub': 'x',
        'notificationPrefs': {'dailySummary': 'yes please', 'reminder': []},
      }).toDomain();

      expect(profile.notificationPrefs.dailySummary, isTrue);
      expect(profile.notificationPrefs.summaryTime, defaultSummaryTime);
      expect(profile.notificationPrefs.appointmentReminder, isTrue);
    });
  });

  group('PlaceSuggestionDto', () {
    test('falls back from label to text', () {
      final one = PlaceSuggestionDto.fromJson(const {
        'placeId': 'p',
        'label': 'Via dei Coronari 18',
        'secondaryLabel': '00186 Roma',
      }).toDomain();
      final two = PlaceSuggestionDto.fromJson(const {
        'id': 'p',
        'text': 'Via Giulia 2',
      }).toDomain();

      expect(one.label, 'Via dei Coronari 18');
      expect(one.secondaryLabel, '00186 Roma');
      expect(two.placeId, 'p');
      expect(two.label, 'Via Giulia 2');
      expect(two.secondaryLabel, isNull);
    });
  });

  group('ShopRequests.openingHours', () {
    test('writes every day, so a closed day is sendable', () {
      final json = ShopRequests.openingHours(
        OpeningHours({
          Weekday.tuesday: [const TimeRange(from: '09:00', to: '13:00')],
        }),
      );

      expect(json.keys, hasLength(7));
      expect(json['mon'], isEmpty);
      expect(json['tue'], [
        {'from': '09:00', 'to': '13:00'},
      ]);
    });

    test('survives a round trip', () {
      final hours = OpeningHours({
        Weekday.monday: [const TimeRange(from: '09:00', to: '13:00')],
        Weekday.saturday: [const TimeRange(from: '10:00', to: '18:00')],
      });

      final back = ShopDto.fromJson({
        'openingHours': ShopRequests.openingHours(hours),
      }).toDomain().openingHours;

      expect(back, hours);
    });
  });
}

// A DTO tolerates a missing or oddly-typed scalar, so reaching the catch means
// the body is structurally not what the app was built against. That has to
// land as a failure the UI can show — not as an exception thrown out of a
// repository, which the user sees as a blank screen.
void _parsingGuard() {
  group('parsed()', () {
    test('a structurally wrong body becomes a failure', () {
      const body = <String, dynamic>{'address': 'Via dei Coronari 18'};
      final result = const ApiResult<Map<String, dynamic>>.success(
        body,
      ).parsed((json) => ShopDto.fromJson(json).toDomain());

      expect(result, isA<Failure<dynamic>>());
      expect((result as Failure).error, isA<UnexpectedError>());
    });

    test('a readable body still succeeds', () {
      final result = const ApiResult<Map<String, dynamic>>.success({
        'shopId': 'abc',
      }).parsed((json) => ShopDto.fromJson(json).toDomain());

      expect(result, isA<Success<dynamic>>());
      expect((result as Success).data.id, 'abc');
    });

    test('an existing failure passes straight through', () {
      final result = const ApiResult<Map<String, dynamic>>.failure(
        NotFound(),
      ).parsed((json) => ShopDto.fromJson(json).toDomain());

      expect((result as Failure).error, isA<NotFound>());
    });
  });
}
