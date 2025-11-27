import 'package:flutter/material.dart';

extension ColorExtension on Color {
  Color withAppOpacity(double opacity) {
    assert(opacity >= 0.0 && opacity <= 1.0);
    return withAlpha((255.0 * opacity).round());
  }

  Color contrastColor({bool reverse = false}) {
    if (computeLuminance() < 0.5) {
      return reverse == true ? Colors.black : Colors.white;
    } else {
      return reverse == true ? Colors.white : Colors.black;
    }
  }
}

/// String <-> Color helpers
extension HexColorExtension on String {
  /// Convert a hex color string to [Color].
  ///
  /// Accepted formats:
  ///  - "#RRGGBB"
  ///  - "RRGGBB"
  ///  - "#AARRGGBB"
  ///  - "AARRGGBB"
  ///
  /// Throws [FormatException] if the string is not a valid 6/8-digit hex.
  Color toColor() {
    var hex = replaceAll('#', '').trim().toUpperCase();
    if (hex.length == 6) hex = 'FF$hex'; // add alpha if missing
    if (hex.length != 8) {
      throw FormatException('Invalid hex color format', this);
    }
    return Color(int.parse(hex, radix: 16));
  }
}
