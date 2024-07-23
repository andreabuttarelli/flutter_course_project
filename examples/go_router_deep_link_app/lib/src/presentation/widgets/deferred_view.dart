import 'package:flutter/material.dart';

class DeferredView extends StatefulWidget {
  const DeferredView({
    super.key,
    required this.future,
    required this.builder,
  });

  final Future Function() future;
  final Widget Function() builder;

  @override
  State<DeferredView> createState() => _DeferredViewState();
}

class _DeferredViewState extends State<DeferredView> {
  late final Future _future;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _future = widget.future.call();
    _future.then((_) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const CircularProgressIndicator();
    }
    return widget.builder.call();
  }
}
