abstract class HomePageState {
  const HomePageState();
}

class HomePageStateInitial extends HomePageState {
  const HomePageStateInitial();
}

class HomePageStateLoading extends HomePageState {
  const HomePageStateLoading();
}

class HomePageStateError extends HomePageState {
  const HomePageStateError(this.error);

  final Exception error;
}

class HomePageStateLoaded extends HomePageState {
  const HomePageStateLoaded(this.userID);

  final String userID;
}
