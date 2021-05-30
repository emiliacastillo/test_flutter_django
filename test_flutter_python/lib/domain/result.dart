import 'package:meta/meta.dart';

abstract class Result<T> {
  static ResultSuccess<T> success<T>({
    @required T value,
  }) =>
      ResultSuccess(
        value: value,
      );

  static ResultError<T> error<T>({
    @required dynamic error,
  }) =>
      ResultError(
        error: error,
      );
}

class ResultSuccess<T> extends Result<T> {
  final T value;

  ResultSuccess({
    @required this.value,
  });
}

class ResultError<T> extends Result<T> {
  final dynamic error;

  ResultError({
    @required this.error,
  });
}
