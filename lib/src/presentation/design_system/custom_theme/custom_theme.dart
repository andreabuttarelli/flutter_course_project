import 'package:flutter/material.dart';

class AppTheme extends ThemeExtension<AppTheme> {
  const AppTheme({
    this.magenta = Colors.purple,
    this.cyan = Colors.cyan,
    this.yellow = Colors.yellow,
    this.black = Colors.black,
  });

  final Color magenta;
  final Color cyan;
  final Color yellow;
  final Color black;

  LinearGradient get gradient => LinearGradient(
        colors: [magenta, cyan, yellow],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

  @override
  ThemeExtension<AppTheme> copyWith({
    Color? magenta,
    Color? cyan,
    Color? yellow,
    Color? black,
  }) {
    return AppTheme(
      magenta: magenta ?? this.magenta,
      cyan: cyan ?? this.cyan,
      yellow: yellow ?? this.yellow,
      black: black ?? this.black,
    );
  }

  @override
  ThemeExtension<AppTheme> lerp(
      covariant ThemeExtension<AppTheme>? other, double t) {
    if (other is! AppTheme) {
      return this;
    }
    return AppTheme(
      magenta: Color.lerp(magenta, other.magenta, t)!,
      cyan: Color.lerp(cyan, other.cyan, t)!,
      yellow: Color.lerp(yellow, other.yellow, t)!,
      black: Color.lerp(black, other.black, t)!,
    );
  }
}
