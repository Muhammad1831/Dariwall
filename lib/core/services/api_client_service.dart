import 'package:dio/dio.dart';
// import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter/foundation.dart';
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
  late Dio _dio;
  final int _timeout = 10;
  // final int _maxRetries = 3;
  // final Duration _retryDelay = const Duration(seconds: 2);

  final UtilsSharedPreferences _preferences;
  final Dio _refreshDio = Dio();
  

  ApiClientService(this._preferences) {
    _initDio();
  }

  void _initDio() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppApi.baseUrl,
        connectTimeout: Duration(seconds: _timeout),
        receiveTimeout: Duration(seconds: _timeout),
        sendTimeout: Duration(seconds: _timeout),
        contentType: 'application/json',
        responseType: ResponseType.json,
        headers: {
          'Accept-Language': 'fa',
        },
        validateStatus: (status) => status != null && status < 400,
      ),
    );

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
          final token = await _preferences.getAccessToken();
          if (token != null) {
            options.headers[AppKeys.keyAuthorization] = '${AppKeys.keyBearer} $token';
          }
          return handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401 &&
              error.requestOptions.path != AppApi.refreshPair) {
            try {
              final newToken = await _refreshToken();
              if (newToken != null) {
                final opts = error.requestOptions;
                opts.headers[AppKeys.keyAuthorization] = '${AppKeys.keyBearer} $newToken';
                final response = await _dio.fetch(opts);
                return handler.resolve(response);
              } else {
                await _logout();
                return handler.reject(
                  DioException(
                    requestOptions: error.requestOptions,
                    type: DioExceptionType.badResponse,
                  ),
                );
              }
            } catch (e) {
              await _logout();
              return handler.reject(
                DioException(
                  requestOptions: error.requestOptions,
                  type: DioExceptionType.badResponse,
                ),
              );
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
          requestHeader: true,
          responseHeader: true,
        ),
      );
    }
  }

  Future<String?> _refreshToken() async {
    try {
      final refreshToken = await _preferences.getRefreshToken();
      if (refreshToken == null) return null;

      final response = await _refreshDio.post(
        '${AppApi.baseUrl}${AppApi.refreshPair}',
        data: {AppSharedPreferencesKey.keyRefresh: refreshToken},
        options: Options(
          sendTimeout: Duration(seconds: _timeout),
          receiveTimeout: Duration(seconds: _timeout),
        ),
      );

      if (response.statusCode == 200 &&
          response.data[AppSharedPreferencesKey.keyAccess] != null &&
          response.data[AppSharedPreferencesKey.keyRefresh] != null) {
        final accessToken = response.data[AppSharedPreferencesKey.keyAccess];
        final newRefreshToken = response.data[AppSharedPreferencesKey.keyRefresh];
        await _preferences.saveAccessToken(accessToken);
        await _preferences.saveRefreshToken(newRefreshToken);

        return accessToken;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<void> _logout() async {
    await _preferences.clear();
    _dio.options.headers.remove(AppKeys.keyAuthorization);
    navigatorKey.currentContext?.goNamed(AppRouteName.welcome);
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    bool forceRefresh = false,
  }) async {
    try {
      // final options = Options(
      //   extra: {'refresh': forceRefresh},
      // );
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
