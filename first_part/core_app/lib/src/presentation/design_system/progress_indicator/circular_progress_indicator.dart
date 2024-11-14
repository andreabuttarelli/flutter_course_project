import 'package:flutter/material.dart';

class CCircularProgressIndicator extends StatelessWidget {
  const CCircularProgressIndicator({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CircularProgressIndicator(
        color: color,
      ),
    );
  }
}
