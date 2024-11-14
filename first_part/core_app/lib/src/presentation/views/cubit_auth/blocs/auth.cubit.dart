import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthUnlogged());

  void login(String email) => emit(AuthLogged(email));
  void logout() => emit(const AuthUnlogged());
}

abstract class AuthState {
  const AuthState();
}

class AuthUnlogged extends AuthState {
  const AuthUnlogged();
}

class AuthLogged extends AuthState {
  final String email;
  const AuthLogged(this.email);
}
