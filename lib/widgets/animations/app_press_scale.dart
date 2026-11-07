import 'package:booknow_mobile/core/constants/app_component_sizes.dart';
import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

/// Builds the control, which must take [states] as its `statesController`.
typedef AppPressScaleBuilder =
    Widget Function(BuildContext context, WidgetStatesController states);

/// Shrinks a control slightly while it is held down.
///
/// The press comes from the control itself, through the `statesController`
/// every Material button accepts, rather than from a gesture detector wrapped
/// around it. That distinction matters inside a scroll view: a finger that
/// lands on a button and then drags loses the tap to the scrollable, the
/// button drops its pressed state, and the scale follows it back up. A
/// `Listener` would hold the button shrunk for the whole scroll, and a
/// `GestureDetector` would be contesting the same tap the button needs.
///
/// Nothing about the tap is handled here, so the control keeps its own
/// `onPressed`, ripple, focus and semantics. It also means a disabled or
/// loading button never reports a press, and so never scales, with no extra
/// check for it.
class AppPressScale extends StatefulWidget {
  /// For a control that reports its own press — every Material button.
  const AppPressScale({
    super.key,
    required AppPressScaleBuilder builder,
    this.scale = AppComponentSizes.pressedScale,
  }) : _builder = builder,
       _child = null,
       onTap = null;

  /// For a card or row that has no `statesController` to offer.
  ///
  /// This **owns** the tap rather than wrapping something that already
  /// handles one, so there is still exactly one `TapGestureRecognizer` in the
  /// arena. `onTapDown`, `onTapUp` and `onTapCancel` are served by that same
  /// recognizer, which is what keeps the scroll behaviour from the other
  /// constructor: drag away and the recognizer loses, `onTapCancel` fires,
  /// and the card comes back up.
  ///
  /// A null [onTap] is an untappable surface — no recogniser, so no press and
  /// no scale, which is what a disabled card should do.
  const AppPressScale.tap({
    super.key,
    required Widget child,
    required this.onTap,
    this.scale = AppComponentSizes.pressedScale,
  }) : _child = child,
       _builder = null;

  final AppPressScaleBuilder? _builder;
  final Widget? _child;

  /// Only set by [AppPressScale.tap].
  final VoidCallback? onTap;

  /// How far down to scale while held; 1.0 is no movement at all.
  final double scale;

  @override
  State<AppPressScale> createState() => _AppPressScaleState();
}

class _AppPressScaleState extends State<AppPressScale>
    with SingleTickerProviderStateMixin {
  final WidgetStatesController _states = WidgetStatesController();

  /// Driven rather than rebuilt with `setState`, because a button that is
  /// disabled mid-press — tap a submit button, it flips to loading — clears
  /// `pressed` from its own `didUpdateWidget`, which runs inside the build
  /// phase where `setState` is illegal. Retargeting a controller there is not.
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: Duration.zero,
  );

  bool _reduceMotion = false;

  @override
  void initState() {
    super.initState();
    _states.addListener(_handleStateChange);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _reduceMotion = MediaQuery.maybeDisableAnimationsOf(context) ?? false;
    _controller.duration = context.motion.fast;
    if (_reduceMotion) _controller.value = 0;
  }

  @override
  void dispose() {
    _states.removeListener(_handleStateChange);
    _states.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _handleStateChange() {
    if (_reduceMotion) return;
    if (_states.value.contains(WidgetState.pressed)) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  void _setPressed(bool value) => _states.update(WidgetState.pressed, value);

  /// The control itself, however it reports a press.
  Widget _content(BuildContext context) {
    final builder = widget._builder;
    if (builder != null) return builder(context, _states);

    final enabled = widget.onTap != null;
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: enabled ? (_) => _setPressed(true) : null,
      onTapUp: enabled ? (_) => _setPressed(false) : null,
      onTapCancel: enabled ? () => _setPressed(false) : null,
      child: widget._child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final child = _content(context);
    if (_reduceMotion) return child;

    final curve = context.motion.curve;

    return AnimatedBuilder(
      animation: _controller,
      // `Transform.scale` paints the control smaller without relaying it out,
      // so nothing around it shifts and the hit test still lands on the
      // untransformed bounds.
      builder: (context, child) => Transform.scale(
        scale: 1 - (1 - widget.scale) * curve.transform(_controller.value),
        child: child,
      ),
      child: child,
    );
  }
}
