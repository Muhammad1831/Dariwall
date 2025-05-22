import 'package:dariwall/core/di/locator_service.dart';
import 'package:dio/dio.dart';
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

  ApiClientService(this._dio, this._preferences) {
    _initDio();
  }

  void _initDio() {
    // _dio = Dio(
    //   BaseOptions(
    //     baseUrl: AppApi.baseUrl,
    //     connectTimeout: Duration(seconds: _timeout),
    //     receiveTimeout: Duration(seconds: _timeout),
    //     sendTimeout: Duration(seconds: _timeout),
    //     contentType: 'application/json',
    //     responseType: ResponseType.json,
    //     headers: {
    //       'Accept-Language': 'fa',
    //     },
    //     validateStatus: (status) => status != null && status < 400,
    //   ),
    // );

    // Add retry interceptor
    // _dio.interceptors.add(
    //   RetryInterceptor(
    //     dio: _dio,
    //     retries: _maxRetries,
    //     retryDelays: List.generate(
    //       _maxRetries,
    //       (index) => _retryDelay * (index + 1),
    //     ),
    //   ),
    // );

    // Add cache interceptor
    // _dio.interceptors.add(
    //   DioCacheInterceptor(
    //     options: CacheOptions(
    //       store: MemCacheStore(),
    //       policy: CachePolicy.request,
    //       maxStale: const Duration(minutes: 5),
    //       priority: CachePriority.high,
    //       allowPostMethod: false,
    //     ),
    //   ),
    // );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = _preferences.getAccessToken();
          if (token != null) {
            options.headers[AppKeys.keyAuthorization] = '${AppKeys.keyBearer} $token';
          }
          return handler.next(options);
        },
        onError: (error, handler) async {
          debugPrint('---------------------called onError---------------------');
          debugPrint('StatusCode ${error.type} >>> ${error.message}');
          debugPrint('************************************');
          if (error.response?.statusCode == 401 &&
              error.requestOptions.path != AppApi.refreshPair) {
            debugPrint('---------------------enter refresh token---------------------');
            if (!_isRefreshing) {
              _isRefreshing = true;
              try {
                final newToken = await _refreshToken();
                if (newToken != null) {
                  final opts = error.requestOptions;
                  opts.headers[AppKeys.keyAuthorization] = '${AppKeys.keyBearer} $newToken';
                  try {
                    final response = await _dio.fetch(opts);
                    return handler.resolve(response);
                  } on DioException catch (retryError) {
                    debugPrint(
                        '--------------call api again after refreshToken have Error--------------');
                    debugPrint(retryError.toString());
                    return handler.next(retryError);
                  }
                } else {
                  debugPrint('--------------clearToken When newToken is Null--------------');
                  await _logout();
                  return handler.next(error);
                }
              } catch (refreshError) {
                debugPrint('--------------clearToken When refreshToken have Error--------------');
                debugPrint('--------------$refreshError--------------');
                if (error.response?.statusCode == 401) {
                  await _logout();
                }
                return handler.next(error);
              } finally {
                _isRefreshing = false;
                debugPrint('_isRefreshing Token : $_isRefreshing');
              }
            }
          }
          return handler.next(error);
        },
      ),
    );

    // if (kDebugMode) {
    //   _dio.interceptors.add(
    //     LogInterceptor(
    //       requestBody: true,
    //       responseBody: true,
    //       requestHeader: true,
    //       responseHeader: true,
    //     ),
    //   );
    // }
  }

  Future<String?> _refreshToken() async {
    try {
      final refreshToken = _preferences.getRefreshToken();
      if (refreshToken == null) return null;

      final response = await _refreshDio.post(
        '${AppApi.baseUrl}${AppApi.refreshPair}',
        data: {AppSharedPreferencesKey.keyRefresh: refreshToken},
        options: Options(
          sendTimeout: Duration(seconds: _timeout),
          receiveTimeout: Duration(seconds: _timeout),
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final accessToken = response.data[AppSharedPreferencesKey.keyAccess];
        final newRefreshToken = response.data[AppSharedPreferencesKey.keyRefresh];

        await _preferences.setAccessToken(accessToken);
        await _preferences.setRefreshToken(newRefreshToken);

        return accessToken;
      }
      return null;
    } catch (e) {
      rethrow;
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
