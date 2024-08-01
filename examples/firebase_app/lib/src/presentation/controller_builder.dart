import 'package:flutter/material.dart';

class ControllerBuilder<T extends TextEditingController>
    extends StatefulWidget {
  const ControllerBuilder({
    super.key,
    required this.create,
    required this.builder,
  });

  final T Function() create;
  final Widget Function(BuildContext, T) builder;

  @override
  State<ControllerBuilder> createState() => _ControllerBuilderState();
}

class _ControllerBuilderState<T extends TextEditingController>
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
