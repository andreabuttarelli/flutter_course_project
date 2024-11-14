import 'package:gestionale/src/core/functions/check_connection.dart';
import 'package:gestionale/src/data/repositories/init_dependencies.repository.dart';
import 'package:gestionale/src/data/services/init_dependencies.service.remote.dart';
import 'package:gestionale/src/di/di.dart';
import 'package:gestionale/src/domain/repositories/init_dependencies.repository.abstract.dart';
import 'package:logger/web.dart';

void initDependenciesWithGetIt() {}

void initCubitUseCaseDependency() {
  print('web');
  getIt.registerLazySingleton(() => Logger());
  getIt.registerLazySingleton<InitDependenciesRepository>(
      () => InitDependenciesRepositoryImpl(
            InitDependenciesServiceRemote(ConnectionChecker(getIt())),
          ));
}
