import 'package:logger/logger.dart';

import 'logger_config.dart';

/// A wrapper around the Logger package that provides a centralized logging system
/// for the entire application. This class follows the singleton pattern to ensure
/// only one instance exists throughout the app.
class AppLogger {
  static final AppLogger _instance = AppLogger._internal();
  late final Logger _logger;
  late LoggerConfig _config;

  /// Factory constructor to return the singleton instance
  factory AppLogger() => _instance;

  /// Private constructor used by the singleton pattern
  AppLogger._internal() {
    // Default to development configuration
    _config = LoggerConfig.development();
    _initLogger();
  }

  /// Initialize the logger with the current configuration
  void _initLogger() {
    _logger = Logger(
      printer: _config.getPrinter(),
      filter: _config.getFilter(),
    );
  }

  /// Configure the logger with specific settings
  void configure(LoggerConfig config) {
    _config = config;
    _initLogger();
  }

  /// Log a trace message (formerly verbose)
  void t(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.t(message, error: error, stackTrace: stackTrace);
  }

  /// Log a debug message
  void d(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.d(message, error: error, stackTrace: stackTrace);
  }

  /// Log an info message
  void i(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.i(message, error: error, stackTrace: stackTrace);
  }

  /// Log a warning message
  void w(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.w(message, error: error, stackTrace: stackTrace);
  }

  /// Log an error message
  void e(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  /// Log a critical error message
  void wtf(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.f(message, error: error, stackTrace: stackTrace);
  }
} 