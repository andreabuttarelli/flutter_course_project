import 'package:http/http.dart';
import 'package:prova/src/data/models/post.model.dart';

class FeedLocalService {
  final Client client;

  const FeedLocalService(this.client);

  Future<List<PostModel>> getPosts() async {
    final data = [
      {
        'id': 1,
        'title': 'title',
        'body': 'body',
      },
      {
        'id': 2,
        'title': 'title',
        'body': 'body',
      },
      {
        'id': 3,
        'title': 'title',
        'body': 'body',
      },
      {
        'id': 4,
        'title': 'title',
        'body': 'body',
      },
    ];
    return PostModel.fromJsonList(data);
  }

  Future<void> addPost(PostModel post) async {
    throw UnimplementedError();
  }
}
