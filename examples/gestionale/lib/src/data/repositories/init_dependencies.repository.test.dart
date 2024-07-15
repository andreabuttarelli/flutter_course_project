import 'package:either_dart/either.dart';
import 'package:gestionale/src/core/custom_exceptions/app_exception.dart';
import 'package:gestionale/src/data/services/init_dependencies.service.test.dart';
import 'package:gestionale/src/domain/repositories/init_dependencies.repository.abstract.dart';

class InitDependenciesTestRepositoryImpl extends InitDependenciesRepository {
  const InitDependenciesTestRepositoryImpl(this._service);

  final InitDependenciesServiceTest _service;

  @override
  Future<Either<AppException, void>> initDependencies() async {
    try {
      return Right(await _service.initDependencies());
    } catch (e, s) {
      return Left(AppException(e.toString(), stackTrace: s));
    }
  }
}
