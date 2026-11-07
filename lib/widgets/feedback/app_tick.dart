import 'package:flutter/material.dart';

/// The tick that draws itself: the app's "it worked".
///
/// Circle first, then the check, with a small settle at the end. With reduce
/// motion on it is simply there.
class AppTick extends StatefulWidget {
  const AppTick({super.key, this.size = 84, this.color});

  final double size;
  final Color? color;

  @override
  State<AppTick> createState() => _AppTickState();
}

class _AppTickState extends State<AppTick> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 720),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final reduce = MediaQuery.maybeDisableAnimationsOf(context) ?? false;
    if (reduce) {
      _controller.value = 1;
    } else if (!_controller.isAnimating && _controller.value == 0) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.color ?? Theme.of(context).colorScheme.secondary;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final settle = Curves.elasticOut.transform(
          ((_controller.value - 0.5) / 0.5).clamp(0.0, 1.0),
        );

        return Transform.scale(
          scale: 0.92 + 0.08 * settle,
          child: CustomPaint(
            size: Size.square(widget.size),
            painter: _TickPainter(progress: _controller.value, color: color),
          ),
        );
      },
    );
  }
}

class _TickPainter extends CustomPainter {
  const _TickPainter({required this.progress, required this.color});

  final double progress;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final stroke = size.width / 16;
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final circle = (progress / 0.6).clamp(0.0, 1.0);
    final radius = size.width / 2 - stroke / 2;
    canvas.drawArc(
      Offset(stroke / 2, stroke / 2) & Size.square(radius * 2),
      -1.57,
      6.283 * Curves.easeOut.transform(circle),
      false,
      paint,
    );

    final check = ((progress - 0.5) / 0.4).clamp(0.0, 1.0);
    if (check == 0) return;

    final w = size.width;
    final path = Path()
      ..moveTo(w * 0.31, w * 0.52)
      ..lineTo(w * 0.44, w * 0.64)
      ..lineTo(w * 0.69, w * 0.38);
    for (final metric in path.computeMetrics()) {
      canvas.drawPath(metric.extractPath(0, metric.length * check), paint);
    }
  }

  @override
  bool shouldRepaint(_TickPainter old) =>
      old.progress != progress || old.color != color;
}
