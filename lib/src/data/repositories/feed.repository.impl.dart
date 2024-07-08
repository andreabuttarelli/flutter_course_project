import 'package:either_dart/either.dart';
import 'package:prova/src/data/models/post.model.dart';
import 'package:prova/src/data/services/feed.service.dart';
import 'package:prova/src/domain/repositories/feed.repository.interface.dart';

class FeedRepositoryImpl extends FeedRepository {
  final FeedService _service;

  const FeedRepositoryImpl(this._service);

  @override
  Future<Either<Exception, List<PostModel>>> getPosts() async {
    try {
      return Right(await _service.getPosts());
    } catch (e) {
      return Left(e is Exception ? e : Exception(e.toString()));
    }
  }

  @override
  Future<Either<Exception, void>> addPost(PostModel post) async {
    try {
      return Right(await _service.addPost(post));
    } catch (e) {
      return Left(e is Exception ? e : Exception(e.toString()));
    }
  }
}
