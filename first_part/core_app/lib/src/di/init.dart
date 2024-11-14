import 'package:get_it/get_it.dart';
import 'package:prova/src/di/data.dart';
import 'package:prova/src/di/domain.dart';

final getIt = GetIt.instance;

void initDependencies() {
  initDataDependencies();
  initDomainDependencies();
}
