import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prova/src/data/models/post.model.dart';
import 'package:prova/src/domain/usecases/add_post.usecase.dart';
import 'package:prova/src/domain/usecases/get_posts.usecase.dart';

class FeedCubit extends Cubit<FeedState> {
  FeedCubit(this._getPostsUseCase, this._addPostsUseCase)
      : super(const FeedLoading());

  final GetPostsUseCase _getPostsUseCase;
  final AddPostsUseCase _addPostsUseCase;

  void load() {
    emit(const FeedLoading());
    _getPostsUseCase.call().then(
          (res) => res.fold(
            (exc) {
              addError(exc, StackTrace.current);
              emit(FeedError(exc));
            },
            (posts) => emit(FeedLoaded(posts)),
          ),
        );
  }

  void addPost() {
    const post = PostModel(id: 1, title: 'Qualcosa', body: 'Ciao');
    final currentState = state;
    if (currentState is FeedLoaded) {
      emit(FeedLoaded([...currentState.posts, post]));
    }
  }
}

abstract class FeedState {
  const FeedState();
}

class FeedLoading extends FeedState {
  const FeedLoading();
}

class FeedError extends FeedState {
  final Exception error;

  const FeedError(this.error);
}

class FeedLoaded extends FeedState {
  final List<PostModel> posts;

  const FeedLoaded(this.posts);
}
