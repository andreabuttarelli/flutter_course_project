import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gestionale/src/presentation/global_blocs/auth/auth.cubit.dart';
import 'package:gestionale/src/presentation/global_blocs/init/init.cubit.dart';
import 'package:gestionale/src/presentation/global_blocs/translations/translations.cubit.dart';
import 'package:gestionale/src/presentation/views/splash/splash.view.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => InitCubit()..initDependencies(),
        ),
        BlocProvider(
          create: (context) => TranslationsCubit(),
        ),
        BlocProvider(
          create: (context) => AuthCubit()..refreshToken(),
        ),
      ],
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
        }
        if (state is InitError) {
          /// error widget
        }
        return const MaterialApp(
          home: SplashView(),
        );
      },
    );
  }
}
