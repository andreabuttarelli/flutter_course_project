import 'package:either_dart/either.dart';
import 'package:prova/src/data/models/post.model.dart';

abstract class FeedRepository {
  const FeedRepository();

  Future<Either<Exception, List<PostModel>>> getPosts();
  Future<Either<Exception, void>> addPost(PostModel post);
}
