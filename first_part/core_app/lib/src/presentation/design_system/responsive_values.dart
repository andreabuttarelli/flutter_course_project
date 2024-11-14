import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const _kPhoneSize = 600;
const _kTabletSize = 1200;

T responsiveValue<T>(
  BuildContext context, {
  required T mobile,
  T? tablet,
  T? desktop,
}) {
  final screenSize = MediaQuery.sizeOf(context);
  if (screenSize.shortestSide < _kPhoneSize) {
    return mobile;
  }
  if (screenSize.shortestSide < _kTabletSize) {
    return tablet ?? mobile;
  }
  return desktop ?? mobile;
}

dynamic platformValue(
  BuildContext context, {
  required dynamic web,
  required dynamic ios,
  required dynamic android,
  required dynamic windows,
  required dynamic macos,
}) {
  if (kIsWeb) {
    return web;
  }
  if (Platform.isIOS) {
    return ios;
  }
  if (Platform.isAndroid) {
    return android;
  }
  if (Platform.isWindows) {
    return windows;
  }
  if (Platform.isMacOS) {
    return macos;
  }
}

dynamic orientationValue(
  BuildContext context, {
  required dynamic portrait,
  required dynamic landscape,
}) {
  final orientation = MediaQuery.of(context).orientation;
  if (orientation == Orientation.portrait) {
    return portrait;
  }
  return landscape;
}

void main() {
  Builder(
    builder: (context) {
      return SizedBox(
        width: responsiveValue(
          context,
          mobile: 16,
          tablet: 18,
          desktop: 20,
        ),
      );
    },
  );
}
