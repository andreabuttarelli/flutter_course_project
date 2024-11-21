import 'package:clean_app/src/presentation/design_system/components/atoms/primary_button.dart';
import 'package:clean_app/src/presentation/design_system/typography/body_typo_widget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:password_strength/password_strength.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  late Box box;
  static const boxName = 'form_data';

  Exception? error;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    openBox();
  }

  void checkError(void Function() callback) {
    try {
      callback();
    } on Exception catch (e) {
      setState(() {
        error = e;
      });
    }
  }

  void openBox() => checkError(() async {
        box = await Hive.openBox(boxName);
      });

  void save() {
    box.put('email', emailController.text);
    box.put('password', passwordController.text);
  }

  void restore() {
    emailController.text = box.get('email', defaultValue: '');
    passwordController.text = box.get('password', defaultValue: '');
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login'), actions: [
        TextButton(
          onPressed: save,
          child: const BodyTypo(label: 'Save'),
        ),
        TextButton(
          onPressed: restore,
          child: const BodyTypo(label: 'Restore'),
        ),
      ]),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            FormField<String>(
              initialValue: emailController.text,
              builder: (state) => Column(
                children: [
                  CupertinoTextField(
                    controller: emailController,
                    placeholder: 'Email',
                    onChanged: (value) => state.didChange(value),
                  ),
                  if (state.hasError)
                    BodyTypo(
                      label: state.errorText!,
                      color: Colors.red,
                    ),
                ],
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your email';
                }
                if (!EmailValidator.validate(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            FormField<PasswordFieldState>(
              initialValue: PasswordFieldState.initial(
                passwordController.text,
              ),
              builder: (state) => Column(
                children: [
                  CupertinoTextField(
                    controller: passwordController,
                    placeholder: 'Password',
                    obscureText: true,
                    onChanged: (value) {
                      final strength = estimatePasswordStrength(value);
                      state.didChange(PasswordFieldState(
                        textValue: value,
                        strength: strength,
                      ));
                    },
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    height: 2,
                    child: FractionallySizedBox(
                      widthFactor: state.value!.strength,
                      heightFactor: 1,
                      child: ColoredBox(
                        color: state.value!.strength <= 0.3
                            ? Colors.red
                            : state.value!.strength < 0.5
                                ? Colors.orange
                                : Colors.green,
                      ),
                    ),
                  ),
                  if (state.hasError)
                    BodyTypo(
                      label: state.errorText!,
                      color: Colors.red,
                    ),
                ],
              ),
              validator: (value) {
                if (value!.textValue.isEmpty) {
                  return 'Please enter your password';
                }
                if (value.textValue.length <= 6) {
                  return 'Password must be at least 6 characters';
                }
                if (value.strength < 0.5) {
                  return 'Password is too weak';
                }
                return null;
              },
            ),
            PrimaryButton(
              label: 'Sign in',
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  print('Signed in');
                  print('Email: ${emailController.text}');
                  print('Password: ${passwordController.text}');
                } else {
                  print('Invalid form');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PasswordFieldState {
  PasswordFieldState({
    required this.textValue,
    required this.strength,
  });

  String textValue;
  double strength;

  factory PasswordFieldState.initial(String initialValue) => PasswordFieldState(
        textValue: initialValue,
        strength: estimatePasswordStrength(initialValue),
      );
}
