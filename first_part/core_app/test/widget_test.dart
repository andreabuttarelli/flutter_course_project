import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:prova/src/data/repositories/feed.repository.impl.dart';
import 'package:prova/src/data/repositories/feed.repository.impl.local.dart';
import 'package:prova/src/data/services/feed.local.service.dart';
import 'package:prova/src/data/services/feed.service.dart';
import 'package:prova/src/domain/usecases/get_posts.usecase.dart';

void main() => tests();

void tests() {
  group(
    'remote operations',
    () {
      final client = Client();
      final service = FeedService(client);
      final reposiory = FeedRepositoryImpl(service);
      final getPosts = GetPostsUseCase(reposiory);

      test(
        'getPosts',
        () async {
          final result = await getPosts.call();
          expect(result.isRight, true);
          expect(result.right.length, 100);
        },
      );
    },
  );

  group(
    'local operations',
    () {
      final client = Client();
      final service = FeedLocalService(client);
      final reposiory = FeedRepositoryLocalImpl(service);
      final getPosts = GetPostsUseCase(reposiory);

      test(
        'getPosts',
        () async {
          final result = await getPosts.call();
          expect(result.isRight, true);
          expect(result.right.length, 4);
        },
      );
    },
  );
}
