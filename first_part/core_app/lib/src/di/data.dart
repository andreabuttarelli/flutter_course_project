import 'package:http/http.dart';
import 'package:prova/src/data/services/feed.service.dart';
import 'package:prova/src/di/init.dart';

void initDataDependencies() {
  getIt.registerLazySingleton<Client>(() => Client());

  getIt.registerLazySingleton(() => FeedService(getIt()));
}
