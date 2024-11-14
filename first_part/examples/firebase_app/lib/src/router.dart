import 'package:firebase_app/src/core/firebase/analytics.dart';
import 'package:firebase_app/src/presentation/auth/login/login.view.dart';
import 'package:firebase_app/src/presentation/global_blocs/auth.cubit.dart';
import 'package:firebase_app/src/presentation/home/home.view.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

AuthState _authState(BuildContext context) => context.read<AuthCubit>().state;
bool isLogged(BuildContext context) => _authState(context) is LoggedIn;

final router = GoRouter(
  observers: [
    analyticsObserver,
  ],
  routes: [
    GoRoute(
      path: '/',
      redirect: (context, _) => redirectFromSplash(context),
      builder: (context, state) => Container(),
    ),
    GoRoute(
      path: '/login',
      redirect: (context, _) => redirectIfSignedIn(context),
      builder: (context, state) => const LoginView(),
    ),
    GoRoute(
      path: '/home',
      redirect: (context, _) => redirectIfSignOut(context),
      builder: (context, state) => const HomeView(),
    ),
  ],
);

String? redirectIfSignedIn(BuildContext context) {
  if (isLogged(context)) {
    return '/home';
  }
  return null;
}

String? redirectIfSignOut(BuildContext context) {
  if (!isLogged(context)) {
    return '/login';
  }
  return null;
}

String redirectFromSplash(BuildContext context) {
  if (isLogged(context)) {
    return '/home';
  } else {
    return '/login';
  }
}
