import 'dart:async';

import 'package:booknow_mobile/core/app/app.dart';
import 'package:booknow_mobile/core/app/observers/app_bloc_observer.dart';
import 'package:booknow_mobile/core/config/app_config.dart';
import 'package:booknow_mobile/core/di/dependency_injection.dart';
import 'package:booknow_mobile/features/home_widgets/home_widget_sync.dart';
import 'package:booknow_mobile/core/services/push/push_service.dart';
import 'package:booknow_mobile/core/services/theme/theme_service.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/routing/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  final binding = WidgetsFlutterBinding.ensureInitialized();

  // Bloc observer is used to log every cubit transition to the log.
  if (kDebugMode) Bloc.observer = const AppBlocObserver();

  // FlutterNativeSplash is used to keep the native launch screen visible until Flutter has actually painted.
  FlutterNativeSplash.preserve(widgetsBinding: binding);

  // Portrait only, there is no landscape.
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // AppConfig is loaded before anything renders.
  await AppConfig.load();

  // Locale data is loaded before anything renders.
  await initializeDateFormatting();

  // Firebase is initialized before the background handler is registered
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(pushBackgroundHandler);

  await setupDependencies();

  runApp(
    TranslationProvider(
      child: BookNowApp(router: di<AppRouter>(), theme: di<ThemeService>()),
    ),
  );

  // FlutterNativeSplash is removed after the first frame is painted.
  binding.addPostFrameCallback((_) {
    FlutterNativeSplash.remove();
    unawaited(di<PushService>().initialize());
    di<HomeWidgetSync>().start();
  });
}
