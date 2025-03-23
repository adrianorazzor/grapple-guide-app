import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../logger/logger.dart';

/// Provider that exposes the singleton AppLogger instance to the entire app
final loggerProvider = Provider<AppLogger>((ref) {
  return AppLogger();
}); 