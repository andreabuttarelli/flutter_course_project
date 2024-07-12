import 'package:bloc_test/bloc_test.dart';
import 'package:gestionale/src/core/custom_exceptions/app_exception.dart';
import 'package:gestionale/src/presentation/global_blocs/init/init.cubit.dart';
import 'package:test/test.dart';

void main() => tests();

void tests() {
  group('testing InitCubit', () {
    blocTest(
      'emits [1] when CounterIncrementPressed is added',
      build: () => InitCubit(),
      act: (cubit) => cubit.initDependencies(),
      wait: const Duration(milliseconds: 0),
      expect: () => [isA<InitError>()],
      errors: () => [isA<AppException>()],
    );
  });
}
