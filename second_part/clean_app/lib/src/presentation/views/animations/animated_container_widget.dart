import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimatedContainerWidget extends StatefulWidget {
  const AnimatedContainerWidget({super.key});

  @override
  State<AnimatedContainerWidget> createState() =>
      _AnimatedContainerWidgetState();
}

class _AnimatedContainerWidgetState extends State<AnimatedContainerWidget> {
  bool active = false;

  @override
  Widget build(BuildContext context) {
    final size = active ? 200.0 : 100.0;
    final color = active ? Colors.blue : Colors.red;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: AnimatedContainer(
                duration: const Duration(
                  milliseconds: 300,
                ),
                curve: Curves.easeInOutExpo,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8),
                ),
                width: size,
                height: size,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                active = !active;
              });
            },
            icon: const Icon(
              CupertinoIcons.refresh,
            ),
          ),
        ],
      ),
    );
  }
}
