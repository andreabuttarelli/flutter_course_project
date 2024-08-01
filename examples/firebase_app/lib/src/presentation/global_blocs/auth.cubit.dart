import 'package:firebase_app/src/core/firebase/analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(LoggedOut()) {
    load();
  }

  void load() {
    checkUser(FirebaseAuth.instance.currentUser);
    FirebaseAuth.instance.authStateChanges().listen(checkUser);
  }

  void checkUser(User? user) {
    if (user != null) {
      emit(LoggedIn(user));
      setUserID(user.uid);
    } else {
      emit(LoggedOut());
    }
  }
}

abstract class AuthState {}

class LoggedIn extends AuthState {
  final User user;

  LoggedIn(this.user);
}

class LoggedOut extends AuthState {}
