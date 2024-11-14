import 'package:gestionale/src/data/models/user.model.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class AuthCubit extends HydratedCubit<AuthState> {
  AuthCubit() : super(AuthUnlogged());

  void updateCurrentUserSession(String token, UserModel user) {
    emit(AuthLogged(token, user));
  }

  void logout() {
    emit(AuthUnlogged());
  }

  void refreshToken() {
    final currentState = state;
    if (currentState is! AuthLogged) return;
  }

  @override
  AuthState fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) {
      return AuthUnlogged();
    }
    try {
      return AuthLogged(
        json['access_token'] as String,
        UserModel.fromJson(
          json['user'] as Map<String, dynamic>,
        ),
      );
    } catch (e) {
      addError(e, StackTrace.current);
      return AuthUnlogged();
    }
  }

  @override
  Map<String, dynamic>? toJson(state) {
    if (state is AuthLogged) {
      return {
        'access_token': state.accessToken,
        'user': state.user.toJson(),
      };
    }
    return {};
  }
}

abstract class AuthState {}

class AuthLogged extends AuthState {
  final String accessToken;
  final UserModel user;

  AuthLogged(this.accessToken, this.user);
}

class AuthUnlogged extends AuthState {}
