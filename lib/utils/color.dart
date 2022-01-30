import 'dart:ui';

extension ColorExtension on Color {
  /// Covert color to hexadecimal CSS like string
  String toHex() {
    return '#'
        '${alpha.toRadixString(16).padLeft(2, '0')}'
        '${red.toRadixString(16).padLeft(2, '0')}'
        '${green.toRadixString(16).padLeft(2, '0')}'
        '${blue.toRadixString(16).padLeft(2, '0')}';
  }
}
