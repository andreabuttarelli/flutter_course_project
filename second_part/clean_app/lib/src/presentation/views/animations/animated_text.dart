import 'package:flutter/material.dart';

class AnimatedText extends StatefulWidget {
  const AnimatedText({super.key});

  @override
  State<AnimatedText> createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText> {
  bool enabled = true;

  @override
  Widget build(BuildContext context) {
    final size = enabled ? 48.0 : 24.0;
    final fontWeight = enabled ? FontWeight.bold : FontWeight.normal;
    return Scaffold(
      body: Center(
        child: AnimatedDefaultTextStyle(
          style: TextStyle(
            fontSize: size,
            fontWeight: fontWeight,
            color: Colors.black,
          ),
          duration: const Duration(seconds: 1),
          child: const Text('Hello World'),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        setState(() {
          enabled = !enabled;
        });
      }),
    );
  }
}
