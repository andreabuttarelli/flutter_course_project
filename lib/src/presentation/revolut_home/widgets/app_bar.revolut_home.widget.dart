import 'dart:ui';

import 'package:flutter/material.dart';

const _kMaxBlur = 48;

class CAppBar extends StatefulWidget {
  const CAppBar({super.key, required this.controller});

  final ScrollController controller;

  @override
  State<CAppBar> createState() => _CAppBarState();
}

class _CAppBarState extends State<CAppBar> {
  double appBarBlur = 0;
  double appbarOpacity = 0;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      if (appBarBlur >= _kMaxBlur) return;
      setState(() {
        appBarBlur =
            (widget.controller.offset / 20).clamp(0, _kMaxBlur).toDouble();
        appbarOpacity = (appBarBlur / _kMaxBlur) / 2;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: appBarBlur, sigmaY: appBarBlur),
        child: Container(
          height: 180,
          width: double.infinity,
          color: Colors.black.withOpacity(appbarOpacity),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.center,
          child: const Text('App Bar'),
        ),
      ),
    );
  }
}
