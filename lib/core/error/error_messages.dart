import 'package:booknow_mobile/core/error/api_error_code.dart';
import 'package:booknow_mobile/core/error/network_exception.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:flutter/widgets.dart';

/// Turns a [NetworkException] into copy a user can act on.
///
/// The API's own `message` is never shown: it is written for developers and is
/// not guaranteed to be in the user's language. The `code` is what the app
/// keys on, and everything it doesn't recognise falls back to the generic
/// message rather than leaking an identifier.
extension NetworkExceptionMessage on NetworkException {
  String localized(BuildContext context) {
    final t = context.t;

    // A recognised business code is more specific than the HTTP status, so it
    // wins wherever the response carried one.
    final byCode = switch (code) {
      ApiErrorCode.slotTaken => t.errors.slotTaken,
      ApiErrorCode.holdExpired => t.errors.holdExpired,
      ApiErrorCode.leadTimeTooShort => t.errors.leadTimeTooShort,
      ApiErrorCode.outsideBookingHorizon => t.errors.outsideBookingHorizon,
      ApiErrorCode.shopClosed => t.errors.shopClosed,
      ApiErrorCode.cancellationWindowPassed =>
        t.errors.cancellationWindowPassed,
      ApiErrorCode.slotNotBookable => t.errors.slotNotBookable,
      ApiErrorCode.serviceNotAvailable => t.errors.serviceNotAvailable,
      ApiErrorCode.invalidBlock => t.errors.invalidBlock,
      ApiErrorCode.providerLimitReached => t.errors.providerLimitReached,
      ApiErrorCode.visitMoved => t.errors.visitMoved,
      ApiErrorCode.suggestionGone => t.errors.suggestionGone,
      ApiErrorCode.providerInUse => t.errors.providerInUse,
      ApiErrorCode.defaultProvider => t.errors.defaultProvider,
      ApiErrorCode.providerNotAvailable => t.errors.providerNotAvailable,
      _ => null,
    };
    if (byCode != null) return byCode;

    return switch (this) {
      NoInternetConnection() => t.errors.noConnection,
      RequestTimeout() => t.errors.timeout,
      Unauthorized() => t.errors.unauthorized,
      Forbidden() => t.errors.forbidden,
      NotFound() => t.errors.notFound,
      TooManyRequests() => t.errors.tooManyRequests,
      ServerError() => t.errors.server,
      UnprocessableEntity() => t.errors.shopIncomplete,
      BadRequest() ||
      Conflict() ||
      RequestCancelled() ||
      BadCertificate() ||
      UnexpectedError() => t.errors.generic,
    };
  }
}
