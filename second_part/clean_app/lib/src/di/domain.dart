import 'package:clean_app/src/di/di.dart';
import 'package:clean_app/src/domain/usecases/get_user_id_usecase.dart';
import 'package:clean_app/src/domain/usecases/submit_form_hr_usecase.dart';

void registerDomainDependencies() {
  getIt.registerLazySingleton(() => GetUserIDUseCase(getIt()));
  getIt.registerLazySingleton(() => SubmitFormHRUseCase(getIt()));
}
