import 'package:booknow_mobile/core/error/network_exception.dart';

/// The outcome of a call to the API: data, or the reason there is none.
///
/// Repositories return this instead of throwing, so a BLoC handles both paths
/// in one place and the analyzer enforces that it handled them.
sealed class ApiResult<T> {
  const ApiResult();

  const factory ApiResult.success(T data) = Success<T>;

  const factory ApiResult.failure(NetworkException error) = Failure<T>;
}

class Success<T> extends ApiResult<T> {
  const Success(this.data);

  final T data;
}

class Failure<T> extends ApiResult<T> {
  const Failure(this.error);

  final NetworkException error;
}

extension ApiResultX<T> on ApiResult<T> {
  bool get isSuccess => this is Success<T>;

  bool get isFailure => this is Failure<T>;

  T? get dataOrNull => switch (this) {
    Success<T>(:final data) => data,
    Failure<T>() => null,
  };

  NetworkException? get errorOrNull => switch (this) {
    Success<T>() => null,
    Failure<T>(:final error) => error,
  };

  /// Handles both branches in one expression.
  R fold<R>({
    required R Function(T data) onSuccess,
    required R Function(NetworkException error) onFailure,
  }) => switch (this) {
    Success<T>(:final data) => onSuccess(data),
    Failure<T>(:final error) => onFailure(error),
  };

  /// Transforms the value, leaving a failure untouched.
  ApiResult<R> map<R>(R Function(T data) transform) => switch (this) {
    Success<T>(:final data) => ApiResult.success(transform(data)),
    Failure<T>(:final error) => ApiResult.failure(error),
  };

  /// Chains another call that can itself fail.
  ApiResult<R> flatMap<R>(ApiResult<R> Function(T data) transform) =>
      switch (this) {
        Success<T>(:final data) => transform(data),
        Failure<T>(:final error) => ApiResult.failure(error),
      };
}
