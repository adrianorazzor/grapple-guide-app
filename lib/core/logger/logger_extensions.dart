import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/logger_provider.dart';
import 'app_logger.dart';

/// Extensions on [Ref] to provide easy access to the logger
extension LoggerRefExtension on Ref {
  /// Get the AppLogger instance
  AppLogger get logger => read(loggerProvider);
}

/// Extensions on [WidgetRef] to provide easy access to the logger
extension LoggerWidgetRefExtension on WidgetRef {
  /// Get the AppLogger instance
  AppLogger get logger => read(loggerProvider);
} 