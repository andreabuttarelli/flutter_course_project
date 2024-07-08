import 'package:either_dart/either.dart';
import 'package:prova/src/data/models/post.model.dart';
import 'package:prova/src/domain/repositories/feed.repository.interface.dart';

class AddPostsUseCase {
  final FeedRepository _repository;

  const AddPostsUseCase(this._repository);

  Future<Either<Exception, void>> call(PostModel post) =>
      _repository.addPost(post);
}
