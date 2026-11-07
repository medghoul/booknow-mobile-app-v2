import 'package:booknow_mobile/core/config/app_config.dart';
import 'package:logger/logger.dart';

/// Thin wrapper over `logger` so the rest of the app never constructs one.
///
/// Logging is off in production: request and response bodies carry customer
/// names, phone numbers and booking details, and nothing here should reach a
/// release build's console.
abstract final class AppLogger {
  static final Logger _logger = Logger(
    filter: _AppLogFilter(),
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 8,
      lineLength: 100,
      printEmojis: false,
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
  );

  static void debug(dynamic message) => _logger.d(message);

  static void info(dynamic message) => _logger.i(message);

  static void warning(dynamic message) => _logger.w(message);

  static void error(dynamic message, [Object? error, StackTrace? stackTrace]) =>
      _logger.e(message, error: error, stackTrace: stackTrace);
}

class _AppLogFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) => !AppConfig.isProduction;
}
