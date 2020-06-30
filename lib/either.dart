
class Either<L, R> {

  bool _isLeft;
  L _left;
  R _right;

  Either.left(this._left) {
    _isLeft = true;
  }

  Either.right(this._right) {
    _isLeft = false;
  }

  C fold<C>(C ifLeft(L), C ifRight(R)) {
    if (_isLeft) {
      return ifLeft(_left);
    } else {
      return ifRight(_right);
    }
  }

}