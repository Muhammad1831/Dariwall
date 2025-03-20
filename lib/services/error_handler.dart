import 'dart:io';
import 'package:dio/dio.dart';
import 'package:ostad/constant/app_error_message.dart';

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

class ErrorHandler {
  static AppException handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return const AppException(
          message: AppErrorMessage.tryAgain,
        );

      case DioExceptionType.badCertificate:
      case DioExceptionType.connectionError:
      case DioExceptionType.cancel:
        return const AppException(
          message: AppErrorMessage.networkError,
        );

      case DioExceptionType.badResponse:
        return _handleErrorResponse(
          error.response?.statusCode,
          error.response?.data,
        );

      case DioExceptionType.unknown:
        if (error.error is SocketException) {
          return const AppException(
            message: AppErrorMessage.networkError,
          );
        }
        return AppException(
          message: AppErrorMessage.unknownError,
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
                    : AppErrorMessage.invalidInput,
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
          message: AppErrorMessage.invalidInput,
          statusCode: 400,
        );

      case 401:
        return const AppException(
          message: AppErrorMessage.authError,
        );

      case 403:
        return const AppException(
          message: AppErrorMessage.unknownError,
        );

      case 404:
        return const AppException(
          message: AppErrorMessage.unknownError,
        );

      case 429:
        return const AppException(
          message: AppErrorMessage.tooManyRequests,
        );

      case 500:
      case 501:
      case 502:
      case 503:
        return const AppException(
          message: AppErrorMessage.serverError,
        );

      default:
        return AppException(
          message: AppErrorMessage.unknownError,
        );
    }
  }
}
