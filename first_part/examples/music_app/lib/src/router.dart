import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:music_app/src/presentation/global_blocs/audio.cubit.dart';
import 'package:music_app/src/presentation/views/404/404.view.dart';
import 'package:music_app/src/presentation/views/auth/auth.view.dart';
import 'package:music_app/src/presentation/views/home/home.view.dart';
import 'package:music_app/src/presentation/views/player/player.view.dart';
import 'package:music_app/src/presentation/views/splash/splash.view.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (_, __) => const SplashView(),
      redirect: (_, __) => redirectFromSplash(),
    ),
    GoRoute(
      path: '/auth',
      builder: (_, __) => const AuthView(),
      redirect: (_, __) => redirectIfSignedIn(),
    ),
    GoRoute(
      path: '/home',
      builder: (_, __) => const HomeView(),
      redirect: (_, __) => redirectIfSignedOut(),
    ),
    GoRoute(
      path: '/player',
      builder: (_, state) => BlocProvider.value(
        value: state.extra as AudioCubit,
        child: const PlayerView(),
      ),
      redirect: (_, __) => redirectIfSignedOut(),
    ),
  ],
  errorBuilder: (_, __) => const NotFoundView(),
);

String? redirectFromSplash() {
  return '/auth';
}

String? redirectIfSignedOut() {
  return null;
}

String? redirectIfSignedIn() {
  return null;
}
