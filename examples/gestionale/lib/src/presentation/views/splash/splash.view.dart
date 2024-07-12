import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gestionale/src/presentation/global_blocs/auth/auth.cubit.dart';
import 'package:gestionale/src/presentation/views/auth/auth.view.dart';
import 'package:gestionale/src/presentation/views/home/home.view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1000)).then(
      (_) => setState(
        () {
          isLoading = false;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: Text('Splash'),
        ),
      );
    }
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthLogged) {
          return const HomeView();
        }
        return const AuthView();
      },
    );
  }
}
