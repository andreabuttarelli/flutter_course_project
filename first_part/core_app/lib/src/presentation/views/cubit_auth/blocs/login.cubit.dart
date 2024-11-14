import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginInitial('', ''));

  void updateEmail(String data) {
    final currentState = state;
    if (currentState is! LoginInitial) return;
    emit(currentState.copyWith(email: data));
  }

  void updatePassword(String data) {
    final currentState = state;
    if (currentState is! LoginInitial) return;
    emit(currentState.copyWith(password: data));
  }

  void login({required Function() onDone}) {
    final currentState = state;
    if (currentState is! LoginInitial) return;
    emit(const LoginLoading());
    Future.delayed(const Duration(seconds: 1)).then((res) {
      if (!currentState.isFormValid) {
        emit(const LoginFailure('Email non valida'));
      } else if (currentState.email == 'ciao' &&
          currentState.password == 'ciao') {
        emit(LoginSuccess(User(currentState.email)));
      } else {
        emit(const LoginFailure('Credenziali errate'));
      }
      emit(currentState);
      onDone();
    });
  }
}

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  const LoginInitial(this.email, this.password);

  final String email;
  final String password;

  bool get isEmailValid => email.isNotEmpty;
  bool get isPasswordValid => password.isNotEmpty;
  bool get isFormValid => isEmailValid && isPasswordValid;

  LoginInitial copyWith({
    String? email,
    String? password,
  }) =>
      LoginInitial(
        email ?? this.email,
        password ?? this.password,
      );

  @override
  List<Object?> get props => [email, password];
}

class LoginLoading extends LoginState {
  const LoginLoading();

  @override
  List<Object?> get props => [];
}

class LoginSuccess extends LoginState {
  const LoginSuccess(this.user);

  final User user;

  @override
  List<Object?> get props => [user];
}

class LoginFailure extends LoginState {
  const LoginFailure(this.error);

  final String error;

  @override
  List<Object?> get props => [error];
}

class User extends Equatable {
  final String email;

  const User(this.email);

  @override
  List<Object?> get props => [email];
}
