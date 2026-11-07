import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:booknow_mobile/core/di/dependency_injection.dart';
import 'package:booknow_mobile/core/services/push/push_service.dart';
import 'package:booknow_mobile/core/services/theme/theme_service.dart';
import 'package:booknow_mobile/core/theme/app_theme.dart';
import 'package:booknow_mobile/features/auth/cubit/auth_cubit.dart';
import 'package:booknow_mobile/features/notifications/data/push_tap_handler.dart';
import 'package:booknow_mobile/features/notifications/widgets/index.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// The root widget.
///
/// The theme choice lives in [ThemeService], not here: the profile both shows
/// and changes it, so it has to be a value two screens can listen to rather
/// than state hidden in this `State`. This end of it listens and applies.
class BookNowApp extends StatefulWidget {
  const BookNowApp({super.key, required this.router, required this.theme});

  final AppRouter router;
  final ThemeService theme;

  @override
  State<BookNowApp> createState() => BookNowAppState();
}

class BookNowAppState extends State<BookNowApp> {
  /// Built once, on purpose.
  ///
  /// `config()` mints a fresh router delegate each call, and the delegate
  /// carries the navigator's `GlobalKey`. `AppScreenInit` builds through a
  /// `LayoutBuilder`, so its builder runs *during layout* and can run more
  /// than once — calling `config()` in `build` there hands the same key to a
  /// second Navigator and trips "Duplicate GlobalKey", leaving a black screen.
  late final RouterConfig<UrlState> _routerConfig = widget.router.config();

  /// Lives as long as the app, not as long as a screen: a push can be tapped
  /// while the app is closed, and the tap has to survive until the session
  /// resolves and there is somewhere to send it.
  late final PushTapHandler _pushTaps = PushTapHandler(
    auth: di<AuthCubit>(),
    navigate: widget.router.navigate,
  );

  @override
  void dispose() {
    unawaited(_pushTaps.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // The design's screens are drawn at 390 × 844; the responsive scale reads
    // from that so `.w` / `.h` / `.sp` mean what the design file means.
    return AppScreenInit(
      designSize: const Size(390, 844),
      builder: (context, child) => ListenableBuilder(
        listenable: widget.theme,
        builder: (context, _) => MaterialApp.router(
          title: 'BookNow',
          debugShowCheckedModeBanner: false,
          routerConfig: _routerConfig,
          builder: (context, child) => PushListener(
            push: di<PushService>(),
            onOpen: _pushTaps.open,
            child: child!,
          ),
          themeMode: widget.theme.themeMode,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          locale: TranslationProvider.of(context).flutterLocale,
          supportedLocales: AppLocaleUtils.supportedLocales,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        ),
      ),
    );
  }
}
