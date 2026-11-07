import 'package:booknow_mobile/core/error/api_result.dart';
import 'package:booknow_mobile/core/error/network_exception.dart';
import 'package:booknow_mobile/core/services/logger/app_logger.dart';

extension ApiResultParsing on ApiResult<Map<String, dynamic>> {
  /// Reads a successful body into a model.
  ///
  /// The DTOs are built to tolerate a missing or oddly-typed field, so getting
  /// here at all means the body is not the shape the app was built against.
  /// That becomes a failure the UI can show, rather than an exception thrown
  /// out of a repository — which surfaces as a blank screen with no
  /// explanation — and rather than a silently empty model, which looks like
  /// working software right up until someone reads the data.
  ApiResult<T> parsed<T>(T Function(Map<String, dynamic> json) read) => fold(
    onSuccess: (body) {
      try {
        return ApiResult.success(read(body));
      } catch (error, stackTrace) {
        AppLogger.error(
          '[api] response body could not be read',
          error,
          stackTrace,
        );
        return ApiResult.failure(UnexpectedError('$error'));
      }
    },
    onFailure: ApiResult.failure,
  );
}
