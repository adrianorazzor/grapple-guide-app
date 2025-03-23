import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'dart:io' show Platform;

import '../logger/logger.dart';

class ApiClient {
  late final Dio _dio;
  final AppLogger _logger = AppLogger();
  
  // Get the appropriate base URL based on platform
  static String get baseUrl {
    // Running on a physical device or emulator
    if (!kIsWeb) {
      if (Platform.isAndroid) {
        // Android emulator uses 10.0.2.2 to access host's localhost
        return 'http://10.0.2.2:8080/api';
      } else if (Platform.isIOS) {
        // iOS simulator uses localhost
        return 'http://localhost:8080/api';
      }
    }
    // Default fallback
    return 'http://localhost:8080/api';
  }
  
  ApiClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    
    // Add DioLogger in debug mode
    if (kDebugMode) {
      DioLogger(
        logger: _logger,
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        logLevel: LogLevel.debug,
      ).addToDio(_dio);
    }
  }
  
  // Generic GET method
  Future<dynamic> get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      _logger.d('GET request to: $path');
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      return _handleError(e);
    }
  }
  
  // Generic POST method
  Future<dynamic> post(String path, {dynamic data}) async {
    try {
      _logger.d('POST request to: $path');
      final response = await _dio.post(
        path,
        data: data,
      );
      return response.data;
    } on DioException catch (e) {
      return _handleError(e);
    }
  }
  
  // Generic PUT method
  Future<dynamic> put(String path, {dynamic data}) async {
    try {
      _logger.d('PUT request to: $path');
      final response = await _dio.put(
        path,
        data: data,
      );
      return response.data;
    } on DioException catch (e) {
      return _handleError(e);
    }
  }
  
  // Generic DELETE method
  Future<dynamic> delete(String path) async {
    try {
      _logger.d('DELETE request to: $path');
      final response = await _dio.delete(path);
      return response.data;
    } on DioException catch (e) {
      return _handleError(e);
    }
  }
  
  // Error handling
  dynamic _handleError(DioException error) {
    String errorMessage;
    
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        errorMessage = 'Connection timeout';
        break;
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final responseData = error.response?.data;
        final serverError = responseData?['message'] ?? 'Unknown error occurred';
        errorMessage = 'Server error: $statusCode - $serverError';
        break;
      case DioExceptionType.cancel:
        errorMessage = 'Request cancelled';
        break;
      default:
        errorMessage = 'Network error occurred: ${error.message}';
        break;
    }
    
    _logger.e('API Error: $errorMessage', error, error.stackTrace);
    throw errorMessage;
  }
} 