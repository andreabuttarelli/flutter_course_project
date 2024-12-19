import 'package:flutter/material.dart';

class NativeView extends StatelessWidget {
  const NativeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Spacer(),
          Expanded(
            child: UiKitView(
              viewType: '<platform-view-type>',
            ),
          ),
        ],
      ),
    );
  }
}
