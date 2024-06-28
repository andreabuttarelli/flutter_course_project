import 'package:flutter/material.dart';
import 'package:prova/src/presentation/design_system/palette/palette.dart';

class TypographyStyles {
  static const TextStyle h1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle h2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle h3 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle h4 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle p = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );
}

void main() {
  const Text('Hello', style: TypographyStyles.h1);
}
