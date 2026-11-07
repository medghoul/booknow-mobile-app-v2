import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// The native half of push, which no Dart test would otherwise touch.
///
/// None of this is reachable from the app's code, and all of it is silent when
/// it breaks: a renamed channel id delivers pushes to a channel the user has
/// never heard of, a missing background mode stops iOS waking the app, and a
/// flavour without its own Firebase file registers tokens against the wrong
/// project. The build does not fail for any of them — so the files are pinned
/// here instead.
void main() {
  String read(String path) => File(path).readAsStringSync();

  // The id appears three times: here in the manifest as Firebase's default,
  // in `MainActivity` which creates the channel, and in the notifications
  // Lambda which names it on every message. The first two are in this repo.
  group('the bookings channel', () {
    test('is what Firebase falls back to', () {
      final manifest = read('android/app/src/main/AndroidManifest.xml');

      expect(
        manifest,
        contains(
          'com.google.firebase.messaging.default_notification_channel_id',
        ),
      );
      expect(manifest, contains('android:value="bookings"'));
    });

    test('is created at high importance, named and described', () {
      final activity = read(
        'android/app/src/main/kotlin/com/booknow/MainActivity.kt',
      );

      expect(activity, contains('BOOKINGS_CHANNEL_ID = "bookings"'));
      expect(activity, contains('createNotificationChannel'));
      // Anything lower and a new booking arrives without a sound: §9.2 sends
      // `android.priority = high`, which only matters if the channel allows
      // it. Importance is the user's to lower afterwards, not ours.
      expect(activity, contains('IMPORTANCE_HIGH'));
      expect(activity, contains('R.string.notification_channel_bookings'));
    });

    // The channel's name is drawn by the phone's Settings, not by the app, so
    // it is a platform resource rather than a slang string — and it still has
    // to exist in both languages.
    test('is named in Italian and English', () {
      for (final path in const [
        'android/app/src/main/res/values/strings.xml',
        'android/app/src/main/res/values-en/strings.xml',
      ]) {
        final strings = read(path);
        expect(
          strings,
          contains('name="notification_channel_bookings"'),
          reason: path,
        );
        expect(
          strings,
          contains('name="notification_channel_bookings_description"'),
          reason: path,
        );
      }
    });
  });

  // Android draws a small icon from its alpha alone. With no icon named,
  // Firebase falls back to the launcher icon — a full-colour square, whose
  // alpha is a solid block — and every push arrives as a white square. The
  // build does not fail, and neither does anything else: it just looks broken.
  group('the Android status-bar icon', () {
    test('is named as Firebase\'s default, with a colour to tint it', () {
      final manifest = read('android/app/src/main/AndroidManifest.xml');

      expect(
        manifest,
        contains('com.google.firebase.messaging.default_notification_icon'),
      );
      expect(manifest, contains('@drawable/ic_stat_booknow'));
      expect(
        manifest,
        contains('com.google.firebase.messaging.default_notification_color'),
      );
      expect(manifest, contains('@color/notification_accent'));
    });

    // One missing density is not a crash: Android scales the nearest one up,
    // and the icon arrives soft on exactly the phones nobody tests on.
    test('exists at every density', () {
      for (final density in const [
        'mdpi',
        'hdpi',
        'xhdpi',
        'xxhdpi',
        'xxxhdpi',
      ]) {
        expect(
          File(
            'android/app/src/main/res/drawable-$density/ic_stat_booknow.png',
          ).existsSync(),
          isTrue,
          reason: density,
        );
      }
    });

    // The shade follows the system theme, and the light palette's terracotta
    // is too dark to read against the dark one.
    test('is tinted in both palettes', () {
      expect(
        read('android/app/src/main/res/values/colors.xml'),
        contains('#A8511F'),
      );
      expect(
        read('android/app/src/main/res/values-night/colors.xml'),
        contains('#E8935C'),
      );
    });
  });

  group('iOS can receive a push', () {
    test('wakes for a remote notification', () {
      expect(read('ios/Runner/Info.plist'), contains('remote-notification'));
    });

    // Without the entitlement iOS never hands over an APNs token, so FCM has
    // no token to give the app either — and the failure looks like "push just
    // does not work" rather than like a missing capability.
    test('declares the push capability in every configuration', () {
      for (final path in const [
        'ios/Runner/Runner.entitlements',
        'ios/Runner/RunnerDebug-development.entitlements',
      ]) {
        expect(read(path), contains('aps-environment'), reason: path);
      }
    });
  });

  // Production lives in its own Firebase project, so a development-stage
  // service account cannot reach a production phone. Which project a build
  // talks to is decided entirely by which of these files it picks up —
  // nothing in Dart names a project — so each flavour's file is pinned to the
  // project it is supposed to belong to.
  group('Firebase config per flavour', () {
    const devProject = 'book-now-a1ec2';
    const prodProject = 'booknow-prod-33d87';

    const projectOf = {
      'local': devProject,
      'development': devProject,
      'production': prodProject,
    };

    Map<String, dynamic> android(String path) =>
        jsonDecode(read(path)) as Map<String, dynamic>;

    Set<String> packagesIn(String path) => (android(path)['client'] as List)
        .map(
          (client) =>
              ((client as Map<String, dynamic>)['client_info']
                      as Map<String, dynamic>)['android_client_info']
                  as Map<String, dynamic>,
        )
        .map((info) => info['package_name'] as String)
        .toSet();

    String projectIn(String path) =>
        (android(path)['project_info'] as Map<String, dynamic>)['project_id']
            as String;

    test('each iOS flavour has the file for its own bundle id', () {
      for (final entry in projectOf.entries) {
        final plist = read('ios/config/${entry.key}/GoogleService-Info.plist');

        expect(
          plist,
          contains('com.booknow.${entry.key}'),
          reason: 'ios/config/${entry.key}',
        );
        expect(plist, contains(entry.value), reason: 'ios/config/${entry.key}');
      }
    });

    // Copied into the bundle at build time by the "GoogleService-Info" script
    // phase, which reads the flavour off the bundle id's suffix.
    test('the iOS build picks the file up by flavour', () {
      final project = read('ios/Runner.xcodeproj/project.pbxproj');

      expect(project, contains(r'config/$(PRODUCT_BUNDLE_IDENTIFIER:suffix)'));
      expect(project, contains('GoogleService-Info.plist'));
    });

    // Gradle reads `src/<flavour>/` before the module root, so production
    // takes its own file and the other two fall back to the one beside them.
    // The set is exact rather than a `contains`: a production client left in
    // the root file is the failure this is here to catch, because it is
    // invisible until the day `src/production/` goes missing and the release
    // build quietly registers its tokens against the development project.
    test('local and development share the module-root file', () {
      const path = 'android/app/google-services.json';

      expect(projectIn(path), devProject);
      expect(packagesIn(path), {
        'com.booknow.local',
        'com.booknow.development',
      });
    });

    test('production has its own file, in its own project', () {
      const path = 'android/app/src/production/google-services.json';

      expect(projectIn(path), prodProject);
      expect(packagesIn(path), {'com.booknow.production'});
    });
  });
}
