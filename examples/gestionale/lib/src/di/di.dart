import 'dart:io';

import 'package:gestionale/src/core/functions/check_connection.dart';
import 'package:gestionale/src/data/repositories/init_dependencies.repository.test.dart';
import 'package:gestionale/src/data/services/init_dependencies.service.test.dart';
import 'package:gestionale/src/domain/repositories/init_dependencies.repository.abstract.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/web.dart';

GetIt getIt = GetIt.instance;

void initDependenciesWithGetIt() {}

InitDependenciesRepository initCubitUseCaseDependency() {
  getIt.registerLazySingleton(() => Logger());
  if (Platform.environment.containsKey('FLUTTER_TEST')) {
    return InitDependenciesTestRepositoryImpl(
      InitDependenciesServiceTest(ConnectionChecker(getIt())),
    );
  } else {
    return InitDependenciesTestRepositoryImpl(
      InitDependenciesServiceTest(ConnectionChecker(getIt())),
    );
  }
}
