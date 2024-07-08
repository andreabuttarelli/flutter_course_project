import 'package:flutter/material.dart';

class AppPalette {
  static final light = _Light();
  static final dark = _Dark();
}

class _Light {
  final background = _AppPaletteBackgroundLight();
  final accent = _AppPaletteAccentLight();
  final text = _AppPaletteTextLight();
}

class _Dark {
  final background = _AppPaletteBackgroundDark();
  final accent = _AppPaletteAccentDark();
  final text = _AppPaletteTextDark();
}

class _AppPaletteBackgroundLight {
  _AppPaletteBackgroundLight();

  final Color primary = const Color(0xFFffffff);
  final Color secondary = const Color(0xFFffffff);
}

class _AppPaletteBackgroundDark {
  _AppPaletteBackgroundDark();

  final Color primary = const Color(0x0ff00000);
  final Color secondary = const Color(0x0ff00000);
}

class _AppPaletteAccentLight {
  _AppPaletteAccentLight();

  final Color primary = Colors.orange;
  final Color secondary = Colors.blue;
}

class _AppPaletteAccentDark {
  _AppPaletteAccentDark();

  final Color primary = const Color.fromARGB(255, 213, 129, 2);
  final Color secondary = const Color.fromARGB(255, 3, 113, 202);
}

class _AppPaletteTextLight {
  _AppPaletteTextLight();

  final Color primary = const Color(0xFF000000);
  final Color secondary = const Color(0xFF000000);
}

class _AppPaletteTextDark {
  _AppPaletteTextDark();

  final Color primary = const Color(0xFFffffff);
  final Color secondary = const Color(0xFFffffff);
}

void main() {
  AppPalette.light.text.primary;
}
