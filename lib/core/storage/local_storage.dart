import 'package:shared_preferences/shared_preferences.dart';

/// 로컬 저장소 래퍼
/// 이메일 등 비민감 정보 저장
class LocalStorage {
  static const _lastEmailKey = 'last_email';
  static const _languageKey = 'app_language';

  final SharedPreferences _prefs;

  LocalStorage._(this._prefs);

  /// 인스턴스 생성
  static Future<LocalStorage> getInstance() async {
    final prefs = await SharedPreferences.getInstance();
    return LocalStorage._(prefs);
  }

  // ============================================
  // 이메일 관리
  // ============================================

  /// 마지막 로그인 이메일 저장
  Future<void> saveLastEmail(String email) async {
    await _prefs.setString(_lastEmailKey, email);
  }

  /// 마지막 로그인 이메일 가져오기
  String? getLastEmail() {
    return _prefs.getString(_lastEmailKey);
  }

  /// 마지막 로그인 이메일 삭제
  Future<void> clearLastEmail() async {
    await _prefs.remove(_lastEmailKey);
  }

  // ============================================
  // 언어 관리
  // ============================================

  /// 언어 저장
  Future<void> saveLanguage(String languageCode) async {
    await _prefs.setString(_languageKey, languageCode);
  }

  /// 저장된 언어 가져오기
  String? getLanguage() {
    return _prefs.getString(_languageKey);
  }

  /// 언어 삭제
  Future<void> clearLanguage() async {
    await _prefs.remove(_languageKey);
  }
}
