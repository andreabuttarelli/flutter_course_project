import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/src/presentation/views/splash/splash.view.dart';
import 'package:music_app/src/router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _AppCubit(),
      child: MaterialApp.router(
        routerConfig: router,
        builder: (context, child) =>
            BlocBuilder<_AppCubit, _AppState>(builder: (context, state) {
          if (state is _AppLoading) {
            return const SplashView();
          }
          if (state is _AppError) {
            return const Scaffold();
          }
          return child!;
        }),
      ),
    );
  }
}

class _AppCubit extends Cubit<_AppState> {
  _AppCubit() : super(const _AppLoading()) {
    load();
  }

  Future<void> load() async {
    emit(const _AppLoading());
    try {
      await Future.delayed(const Duration(seconds: 2));
      emit(const _AppLoaded());
    } catch (e) {
      emit(_AppError(Exception(e.toString())));
    }
  }
}

abstract class _AppState {
  const _AppState();
}

class _AppLoading extends _AppState {
  const _AppLoading();
}

class _AppLoaded extends _AppState {
  const _AppLoaded();
}

class _AppError extends _AppState {
  final Exception error;

  const _AppError(this.error);
}
