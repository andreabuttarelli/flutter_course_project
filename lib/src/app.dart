import 'package:flutter/material.dart';
import 'package:prova/src/presentation/design_system/buttons/buttons.widget.dart';
import 'package:prova/src/presentation/design_system/custom_theme/custom_theme.dart';
import 'package:prova/src/presentation/design_system/palette/palette.dart';
import 'package:prova/src/presentation/design_system/typography/styles/styles.typography.dart';
import 'package:prova/src/presentation/inherited_widgets/theme.inherited.dart';
import 'package:prova/src/presentation/views/bottombar_page_with_sub_navigators/bottombar_page_with_sub_navigators.view.dart';
import 'package:prova/src/presentation/views/splash/splash.view.dart';

const _kDefaultTheme = ThemeMode.light;

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  bool isLoading = true;
  Exception? error;
  final ValueNotifier<ThemeMode> themeModeNotifier =
      ValueNotifier(_kDefaultTheme);

  @override
  void initState() {
    super.initState();
    themeModeNotifier.addListener(() {
      if (themeModeNotifier.value == ThemeMode.dark) {
        /// absurd. Just a stupid example
        setState(() {
          error = Exception('Dark mode is not supported yet');
        });
      }
    });
    initDependencies();
  }

  @override
  void dispose() {
    themeModeNotifier.dispose();
    super.dispose();
  }

  Future<void> initDependencies() async {
    try {
      setState(() {
        isLoading = true;
      });
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        if (e is Exception) {
          error = e;
        }
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) return const SplashView();
    if (error != null) {
      return Material(
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child: Column(
              children: [
                Text(
                  error.toString(),
                ),
                PrimaryButton(
                  label: 'Try again',
                  onTap: initDependencies,
                ),
              ],
            ),
          ),
        ),
      );
    }
    return InheritedAppTheme(
      themeMode: themeModeNotifier,
      child: Builder(
        builder: (context) {
          final themeModeNotifier = InheritedAppTheme.of(context).themeMode;
          return ValueListenableBuilder(
            valueListenable: themeModeNotifier,
            builder: (context, mode, _) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
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
                themeMode: mode,
                home: const BottombarPageWithSubNavigatorsView(),
              );
            },
          );
        },
      ),
    );
  }
}
