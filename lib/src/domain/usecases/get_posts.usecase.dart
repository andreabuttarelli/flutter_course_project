import 'package:either_dart/either.dart';
import 'package:prova/src/core/typedef.dart';
import 'package:prova/src/domain/repositories/feed.repository.interface.dart';

class GetPostsUseCase {
  final FeedRepository _repository;

  const GetPostsUseCase(this._repository);

  Future<Either<Exception, Posts>> call() => _repository.getPosts();
}
