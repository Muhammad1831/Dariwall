abstract class Either<L, R> {
  T fold<T>(T Function(L left) left, T Function(R right) right);
}

class Left<L, R> extends Either<L, R> {
  final L value;

  Left(this.value);

  @override
  T fold<T>(T Function(L left) left, T Function(R right) right) {
    return left(value);
  }
}

class Right<L, R> extends Either<L, R> {
  final R value;

  Right(this.value);

  @override
  T fold<T>(T Function(L left) left, T Function(R right) right) {
    return right(value);
  }
}
