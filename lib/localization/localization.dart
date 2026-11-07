import 'package:booknow_mobile/localization/translations/generated/translations.g.dart';
import 'package:flutter/widgets.dart';

export 'package:booknow_mobile/localization/translations/generated/translations.g.dart';

/// The languages the app ships in.
///
/// Italian is the pilot's UI language; English is kept in step because the
/// product is meant to outgrow one shop in one city, and retrofitting a second
/// locale later is far more work than keeping one current.
enum AppLanguage {
  italian(AppLocale.it, 'Italiano'),
  english(AppLocale.en, 'English');

  const AppLanguage(this.locale, this.nativeName);

  final AppLocale locale;

  /// The language's name in its own language — never translated.
  final String nativeName;

  String get code => locale.languageCode;

  static AppLanguage fromCode(String? code) => AppLanguage.values.firstWhere(
    (language) => language.code == code,
    orElse: () => AppLanguage.italian,
  );

  static List<Locale> get supportedLocales => AppLanguage.values
      .map((language) => language.locale.flutterLocale)
      .toList();
}
