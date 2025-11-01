import 'package:dio/dio.dart';
import 'package:engaz_task/app/core/constants/app_endpoints.dart';
import 'package:engaz_task/app/core/errors/exceptions.dart';
import 'package:engaz_task/app/core/network/api_consumer.dart';
import 'package:engaz_task/app/core/network/interceptors.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@LazySingleton(as: ApiConsumer)
class DioConsumer implements ApiConsumer {
  DioConsumer({required this.client}) {
    client.options
      ..baseUrl = EndpointConstants.baseUrl
      ..responseType = ResponseType.json
      ..connectTimeout = const Duration(seconds: 90)
      ..receiveTimeout = const Duration(seconds: 90);

    client.interceptors.add(AppInterceptors());

    /// ✅ Logger interceptor
    client.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
      ),
    );
  }
  final Dio client;

  @override
  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await client.get<dynamic>(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (error) {
      throw _handleDioError(error);
    }
  }

  @override
  Future<dynamic> post(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await client.post<dynamic>(
        path,
        data: body,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (error) {
      throw _handleDioError(error);
    }
  }

  @override
  Future<dynamic> put(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await client.put<dynamic>(
        path,
        data: body,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (error) {
      throw _handleDioError(error);
    }
  }

  @override
  Future<dynamic> delete(String path, {Map<String, dynamic>? headers}) async {
    try {
      final response = await client.delete<dynamic>(
        path,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (error) {
      throw _handleDioError(error);
    }
  }

  @override
  Future<dynamic> postWithFile(
    String path, {
    Map<String, dynamic>? fields,
    Map<String, String>? filePaths,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final formData = await _createFormData(fields, filePaths);
      final response = await client.post<dynamic>(
        path,
        data: formData,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (error) {
      throw _handleDioError(error);
    }
  }

  @override
  Future<dynamic> putWithFile(
    String path, {
    Map<String, dynamic>? fields,
    Map<String, String>? filePaths,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final formData = await _createFormData(fields, filePaths);
      final response = await client.put<dynamic>(
        path,
        data: formData,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (error) {
      throw _handleDioError(error);
    }
  }

  Future<FormData> _createFormData(
    Map<String, dynamic>? fields,
    Map<String, String>? filePaths,
  ) async {
    final formData = FormData();

    if (fields != null) {
      fields.forEach((key, value) {
        formData.fields.add(MapEntry(key, value.toString()));
      });
    }

    if (filePaths != null) {
      for (final entry in filePaths.entries) {
        final file = await MultipartFile.fromFile(
          entry.value,
          filename: entry.value.split('/').last,
        );
        formData.files.add(MapEntry(entry.key, file));
      }
    }

    return formData;
  }

  AppException _handleDioError(DioException error) {
    final response = error.response;
    final statusCode = response?.statusCode ?? 0;

    final rawMessage = (response?.data as Map<String, dynamic>?)?['message'];
    String message;

    if (rawMessage is List) {
      message = rawMessage.join('\n');
    } else if (rawMessage is String) {
      message = rawMessage;
    } else {
      message = 'Unknown Error';
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const ServerException('Connection timeout - working offline', 0);

      case DioExceptionType.badResponse:
        return ServerException(message, statusCode);

      case DioExceptionType.badCertificate:
        return ServerException(
            'Bad certificate - please check your connection security',
            statusCode);

      case DioExceptionType.cancel:
        return ServerException('Request was cancelled', statusCode);

      case DioExceptionType.connectionError:
        return const ServerException(
            'No internet connection - working offline', 0);

      case DioExceptionType.unknown:
        // ignore: use_if_null_to_convert_nulls_to_bools
        if (error.message?.contains('SocketException') == true) {
          return const ServerException(
              'No internet connection - working offline', 0);
        }
        return ServerException('Unexpected error occurred', statusCode);
    }
  }
}
