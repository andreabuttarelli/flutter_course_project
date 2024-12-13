import 'package:flutter/material.dart';

class AnimatedCrossFadeWidget extends StatefulWidget {
  const AnimatedCrossFadeWidget({super.key});

  @override
  State<AnimatedCrossFadeWidget> createState() =>
      _AnimatedCrossFadeWidgetState();
}

class _AnimatedCrossFadeWidgetState extends State<AnimatedCrossFadeWidget> {
  bool enabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedCrossFade(
          firstChild: Container(
            width: 200,
            height: 200,
            color: Colors.blue,
          ),
          secondChild: Container(
            width: 100,
            height: 100,
            color: Colors.red,
          ),
          crossFadeState:
              enabled ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          duration: const Duration(seconds: 1),
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
