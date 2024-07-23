import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_app/src/presentation/404/page_404.view.dart';
import 'package:go_router_app/src/presentation/home/home_with_child.view.dart';
import 'package:go_router_app/src/presentation/home/sub_routes/routed1.view.dart';
import 'package:go_router_app/src/presentation/home/sub_routes/routed2.view.dart';
import 'package:go_router_app/src/presentation/page2/page2.view.dart'
    deferred as page2;
import 'package:go_router_app/src/presentation/post/post.view.dart'
    deferred as post;
import 'package:go_router_app/src/presentation/widgets/deferred_view.dart';

enum AppRoutes {
  home('/'),
  page2('/page2'),
  post('/post/:id');

  static String postPath(String id) => post.path.replaceAll(':id', id);

  final String path;
  const AppRoutes(this.path);
}

final router = GoRouter(
  routes: [
    ShellRoute(
      builder: (context, state, child) => HomeWithChildView(child: child),
      routes: [
        GoRoute(
          path: '/a',
          builder: (context, _) => const Routed1(),
        ),
        GoRoute(
          path: '/b',
          builder: (context, _) => const Routed2(),
        ),
      ],
      redirect: redirectIfSignedIn,
    ),
    GoRoute(
      path: AppRoutes.page2.path,
      builder: (context, _) => DeferredView(
        future: () async => page2.loadLibrary(),
        builder: () => page2.Page2View(),
      ),
      redirect: redirectIfSignedOut,
    ),
    GoRoute(
      path: AppRoutes.post.path,
      builder: (context, state) => DeferredView(
        future: () async => post.loadLibrary(),
        builder: () => post.PostView(
          id: state.pathParameters['id']!,
        ),
      ),
    ),
  ],
  errorBuilder: (context, state) => const Page404View(),
);

String? redirectIfSignedIn(BuildContext context, GoRouterState state) {
  return null;
}

String? redirectIfSignedOut(BuildContext context, GoRouterState state) {
  return null;
}
