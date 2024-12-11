import 'package:clean_app/src/data/providers/form_hr_provider_offline.dart';
import 'package:clean_app/src/data/providers/user_provider_offline.dart';
import 'package:clean_app/src/data/providers/user_provider_remote.dart';
import 'package:clean_app/src/data/repositories/form_hr_repository_impl.dart';
import 'package:clean_app/src/data/repositories/user_repository_impl.dart';
import 'package:clean_app/src/di/di.dart';
import 'package:clean_app/src/domain/repositories/form_hr_repository_abs.dart';
import 'package:clean_app/src/domain/repositories/user_repository_abs.dart';

void registerDataDependencies() {
  getIt.registerLazySingleton(() => const UserProviderRemote());
  getIt.registerLazySingleton(() => const UserProviderOffline());

  getIt.registerLazySingleton(() => const FormHRProvider());

  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      getIt(),
      getIt(),
    ),
  );

  getIt.registerLazySingleton<FormHRRepository>(
      () => FormHRRepositoryImpl(getIt()));
}
