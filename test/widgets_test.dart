import 'package:booknow_mobile/core/structures/enums/booking_status.dart';
import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'theme_test.dart' show pumpThemed;

void main() {
  group('AppElevatedButton', () {
    testWidgets('renders its label and fires onPressed', (tester) async {
      var taps = 0;
      await pumpThemed(
        tester,
        AppElevatedButton(label: 'Conferma e paga', onPressed: () => taps++),
      );

      expect(find.text('Conferma e paga'), findsOneWidget);
      await tester.tap(find.byType(AppElevatedButton));
      expect(taps, 1);
    });

    testWidgets('swallows taps while loading, so a booking is not doubled', (
      tester,
    ) async {
      var taps = 0;
      await pumpThemed(
        tester,
        AppElevatedButton(
          label: 'Conferma e paga',
          isLoading: true,
          onPressed: () => taps++,
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.tap(find.byType(AppElevatedButton));
      expect(taps, 0);
    });

    testWidgets('is inert when disabled', (tester) async {
      var taps = 0;
      await pumpThemed(
        tester,
        AppElevatedButton(
          label: 'Conferma',
          isDisabled: true,
          onPressed: () => taps++,
        ),
      );

      await tester.tap(find.byType(AppElevatedButton));
      expect(taps, 0);
    });
  });

  group('AppSettingsRow', () {
    // The chevron promises a screen. A row that raises a dialog over this
    // one has not gone anywhere, so it must not draw the arrow — that is how
    // the design tells "Notifiche ›" apart from "Esci".
    testWidgets('an action row is tappable and still draws no arrow', (
      tester,
    ) async {
      var taps = 0;

      await pumpThemed(
        tester,
        AppSettingsRow.action(
          icon: AppLineIcons.bell,
          label: 'Esci',
          onTap: () => taps++,
        ),
      );

      expect(find.byIcon(Icons.chevron_right_rounded), findsNothing);

      await tester.tap(find.text('Esci'));
      await tester.pump();
      expect(taps, 1);
    });

    testWidgets('a row that opens a screen does draw one', (tester) async {
      await pumpThemed(
        tester,
        AppSettingsRow(
          icon: AppLineIcons.bell,
          label: 'Notifiche',
          onTap: () {},
        ),
      );

      expect(find.byType(AppLineIcon), findsNWidgets(2));
    });

    // The notifications row has no value until the OS answers, which lands
    // after the screen is already standing.
    testWidgets('a value that arrives late fades in rather than popping', (
      tester,
    ) async {
      Future<void> pumpRow(String? value) => pumpThemed(
        tester,
        AppSettingsRow(
          icon: AppLineIcons.bell,
          label: 'Notifiche',
          value: value,
          onTap: () {},
        ),
        animations: true,
      );

      await pumpRow(null);
      expect(find.text('Attive'), findsNothing);

      await pumpRow('Attive');
      await tester.pump(const Duration(milliseconds: 50));

      final fade = tester.widget<FadeTransition>(
        find
            .ancestor(
              of: find.text('Attive'),
              matching: find.byType(FadeTransition),
            )
            .first,
      );
      expect(
        fade.opacity.value,
        lessThan(1),
        reason: 'the word is still on its way in, not set',
      );

      await tester.pumpAndSettle();
      expect(find.text('Attive'), findsOneWidget);
    });

    // "Attive" replacing "Non attive" is the same row changing its mind, and
    // reads as one word becoming another rather than a repaint.
    testWidgets('one value crosses over the one it replaces', (tester) async {
      Future<void> pumpRow(String value) => pumpThemed(
        tester,
        AppSettingsRow(
          icon: AppLineIcons.bell,
          label: 'Notifiche',
          value: value,
          onTap: () {},
        ),
        animations: true,
      );

      await pumpRow('Non attive');
      await pumpRow('Attive');
      await tester.pump(const Duration(milliseconds: 50));

      expect(find.text('Non attive'), findsOneWidget);
      expect(find.text('Attive'), findsOneWidget);

      await tester.pumpAndSettle();

      expect(find.text('Non attive'), findsNothing);
      expect(find.text('Attive'), findsOneWidget);
    });
  });

  group('AppBottomSheet', () {
    // Not a Material default that happens to be close: the sheet reads its
    // motion off the tokens, so moving `AppMotion` moves every sheet.
    testWidgets('rises on the tokens and leaves quicker than it came', (
      tester,
    ) async {
      late BuildContext sheetContext;

      final host = await pumpThemed(
        tester,
        Builder(
          builder: (context) => TextButton(
            onPressed: () => AppBottomSheet.show<void>(
              context,
              builder: (sheet) {
                sheetContext = sheet;
                return const Text('contenuto');
              },
            ),
            child: const Text('open'),
          ),
        ),
        animations: true,
      );

      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();

      final route = ModalRoute.of(sheetContext)!;

      expect(route.transitionDuration, host.motion.normal);
      expect(
        route.reverseTransitionDuration,
        host.motion.fast,
        reason: 'an answer already given is not worth easing back down',
      );
    });
  });

  group('AppDialog', () {
    Future<List<bool>> pumpDialog(
      WidgetTester tester, {
      bool isDestructive = false,
      String? cancelLabel = 'Annulla',
    }) async {
      final answers = <bool>[];

      await pumpThemed(
        tester,
        Builder(
          builder: (context) => TextButton(
            onPressed: () async => answers.add(
              await AppDialog.show(
                context,
                icon: Icons.logout_rounded,
                title: 'Uscire?',
                message: 'Le tue prenotazioni restano salvate.',
                confirmLabel: 'Esci',
                cancelLabel: cancelLabel,
                isDestructive: isDestructive,
              ),
            ),
            child: const Text('open'),
          ),
        ),
      );

      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();

      return answers;
    }

    // A dialog stops the user, so it is there rather than arriving: fast, and
    // on the emphasized curve rather than Material's `Curves.easeOut`.
    testWidgets('fades in on the motion tokens', (tester) async {
      final host = await pumpThemed(
        tester,
        Builder(
          builder: (context) => TextButton(
            onPressed: () =>
                AppDialog.show(context, title: 'Uscire?', confirmLabel: 'Esci'),
            child: const Text('open'),
          ),
        ),
        animations: true,
      );

      await tester.tap(find.text('open'));
      await tester.pump();
      await tester.pump(host.motion.fast ~/ 2);

      final fade = tester.widget<FadeTransition>(
        find
            .ancestor(
              of: find.byType(AlertDialog),
              matching: find.byType(FadeTransition),
            )
            .first,
      );

      expect(
        fade.opacity.value,
        closeTo(host.motion.curveEmphasized.transform(0.5), 0.01),
        reason: 'half way through, `Curves.easeOut` is a different number',
      );

      await tester.pumpAndSettle();
    });

    ColorScheme schemeOf(WidgetTester tester) =>
        Theme.of(tester.element(find.byType(ElevatedButton).first)).colorScheme;

    /// The colour the confirm button actually paints: its own override, or
    /// the theme's when it does not set one.
    Color? confirmColour(WidgetTester tester) {
      final button = find.byType(ElevatedButton).first;
      final own = tester
          .widget<ElevatedButton>(button)
          .style
          ?.backgroundColor
          ?.resolve({});

      return own ??
          Theme.of(
            tester.element(button),
          ).elevatedButtonTheme.style?.backgroundColor?.resolve({});
    }

    testWidgets('confirming resolves true and cancelling false', (
      tester,
    ) async {
      var answers = await pumpDialog(tester);
      await tester.tap(find.text('Esci'));
      await tester.pumpAndSettle();
      expect(answers, [true]);

      answers = await pumpDialog(tester);
      await tester.tap(find.text('Annulla'));
      await tester.pumpAndSettle();
      expect(answers, [false]);
    });

    // A caller must not be able to read "tapped away" as an answer.
    testWidgets('dismissing resolves false, never null', (tester) async {
      final answers = await pumpDialog(tester);

      await tester.tapAt(const Offset(10, 10));
      await tester.pumpAndSettle();

      expect(answers, [false]);
    });

    // The way out of a dialog that stops you should not be the faintest
    // thing on it.
    testWidgets('cancel is a real button, not a text link', (tester) async {
      await pumpDialog(tester);

      expect(find.byType(AppOutlinedButton), findsOneWidget);
      expect(find.byType(AppTextButton), findsNothing);
    });

    testWidgets('a single-action dialog has no way to decline', (tester) async {
      await pumpDialog(tester, cancelLabel: null);

      expect(find.text('Esci'), findsOneWidget);
      expect(find.byType(AppOutlinedButton), findsNothing);
    });

    // Signing out costs nothing, so it is not painted red. If every
    // confirmation were destructive, red would stop meaning anything.
    testWidgets('an ordinary confirmation is the action colour', (
      tester,
    ) async {
      await pumpDialog(tester);

      expect(confirmColour(tester), schemeOf(tester).primary);
    });

    testWidgets('a destructive one is the danger colour', (tester) async {
      await pumpDialog(tester, isDestructive: true);

      expect(confirmColour(tester), schemeOf(tester).error);
    });

    testWidgets('the mark is decorative, and says so', (tester) async {
      await pumpDialog(tester);

      expect(
        find.ancestor(
          of: find.byIcon(Icons.logout_rounded),
          matching: find.byType(ExcludeSemantics),
        ),
        findsOneWidget,
      );
    });
  });

  group('AppIconButton', () {
    ButtonStyle? styleOf(WidgetTester tester) =>
        tester.widget<IconButton>(find.byType(IconButton)).style;

    OutlinedBorder? shapeOf(WidgetTester tester) =>
        styleOf(tester)?.shape?.resolve({});

    testWidgets('a bare button is the glyph and nothing else', (tester) async {
      await pumpThemed(
        tester,
        AppIconButton(icon: Icons.close, tooltip: 'Chiudi', onPressed: () {}),
      );

      expect(styleOf(tester), isNull);
    });

    // The two discs are the same size — one platform touch target — and are
    // told apart by their edge, not by how big they are.
    testWidgets('a filled disc is solid, an outlined one is an edge', (
      tester,
    ) async {
      await pumpThemed(
        tester,
        AppIconButton(
          icon: Icons.edit_outlined,
          tooltip: 'Modifica',
          style: AppIconButtonStyle.filled,
          onPressed: () {},
        ),
      );

      final filled = styleOf(tester);
      expect(filled?.backgroundColor?.resolve({}), isNotNull);
      expect(shapeOf(tester)?.side.style, BorderStyle.none);
      final size = filled?.fixedSize?.resolve({});

      await pumpThemed(
        tester,
        AppIconButton(
          icon: Icons.edit_outlined,
          tooltip: 'Modifica',
          style: AppIconButtonStyle.outlined,
          onPressed: () {},
        ),
      );

      expect(styleOf(tester)?.backgroundColor?.resolve({}), isNull);
      expect(shapeOf(tester)?.side.width, greaterThan(0));
      expect(styleOf(tester)?.fixedSize?.resolve({}), size);
    });
  });

  group('AppDivider', () {
    // Colour and thickness used to be passed at nine call sites. They belong
    // to `DividerThemeData`, and a rule a shade off from the rest is exactly
    // what restating them produces.
    testWidgets('takes its colour and thickness from the theme', (
      tester,
    ) async {
      late ThemeData theme;
      await pumpThemed(
        tester,
        Builder(
          builder: (context) {
            theme = Theme.of(context);
            return const AppDivider();
          },
        ),
      );

      final divider = tester.widget<Divider>(find.byType(Divider));
      expect(divider.color, isNull, reason: 'not restated');
      expect(divider.thickness, isNull, reason: 'not restated');
      expect(theme.dividerTheme.color, isNotNull);
      expect(theme.dividerTheme.thickness, isNotNull);
    });

    // Material's own default reserves 16 of vertical space, so a rule between
    // two rows silently adds a gap wherever someone forgets to say otherwise.
    testWidgets('occupies its own thickness and no more', (tester) async {
      late double thickness;
      await pumpThemed(
        tester,
        Builder(
          builder: (context) {
            thickness = Theme.of(context).dividerTheme.thickness!;
            return const AppDivider();
          },
        ),
      );

      expect(tester.getSize(find.byType(Divider)).height, thickness);
    });

    testWidgets('the inset variant stops short of both edges', (tester) async {
      await pumpThemed(tester, const AppDivider.inset());

      final line = tester.widget<Divider>(find.byType(Divider));
      expect(line.indent, greaterThan(0));
      expect(line.endIndent, line.indent);
    });
  });

  group('AppSwitch', () {
    // The whole reason this is drawn rather than themed: Material's switch
    // shrinks its thumb when it is off, and the design's does not.
    testWidgets('the thumb is the same size whichever side it is on', (
      tester,
    ) async {
      await pumpThemed(
        tester,
        Column(
          children: [
            AppSwitch(value: true, onChanged: (_) {}),
            AppSwitch(value: false, onChanged: (_) {}),
          ],
        ),
      );
      await tester.pumpAndSettle();

      // The thumbs are the round ones; the tracks are the capsules.
      final thumbs = find.byWidgetPredicate(
        (widget) =>
            widget is Container &&
            widget.decoration is BoxDecoration &&
            (widget.decoration! as BoxDecoration).shape == BoxShape.circle,
      );

      expect(thumbs, findsNWidgets(2));
      expect(tester.getSize(thumbs.first), tester.getSize(thumbs.last));
    });

    testWidgets('a tap asks for the opposite of what it shows', (tester) async {
      bool? asked;
      await pumpThemed(
        tester,
        AppSwitch(value: false, onChanged: (value) => asked = value),
      );

      await tester.tap(find.byType(AppSwitch));
      await tester.pumpAndSettle();

      expect(asked, isTrue);
    });

    // A switch nobody can move is dimmed rather than hidden: the setting
    // still exists, it is simply not theirs to change.
    testWidgets('no handler means no tap and a dimmed control', (tester) async {
      var taps = 0;
      await pumpThemed(
        tester,
        GestureDetector(
          onTap: () => taps++,
          child: const AppSwitch(value: true, onChanged: null),
        ),
      );

      expect(find.byType(Opacity), findsOneWidget);

      await tester.tap(find.byType(AppSwitch));
      await tester.pumpAndSettle();

      // The tap fell through to the parent: the switch took none of it.
      expect(taps, 1);
    });
  });

  group('AppTextField', () {
    // The theme makes every field a pill, which is right for one line and
    // wrong for four: the curve eats the first and last line's corners.
    testWidgets('a multi-line field is a rounded box, not a pill', (
      tester,
    ) async {
      final context = await pumpThemed(
        tester,
        const AppTextField(label: 'Messaggio', maxLines: 4),
      );

      final decoration = tester
          .widget<InputDecorator>(find.byType(InputDecorator))
          .decoration;

      expect(
        (decoration.enabledBorder! as OutlineInputBorder).borderRadius,
        context.radii.xlR,
      );
      expect(
        (decoration.focusedBorder! as OutlineInputBorder).borderRadius,
        context.radii.xlR,
      );
    });

    testWidgets('one line takes the input radius', (tester) async {
      final context = await pumpThemed(
        tester,
        const AppTextField(label: 'Nome'),
      );

      final decoration = tester
          .widget<InputDecorator>(find.byType(InputDecorator))
          .decoration;

      expect(
        (decoration.enabledBorder! as OutlineInputBorder).borderRadius,
        context.radii.mdR,
      );
    });
  });

  group('AppStatusBadge', () {
    testWidgets('always shows an icon and a word, never colour alone', (
      tester,
    ) async {
      final context = await pumpThemed(tester, const SizedBox.shrink());
      final tint = context.status.ofBooking(BookingStatus.confirmed);

      await pumpThemed(
        tester,
        AppStatusBadge(
          tint: tint,
          icon: Icons.check_circle_outline,
          label: 'Confermata',
        ),
      );

      expect(find.byIcon(Icons.check_circle_outline), findsOneWidget);
      expect(find.text('Confermata'), findsOneWidget);
    });
  });

  group('AppEmptyState', () {
    testWidgets('shows its action when one is given', (tester) async {
      await pumpThemed(
        tester,
        AppEmptyState(
          icon: Icons.event_busy,
          title: 'Nessuna prenotazione',
          message: 'Le tue prenotazioni compariranno qui.',
          action: AppElevatedButton(label: 'Prenota', onPressed: () {}),
        ),
      );

      expect(find.text('Nessuna prenotazione'), findsOneWidget);
      expect(find.byType(AppElevatedButton), findsOneWidget);
    });
  });

  group('AppScaffold', () {
    testWidgets('pads its body with the screen gutter', (tester) async {
      await pumpThemed(tester, const AppScaffold(body: Text('content')));

      expect(find.text('content'), findsOneWidget);

      final context = tester.element(find.text('content'));
      final padding = tester.widget<Padding>(
        find
            .ancestor(of: find.text('content'), matching: find.byType(Padding))
            .first,
      );

      expect(padding.padding, context.spacing.screenGutter);
    });

    testWidgets('blocks the back gesture when canPop is false', (tester) async {
      await pumpThemed(
        tester,
        const AppScaffold(canPop: false, body: Text('paying')),
      );

      final popScope = tester.widget<PopScope<Object?>>(
        find.byType(PopScope<Object?>).first,
      );
      expect(popScope.canPop, isFalse);
    });
  });
}
