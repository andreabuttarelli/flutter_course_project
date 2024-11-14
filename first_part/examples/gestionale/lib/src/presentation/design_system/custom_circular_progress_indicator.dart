import 'package:flutter/material.dart';

class CCircularProgressIndicator extends StatelessWidget {
  const CCircularProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const RepaintBoundary(
      child: CircularProgressIndicator(),
    );
  }
}
