import 'package:flutter/material.dart';
import 'package:google_maps/src/presentation/map/map.view.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MapView(),
    );
  }
}
