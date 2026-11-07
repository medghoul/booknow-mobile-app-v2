import 'dart:io';

import 'package:dio/dio.dart';
import 'package:booknow_mobile/core/error/api_error_code.dart';

/// Everything that can go wrong on the way to the API, as a closed set.
///
/// A sealed class rather than a freezed union: the app switches on these
/// exhaustively and Dart 3 checks that for us, so the generated union buys
/// nothing here and costs a build_runner round trip on every edit.
///
/// The message a user sees is never taken from here directly — the UI maps the
/// variant to a localised string, because these are diagnostics, not copy.
sealed class NetworkException implements Exception {
  const NetworkException();

  /// Maps a [DioException] onto this set.
  factory NetworkException.fromDio(DioException exception) {
    return switch (exception.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout ||
      DioExceptionType.transformTimeout => const RequestTimeout(),
      DioExceptionType.cancel => const RequestCancelled(),
      DioExceptionType.badCertificate => const BadCertificate(),
      DioExceptionType.connectionError => const NoInternetConnection(),
      DioExceptionType.unknown =>
        exception.error is SocketException
            ? const NoInternetConnection()
            : UnexpectedError(exception.message ?? exception.toString()),
      DioExceptionType.badResponse => _fromResponse(exception.response),
    };
  }

  static NetworkException _fromResponse(Response<dynamic>? response) {
    final status = response?.statusCode ?? 0;
    final body = response?.data;
    final code = body is Map<String, dynamic> ? body['code'] as String? : null;
    final message = body is Map<String, dynamic>
        ? body['message'] as String?
        : null;

    return switch (status) {
      400 => BadRequest(ApiErrorCode.fromWire(code), message),
      422 => UnprocessableEntity(ApiErrorCode.fromWire(code), message),
      401 => const Unauthorized(),
      403 => Forbidden(ApiErrorCode.fromWire(code), message),
      404 => const NotFound(),
      409 => Conflict(ApiErrorCode.fromWire(code), message),
      429 => const TooManyRequests(),
      >= 500 => const ServerError(),
      _ => UnexpectedError(message ?? 'HTTP $status'),
    };
  }

  /// The API's error code, where the response carried one.
  ApiErrorCode get code => ApiErrorCode.unknown;
}

/// No usable connection, or the host could not be reached.
class NoInternetConnection extends NetworkException {
  const NoInternetConnection();
}

/// The request did not complete in time.
class RequestTimeout extends NetworkException {
  const RequestTimeout();
}

/// The request was cancelled before it completed.
class RequestCancelled extends NetworkException {
  const RequestCancelled();
}

/// The TLS certificate did not validate.
class BadCertificate extends NetworkException {
  const BadCertificate();
}

/// 400 / 422 — the request was rejected as invalid.
class BadRequest extends NetworkException {
  const BadRequest(this.code, this.message);

  @override
  final ApiErrorCode code;
  final String? message;
}

/// 401 — the token is missing, expired or rejected. The app signs the user out.
class Unauthorized extends NetworkException {
  const Unauthorized();
}

/// 403 — authenticated, but not allowed to touch this shop or booking.
class Forbidden extends NetworkException {
  const Forbidden(this.code, this.message);

  @override
  final ApiErrorCode code;
  final String? message;
}

/// 404 — no such resource.
class NotFound extends NetworkException {
  const NotFound();
}

/// 409 — the state changed underneath us; `SLOT_TAKEN` is the one that matters.
class Conflict extends NetworkException {
  const Conflict(this.code, this.message);

  @override
  final ApiErrorCode code;
  final String? message;
}

/// 429 — rate limited.
class TooManyRequests extends NetworkException {
  const TooManyRequests();
}

/// 5xx.
class ServerError extends NetworkException {
  const ServerError();
}

/// 422 — the request was understood but the data is incomplete.
///
/// Separate from [BadRequest] because the app reacts differently: a 400 is a
/// bug to report, while a 422 from `POST /shops/me/publish` is the owner
/// having missed a step, and the wizard jumps them back to it.
class UnprocessableEntity extends NetworkException {
  const UnprocessableEntity(this.code, this.message);

  @override
  final ApiErrorCode code;

  final String? message;
}

/// Anything that didn't fit, including parse failures.
class UnexpectedError extends NetworkException {
  const UnexpectedError(this.detail);

  final String detail;
}
