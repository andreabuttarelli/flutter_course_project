import 'package:flutter/material.dart';

class LabelTypo extends StatelessWidget {
  const LabelTypo({
    super.key,
    required this.label,
    this.color,
    this.fontWeight,
    this.maxLines,
  });

  final String label;
  final Color? color;
  final FontWeight? fontWeight;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      maxLines: maxLines,
      style: Theme.of(context).textTheme.labelLarge!.copyWith(
            color: color,
            fontWeight: fontWeight,
          ),
    );
  }
}
