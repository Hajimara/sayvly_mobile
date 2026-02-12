import 'dart:math';

/// 랜덤 닉네임 생성 유틸리티
/// 백엔드 AuthService.resolveUniqueNickname() 로직 참고
class NicknameGenerator {
  NicknameGenerator._();

  /// 랜덤 닉네임 생성
  /// "사용자" + 6자리 랜덤 숫자 (100000-999999) 형식
  /// 중복 체크는 백엔드 API에서 처리
  static String generateRandom() {
    final random = Random();
    final suffix = 100000 + random.nextInt(900000); // 100000-999999
    return '사용자$suffix';
  }
}
