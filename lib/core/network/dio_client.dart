import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'auth_interceptor.dart';
import '../storage/secure_storage.dart';

/// Dio HTTP 클라이언트 설정
class DioClient {
  DioClient._();

  static Dio? _instance;

  /// Dio 인스턴스 (싱글톤)
  static Dio get instance {
    _instance ??= _createDio();
    return _instance!;
  }

  /// 개발 환경 API URL
  static const String _devBaseUrl = 'http://10.0.2.2:8080/api/v1'; // Android 에뮬레이터
  static const String _iosDevBaseUrl = 'http://localhost:8080/api/v1'; // iOS 시뮬레이터
  static const String _prodBaseUrl = 'https://api.sayvly.com/api/v1';

  /// Dio 인스턴스 생성
  static Dio _createDio() {
    // 개발 모드: 플랫폼별 로컬 서버, 릴리즈 모드: 프로덕션 서버
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
        },
      ),
    );

    // 인터셉터 추가
    dio.interceptors.addAll([
      AuthInterceptor(dio, SecureStorage()),
      if (kDebugMode) _LogInterceptor(),
    ]);

    return dio;
  }

  /// Dio 인스턴스 리셋 (로그아웃 시 사용)
  static void reset() {
    _instance = null;
  }
}

/// 디버그용 로그 인터셉터
class _LogInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('┌────────────────────────────────────────────────────────');
    debugPrint('│ [REQUEST] ${options.method} ${options.uri}');
    debugPrint('│ Headers: ${options.headers}');
    if (options.data != null) {
      debugPrint('│ Body: ${options.data}');
    }
    debugPrint('└────────────────────────────────────────────────────────');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('┌────────────────────────────────────────────────────────');
    debugPrint('│ [RESPONSE] ${response.statusCode} ${response.requestOptions.uri}');
    debugPrint('│ Data: ${response.data}');
    debugPrint('└────────────────────────────────────────────────────────');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint('┌────────────────────────────────────────────────────────');
    debugPrint('│ [ERROR] ${err.type} ${err.requestOptions.uri}');
    debugPrint('│ Message: ${err.message}');
    if (err.response != null) {
      debugPrint('│ Response: ${err.response?.data}');
    }
    debugPrint('└────────────────────────────────────────────────────────');
    handler.next(err);
  }
}
