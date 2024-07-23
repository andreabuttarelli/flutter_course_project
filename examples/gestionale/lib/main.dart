import 'package:flutter/material.dart';
import 'package:gestionale/src/app.dart';
import 'package:gestionale/src/di/di.dart';

void main() {
  initCubitUseCaseDependency();
  runApp(const App());
}
