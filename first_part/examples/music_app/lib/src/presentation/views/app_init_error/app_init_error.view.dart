import 'package:flutter/material.dart';
import 'package:music_app/src/core/extensions/lists.ext.dart';
import 'package:music_app/src/core/extensions/widgets.ext.dart';

class AppInitErrorView extends StatelessWidget {
  const AppInitErrorView({
    super.key,
    required this.error,
    required this.onRetry,
  });

  final String error;
  final Function() onRetry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        Text(error),
        FilledButton(
          onPressed: onRetry,
          child: const Text('Retry'),
        ),
      ].column().center(),
    );
  }
}
