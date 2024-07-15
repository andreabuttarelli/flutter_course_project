import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gestionale/src/presentation/design_system/custom_circular_progress_indicator.dart';
import 'package:gestionale/src/presentation/global_blocs/auth/auth.cubit.dart';
import 'package:gestionale/src/presentation/views/auth/blocs/login.cubit.dart';

class AuthView extends StatelessWidget {
  const AuthView({
    super.key,
    this.useAuthCubit = true,
  });

  final bool useAuthCubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: _Body(
        useAuthCubit: useAuthCubit,
      ),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({super.key, required this.useAuthCubit});

  final bool useAuthCubit;

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  LoginCubit get _loginCubit => context.read<LoginCubit>();
  bool isFormValid(LoginState state) =>
      state is LoginInitial && state.isFormValid();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();

    emailController.addListener(
      () => _loginCubit.updateEmail(emailController.text),
    );
    passwordController.addListener(
      () => _loginCubit.updatePassword(passwordController.text),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(state.exception.message),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Close'),
                ),
              ],
            ),
          );
          return;
        }
        if (state is LoginSuccess) {
          if (widget.useAuthCubit) {
            context.read<AuthCubit>().updateCurrentUserSession(
                  state.accessToken,
                  state.user,
                );
          }
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Spacer(),
                CupertinoTextField(
                  controller: emailController,
                  placeholder: 'Email',
                  keyboardType: TextInputType.emailAddress,
                ),
                CupertinoTextField(
                  controller: passwordController,
                  placeholder: 'Password',
                  obscureText: true,
                ),
                const Spacer(),
                BlocBuilder<LoginCubit, LoginState>(
                  builder: (context, state) {
                    final valid = isFormValid(state);
                    if (state is LoginSuccess) {
                      return const Text(
                        'Login Success',
                        style: TextStyle(
                          color: Colors.green,
                        ),
                      );
                    }
                    return IgnorePointer(
                      ignoring: !valid,
                      child: Opacity(
                        opacity: valid ? 1 : 0.5,
                        child: FilledButton(
                          onPressed: () => _loginCubit.login(
                            emailController.text,
                            passwordController.text,
                          ),
                          child: state is LoginLoading
                              ? const CCircularProgressIndicator()
                              : const Text('Login'),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
