// Flutter imports:
import 'package:flutter/material.dart';

class ControllerBuilder<T extends ValueNotifier<dynamic>>
    extends StatefulWidget {
  const ControllerBuilder({
    required this.create,
    required this.builder,
    super.key,
  });

  final T Function() create;
  final Widget Function(BuildContext, T) builder;

  @override
  State<ControllerBuilder<T>> createState() => _ControllerDisposerState<T>();
}

class _ControllerDisposerState<T extends ValueNotifier<dynamic>>
    extends State<ControllerBuilder<T>> {
  late final T controller;

  @override
  void initState() {
    super.initState();
    controller = widget.create();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, controller);
  }
}
