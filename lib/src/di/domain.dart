import 'package:prova/src/data/repositories/feed.repository.impl.dart';
import 'package:prova/src/data/repositories/feed.repository.impl.local.dart';
import 'package:prova/src/di/init.dart';
import 'package:prova/src/domain/usecases/add_post.usecase.dart';
import 'package:prova/src/domain/usecases/get_posts.usecase.dart';

void initDomainDependencies() {
  getIt.registerLazySingleton<FeedRepositoryImpl>(
      () => FeedRepositoryImpl(getIt()));
  getIt.registerLazySingleton<FeedRepositoryLocalImpl>(
      () => FeedRepositoryLocalImpl(getIt()));

  getIt.registerLazySingleton(
      () => GetPostsUseCase(getIt<FeedRepositoryImpl>()));
  getIt.registerLazySingleton(
      () => AddPostsUseCase(getIt<FeedRepositoryLocalImpl>()));
}
