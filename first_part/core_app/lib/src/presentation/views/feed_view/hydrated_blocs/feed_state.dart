part of 'feed.hydrated.cubit.dart';

@freezed
class FeedState with _$FeedState {
  const factory FeedState.loading() = _Loading;
  const factory FeedState.error(Exception exc) = _Error;
  const factory FeedState.loaded(List<PostModel> posts) = _Loaded;
}
