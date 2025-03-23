import 'package:logger/logger.dart';

/// Different logging environments that can be configured
enum LogEnvironment {
  /// Development environment - verbose logging
  development,
  
  /// Production environment - filtered logging
  production,
  
  /// Testing environment - controlled logging
  testing,
}

/// Configuration class for the AppLogger
class LoggerConfig {
  /// Current active environment
  final LogEnvironment environment;
  
  /// Whether to print emoji icons in logs
  final bool printEmojis;
  
  /// Whether to print colors in logs
  final bool colors;
  
  /// Maximum line length for logs
  final int lineLength;
  
  /// Number of method calls to display in a regular log
  final int methodCount;
  
  /// Number of method calls to display when an error occurs
  final int errorMethodCount;

  /// Creates a logger configuration
  const LoggerConfig({
    this.environment = LogEnvironment.development,
    this.printEmojis = true,
    this.colors = true,
    this.lineLength = 120,
    this.methodCount = 2,
    this.errorMethodCount = 8,
  });
  
  /// Creates a development configuration
  factory LoggerConfig.development() => const LoggerConfig(
        environment: LogEnvironment.development,
      );
  
  /// Creates a production configuration
  factory LoggerConfig.production() => const LoggerConfig(
        environment: LogEnvironment.production,
        printEmojis: false,
        methodCount: 0,
      );
  
  /// Creates a testing configuration
  factory LoggerConfig.testing() => const LoggerConfig(
        environment: LogEnvironment.testing,
        printEmojis: false,
        colors: false,
      );
      
  /// Get the appropriate filter based on the environment
  Level get minimumLevel {
    switch (environment) {
      case LogEnvironment.development:
        return Level.trace;
      case LogEnvironment.production:
        return Level.warning;
      case LogEnvironment.testing:
        return Level.debug;
    }
  }
  
  /// Get the logger filter based on the environment
  LogFilter getFilter() {
    switch (environment) {
      case LogEnvironment.development:
        return DevelopmentFilter();
      case LogEnvironment.production:
        return ProductionFilter();
      case LogEnvironment.testing:
        return ProductionFilter();
    }
  }
  
  /// Get the printer implementation based on configuration
  LogPrinter getPrinter() {
    return PrettyPrinter(
      methodCount: methodCount,
      errorMethodCount: errorMethodCount,
      lineLength: lineLength,
      colors: colors,
      printEmojis: printEmojis,
    );
  }
} 