import 'package:flutter/material.dart';
import 'package:music_app/src/core/extensions/widgets.ext.dart';

class NotFoundView extends StatelessWidget {
  const NotFoundView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Text('404').center(),
    );
  }
}
