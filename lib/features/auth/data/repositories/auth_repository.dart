import 'package:dio/dio.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/storage/secure_storage.dart';
import '../../../../core/storage/local_storage.dart';
import '../../../../core/error/error_handler.dart';
import '../../../../core/error/error_code.dart';
import '../models/auth_request.dart';
import '../models/auth_response.dart';

/// 인증 관련 API 저장소
class AuthRepository {
  final Dio _dio;
  final SecureStorage _storage;
  LocalStorage? _localStorage;

  AuthRepository({Dio? dio, SecureStorage? storage, LocalStorage? localStorage})
    : _dio = dio ?? DioClient.instance,
      _storage = storage ?? SecureStorage(),
      _localStorage = localStorage;

  /// 회원가입
  /// POST /auth/signup
  Future<AuthResponse> signup(SignupRequest request) async {
    try {
      final response = await _dio.post('/auth/signup', data: request.toJson());

      final authResponse = AuthResponse.fromJson(response.data['data']);
      await _saveAuthData(authResponse);
      return authResponse;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// 로그인
  /// POST /auth/login
  Future<AuthResponse> login(LoginRequest request) async {
    try {
      final response = await _dio.post('/auth/login', data: request.toJson());

      final authResponse = AuthResponse.fromJson(response.data['data']);
      await _saveAuthData(authResponse);
      
      // 이메일 저장
      await _saveLastEmail(request.email);
      
      return authResponse;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// 소셜 로그인
  /// POST /auth/social
  Future<AuthResponse> socialLogin(SocialLoginRequest request) async {
    try {
      final response = await _dio.post('/auth/social', data: request.toJson());

      final authResponse = AuthResponse.fromJson(response.data['data']);
      await _saveAuthData(authResponse);
      return authResponse;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// 토큰 갱신
  /// POST /auth/refresh
  Future<AuthResponse> refreshToken() async {
    try {
      final refreshToken = await _storage.getRefreshToken();
      if (refreshToken == null) {
        throw AuthException('리프레시 토큰이 없습니다.');
      }

      final response = await _dio.post(
        '/auth/refresh',
        data: {'refreshToken': refreshToken},
      );

      final authResponse = AuthResponse.fromJson(response.data['data']);
      await _saveAuthData(authResponse);
      return authResponse;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// 로그아웃
  /// POST /auth/logout
  Future<void> logout() async {
    try {
      await _dio.post('/auth/logout');
    } catch (_) {
      // 로그아웃 API 실패해도 로컬 데이터는 삭제
    } finally {
      await _storage.clearAll();
      DioClient.reset();
    }
  }

  /// 로그인 여부 확인
  Future<bool> isLoggedIn() async {
    return await _storage.isLoggedIn();
  }

  /// 저장된 인증 데이터 가져오기
  Future<AuthResponse?> getStoredAuthData() async {
    final accessToken = await _storage.getAccessToken();
    final refreshToken = await _storage.getRefreshToken();
    final userIdStr = await _storage.getUserId();

    if (accessToken == null || refreshToken == null || userIdStr == null) {
      return null;
    }

    final userId = int.tryParse(userIdStr);
    if (userId == null) {
      return null;
    }

    return AuthResponse(
      userId: userId,
      accessToken: accessToken,
      refreshToken: refreshToken,
      expiresIn: 0, // 저장되지 않으므로 기본값 사용
    );
  }

  /// 인증 데이터 저장
  Future<void> _saveAuthData(AuthResponse response) async {
    await _storage.saveTokens(
      accessToken: response.accessToken,
      refreshToken: response.refreshToken,
    );
    await _storage.saveUserId(response.userId.toString());
  }

  /// 마지막 로그인 이메일 저장
  Future<void> _saveLastEmail(String email) async {
    _localStorage ??= await LocalStorage.getInstance();
    await _localStorage!.saveLastEmail(email);
  }

  /// 마지막 로그인 이메일 가져오기
  Future<String?> getLastEmail() async {
    _localStorage ??= await LocalStorage.getInstance();
    return _localStorage!.getLastEmail();
  }

  /// 에러 처리
  Exception _handleError(DioException e) {
    final appException = ErrorHandler.handle(e);
    
    // ServerException을 AuthException으로 변환
    if (appException is ServerException) {
      return AuthException(
        appException.userMessage,
        errorCode: appException.errorCode,
      );
    }
    
    // NetworkException을 AuthException으로 변환
    return AuthException(appException.userMessage);
  }
}

/// 인증 관련 예외
class AuthException implements Exception {
  final String message;
  final ErrorCode? errorCode;

  AuthException(this.message, {this.errorCode});

  @override
  String toString() => message;
}
