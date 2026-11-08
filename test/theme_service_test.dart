import 'package:booknow_mobile/core/services/storage/prefs_service.dart';
import 'package:booknow_mobile/core/services/theme/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A screen the router is holding on to: built once, so a rebuild of
/// whatever is above it cannot rebuild this subtree — `Element.updateChild`
/// skips a child whose widget is the same instance. Listening to the service
/// is the only thing that brings the new choice down here, which is the bug
/// this file exists for: the theme changed and the control that changed it
/// went on showing the old one.
class _Screen extends StatelessWidget {
  const _Screen(this.theme);

  final ThemeService theme;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: theme,
      builder: (context, _) => Scaffold(
        body: Column(
          children: [
            Text(theme.themeMode.name),
            TextButton(
              onPressed: () => theme.setThemeMode(ThemeMode.dark),
              child: const Text('scegli scuro'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late PrefsService prefs;

  Future<PrefsService> prefsWith(Map<String, Object> values) async {
    SharedPreferences.setMockInitialValues(values);
    return PrefsService.create();
  }

  setUp(() async => prefs = await prefsWith({}));

  group('ThemeService', () {
    test('a first launch is light, whatever the phone is set to', () {
      expect(ThemeService(prefs).themeMode, ThemeMode.light);
    });

    test('someone who chose to follow the phone still does', () async {
      final stored = await prefsWith({'theme_mode': 'system'});

      expect(ThemeService(stored).themeMode, ThemeMode.system);
    });

    test('a stored choice is in force before the first frame', () async {
      final stored = await prefsWith({'theme_mode': 'dark'});

      expect(ThemeService(stored).themeMode, ThemeMode.dark);
    });

    test('a choice is announced and then written', () async {
      final service = ThemeService(prefs);
      var notifications = 0;
      service.addListener(() => notifications++);

      await service.setThemeMode(ThemeMode.dark);

      expect(notifications, 1);
      expect(service.themeMode, ThemeMode.dark);
      expect(prefs.themeMode, ThemeMode.dark);
    });

    // Tapping the segment that is already on rebuilds the whole app
    // otherwise, and every listener with it.
    test('choosing what is already in force tells nobody', () async {
      final service = ThemeService(prefs);
      var notifications = 0;
      service.addListener(() => notifications++);

      await service.setThemeMode(ThemeMode.light);

      expect(notifications, 0);
    });

    testWidgets('a screen the router kept sees the new choice', (tester) async {
      final service = ThemeService(prefs);
      // Built once, like a page the router is holding on to.
      final screen = _Screen(service);

      await tester.pumpWidget(
        ListenableBuilder(
          listenable: service,
          builder: (context, _) => MaterialApp(
            themeMode: service.themeMode,
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            home: screen,
          ),
        ),
      );

      expect(find.text('light'), findsOneWidget);

      await tester.tap(find.text('scegli scuro'));
      await tester.pumpAndSettle();

      expect(find.text('dark'), findsOneWidget);
      expect(
        Theme.of(tester.element(find.byType(Scaffold))).brightness,
        Brightness.dark,
      );
    });
  });
}
