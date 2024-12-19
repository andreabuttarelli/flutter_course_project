import 'package:flutter/material.dart';

class ProgressIndicatorAnimationWidget extends StatefulWidget {
  const ProgressIndicatorAnimationWidget({super.key});

  @override
  State<ProgressIndicatorAnimationWidget> createState() =>
      _ProgressIndicatorAnimationWidgetState();
}

class _ProgressIndicatorAnimationWidgetState
    extends State<ProgressIndicatorAnimationWidget>
    with TickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    controller.repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(controller.value);
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: controller,
          child: const SizedBox(
            width: 200,
            height: 200,
          ),
          builder: (context, child) {
            return LinearProgressIndicator(
              value: controller.value,
            );
          },
        ),
      ),
    );
  }
}
