import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// The app's line icons, as path data on a 24 unit grid.
abstract final class AppLineIcons {
  static const String search =
      'M21 21l-4.3-4.3M11 18a7 7 0 1 1 0-14 7 7 0 0 1 0 14z';
  static const String activity = 'M3 12h4l3 8 4-16 3 8h4';
  static const String person =
      'M12 12a4 4 0 1 0 0-8 4 4 0 0 0 0 8zM4 21a8 8 0 0 1 16 0';
  static const String today =
      'M12 8v4l3 2M12 21a9 9 0 1 0 0-18 9 9 0 0 0 0 18z';
  static const String calendar = 'M3 4h18v18H3zM16 2v4M8 2v4M3 10h18';
  static const String shop =
      'M3 10l2-6h14l2 6M4 10v10h16V10M3 10h18M9 20v-6h6v6';
  static const String services = 'M6 6l12 12M18 6L6 18';
  static const String hours =
      'M12 7v5l3 2M12 21a9 9 0 1 0 0-18 9 9 0 0 0 0 18z';
  static const String customers =
      'M9 11a3 3 0 1 0 0-6 3 3 0 0 0 0 6zM3 20a6 6 0 0 1 12 0M17 11a3 3 0 1 0 0-6M21 20a6 6 0 0 0-3-5';
  static const String bell =
      'M6 8a6 6 0 0 1 12 0c0 7 3 9 3 9H3s3-2 3-9M10.3 21a1.94 1.94 0 0 0 3.4 0';
  static const String help =
      'M12 21a9 9 0 1 0 0-18 9 9 0 0 0 0 18zM9.5 9a2.5 2.5 0 0 1 4.8 1c0 1.5-2.3 2-2.3 3.5M12 17h.01';
  static const String chevronRight = 'M9 6l6 6-6 6';
  static const String chevronLeft = 'M15 6l-6 6 6 6';
  static const String chevronUp = 'M18 15l-6-6-6 6';
  static const String chevronDown = 'M6 9l6 6 6-6';
  static const String pin =
      'M12 21s-7-6.2-7-11a7 7 0 0 1 14 0c0 4.8-7 11-7 11zM12 12.5a2.5 2.5 0 1 0 0-5 2.5 2.5 0 0 0 0 5z';
  static const String close = 'M6 6l12 12M18 6L6 18';
  static const String check = 'M5 12l5 5L20 7';
  static const String map = 'M9 4L3 6v14l6-2 6 2 6-2V4l-6 2zM9 4v14M15 6v14';
  static const String list =
      'M8 6h13M8 12h13M8 18h13M3 6h.01M3 12h.01M3 18h.01';
  static const String plus = 'M12 5v14M5 12h14';
  static const String locate =
      'M12 19a7 7 0 1 0 0-14 7 7 0 0 0 0 14zM12 2v3M12 19v3M2 12h3M19 12h3';
  static const String camera =
      'M4 8h3l2-3h6l2 3h3v11H4zM12 16.5a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7z';
}

/// One line icon, stroked in [color].
class AppLineIcon extends StatelessWidget {
  const AppLineIcon(
    this.path, {
    super.key,
    this.size = 20,
    this.color,
    this.strokeWidth = 2,
  });

  final String path;
  final double size;

  /// The surrounding icon colour when null.
  final Color? color;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    final paint = color ?? IconTheme.of(context).color ?? Colors.black;

    return SvgPicture.string(
      '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" '
      'stroke="#000" stroke-width="$strokeWidth" stroke-linecap="round" '
      'stroke-linejoin="round"><path d="$path"/></svg>',
      width: size.w,
      height: size.w,
      excludeFromSemantics: true,
      colorFilter: ColorFilter.mode(paint, BlendMode.srcIn),
    );
  }
}
