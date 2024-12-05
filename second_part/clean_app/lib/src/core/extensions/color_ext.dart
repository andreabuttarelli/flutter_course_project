import 'package:flutter/material.dart';

extension ColorExt on Color {
  String get hex => '#${value.toRadixString(16).substring(2)}';
}
