import 'package:either_dart/either.dart';

Either<Exception, int> _prova() {
  try {
    return const Right(0);
  } catch (e) {
    return Left(Exception(e.toString()));
  }
}

void main() {
  _prova().fold((l) {
    print(l);
  }, (r) {
    print(r);
  });

  final res = _prova();
  if (res.isLeft) {
    res.left;
  }
  if (res.isRight) {
    res.right;
  }
}
