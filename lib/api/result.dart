class Result<V, E> {
  E? _error;
  V? _value;

  Result.success(V value) {
    _value = value;
  }

  Result.error(E error) {
    _error = error;
  }

  bool isError() {
    return _value == null;
  }

  bool isSuccess() {
    return _value != null;
  }

  V? getValue() {
    return _value;
  }

  E? getError() {
    return _error;
  }
}

class DataError {
  final String message;
  final int errorCode;

  DataError(this.message, this.errorCode);
}
