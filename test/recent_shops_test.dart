import 'package:booknow_mobile/core/services/storage/prefs_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late PrefsService prefs;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await PrefsService.create();
  });

  test('starts empty', () {
    expect(prefs.recentShopIds, isEmpty);
  });

  test('puts the last opened first, without repeats', () async {
    await prefs.addRecentShop('a');
    await prefs.addRecentShop('b');
    await prefs.addRecentShop('a');

    expect(prefs.recentShopIds, ['a', 'b']);
  });

  test('keeps only the last five', () async {
    for (final id in ['a', 'b', 'c', 'd', 'e', 'f']) {
      await prefs.addRecentShop(id);
    }

    expect(prefs.recentShopIds, ['f', 'e', 'd', 'c', 'b']);
  });
}
