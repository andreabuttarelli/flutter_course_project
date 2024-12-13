import 'dart:async';

import 'package:flutter/material.dart';

class AnimatedGridWidget extends StatefulWidget {
  const AnimatedGridWidget({super.key});

  @override
  State<AnimatedGridWidget> createState() => _AnimatedGridWidgetState();
}

class _AnimatedGridWidgetState extends State<AnimatedGridWidget> {
  final gridKey = GlobalKey<AnimatedGridState>();
  List<int> items = [];
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
      const Duration(seconds: 2),
      (e) {
        items.add(items.length + 1);
        gridKey.currentState!.insertItem(items.length - 1);
      },
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedGrid(
        key: gridKey,
        itemBuilder: (context, index, animation) {
          return ScaleTransition(
            scale: Tween(
              begin: 0.7,
              end: 1.0,
            ).animate(animation),
            child: Container(
              color: Colors.blue,
              child: Center(
                child: Text('$index'),
              ),
            ),
          );
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
      ),
    );
  }
}
