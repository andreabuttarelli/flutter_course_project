import 'package:clean_app/src/core/extensions/string_ext.dart';
import 'package:clean_app/src/presentation/design_system/palette/palette.dart';
import 'package:flutter/material.dart';

class AnimatedButtonWidget extends StatefulWidget {
  const AnimatedButtonWidget({
    super.key,
    this.enabled = true,
    required this.onTap,
  });

  final bool enabled;
  final Function() onTap;

  @override
  State<AnimatedButtonWidget> createState() => _AnimatedButtonWidgetState();
}

class _AnimatedButtonWidgetState extends State<AnimatedButtonWidget> {
  late bool enabled;
  bool tapped = false;
  bool hovered = false;

  @override
  void initState() {
    super.initState();
    enabled = widget.enabled;
  }

  @override
  void didUpdateWidget(covariant AnimatedButtonWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.enabled != oldWidget.enabled) {
      setState(() {
        enabled = widget.enabled;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const duration = Duration(milliseconds: 300);
    const curve = Curves.easeInOut;
    return IgnorePointer(
      ignoring: !enabled,
      child: GestureDetector(
        onTapDown: (e) {
          setState(() {
            tapped = true;
          });
        },
        onTapUp: (e) {
          setState(() {
            tapped = false;
          });
        },
        onTap: () {
          widget.onTap();
        },
        child: MouseRegion(
          onEnter: (e) {
            setState(() {
              hovered = true;
            });
          },
          onExit: (e) {
            setState(() {
              hovered = false;
              tapped = false;
            });
          },
          cursor: SystemMouseCursors.click,
          child: AnimatedScale(
            duration: duration,
            curve: curve,
            scale: tapped ? 0.5 : 1,
            child: AnimatedOpacity(
              duration: duration,
              curve: curve,
              opacity: enabled ? 1 : 0.5,
              child: AnimatedContainer(
                duration: duration,
                curve: curve,
                color: AppColors.primary.darkThemeValue.c.withOpacity(
                  hovered ? 0.2 : 1,
                ),
                width: double.infinity,
                height: 48,
                child: const Center(
                  child: Text('Animated Button'),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ExampleAnimatedButton extends StatelessWidget {
  const ExampleAnimatedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedButtonWidget(
          onTap: () {},
        ),
      ),
    );
  }
}
