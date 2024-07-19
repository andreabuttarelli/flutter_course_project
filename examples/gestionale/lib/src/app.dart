import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gestionale/src/core/translations/index.dart';
import 'package:gestionale/src/di/di.dart';
import 'package:gestionale/src/domain/usecases/init_dependencies.usecase.dart';
import 'package:gestionale/src/presentation/global_blocs/auth/auth.cubit.dart';
import 'package:gestionale/src/presentation/global_blocs/init/init.cubit.dart';
import 'package:gestionale/src/presentation/views/splash/splash.view.dart';
import 'package:localization/localization.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InitCubit(
        InitDependenciesUseCase(
          initCubitUseCaseDependency(),
        ),
      )..initDependencies(),
      child: const _App(),
    );
  }
}

class _App extends StatelessWidget {
  const _App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InitCubit, InitState>(
      builder: (context, state) {
        if (state is InitiLoading) {
          /// loading widget
          return const Material(
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state is InitError) {
          /// error widget
          return Material(
            color: Colors.white,
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Error'),
                    FilledButton(
                      onPressed: () {
                        context.read<InitCubit>().initDependencies();
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AuthCubit()..refreshToken(),
            ),
          ],
          child: CustomLocalization(
            translations: translations,
            fallbackLocale: fallbackLocale,
            builder: (context, currentLocale) {
              return MaterialApp(
                localizationsDelegates: const [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: [
                  ...translations.keys.map((e) => Locale(e)),
                ],
                locale: currentLocale,
                home: const SplashView(),
              );
            },
          ),
        );
      },
    );
  }
}
