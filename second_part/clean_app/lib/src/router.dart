import 'package:clean_app/src/presentation/views/form_hr/form_her_view_with_indexstack_with_valuenotifier.dart';
import 'package:clean_app/src/presentation/views/form_hr/form_her_view_with_pageview.dart';
import 'package:clean_app/src/presentation/views/form_hr/shell/anagrafica_view.dart';
import 'package:clean_app/src/presentation/views/form_hr/shell/curriculum_view.dart';
import 'package:clean_app/src/presentation/views/form_hr/shell/form_hr_shell_view.dart';
import 'package:clean_app/src/presentation/views/form_hr/shell/residenza_view.dart';
import 'package:clean_app/src/presentation/views/form_hr/wrong_form_her_view_with_indexstack_validate_granularity.dart';
import 'package:clean_app/src/presentation/views/lottie/lottie_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const SizedBox(),
    redirect: (_, __) => '/lottie',
  ),
  GoRoute(
    path: '/form_hr_indexed',
    builder: (context, state) =>
        const FormHRViewWithIndexedStackValidateGranularity(),
  ),
  GoRoute(
    path: '/form_hr_pageview',
    builder: (context, state) => const FormHRView(),
  ),
  GoRoute(
    path: '/lottie',
    builder: (context, state) => const LottieAnimationView(),
  ),
  ShellRoute(
    routes: [
      GoRoute(
        path: '/form_hr/residenza',
        builder: (context, state) => const Form(
          child: ResidenzaView(),
        ),
      ),
      GoRoute(
        path: '/form_hr/anagrafica',
        builder: (context, state) => const Form(
          child: AnagraficaView(),
        ),
      ),
      GoRoute(
        path: '/form_hr/curriculum',
        builder: (context, state) => const Form(
          child: CurriculumView(),
        ),
      ),
    ],
    builder: (context, state, child) {
      const prefix = '/form_hr/';
      final location = state.uri.toString().replaceFirst(prefix, '');
      return FormHrShellView(
        key: ValueKey(state.uri.toString()),
        tab: FormHRTabs.fromName(location),
        child: child,
      );
    },
  ),
]);
