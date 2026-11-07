# BookNow — mobile app v2

Rebuild of `booknow-mobile-app` to `booknow-design-guide.md`: same features and API, new look.

Flutter app for iOS and Android. Customers book a barber slot and pay a small  
service fee in the app; shop owners manage their agenda for free.

## Requirements


| Tool                 | Version                       |
| -------------------- | ----------------------------- |
| Flutter              | 3.47.4 (stable)               |
| Xcode                | 26.x, with CocoaPods          |
| Android Studio / SDK | AGP 8.13, Gradle 8.14, JDK 21 |


The repo is pinned to Gradle 8.14 and AGP 8.13 deliberately — newer templates
scaffold AGP 9.x, which this Flutter's Gradle plugin refuses to apply.

## Getting started

```bash
flutter pub get
dart run husky install     # once, to enable the git hooks
flutter run --flavor local --dart-define=ENV=local
```

VS Code users can skip the flags: `.vscode/launch.json` has a configuration per
flavour.

## Flavours

Three, on both platforms, each installable side by side.


| Flavour       | Android applicationId     | iOS bundle id             | Launcher name | API              |
| ------------- | ------------------------- | ------------------------- | ------------- | ---------------- |
| `local`       | `com.booknow.local`       | `com.booknow.local`       | BookNow Local | `localhost:3000` |
| `development` | `com.booknow.development` | `com.booknow.development` | BookNow Dev   | dev backend      |
| `production`  | `com.booknow.production`  | `com.booknow.production`  | BookNow       | live backend     |


```bash
flutter run   --flavor development --dart-define=ENV=development
flutter build apk --flavor production --dart-define=ENV=production
flutter build ios --flavor production --dart-define=ENV=production
```

`--flavor` **and** `--dart-define=ENV` **are separate and both are needed.** The
flavour picks the native application id, launcher name and Firebase app;
`ENV` picks the `.env` file. Nothing enforces that they agree, so a mismatched
pair builds happily and talks to the wrong backend.

Android flavours live in `android/app/build.gradle.kts`; iOS uses one Xcode
scheme and three build configurations per flavour, set up per the
[Flutter flavours guide](https://docs.flutter.dev/deployment/flavors-ios).
Every configuration must also be listed in `ios/Podfile` or CocoaPods will not
wire it up.

## Configuration

Runtime configuration comes from a bundled `.env` file, read by
`flutter_dotenv` and exposed through `AppConfig`.

```
.env.local          .env.development          .env.production
```

`--dart-define=ENV=<name>` selects one. Without it, the build mode decides:
release reads `.env.production`, debug and profile read `.env.development`.
`main()` awaits `AppConfig.load()` before anything reads a value.

> A `.env` ships as a **plaintext asset** — anyone who unzips the app can read
> it. Only public values belong in one. Stripe's publishable key yes; its
> secret key, or any other credential, never.

`.env.example` documents the keys. `STRIPE_PUBLISHABLE_KEY` is intentionally
blank in the committed files: until it is filled in, Stripe initialisation is
skipped and the app runs with payments disabled rather than crashing.

## Firebase

One project, `book-now-a1ec2`, with a separate app registered per flavour per
platform — six in total — so pushes and analytics never cross environments.

- **Android** — `android/app/google-services.json` holds every client in one
file. The Gradle plugin picks the entry matching the variant's applicationId.
- **iOS** — a plist describes exactly one app, so there are three:
`ios/config/{local,development,production}/GoogleService-Info.plist`. The
*Copy Firebase config for flavour* build phase copies the right one into the
bundle. There is deliberately no committed `ios/Runner/GoogleService-Info.plist`.

`Firebase.initializeApp()` is called **without** options, so each flavour reads
its own native config. Passing a generated `firebase_options.dart` would
override both files and register every flavour as the same app — the build
would pass and the tokens would be wrong.

Adding a flavour means registering two more Firebase apps and re-downloading
both configs.

### Push

`PushService` (`lib/core/services/push/`) owns permission, the FCM token and
the three ways a message arrives; it exposes `messages` and `taps` as streams.
It does **not** prompt on launch — the spec asks for notification permission
after the role choice, so call `requestPermission()` from there.

No push will arrive yet: iOS needs an APNs key uploaded to Firebase, and the
simulator cannot receive remote notifications at all.

## Commands

```bash
flutter test                                              # 66 tests
flutter analyze
dart format lib test
dart run build_runner build --delete-conflicting-outputs  # freezed, json, routes
dart run slang                                            # translations only
dart run flutter_launcher_icons                           # app icons
dart run flutter_native_splash:create                     # launch screens
```



## Project layout

```
lib/
├── main.dart          # config, Firebase, DI, then runApp
├── core/
│   ├── app/           # BookNowApp: theme mode, router, translations
│   ├── config/        # AppConfig — the .env values
│   ├── constants/     # colours, icons, component sizes, animation tokens
│   ├── di/            # GetIt graph
│   ├── error/         # ApiResult, NetworkException, error copy
│   ├── services/      # storage, connectivity, logging, push
│   └── theme/         # AppTheme + ThemeExtensions
├── data/              # Dio client, interceptors, endpoints
├── features/          # one folder per feature: cubit/ views/ widgets/ di/
├── localization/      # slang sources + generated (it, en)
├── routing/           # AppRouter (auto_route)
└── widgets/           # the shared App* component library
```

Sizing, spacing, radii, type, motion and colour come from `ThemeExtension`s
reached through `BuildContext` — never raw numbers.
`test/design_tokens_test.dart` pins the scales to the design system, so changing one tells you what you broke.

## Git hooks

`dart run husky install` points `core.hooksPath` at `.husky/`.

- **commit-msg** — Conventional Commits: `type(scope): description`
- **pre-commit** — `flutter analyze` and `dart format --set-exit-if-changed`
over `lib/` and `test/`

Both are toggleable in `.husky/hook_config.yaml`.

## Known gaps

- **Photography.** The shop interior behind the sign-in header and the chair on
the first onboarding slide are placeholders. Both widgets take an optional
image and fall back to a flat tint.
- **Auth is stubbed.** `StubAuthRepository` fabricates a session locally; swap
it for the Cognito implementation in `auth_di.dart` once the user pool
exists. Nothing outside that file changes.
- **Base configurations.** The unflavoured `Debug`/`Release`/`Profile` still
build `com.booknow`, which no Firebase app is registered for. Always pass
`--flavor`.

