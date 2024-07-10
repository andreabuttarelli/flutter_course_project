import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prova/src/data/models/post.model.dart';
import 'package:prova/src/domain/usecases/get_posts.usecase.dart';

part 'feed.cubit.freezed.dart';
part 'feed_state.dart';

class FeedCubit extends Cubit<FeedState> {
  FeedCubit(this._getPostsUseCase) : super(const FeedState.loading());

  final GetPostsUseCase _getPostsUseCase;

  void load() {
    emit(const FeedState.loading());
    _getPostsUseCase.call().then(
          (res) => res.fold(
            (exc) {
              addError(exc, StackTrace.current);
              emit(FeedState.error(exc));
            },
            (posts) => emit(FeedState.loaded(posts)),
          ),
        );
  }

  void addPost() {
    const post = PostModel(id: 1, title: 'Qualcosa', body: 'Ciao');
    final currentState = state.whenOrNull(loaded: (posts) => posts);
    if (currentState == null) return;
    emit(FeedState.loaded([...currentState, post]));
  }
}
