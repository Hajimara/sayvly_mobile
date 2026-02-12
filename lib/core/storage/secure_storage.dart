import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// 보안 저장소 래퍼
/// Access Token, Refresh Token 등 민감한 정보 저장
class SecureStorage {
  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';
  static const _userIdKey = 'user_id';
  static const _onboardingSkippedKey = 'onboarding_skipped';

  final FlutterSecureStorage _storage;

  SecureStorage()
      : _storage = const FlutterSecureStorage(
          aOptions: AndroidOptions(
            encryptedSharedPreferences: true,
          ),
          iOptions: IOSOptions(
            accessibility: KeychainAccessibility.first_unlock_this_device,
          ),
        );

  // ============================================
  // Token 관리
  // ============================================

  /// Access Token 저장
  Future<void> saveAccessToken(String token) async {
    await _storage.write(key: _accessTokenKey, value: token);
  }

  /// Access Token 가져오기
  Future<String?> getAccessToken() async {
    return await _storage.read(key: _accessTokenKey);
  }

  /// Refresh Token 저장
  Future<void> saveRefreshToken(String token) async {
    await _storage.write(key: _refreshTokenKey, value: token);
  }

  /// Refresh Token 가져오기
  Future<String?> getRefreshToken() async {
    return await _storage.read(key: _refreshTokenKey);
  }

  /// 토큰 일괄 저장
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await Future.wait([
      saveAccessToken(accessToken),
      saveRefreshToken(refreshToken),
    ]);
  }

  /// 토큰 삭제
  Future<void> clearTokens() async {
    await Future.wait([
      _storage.delete(key: _accessTokenKey),
      _storage.delete(key: _refreshTokenKey),
    ]);
  }

  // ============================================
  // User ID 관리
  // ============================================

  /// User ID 저장
  Future<void> saveUserId(String userId) async {
    await _storage.write(key: _userIdKey, value: userId);
  }

  /// User ID 가져오기
  Future<String?> getUserId() async {
    return await _storage.read(key: _userIdKey);
  }

  // ============================================
  // 전체 삭제
  // ============================================

  /// 모든 저장된 데이터 삭제 (로그아웃 시 사용)
  Future<void> clearAll() async {
    await _storage.deleteAll();
  }

  /// 로그인 여부 확인
  Future<bool> isLoggedIn() async {
    final token = await getAccessToken();
    return token != null && token.isNotEmpty;
  }

  // ============================================
  // 온보딩 건너뛰기 플래그 관리
  // ============================================

  /// 온보딩 건너뛰기 플래그 저장
  Future<void> setOnboardingSkipped(bool skipped) async {
    await _storage.write(key: _onboardingSkippedKey, value: skipped.toString());
  }

  /// 온보딩 건너뛰기 여부 확인
  Future<bool> isOnboardingSkipped() async {
    final value = await _storage.read(key: _onboardingSkippedKey);
    return value == 'true';
  }

  /// 온보딩 건너뛰기 플래그 삭제
  Future<void> clearOnboardingSkipped() async {
    await _storage.delete(key: _onboardingSkippedKey);
  }
}
