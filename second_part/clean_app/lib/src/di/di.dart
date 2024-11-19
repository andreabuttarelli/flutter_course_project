import 'package:clean_app/src/di/data.dart';
import 'package:clean_app/src/di/domain.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void registerAllDependencies() {
  registerDataDependencies();
  registerDomainDependencies();
}
