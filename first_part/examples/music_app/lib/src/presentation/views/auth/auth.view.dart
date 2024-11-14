import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:music_app/src/core/extensions/lists.ext.dart';
import 'package:music_app/src/core/extensions/widgets.ext.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        const Text(
          'Title',
          style: TextStyle(
            color: Colors.white,
          ),
        ).center().colored(Colors.green).expanded(flex: 2),
        FilledButton(
          onPressed: () {
            context.go('/home');
          },
          child: const Text('Sign in'),
        ).center().expanded(),
      ].column(),
    );
  }
}
