import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:prova/src/presentation/design_system/buttons/buttons.widget.dart';
import 'package:prova/src/presentation/design_system/grid/grid.dart';
import 'package:prova/src/presentation/design_system/typography/widgets/typography.widget.dart';
import 'package:prova/src/presentation/views/cubit_auth/blocs/auth.cubit.dart';
import 'package:prova/src/presentation/views/cubit_auth/blocs/login.cubit.dart';
import 'package:prova/src/presentation/views/cubit_auth/cubit_profile.view.dart';

class CubitAuthView extends StatelessWidget {
  const CubitAuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const H2('Login'),
        ),
        body: const _Listeners(),
      ),
    );
  }
}

class _Listeners extends StatelessWidget {
  const _Listeners({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthCubit, AuthState>(
          listenWhen: (previous, current) =>
              previous != current && current is AuthLogged,
          listener: (context, state) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => const CubitProfileView(),
              ),
            );
          },
        ),
        BlocListener<LoginCubit, LoginState>(
          listenWhen: (previous, current) =>
              previous != current && current is LoginSuccess,
          listener: (context, state) {
            context.read<AuthCubit>().login((state as LoginSuccess).user.email);
          },
        ),
        BlocListener<LoginCubit, LoginState>(
          listenWhen: (previous, current) =>
              previous != current && current is LoginFailure,
          listener: (context, state) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text((state as LoginFailure).error),
              ),
            );
          },
        ),
      ],
      child: _UI(
        onEmailChanged: (email) =>
            context.read<LoginCubit>().updateEmail(email),
        onPasswordChanged: (password) =>
            context.read<LoginCubit>().updatePassword(password),
        onSignIn: () async {
          final completer = Completer<void>();
          context.read<LoginCubit>().login(onDone: () {
            completer.complete();
          });
          await completer.future;
        },
      ),
    );
  }
}

class _UI extends StatefulWidget {
  const _UI({
    super.key,
    required this.onEmailChanged,
    required this.onPasswordChanged,
    required this.onSignIn,
  });

  final Function(String) onEmailChanged;
  final Function(String) onPasswordChanged;
  final Future<void> Function() onSignIn;

  @override
  State<_UI> createState() => _BodyState();
}

class _BodyState extends State<_UI> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final FocusNode emailFocusNode;
  late final FocusNode passwordFocusNode;

  @override
  void initState() {
    super.initState();

    emailController = TextEditingController();
    emailController.addListener(() {
      widget.onEmailChanged(emailController.text);
    });

    passwordController = TextEditingController();
    passwordController.addListener(() {
      widget.onPasswordChanged(passwordController.text);
    });

    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  void _continueToPassword(String text) {
    final state = context.read<LoginCubit>().state;
    if (state is! LoginInitial) return;
    if (state.isEmailValid) return;
    passwordFocusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        passwordFocusNode.unfocus();
        emailFocusNode.unfocus();
      },
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: SizedBox(
            width: 600,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(),
                CupertinoTextField(
                  controller: emailController,
                  placeholder: 'Email',
                  onSubmitted: _continueToPassword,
                ),
                const Gap(Grid.medium),
                CupertinoTextField(
                  controller: passwordController,
                  focusNode: passwordFocusNode,
                  placeholder: 'Password',
                  onSubmitted: (data) => widget.onSignIn(),
                ),
                const Spacer(),
                BlocBuilder<LoginCubit, LoginState>(
                  builder: (context, state) {
                    return PrimaryButton(
                      label: 'Login',
                      enabled: state is LoginInitial && state.isFormValid,
                      onTap: () async => widget.onSignIn(),
                    );
                  },
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
