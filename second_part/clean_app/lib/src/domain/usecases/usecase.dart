abstract class UseCase<R, P extends UseCaseParams> {
  const UseCase();

  Future<R> call(P params);
}

class UseCaseParams {
  const UseCaseParams();

  factory UseCaseParams.empty() {
    return const UseCaseParams();
  }
}
