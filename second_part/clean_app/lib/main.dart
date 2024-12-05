import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:clean_app/src/core/extensions/string_ext.dart';
import 'package:clean_app/src/presentation/design_system/palette/palette.dart';
import 'package:clean_app/src/router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      initial: AdaptiveThemeMode.system,
      light: ThemeData(
        primaryColor: AppColors.primary.lightThemeValue.c,
        scaffoldBackgroundColor: AppColors.backgroundPrimary.lightThemeValue.c,
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: AppColors.primary.lightThemeValue.c,
          onPrimary: AppColors.onPrimary.lightThemeValue.c,
          secondary: AppColors.secondary.lightThemeValue.c,
          onSecondary: AppColors.onSecondary.lightThemeValue.c,
          error: AppColors.error.lightThemeValue.c,
          onError: AppColors.onPrimary.lightThemeValue.c,
          surface: AppColors.backgroundPrimary.lightThemeValue.c,
          onSurface: AppColors.onBackgroundPrimary.lightThemeValue.c,
          surfaceContainer:
              AppColors.inputBackgroundOnPrimary.lightThemeValue.c,
        ),
        useMaterial3: true,
      ),
      dark: ThemeData(
        colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primary: AppColors.primary.darkThemeValue.c,
          onPrimary: AppColors.onPrimary.darkThemeValue.c,
          secondary: AppColors.secondary.darkThemeValue.c,
          onSecondary: AppColors.onSecondary.darkThemeValue.c,
          error: AppColors.error.darkThemeValue.c,
          onError: AppColors.onPrimary.darkThemeValue.c,
          surface: AppColors.backgroundPrimary.darkThemeValue.c,
          onSurface: AppColors.onBackgroundPrimary.darkThemeValue.c,
          surfaceContainer: AppColors.inputBackgroundOnPrimary.darkThemeValue.c,
        ),
        useMaterial3: true,
      ),
      builder: (context, theme) {
        return MaterialApp.router(
          routerConfig: router,
          title: 'Flutter Demo',
          theme: theme,
        );
      },
    );
  }
}
