import 'package:flutter/material.dart';

class Page404View extends StatelessWidget {
  const Page404View({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          '404',
          style: TextStyle(
            fontSize: 80,
          ),
        ),
      ),
    );
  }
}
