import 'package:dio/dio.dart';
import 'dio_client.dart';
import '../storage/secure_storage.dart';

class AuthInterceptor extends Interceptor {
  final Dio _dio;
  final SecureStorage _storage;

  AuthInterceptor(this._dio, this._storage);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers['Accept-Language'] = DioClient.currentLanguage;

    if (_isPublicPath(options.path)) {
      return handler.next(options);
    }

    final accessToken = await _storage.getAccessToken();
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final refreshed = await _refreshToken();
      if (refreshed) {
        try {
          final response = await _retryRequest(err.requestOptions);
          return handler.resolve(response);
        } catch (_) {
          return handler.next(err);
        }
      }
      await _storage.clearAll();
    }

    handler.next(err);
  }

  bool _isPublicPath(String path) {
    const publicPaths = [
      '/auth/login',
      '/auth/signup',
      '/auth/social',
      '/auth/refresh',
    ];
    return publicPaths.any((p) => path.contains(p));
  }

  Future<bool> _refreshToken() async {
    try {
      final refreshToken = await _storage.getRefreshToken();
      if (refreshToken == null) return false;

      final response = await _dio.post(
        '/auth/refresh',
        data: {'refreshToken': refreshToken},
        options: Options(headers: {'Authorization': ''}),
      );

      if (response.statusCode == 200) {
        final payload = response.data;
        final data = payload is Map<String, dynamic>
            ? (payload['data'] as Map<String, dynamic>? ?? payload)
            : null;
        if (data == null) return false;

        await _storage.saveTokens(
          accessToken: data['accessToken'] as String,
          refreshToken: data['refreshToken'] as String,
        );
        return true;
      }
    } catch (_) {}
    return false;
  }

  Future<Response> _retryRequest(RequestOptions requestOptions) async {
    final accessToken = await _storage.getAccessToken();
    if (accessToken == null || accessToken.isEmpty) {
      throw DioException(
        requestOptions: requestOptions,
        type: DioExceptionType.unknown,
        error: 'Missing access token for retry',
      );
    }

    requestOptions.headers['Authorization'] = 'Bearer $accessToken';
    requestOptions.headers['Accept-Language'] = DioClient.currentLanguage;
    return _dio.fetch(requestOptions);
  }
}
