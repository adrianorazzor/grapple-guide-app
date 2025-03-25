import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logger/logger.dart';
import 'logger_state.dart';

class LoggerCubit extends Cubit<LoggerState> {
  final AppLogger _logger;
  
  LoggerCubit({required AppLogger logger}) 
      : _logger = logger,
        super(LoggerInitial());
        
  void log(String message) {
    _logger.i(message);
  }
  
  void logError(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error, stackTrace);
  }
  
  void logWarning(String message) {
    _logger.w(message);
  }
  
  void logDebug(String message) {
    _logger.d(message);
  }
} 