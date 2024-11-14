import 'package:flutter/material.dart';
import 'package:music_app/src/core/extensions/widgets.ext.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Text('Splash').center(),
    );
  }
}
