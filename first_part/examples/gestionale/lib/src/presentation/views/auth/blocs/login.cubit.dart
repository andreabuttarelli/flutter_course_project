import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gestionale/src/core/custom_exceptions/app_exception.dart';
import 'package:gestionale/src/data/models/responses/login.response.dart';
import 'package:gestionale/src/data/models/user.model.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial('', ''));

  void updateEmail(String email) {
    final currentState = state;
    assert(currentState is LoginInitial);
    if (currentState is! LoginInitial) return;
    emit(currentState.copyWith(email: email));
  }

  void updatePassword(String password) {
    final currentState = state;
    assert(currentState is LoginInitial);
    if (currentState is! LoginInitial) return;
    emit(currentState.copyWith(password: password));
  }

  void login(String email, String password) {
    emit(LoginLoading());
    _login().then(
      (res) => res.fold(
        (exc) {
          addError(exc, exc.stackTrace);
          emit(LoginFailure(exc));
          emit(LoginInitial(email, password));
        },
        (response) {
          emit(LoginSuccess(
            response.accessToken,
            response.user,
          ));
        },
      ),
    );
  }

  Future<Either<AppException, LoginResponseModel>> _login() async {
    return Right(
      LoginResponseModel(
        accessToken: 'token',
        user: UserModel(id: '1', name: 'Giulia'),
      ),
    );
  }
}

abstract class LoginState {}

class LoginInitial extends LoginState {
  final String email;
  final String password;

  LoginInitial(this.email, this.password);

  bool isFormValid() => email.isNotEmpty && password.length >= 6;

  LoginInitial copyWith({
    String? email,
    String? password,
  }) =>
      LoginInitial(
        email ?? this.email,
        password ?? this.password,
      );
}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String accessToken;
  final UserModel user;

  LoginSuccess(
    this.accessToken,
    this.user,
  );
}

class LoginFailure extends LoginState {
  final AppException exception;

  LoginFailure(this.exception);
}
