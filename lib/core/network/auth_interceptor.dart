import 'package:dio/dio.dart';
import '../storage/secure_storage.dart';

/// 인증 인터셉터
/// Access Token 자동 추가 및 토큰 갱신 처리
class AuthInterceptor extends Interceptor {
  final Dio _dio;
  final SecureStorage _storage;

  AuthInterceptor(this._dio, this._storage);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // 인증이 필요없는 경로 스킵
    if (_isPublicPath(options.path)) {
      return handler.next(options);
    }

    // Access Token 가져오기
    final accessToken = await _storage.getAccessToken();
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // 401 Unauthorized 처리
    if (err.response?.statusCode == 401) {
      final refreshed = await _refreshToken();
      if (refreshed) {
        // 토큰 갱신 성공 시 원래 요청 재시도
        try {
          final response = await _retryRequest(err.requestOptions);
          return handler.resolve(response);
        } catch (e) {
          return handler.next(err);
        }
      } else {
        // 토큰 갱신 실패 시 로그아웃 처리 필요
        await _storage.clearAll();
      }
    }

    handler.next(err);
  }

  /// 인증이 필요없는 공개 경로 확인
  bool _isPublicPath(String path) {
    const publicPaths = [
      '/auth/login',
      '/auth/signup',
      '/auth/social-login',
      '/auth/refresh',
    ];
    return publicPaths.any((p) => path.contains(p));
  }

  /// 토큰 갱신
  Future<bool> _refreshToken() async {
    try {
      final refreshToken = await _storage.getRefreshToken();
      if (refreshToken == null) return false;

      final response = await _dio.post(
        '/auth/refresh',
        data: {'refreshToken': refreshToken},
        options: Options(
          headers: {'Authorization': ''},
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        await _storage.saveTokens(
          accessToken: data['accessToken'],
          refreshToken: data['refreshToken'],
        );
        return true;
      }
    } catch (e) {
      // 토큰 갱신 실패
    }
    return false;
  }

  /// 요청 재시도
  Future<Response> _retryRequest(RequestOptions requestOptions) async {
    final accessToken = await _storage.getAccessToken();
    requestOptions.headers['Authorization'] = 'Bearer $accessToken';

    return _dio.fetch(requestOptions);
  }
}
