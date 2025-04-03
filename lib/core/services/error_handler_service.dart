import 'dart:io';
import 'package:dio/dio.dart';
import 'package:ostad/core/constant/app_message.dart';

class AppException implements Exception {
  final String message;
  final int? statusCode;

  const AppException({
    required this.message,
    this.statusCode,
  });

  @override
  String toString() => message;
}

class ErrorHandlerService {
  static AppException handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return const AppException(
          message: AppMessage.tryAgain,
        );

      case DioExceptionType.badCertificate:
      case DioExceptionType.connectionError:
      case DioExceptionType.cancel:
        return const AppException(
          message: AppMessage.networkError,
        );

      case DioExceptionType.badResponse:
        return _handleErrorResponse(
          error.response?.statusCode,
          error.response?.data,
        );

      case DioExceptionType.unknown:
        if (error.error is SocketException) {
          return const AppException(
            message: AppMessage.networkError,
          );
        }
        return AppException(
          message: AppMessage.unknownError,
        );
    }
  }

  static AppException _handleErrorResponse(int? statusCode, dynamic data) {
    switch (statusCode) {
      case 400:
        if (data != null && data is Map) {
          if (data.containsKey('message')) {
            return AppException(
              message: data['message'].toString(),
              statusCode: statusCode,
            );
          } else if (data.containsKey('error')) {
            return AppException(
              message: data['error'].toString(),
              statusCode: statusCode,
            );
          } else if (data.containsKey('errors')) {
            final errors = data['errors'];
            if (errors is Map) {
              final errorMessages = <String>[];
              errors.forEach((key, value) {
                if (value is List) {
                  errorMessages.add('$key: ${value.first}');
                } else {
                  errorMessages.add('$key: ${value.toString()}');
                }
              });
              return AppException(
                message: errorMessages.isNotEmpty
                    ? errorMessages.join('\n')
                    : AppMessage.invalidInput,
                statusCode: statusCode,
              );
            } else if (errors is List && errors.isNotEmpty) {
              return AppException(
                message: errors.first.toString(),
                statusCode: statusCode,
              );
            }
          }
        }
        return AppException(
          message: AppMessage.invalidInput,
          statusCode: 400,
        );

      case 401:
        return const AppException(
          message: AppMessage.authError,
        );

      case 403:
        return const AppException(
          message: AppMessage.unknownError,
        );

      case 404:
        return const AppException(
          message: AppMessage.unknownError,
        );

      case 429:
        return const AppException(
          message: AppMessage.tooManyRequests,
        );

      case 500:
      case 501:
      case 502:
      case 503:
        return const AppException(
          message: AppMessage.serverError,
        );

      default:
        return AppException(
          message: AppMessage.unknownError,
        );
    }
  }
}
