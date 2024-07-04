import 'package:flutter/material.dart';

class InheritedAppTheme extends InheritedWidget {
  const InheritedAppTheme({
    super.key,
    required super.child,
    required this.themeMode,
  });

  final ValueNotifier<ThemeMode> themeMode;

  static InheritedAppTheme? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedAppTheme>();
  }

  static InheritedAppTheme of(BuildContext context) {
    final result = maybeOf(context);
    assert(result != null, 'No InheritedAppTheme found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(InheritedAppTheme oldWidget) {
    return themeMode != oldWidget.themeMode;
  }
}
