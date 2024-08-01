import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  void setEmail(value) => emit((state as LoginInitial).copyWith(email: value));
  void setPassword(value) =>
      emit((state as LoginInitial).copyWith(password: value));

  Future<void> login() async {
    final currentState = state as LoginInitial;
    emit(LoginLoading());
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: currentState.email,
        password: currentState.password,
      );
      FirebaseAnalytics.instance.logLogin();
      emit(LoginSuccess());
      emit(LoginInitial(
          email: currentState.email, password: currentState.password));
    } on FirebaseAuthException catch (e, s) {
      if (e.code == 'weak-password') {
        addError('The password provided is too weak.', s);
      } else if (e.code == 'email-already-in-use') {
        addError('The account already exists for that email.', s);
      } else {
        addError(e, s);
      }
      emit(LoginInitial(
          email: currentState.email, password: currentState.password));
    }
  }

  Future<void> loginAnonymously() async {
    emit(LoginLoading());
    try {
      await FirebaseAuth.instance.signInAnonymously();
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e, s) {
      addError(e, s);
      emit(LoginInitial());
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    emit(
        LoginFailure(error is Exception ? error : Exception(error.toString())));
    FirebaseCrashlytics.instance.recordError(error, stackTrace);
    super.onError(error, stackTrace);
  }
}

abstract class LoginState {}

class LoginInitial extends LoginState {
  final String email;
  final String password;

  LoginInitial({this.email = '', this.password = ''});

  LoginInitial copyWith({String? email, String? password}) {
    return LoginInitial(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  final Exception error;

  LoginFailure(this.error);
}
