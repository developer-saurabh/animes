import 'package:dio/dio.dart';

class ApiError implements Exception {
  final String message;
  final int? statusCode;

  ApiError({required this.message, this.statusCode});

  factory ApiError.fromDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ApiError(message: 'Connection timeout');
      case DioExceptionType.sendTimeout:
        return ApiError(message: 'Request timeout');
      case DioExceptionType.receiveTimeout:
        return ApiError(message: 'Response timeout');
      case DioExceptionType.badResponse:
        return ApiError(
          message: error.response?.statusMessage ?? 'Bad response',
          statusCode: error.response?.statusCode,
        );
      case DioExceptionType.cancel:
        return ApiError(message: 'Request cancelled');
      case DioExceptionType.unknown:
      default:
        return ApiError(message: 'Something went wrong');
    }
  }

  @override
  String toString() => message;
}
