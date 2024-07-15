import 'package:either_dart/either.dart';
import 'package:gestionale/src/domain/repositories/init_dependencies.repository.abstract.dart';

class InitDependenciesUseCase {
  const InitDependenciesUseCase(this._repository);

  final InitDependenciesRepository _repository;

  Future<Either<Exception, void>> call() => _repository.initDependencies();
}
