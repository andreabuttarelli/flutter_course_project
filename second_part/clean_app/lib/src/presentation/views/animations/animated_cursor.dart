import 'package:flutter/material.dart';

class AnimatedCursor extends StatefulWidget {
  const AnimatedCursor({super.key});

  @override
  State<AnimatedCursor> createState() => _AnimatedCursorState();
}

class _AnimatedCursorState extends State<AnimatedCursor> {
  Offset? position;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MouseRegion(
          onExit: (e) {
            setState(() {
              position = null;
            });
          },
          onHover: (e) {
            setState(() {
              position = e.localPosition;
            });
          },
          child: Stack(
            children: [
              Container(
                width: 200,
                height: 200,
                color: Colors.blue,
              ),
              if (position != null)
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  left: position!.dx - 12,
                  top: position!.dy - 12,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
