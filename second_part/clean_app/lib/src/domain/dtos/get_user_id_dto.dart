class GetUserIDDto<L extends Exception, R> {
  final L? l;
  final R? r;

  L get left => l!;
  R get right => r!;

  bool get isLeft => l != null;
  bool get isRight => r != null;

  GetUserIDDto({this.l, this.r});

  factory GetUserIDDto.left(L l) {
    return GetUserIDDto(l: l);
  }

  factory GetUserIDDto.right(R r) {
    return GetUserIDDto(r: r);
  }

  void fold(void Function(L) onLeft, void Function(R) onRight) {
    if (isLeft) {
      onLeft(left);
    } else {
      onRight(right);
    }
  }
}
