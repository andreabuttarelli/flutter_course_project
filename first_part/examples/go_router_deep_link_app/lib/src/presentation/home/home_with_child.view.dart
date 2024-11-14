import 'package:flutter/material.dart';

class HomeWithChildView extends StatelessWidget {
  const HomeWithChildView({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
    );
  }
}
