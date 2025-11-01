import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:engaz_task/app/core/errors/exceptions.dart';
import 'package:engaz_task/app/core/network/status_code.dart';

class AppInterceptors extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Add authorization token
    options.headers['token'] =
        'dc079f920655b1fa318449f94781bd364d15cbf598107842319260cc53c29e96';

    // Add language header
    options.headers['lang'] = 'en';

    // Only set Content-Type and Accept for non-multipart requests
    if (options.data is! FormData) {
      // Check if we want to send as form-encoded
      if (options.headers['Content-Type'] ==
          'application/x-www-form-urlencoded') {
        options.headers['Accept'] = 'application/json';
      } else {
        // Default to JSON
        options.headers['Content-Type'] = 'application/json';
        options.headers['Accept'] = 'application/json';
      }
    } else {
      // For multipart requests, let Dio handle Content-Type automatically
      options.headers['Accept'] = 'application/json';
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final statusCode = err.response?.statusCode ?? 0;

    // Handle network connectivity issues
    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.unknown) {
      log('Network connectivity issue detected: ${err.type}');
    }

    // Handle different status codes
    switch (statusCode) {
      case StatusCode.unauthorized:
        log('Unauthorized access');
      case StatusCode.forbidden:
        log('Forbidden access');
      case StatusCode.notFound:
        log('Resource not found');
      case StatusCode.conflict:
        log('Conflict - resource already exists');
      case StatusCode.internalServerError:
        log('Internal server error');
    }

    // Safely parse the message
    final data = err.response?.data;
    String message;

    if (data is Map<String, dynamic>) {
      final msg = data['message'] ?? data['error'];
      if (msg is String) {
        message = msg;
      } else if (msg is List) {
        message = msg.join('\n');
      } else {
        message = msg?.toString() ?? 'An error occurred';
      }
    } else if (data is List) {
      message = data.join('\n');
    } else if (data is String) {
      message = data;
    } else {
      message = 'An error occurred';
    }

    log('API Error: Status $statusCode, Message: $message');
    log('Response data: $data');

    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        error: ServerException(message, statusCode),
        response: err.response,
      ),
    );
  }
}
