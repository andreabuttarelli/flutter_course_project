import 'dart:io';

import 'package:gestionale/src/core/functions/check_connection.dart';
import 'package:gestionale/src/data/repositories/init_dependencies.repository.dart';
import 'package:gestionale/src/data/repositories/init_dependencies.repository.test.dart';
import 'package:gestionale/src/data/services/init_dependencies.service.remote.dart';
import 'package:gestionale/src/data/services/init_dependencies.service.test.dart';
import 'package:gestionale/src/di/di.dart';
import 'package:gestionale/src/domain/repositories/init_dependencies.repository.abstract.dart';
import 'package:logger/web.dart';

void initDependenciesWithGetIt() {}

void initCubitUseCaseDependency() {
  print('io ');
  getIt.registerLazySingleton(() => Logger());
  if (Platform.environment.containsKey('FLUTTER_TEST')) {
    getIt.registerLazySingleton<InitDependenciesRepository>(
        () => InitDependenciesTestRepositoryImpl(
              InitDependenciesServiceTest(ConnectionChecker(getIt())),
            ));
  } else {
    getIt.registerLazySingleton<InitDependenciesRepository>(
        () => InitDependenciesRepositoryImpl(
              InitDependenciesServiceRemote(ConnectionChecker(getIt())),
            ));
  }
}
