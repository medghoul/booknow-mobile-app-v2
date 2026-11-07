import 'package:booknow_mobile/core/config/app_config.dart';
import 'package:booknow_mobile/core/services/connectivity/network_info.dart';
import 'package:booknow_mobile/core/services/launcher/link_service.dart';
import 'package:booknow_mobile/core/services/location/location_service.dart';
import 'package:booknow_mobile/core/services/logger/app_logger.dart';
import 'package:booknow_mobile/core/services/launcher/system_settings_service.dart';
import 'package:booknow_mobile/core/services/storage/prefs_service.dart';
import 'package:booknow_mobile/core/services/storage/secure_storage_service.dart';
import 'package:booknow_mobile/core/services/theme/theme_service.dart';
import 'package:booknow_mobile/data/dio_client/dio_client.dart';
import 'package:booknow_mobile/data/interceptors/auth_interceptor.dart';
import 'package:booknow_mobile/data/interceptors/connectivity_interceptor.dart';
import 'package:booknow_mobile/data/interceptors/locale_interceptor.dart';
import 'package:booknow_mobile/data/interceptors/logging_interceptor.dart';
import 'package:booknow_mobile/core/services/push/push_service.dart';
import 'package:booknow_mobile/features/agenda/di/agenda_di.dart';
import 'package:booknow_mobile/features/auth/cubit/auth_cubit.dart';
import 'package:booknow_mobile/features/auth/di/auth_di.dart';
import 'package:booknow_mobile/features/booking_flow/di/booking_flow_di.dart';
import 'package:booknow_mobile/features/bookings/di/bookings_di.dart';
import 'package:booknow_mobile/features/queue/di/queue_di.dart';
import 'package:booknow_mobile/features/home/di/home_di.dart';
import 'package:booknow_mobile/features/shop_setup/di/shop_di.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/localization/services/localization_service.dart';
import 'package:booknow_mobile/routing/app_router.dart';
import 'package:booknow_mobile/routing/app_router.gr.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';

final GetIt di = GetIt.instance;

/// Builds the object graph. Called once, before `runApp`.
///
/// Registration order matters: the Dio client's interceptors depend on storage
/// and connectivity, so those come first.
Future<void> setupDependencies() async {
  AppConfig.assertConfigured();

  await _registerServices();
  await _registerLocalization();
  _registerNetwork();
  _registerRouter();
  _registerFeatures();
  _registerPush();
  await _configureStripe();
}

Future<void> _registerServices() async {
  di.registerSingleton<PrefsService>(await PrefsService.create());
  di.registerSingleton<PackageInfo>(await PackageInfo.fromPlatform());
  di.registerLazySingleton<LinkService>(LinkService.new);
  di.registerLazySingleton<LocationService>(LocationService.new);
  di.registerLazySingleton<SystemSettingsService>(SystemSettingsService.new);
  di.registerLazySingleton<ThemeService>(
    () => ThemeService(di<PrefsService>()),
  );
  di.registerLazySingleton<SecureStorageService>(SecureStorageService.new);
  di.registerLazySingleton<Connectivity>(Connectivity.new);
  di.registerLazySingleton<NetworkInfo>(() => NetworkInfo(di<Connectivity>()));
}

Future<void> _registerLocalization() async {
  final service = LocalizationService(di<PrefsService>());
  await service.initialize();
  di.registerSingleton<LocalizationService>(service);
}

void _registerNetwork() {
  di.registerLazySingleton<DioClient>(
    () => DioClient(
      interceptors: [
        LocaleInterceptor(() => LocaleSettings.currentLocale.languageCode),
        ConnectivityInterceptor(di<NetworkInfo>()),
        AuthInterceptor(
          storage: di<SecureStorageService>(),
          onUnauthorized: _onUnauthorized,
        ),
        if (!AppConfig.isProduction) LoggingInterceptor(),
      ],
    ),
  );
}

void _registerRouter() {
  di.registerLazySingleton<AppRouter>(AppRouter.new);
}

void _registerFeatures() {
  registerShopFeature(di);
  registerAuthFeature(di);
  registerHomeFeature(di);
  registerAgendaFeature(di);
  registerBookingsFeature(di);
  registerQueueFeature(di);
  registerBookingFlowFeature(di);
}

/// Push is a singleton because the token and the message streams have to be
/// the same ones everywhere. It is registered here but *started* from `main`
/// after the first frame — see `PushService.initialize`.
void _registerPush() {
  di.registerLazySingleton<PushService>(PushService.new);
}

Future<void> _configureStripe() async {
  if (!AppConfig.hasStripe) {
    AppLogger.warning(
      'STRIPE_PUBLISHABLE_KEY is empty — payments are disabled in this build.',
    );
    return;
  }

  Stripe.publishableKey = AppConfig.stripePublishableKey;
  // Left null rather than empty when unset: an empty identifier passes the
  // plugin's check and then fails inside Apple Pay instead.
  final merchantId = AppConfig.stripeMerchantId;
  if (merchantId.isNotEmpty) Stripe.merchantIdentifier = merchantId;
  await Stripe.instance.applySettings();
}

/// Guards against a burst of 401s all tearing the session down at once.
bool _isHandlingUnauthorized = false;

/// Puts the user back to browsing as a guest after their session is rejected.
///
/// The guest's tabs, not the splash: the splash's whole job is to restore the session,
/// so routing a rejection through it means immediately asking the server about
/// the session that was just rejected — which 401s, which lands here again.
Future<void> _onUnauthorized() async {
  if (_isHandlingUnauthorized) return;
  _isHandlingUnauthorized = true;

  try {
    AppLogger.info('Session rejected — back to browsing as a guest.');
    await di<AuthCubit>().sessionRejected();
    await di<AppRouter>().replaceAll([const CustomerShellRoute()]);
  } finally {
    _isHandlingUnauthorized = false;
  }
}
