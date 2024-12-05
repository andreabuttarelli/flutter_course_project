import 'package:flutter/material.dart';

extension StringExt on String {
  Color get c => Color(int.parse('0xFF${replaceAll('#', '')}'));
}
