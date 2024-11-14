import 'package:firebase_app/src/presentation/auth/login/blocs/login.cubit.dart';
import 'package:firebase_app/src/presentation/controller_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({super.key});

  LoginCubit _cubit(BuildContext context) => context.read<LoginCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: 600,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ControllerBuilder(
                    create: () => TextEditingController(),
                    builder: (context, controller) {
                      return CupertinoTextField(
                        controller: controller,
                        placeholder: 'Email',
                        onChanged: (value) => _cubit(context).setEmail(value),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ControllerBuilder(
                    create: () => TextEditingController(),
                    builder: (context, controller) {
                      return CupertinoTextField(
                        controller: controller,
                        placeholder: 'Password',
                        onChanged: (value) =>
                            _cubit(context).setPassword(value),
                      );
                    },
                  ),
                  const Spacer(),
                  FilledButton(
                    onPressed: () => _cubit(context).login(),
                    child: const Text('Sign in'),
                  ),
                  GestureDetector(
                    onTap: () => _cubit(context).loginAnonymously(),
                    child: const Text('Or continue as guest'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
