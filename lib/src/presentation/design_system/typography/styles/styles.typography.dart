import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TypographyStyles {
  static const TextStyle h1 = TextStyle(
    fontFamily: 'BasierCircle',
    fontSize: 32,
    fontWeight: FontWeight.bold,
  );
  static final TextStyle h2 = GoogleFonts.koulen(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  static final TextStyle h3 = GoogleFonts.koulen(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  static final TextStyle h4 = GoogleFonts.koulen(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  static final TextStyle p = GoogleFonts.koulen(
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );
}

void main() {
  const Text('Hello', style: TypographyStyles.h1);
}
