import 'package:flutter/material.dart';
import 'package:prova/src/presentation/design_system/app_assets/app_assets.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        AppAssets.colosseo,
      ),
    );
  }
}
