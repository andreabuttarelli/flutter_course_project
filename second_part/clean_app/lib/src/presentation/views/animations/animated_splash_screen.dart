import 'package:flutter/material.dart';

class AnimatedSplashScreen extends StatefulWidget {
  const AnimatedSplashScreen({super.key});

  @override
  State<AnimatedSplashScreen> createState() => _State();
}

class _State extends State<AnimatedSplashScreen> with TickerProviderStateMixin {
  late final AnimationController controller;
  late Animation<double> scaleAnimation;
  late Animation<Color?> colorAnimation;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    controller.repeat(reverse: true);
    scaleAnimation = Tween<double>(begin: 10, end: 300).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOutCubicEmphasized,
      ),
    );
    colorAnimation = ColorTween(begin: Colors.blue, end: Colors.red).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOutSine,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: controller,
          child: const SizedBox(
            width: 200,
            height: 200,
          ),
          builder: (context, child) {
            return Container(
              width: scaleAnimation.value,
              height: 200,
              color: colorAnimation.value,
            );
          },
        ),
      ),
    );
  }
}
