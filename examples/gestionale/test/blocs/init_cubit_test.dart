import 'package:bloc_test/bloc_test.dart';
import 'package:gestionale/src/core/custom_exceptions/app_exception.dart';
import 'package:gestionale/src/core/functions/check_connection.dart';
import 'package:gestionale/src/data/repositories/init_dependencies.repository.test.dart';
import 'package:gestionale/src/data/services/init_dependencies.service.test.dart';
import 'package:gestionale/src/domain/usecases/init_dependencies.usecase.dart';
import 'package:gestionale/src/presentation/global_blocs/init/init.cubit.dart';
import 'package:logger/web.dart';
import 'package:test/test.dart';

void main() => tests();

void tests() {
  group('testing InitCubit', () {
    blocTest(
      'emits InitSuccess after initDependencies',
      build: () => InitCubit(
        InitDependenciesUseCase(
          InitDependenciesTestRepositoryImpl(
            InitDependenciesServiceTest(
              ConnectionChecker(Logger()),
            ),
          ),
        ),
      ),
      act: (cubit) => cubit.initDependencies(),
      wait: const Duration(milliseconds: 0),
      expect: () => [isA<InitSuccess>()],
    );

    blocTest(
      'emits InitError after initDependencies with error',
      build: () => InitCubit(
        InitDependenciesUseCase(
          InitDependenciesTestRepositoryImpl(
            InitDependenciesServiceTest(
              ConnectionChecker(Logger()),
              shouldThrowException: true,
            ),
          ),
        ),
      ),
      act: (cubit) => cubit.initDependencies(),
      wait: const Duration(milliseconds: 0),
      expect: () => [isA<InitError>()],
      errors: () => [isA<AppException>()],
    );
  });
}
