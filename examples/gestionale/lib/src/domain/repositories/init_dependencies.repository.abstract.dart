import 'package:either_dart/either.dart';

abstract class InitDependenciesRepository {
  const InitDependenciesRepository();

  Future<Either<Exception, void>> initDependencies();
}
