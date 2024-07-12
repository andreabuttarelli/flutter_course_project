import 'package:flutter/material.dart';
import 'package:gestionale/src/core/extensions/translate_extension.dart';

class H1 extends StatelessWidget {
  const H1(this.label, {super.key, this.translationEnabled = true});

  final String label;
  final bool translationEnabled;

  @override
  Widget build(BuildContext context) {
    return Text(translationEnabled ? context.tr(label) : label);
  }
}
