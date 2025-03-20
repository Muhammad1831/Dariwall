// lib/services/api/api_client.dart
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:ostad/constant/app_api.dart';
import 'package:ostad/constant/app_error_message.dart';
import 'package:ostad/constant/app_shared_preferences_key.dart';
import 'package:ostad/services/error_handler.dart';
import 'package:ostad/utils/app_shared_preferences.dart';

class ApiClient {
  late Dio _dio;
  final int _timeout = 10;

  final AppSharedPreferences _preferences;
  final Dio _authDio = Dio();

  ApiClient(this._preferences) {
    _initDio();
  }

  void _initDio() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppApi.baseUrl,
        connectTimeout: Duration(seconds: _timeout),
        receiveTimeout: Duration(seconds: _timeout),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _preferences.getAccessToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            try {
              final newToken = await _refreshToken();
              if (newToken != null) {
                final opts = error.requestOptions;
                opts.headers['Authorization'] = 'Bearer $newToken';
                final response = await _dio.fetch(opts);
                return handler.resolve(response);
              }
            } catch (e) {
              _preferences.clear();
            }
          }
          return handler.next(error);
        },
      ),
    );

    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
        ),
      );
    }
  }

  Future<String?> _refreshToken() async {
    try {
      final refreshToken = await _preferences.getRefreshToken();
      if (refreshToken == null) return null;

      final response = await _authDio.post(
        '${AppApi.baseUrl}${AppApi.loginRenew}',
        data: {AppSharedPreferencesKey.keyRefreshToken: refreshToken},
      );

      if (response.statusCode == 200) {
        final accessToken = response.data[AppSharedPreferencesKey.keyToken];
        final newRefreshToken = response.data[AppSharedPreferencesKey.keyRefreshToken];

        await _preferences.saveAccessToken(accessToken);
        await _preferences.saveRefreshToken(newRefreshToken);

        return accessToken;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      return await _dio.get(path, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw ErrorHandler.handleDioError(e);
    } catch (e) {
      throw AppException(
        message: AppErrorMessage.unknownError,
      );
    }
  }

  Future<Response> post(String path, {dynamic data}) async {
    try {
      return await _dio.post(path, data: data);
    } on DioException catch (e) {
      throw ErrorHandler.handleDioError(e);
    } catch (e) {
      throw AppException(
        message: AppErrorMessage.unknownError,
      );
    }
  }

  Future<Response> put(String path, {dynamic data}) async {
    try {
      return await _dio.put(path, data: data);
    } on DioException catch (e) {
      throw ErrorHandler.handleDioError(e);
    } catch (e) {
      throw AppException(
        message: AppErrorMessage.unknownError,
      );
    }
  }

  Future<Response> delete(String path) async {
    try {
      return await _dio.delete(path);
    } on DioException catch (e) {
      throw ErrorHandler.handleDioError(e);
    } catch (e) {
      throw AppException(
        message: AppErrorMessage.unknownError,
      );
    }
  }
}
