import 'dart:convert';

import 'package:http/http.dart';
import 'package:prova/src/core/check_status_code.dart';
import 'package:prova/src/data/models/post.model.dart';

class FeedService {
  final Client client;

  const FeedService(this.client);

  Future<List<PostModel>> getPosts() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final res = await client.get(url);
    if (!checkStatusCode(res.statusCode)) {
      throw Exception(
          'Failed to load posts, status code: ${res.statusCode}, error: ${res.body}');
    }
    final data = jsonDecode(res.body);
    return PostModel.fromJsonList(data);
  }

  Future<void> addPost(PostModel post) async {
    throw UnimplementedError();
  }
}
