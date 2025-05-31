import 'dart:async';

import 'package:dariwall/core/di/locator_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
// import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dariwall/core/constant/app_api.dart';
import 'package:dariwall/core/constant/app_message.dart';
import 'package:dariwall/core/constant/app_keys.dart';
import 'package:dariwall/core/constant/app_shared_preferences_key.dart';
import 'package:dariwall/core/route/app_route_name.dart';
import 'package:dariwall/core/services/error_handler_service.dart';
import 'package:dariwall/core/utils/utils_shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:synchronized/synchronized.dart';
// import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class ApiClientService {
  final Dio _dio;
  final int _timeout = 15;
  final Dio _refreshDio = Dio();
  // final int _maxRetries = 3;
  // final Duration _retryDelay = const Duration(seconds: 2);

  final UtilsSharedPreferences _preferences;
  bool _isRefreshing = false;
  final List<Completer<void>> _refreshCompleters = [];

  // کوکی برای جلوگیری از مسابقه شرطی
  final _refreshLock = Lock();

  ApiClientService(this._dio, this._preferences) {
    _initDio();
  }

  bool _isTokenExpired(String? token) {
    if (token == null || token.isEmpty) return true;
    try {
      return JwtDecoder.isExpired(token);
    } catch (e) {
      debugPrint('Token parsing error: $e');
      return true;
    }
  }

  void _initDio() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          try {
            final token = _preferences.getAccessToken();

            if (token == null) {
              return handler.next(options);
            }

            if (_isTokenExpired(token)) {
              debugPrint('Token expired, attempting refresh...');
              await _refreshLock.synchronized(() async {
                if (_isTokenExpired(_preferences.getAccessToken())) {
                  final newToken = await _refreshToken();
                  if (newToken == null) {
                    await _logout();
                    return handler.next(options);
                  }
                }
              });
            }

            options.headers[AppKeys.keyAuthorization] =
                '${AppKeys.keyBearer} ${_preferences.getAccessToken()}';
            return handler.next(options);
          } catch (e) {
            debugPrint('Request interceptor error: $e');
            return handler.next(options);
          }
        },
        onError: (error, handler) async {
          debugPrint('API Error: ${error.type} - ${error.message}');

          // فقط برای خطاهای 401 که مربوط به مسیر تازه‌سازی نیستند
          if (error.response?.statusCode == 401 &&
              error.requestOptions.path != AppApi.refreshPair) {
            await _refreshLock.synchronized(() async {
              if (!_isRefreshing) {
                _isRefreshing = true;
                try {
                  final newToken = await _refreshToken();

                  if (newToken != null) {
                    final opts = error.requestOptions;
                    opts.headers[AppKeys.keyAuthorization] = '${AppKeys.keyBearer} $newToken';

                    try {
                      final response = await _dio.fetch(opts..cancelToken = null);
                      return handler.resolve(response);
                    } on DioException catch (retryError) {
                      debugPrint('Retry failed: ${retryError.message}');
                      return handler.next(retryError);
                    }
                  } else {
                    await _logout();
                    return handler.next(error);
                  }
                } catch (refreshError) {
                  debugPrint('Refresh failed: $refreshError');
                  await _logout();
                  return handler.next(error);
                } finally {
                  _isRefreshing = false;
                }
              } else {
                // اگر در حال تازه‌سازی هستیم، صبر می‌کنیم
                final completer = Completer<void>();
                _refreshCompleters.add(completer);
                await completer.future;

                // پس از تازه‌سازی، درخواست را دوباره امتحان می‌کنیم
                try {
                  final opts = error.requestOptions;
                  opts.headers[AppKeys.keyAuthorization] =
                      '${AppKeys.keyBearer} ${_preferences.getAccessToken()}';
                  final response = await _dio.fetch(opts..cancelToken = null);
                  return handler.resolve(response);
                } catch (e) {
                  return handler.next(error);
                }
              }
            });
          }

          // برای سایر خطاها
          return handler.next(error);
        },
      ),
    );

    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
        requestHeader: true,
        responseHeader: true,
      ));
    }
  }

  Future<String?> _refreshToken() async {
    try {
      final refreshToken = _preferences.getRefreshToken();

      if (refreshToken == null || refreshToken.isEmpty || _isTokenExpired(refreshToken)) {
        debugPrint('Refresh token is invalid or expired');
        return null;
      }

      final response = await _refreshDio.post(
        '${AppApi.baseUrl}${AppApi.refreshPair}',
        data: {AppSharedPreferencesKey.keyRefresh: refreshToken},
        options: Options(
          headers: {
            'Accept-Language': 'fa',
            'Content-Type': 'application/json',
          },
          sendTimeout: Duration(seconds: _timeout),
          receiveTimeout: Duration(seconds: _timeout),
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final accessToken = response.data[AppSharedPreferencesKey.keyAccess] as String?;
        final newRefreshToken = response.data[AppSharedPreferencesKey.keyRefresh] as String?;

        if (accessToken == null || newRefreshToken == null) {
          debugPrint('Invalid token response format');
          return null;
        }

        await _preferences.setAccessToken(accessToken);
        await _preferences.setRefreshToken(newRefreshToken);

        // اطلاع‌رسانی به تمام درخواست‌های در انتظار
        for (final completer in _refreshCompleters) {
          completer.complete();
        }
        _refreshCompleters.clear();

        return accessToken;
      }

      debugPrint('Refresh failed with status: ${response.statusCode}');
      return null;
    } on DioException catch (e) {
      debugPrint('Refresh token error: ${e.message}');
      if (e.response?.statusCode == 401) {
        await _logout();
      }
      return null;
    } catch (e) {
      debugPrint('Unexpected refresh error: $e');
      return null;
    }
  }

  Future<void> _logout() async {
    LocatorService.reset();
    navigatorKey.currentContext?.goNamed(AppRouteName.welcome);
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.get(
        path,
        queryParameters: queryParameters,
      );
    } on DioException catch (e) {
      throw ErrorHandlerService.handleDioError(e);
    } catch (e) {
      throw AppException(message: AppMessage.unknownError);
    }
  }

  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
      );
    } on DioException catch (e) {
      throw ErrorHandlerService.handleDioError(e);
    }
  }

  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
      );
    } on DioException catch (e) {
      throw ErrorHandlerService.handleDioError(e);
    } catch (e) {
      throw AppException(message: AppMessage.unknownError);
    }
  }

  Future<Response> delete(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.delete(
        path,
        queryParameters: queryParameters,
      );
    } on DioException catch (e) {
      throw ErrorHandlerService.handleDioError(e);
    } catch (e) {
      throw AppException(message: AppMessage.unknownError);
    }
  }

  Future<Response> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
      );
    } on DioException catch (e) {
      throw ErrorHandlerService.handleDioError(e);
    } catch (e) {
      throw AppException(message: AppMessage.unknownError);
    }
  }

  Future<Response> download(
    String urlPath,
    String savePath, {
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.download(
        urlPath,
        savePath,
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken,
        queryParameters: queryParameters,
      );
    } on DioException catch (e) {
      throw ErrorHandlerService.handleDioError(e);
    } catch (e) {
      throw AppException(message: AppMessage.unknownError);
    }
  }
}
