import 'package:clean_app/src/di/di.dart';
import 'package:clean_app/src/domain/usecases/get_user_id_usecase.dart';

void registerDomainDependencies() {
  getIt.registerLazySingleton(() => GetUserIDUseCase(getIt()));
}
