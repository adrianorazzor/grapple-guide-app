import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'app_logger.dart';

/// A custom Dio logger that integrates pretty_dio_logger with our AppLogger
class DioLogger {
  final AppLogger _logger;
  final bool enabled;
  final bool requestHeader;
  final bool requestBody;
  final bool responseHeader;
  final bool responseBody;
  final bool error;
  final bool compact;
  final int maxWidth;
  final LogLevel logLevel;

  /// Creates a new DioLogger with customizable configuration
  DioLogger({
    AppLogger? logger,
    this.enabled = true,
    this.requestHeader = true,
    this.requestBody = true,
    this.responseHeader = false,
    this.responseBody = true,
    this.error = true,
    this.compact = true,
    this.maxWidth = 90,
    this.logLevel = LogLevel.debug,
  }) : _logger = logger ?? AppLogger();

  /// Adds the logger to the provided Dio instance
  void addToDio(Dio dio) {
    if (!enabled || !kDebugMode) return;

    // Add pretty_dio_logger for console output
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: requestHeader,
        requestBody: requestBody,
        responseHeader: responseHeader,
        responseBody: responseBody,
        error: error,
        compact: compact,
        maxWidth: maxWidth,
        logPrint: _customLogPrint,
      ),
    );

    // Add a custom interceptor for AppLogger integration
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          _logger.d(
            'API REQUEST [${options.method}] ${options.uri}',
            options.data,
          );
          return handler.next(options);
        },
        onResponse: (response, handler) {
          _logger.d(
            'API RESPONSE [${response.statusCode}] ${response.requestOptions.uri}',
            response.data,
          );
          return handler.next(response);
        },
        onError: (error, handler) {
          _logger.e(
            'API ERROR [${error.response?.statusCode}] ${error.requestOptions.uri}',
            error,
            error.stackTrace,
          );
          return handler.next(error);
        },
      ),
    );
  }

  /// Custom log printer that routes logs to our AppLogger
  void _customLogPrint(Object object) {
    switch (logLevel) {
      case LogLevel.debug:
        _logger.d(object.toString());
        break;
      case LogLevel.info:
        _logger.i(object.toString());
        break;
      case LogLevel.warning:
        _logger.w(object.toString());
        break;
      case LogLevel.error:
        _logger.e(object.toString());
        break;
    }
  }
}

/// Log levels for the DioLogger
enum LogLevel {
  debug,
  info,
  warning,
  error,
} 