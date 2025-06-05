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

  final UtilsSharedPreferences _preferences;

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
                try {
                  await _refreshToken();
                } on DioException catch (refreshError) {
                  debugPrint('Refresh failed: $refreshError');
                  if (refreshError.response!.statusCode == 401) {
                    await _logout();
                  }
                  return handler.reject(refreshError);
                } // if (newToken == null) {
                // await _logout();
                // if (!handler.isCompleted) {
                //   return handler.reject(DioException(requestOptions: options));
                // }
                // }
              });
            }

            options.headers[AppKeys.keyAuthorization] =
                '${AppKeys.keyBearer} ${_preferences.getAccessToken()}';
            if (!handler.isCompleted) {
              return handler.next(options);
            }
          } catch (e) {
            debugPrint('Request interceptor error: $e');
            if (!handler.isCompleted) {
              return handler.next(options);
            }
          }
        },
        onError: (error, handler) async {
          debugPrint('API Error: ${error.type} - ${error.message}');

          // فقط برای خطاهای 401 که مربوط به مسیر تازه‌سازی نیستند
          if (error.response?.statusCode == 401 &&
              error.requestOptions.path != AppApi.refreshPair) {
            await _refreshLock.synchronized(() async {
              try {
                final newToken = await _refreshToken();

                // if (newToken != null) {
                final opts = error.requestOptions;
                opts.headers[AppKeys.keyAuthorization] = '${AppKeys.keyBearer} $newToken';

                try {
                  final response = await _dio.fetch(opts);
                  return handler.resolve(response);
                } on DioException catch (retryError) {
                  debugPrint('Retry failed: ${retryError.message}');
                  handler.reject(retryError);
                  return;
                }
                // } else {
                //   await _logout();
                //   return handler.reject(error);
                //   // return handler.next(error);
                // }
              } on DioException catch (refreshError) {
                debugPrint('Refresh failed: $refreshError');
                if (refreshError.response!.statusCode == 401) {
                  await _logout();
                }
                return handler.reject(error);
                // return handler.next(error);
              } catch (e) {
                return handler.reject(error);
              }
            });
          }

          // برای سایر خطاها
          if (!handler.isCompleted) {
            return handler.next(error);
          }
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

  Future<String> _refreshToken() async {
    // int retryCount = 0;
    // DioException? lastError;

    // while (retryCount < _maxRefreshRetries) {
    try {
      final refreshToken = _preferences.getRefreshToken();

      // if (refreshToken == null || refreshToken.isEmpty || _isTokenExpired(refreshToken)) {
      //   debugPrint('Refresh token is invalid or expired');
      //   return null;
      // }

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

      // if (response.statusCode == 200 || response.statusCode == 201) {
      final accessToken = response.data[AppSharedPreferencesKey.keyAccess];
      final newRefreshToken = response.data[AppSharedPreferencesKey.keyRefresh];

      await _preferences.setAccessToken(accessToken);
      await _preferences.setRefreshToken(newRefreshToken);

      return accessToken;
      // }

      // debugPrint('Refresh failed with status: ${response.statusCode}');
      // } on DioException catch (e) {
      // retryCount++;
      // lastError = e;
      // debugPrint('Refresh token attempt $retryCount failed: ${e.message}');

      // If it's a 401, no point in retrying
      // if (e.response?.statusCode == 401) {
      //   rethrow;
      // }

      // Exponential backoff
      // await Future.delayed(Duration(seconds: retryCount * 5));
    } catch (e) {
      rethrow;
      // retryCount++;
      // debugPrint('Unexpected refresh error attempt $retryCount: $e');
      // await Future.delayed(Duration(seconds: retryCount * 5));
    }
    // }

    // If we got here, all retries failed
    // if (lastError?.response?.statusCode == 401) {
    //   return null;
    // }

    // return null;
    // on DioException catch (e) {
    //   debugPrint('Refresh token error: ${e.message}');
    //   if (e.response?.statusCode == 401) {
    //     await _logout();
    //   }
    //   return null;
    // } catch (e) {
    //   debugPrint('Unexpected refresh error: $e');
    //   return null;
    // }
  }

  Future<void> _logout() async {
    LocatorService.reset();

    // 2. لغو تمام درخواست‌های جاری بدون بستن Dio
    _dio.interceptors.clear();
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
