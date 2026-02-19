import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'auth_interceptor.dart';
import '../storage/secure_storage.dart';

class DioClient {
  DioClient._();

  static Dio? _instance;
  static String _currentLanguage = 'ko';

  static Dio get instance {
    _instance ??= _createDio();
    return _instance!;
  }

  static const String _devBaseUrl = 'http://10.0.2.2:8080/api/v1';
  static const String _iosDevBaseUrl = 'http://localhost:8080/api/v1';
  static const String _prodBaseUrl = 'https://api.sayvly.com/api/v1';

  static String get currentLanguage => _currentLanguage;

  static void setLanguage(String languageCode) {
    _currentLanguage = languageCode.startsWith('en') ? 'en' : 'ko';
    final dio = _instance;
    if (dio != null) {
      dio.options.headers['Accept-Language'] = _currentLanguage;
    }
  }

  static Dio _createDio() {
    final baseUrl = kDebugMode
        ? (Platform.isIOS ? _iosDevBaseUrl : _devBaseUrl)
        : _prodBaseUrl;

    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Accept-Language': _currentLanguage,
        },
      ),
    );

    dio.interceptors.addAll([
      AuthInterceptor(dio, SecureStorage()),
      if (kDebugMode) _LogInterceptor(),
    ]);

    return dio;
  }

  static void reset() {
    _instance = null;
  }
}

class _LogInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('[REQUEST] ${options.method} ${options.uri}');
    debugPrint('Headers: ${options.headers}');
    if (options.data != null) debugPrint('Body: ${options.data}');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('[RESPONSE] ${response.statusCode} ${response.requestOptions.uri}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint('[ERROR] ${err.type} ${err.requestOptions.uri}');
    debugPrint('Message: ${err.message}');
    handler.next(err);
  }
}
