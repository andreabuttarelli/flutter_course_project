import 'package:flutter/material.dart';
import 'package:prova/src/presentation/design_system/custom_theme/custom_theme.dart';
import 'package:prova/src/presentation/design_system/palette/palette.dart';
import 'package:prova/src/presentation/design_system/typography/styles/styles.typography.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        colorScheme: ColorScheme.light(
          primary: AppPalette.light.accent.primary,
          secondary: AppPalette.light.accent.secondary,
        ),
        textTheme: TextTheme(
          displayLarge: TypographyStyles.h1.copyWith(
            color: AppPalette.light.text.primary,
          ),
          headlineLarge: TypographyStyles.h2.copyWith(
            color: AppPalette.light.text.primary,
          ),
          titleLarge: TypographyStyles.h3.copyWith(
            color: AppPalette.light.text.primary,
          ),
          bodyLarge: TypographyStyles.p.copyWith(
            color: AppPalette.light.text.primary,
          ),
          labelLarge: TypographyStyles.p.copyWith(
            color: AppPalette.light.text.primary,
          ),
        ),
        extensions: [
          const AppTheme(),
        ],
      ),
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.dark(
          primary: AppPalette.light.accent.primary,
          secondary: AppPalette.light.accent.secondary,
        ),
        textTheme: TextTheme(
          displayLarge: TypographyStyles.h1.copyWith(
            color: AppPalette.dark.text.primary,
          ),
          headlineLarge: TypographyStyles.h2.copyWith(
            color: AppPalette.dark.text.primary,
          ),
          titleLarge: TypographyStyles.h3.copyWith(
            color: AppPalette.dark.text.primary,
          ),
          bodyLarge: TypographyStyles.p.copyWith(
            color: AppPalette.dark.text.primary,
          ),
          labelLarge: TypographyStyles.p.copyWith(
            color: AppPalette.dark.text.primary,
          ),
        ),
        extensions: [
          const AppTheme(),
        ],
      ),
      themeMode: ThemeMode.system,
      home: const Scaffold(
        body: Center(
          child: RepaintBoundary(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
