import 'package:either_dart/either.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gestionale/src/core/bloc_observer/bloc_observer.dart';
import 'package:gestionale/src/core/custom_exceptions/app_exception.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

class InitCubit extends Cubit<InitState> {
  InitCubit() : super(InitiLoading());

  void initDependencies() {
    _initDependencies().then(
      (res) => res.fold(
        (l) {
          addError(l, l.stackTrace);
          emit(InitError());
        },
        (r) => emit(InitSuccess()),
      ),
    );
  }

  Future<Either<AppException, void>> _initDependencies() async {
    try {
      Bloc.observer = AppBlocObserver();
      WidgetsFlutterBinding.ensureInitialized();
      HydratedBloc.storage = await HydratedStorage.build(
        storageDirectory: kIsWeb
            ? HydratedStorage.webStorageDirectory
            : await getApplicationDocumentsDirectory(),
      );
      return const Right(null);
    } catch (e, s) {
      return Left(
        AppException(
          e.toString(),
          stackTrace: s,
        ),
      );
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    print('Error: $error - $stackTrace');
  }
}

abstract class InitState {}

class InitiLoading extends InitState {}

class InitError extends InitState {}

class InitSuccess extends InitState {}
