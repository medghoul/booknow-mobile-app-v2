import 'package:booknow_mobile/core/structures/enums/prefs_keys.dart';
import 'package:booknow_mobile/core/utils/validation/form_validators.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() => LocaleSettings.setLocaleSync(AppLocale.en));

  group('required', () {
    test('rejects null, empty and whitespace alike', () {
      for (final value in [null, '', '   ', '\n']) {
        expect(FormValidators.required(value), isNotNull, reason: '$value');
      }
    });

    test('accepts any real text', () {
      expect(FormValidators.required('Marco'), isNull);
    });
  });

  group('phone', () {
    test('an empty value passes, because the field is optional', () {
      expect(FormValidators.phone(null), isNull);
      expect(FormValidators.phone(''), isNull);
      expect(FormValidators.phone('  '), isNull);
    });

    test('but an empty value fails when the caller asks for one', () {
      expect(FormValidators.phone('', isRequired: true), isNotNull);
    });

    test('accepts the grouping the design shows', () {
      // "347 8821 940" is how the profile screen renders it.
      expect(FormValidators.phone('347 8821 940'), isNull);
      expect(FormValidators.phone('+39 347 8821 940'), isNull);
      expect(FormValidators.phone('+39 (347) 882-1940'), isNull);
    });

    test('rejects letters and obviously wrong lengths', () {
      expect(FormValidators.phone('not a phone'), isNotNull);
      expect(FormValidators.phone('1'), isNotNull);
      expect(FormValidators.phone('+390123456789012345'), isNotNull);
    });
  });

  group('email', () {
    test('accepts ordinary and relay addresses', () {
      expect(FormValidators.email('marco@example.com'), isNull);
      expect(FormValidators.email('abc.def@privaterelay.appleid.com'), isNull);
    });

    test('rejects the shapes that are certainly wrong', () {
      for (final value in ['marco', 'marco@', '@example.com', 'a@b']) {
        expect(FormValidators.email(value), isNotNull, reason: value);
      }
    });

    test('is optional when asked to be', () {
      expect(FormValidators.email('', isRequired: false), isNull);
    });
  });

  group('all', () {
    test('reports the first complaint and stops', () {
      final validate = FormValidators.all([
        FormValidators.required,
        (value) => FormValidators.length(value, min: 5),
      ]);

      expect(validate(''), FormValidators.required(''));
      expect(validate('abc'), FormValidators.length('abc', min: 5));
      expect(validate('abcdef'), isNull);
    });
  });

  group('PrefsKey', () {
    test('every key is unique', () {
      final values = PrefsKey.values.map((key) => key.value).toList();
      expect(values.toSet().length, values.length);
    });

    test('only the tokens are secret', () {
      final secure = PrefsKey.values.where((key) => key.isSecure).toSet();
      expect(secure, {
        PrefsKey.accessToken,
        PrefsKey.refreshToken,
        PrefsKey.idToken,
      });
    });
  });
}
