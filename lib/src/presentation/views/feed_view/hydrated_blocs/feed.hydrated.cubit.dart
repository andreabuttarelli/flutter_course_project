import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prova/src/data/models/index.dart';
import 'package:replay_bloc/replay_bloc.dart';

part 'feed.hydrated.cubit.freezed.dart';
part 'feed_state.dart';

class FeedCubit extends HydratedCubit<FeedState> with ReplayCubitMixin {
  FeedCubit() : super(const FeedState.loaded([]));

  void addPost() {
    const post = PostModel(
      id: 1,
      title: 'Qualcosa',
      body: 'Ciao',
    );
    final existingPosts = state.whenOrNull(loaded: (posts) => posts);
    emit(FeedState.loaded(
      [
        if (existingPosts != null) ...existingPosts,
        post,
      ],
    ));
  }

  @override
  FeedState? fromJson(Map<String, dynamic> json) {
    return FeedState.loaded(
      PostModel.fromJsonList(
        json['posts'] ?? [],
      ),
    );
  }

  @override
  Map<String, dynamic>? toJson(FeedState state) => state.when(
        loading: () => {},
        error: (exc) => {},
        loaded: (posts) => {
          'posts': posts.map((e) => e.toJson()).toList(),
        },
      );
}
