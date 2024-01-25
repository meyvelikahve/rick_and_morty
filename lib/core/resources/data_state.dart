import 'package:rick_morty_api/common/exception/failure.dart';

abstract class DataState<T> {
  final T? data;
  final Failure? exception;
  DataState({
    this.data,
    this.exception,
  });
}

class DataSuccess<T> extends DataState<T> {
  DataSuccess(T data) : super(data: data);
}

class DataFailed<T> extends DataState<T> {
  DataFailed(Failure failure) : super(exception: failure);
}
