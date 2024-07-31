import 'dart:ui';

import 'package:flutter/widgets.dart';

extension WidgetUtils on Widget {
  Center center() => Center(child: this);
  Expanded expanded({int flex = 1}) => Expanded(flex: flex, child: this);
  Align align(Alignment alignment) => Align(alignment: alignment, child: this);
  Padding padding(EdgeInsetsGeometry padding) =>
      Padding(padding: padding, child: this);
  Padding paddingAll(double padding) =>
      Padding(padding: EdgeInsets.all(padding), child: this);
  Padding paddingSymmetric({double vertical = 0, double horizontal = 0}) =>
      Padding(
        padding:
            EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
        child: this,
      );
  Padding paddingOnly(
          {double left = 0,
          double top = 0,
          double right = 0,
          double bottom = 0}) =>
      Padding(
        padding: EdgeInsets.only(
          left: left,
          top: top,
          right: right,
          bottom: bottom,
        ),
        child: this,
      );
  SafeArea safeArea() => SafeArea(child: this);
  ColoredBox colored(Color color) => ColoredBox(color: color, child: this);
  BackdropFilter blur(double sigma) => BackdropFilter(
      filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma), child: this);
  ClipRRect clipRRect({BorderRadius borderRadius = BorderRadius.zero}) =>
      ClipRRect(borderRadius: borderRadius, child: this);
  DecoratedBox decorated({Decoration decoration = const BoxDecoration()}) =>
      DecoratedBox(decoration: decoration, child: this);
  GestureDetector onTap(Function() callback) =>
      GestureDetector(onTap: callback, child: this);
}
