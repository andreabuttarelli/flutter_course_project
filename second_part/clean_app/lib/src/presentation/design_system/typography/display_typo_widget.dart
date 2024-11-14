import 'package:flutter/material.dart';

class DisplayTypo extends StatelessWidget {
  const DisplayTypo({
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
      style: Theme.of(context).textTheme.displayLarge!.copyWith(
            color: color,
            fontWeight: fontWeight,
          ),
    );
  }
}
