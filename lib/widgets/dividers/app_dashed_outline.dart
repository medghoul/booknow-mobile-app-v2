import 'package:flutter/material.dart';

/// A dashed rounded-rectangle outline, painted around [child].
///
/// The design system uses a dash for "nothing here yet": a free run on the
/// owner's timeline, a closed day in the date strip. A solid hairline would
/// read as a card with no content, which is a different thing, so the dash is
/// load-bearing rather than decoration.
///
/// Flutter has no dashed [Border] — `BorderSide` strokes continuously — so the
/// outline is painted. It goes behind the child, inset by half the stroke so
/// the line lands inside the widget's own bounds rather than straddling them.
class AppDashedOutline extends StatelessWidget {
  const AppDashedOutline({
    super.key,
    required this.child,
    required this.color,
    required this.radius,
    this.strokeWidth = 1.5,
    this.dashLength = 5,
    this.gapLength = 4,
  });

  final Widget child;
  final Color color;
  final double radius;
  final double strokeWidth;
  final double dashLength;
  final double gapLength;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedOutlinePainter(
        color: color,
        radius: radius,
        strokeWidth: strokeWidth,
        dashLength: dashLength,
        gapLength: gapLength,
      ),
      child: child,
    );
  }
}

class _DashedOutlinePainter extends CustomPainter {
  const _DashedOutlinePainter({
    required this.color,
    required this.radius,
    required this.strokeWidth,
    required this.dashLength,
    required this.gapLength,
  });

  final Color color;
  final double radius;
  final double strokeWidth;
  final double dashLength;
  final double gapLength;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final outline = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Offset.zero & size,
          Radius.circular(radius),
        ).deflate(strokeWidth / 2),
      );

    // `computeMetrics` walks the path once and hands back its length, which is
    // the only way to space dashes evenly around corners of different radii.
    for (final metric in outline.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        canvas.drawPath(
          metric.extractPath(
            distance,
            (distance + dashLength).clamp(0, metric.length),
          ),
          paint,
        );
        distance += dashLength + gapLength;
      }
    }
  }

  @override
  bool shouldRepaint(_DashedOutlinePainter old) =>
      old.color != color ||
      old.radius != radius ||
      old.strokeWidth != strokeWidth ||
      old.dashLength != dashLength ||
      old.gapLength != gapLength;
}
