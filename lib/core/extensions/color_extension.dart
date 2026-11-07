import 'package:flutter/material.dart';

extension ColorExtension on Color {
  /// Replacement for the deprecated `withOpacity`.
  Color withOpacityValue(double opacity) {
    assert(opacity >= 0 && opacity <= 1, 'Opacity must be between 0 and 1');
    return withAlpha((255 * opacity).round());
  }
}
