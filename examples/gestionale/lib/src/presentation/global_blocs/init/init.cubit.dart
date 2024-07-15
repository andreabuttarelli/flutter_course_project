import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gestionale/src/core/custom_exceptions/app_exception.dart';
import 'package:gestionale/src/di/di.dart';
import 'package:gestionale/src/domain/usecases/init_dependencies.usecase.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class InitCubit extends Cubit<InitState> {
  InitCubit(this._initDependenciesUseCase) : super(InitiLoading());

  final InitDependenciesUseCase _initDependenciesUseCase;

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
      initDependenciesWithGetIt();
      final res = await _initDependenciesUseCase.call();
      if (res.isLeft) {
        throw res.left;
      }
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
