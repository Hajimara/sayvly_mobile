/// 비밀번호 유효성 검사 및 강도 계산
class PasswordValidator {
  PasswordValidator._();

  /// 비밀번호 규칙
  /// - 최소 8자 이상
  /// - 영문 포함
  /// - 숫자 포함
  /// - 특수문자 포함
  static const int minLength = 8;

  /// 비밀번호 유효성 검사
  static PasswordValidationResult validate(String password) {
    final hasMinLength = password.length >= minLength;
    final hasUpperCase = password.contains(RegExp(r'[A-Z]'));
    final hasLowerCase = password.contains(RegExp(r'[a-z]'));
    final hasDigit = password.contains(RegExp(r'[0-9]'));
    final hasSpecialChar = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    final hasLetter = hasUpperCase || hasLowerCase;

    return PasswordValidationResult(
      hasMinLength: hasMinLength,
      hasLetter: hasLetter,
      hasDigit: hasDigit,
      hasSpecialChar: hasSpecialChar,
    );
  }

  /// 비밀번호 강도 계산
  static PasswordStrength calculateStrength(String password) {
    if (password.isEmpty) return PasswordStrength.none;

    final result = validate(password);
    final passedCount = [
      result.hasMinLength,
      result.hasLetter,
      result.hasDigit,
      result.hasSpecialChar,
    ].where((e) => e).length;

    switch (passedCount) {
      case 0:
      case 1:
        return PasswordStrength.weak;
      case 2:
      case 3:
        return PasswordStrength.medium;
      case 4:
        // 강함 조건: 모든 규칙 통과 + 10자 이상
        if (password.length >= 10) {
          return PasswordStrength.strong;
        }
        return PasswordStrength.medium;
      default:
        return PasswordStrength.weak;
    }
  }

  /// 비밀번호가 모든 규칙을 통과하는지 확인
  static bool isValid(String password) {
    final result = validate(password);
    return result.isValid;
  }
}

/// 비밀번호 유효성 검사 결과
class PasswordValidationResult {
  final bool hasMinLength;
  final bool hasLetter;
  final bool hasDigit;
  final bool hasSpecialChar;

  const PasswordValidationResult({
    required this.hasMinLength,
    required this.hasLetter,
    required this.hasDigit,
    required this.hasSpecialChar,
  });

  /// 모든 규칙을 통과했는지
  bool get isValid =>
      hasMinLength && hasLetter && hasDigit && hasSpecialChar;

  /// 통과한 규칙 개수
  int get passedCount => [
        hasMinLength,
        hasLetter,
        hasDigit,
        hasSpecialChar,
      ].where((e) => e).length;

  /// 에러 메시지
  String? get errorMessage {
    if (isValid) return null;

    final List<String> errors = [];

    if (!hasMinLength) {
      errors.add('8자 이상');
    }
    if (!hasLetter) {
      errors.add('영문 포함');
    }
    if (!hasDigit) {
      errors.add('숫자 포함');
    }
    if (!hasSpecialChar) {
      errors.add('특수문자 포함');
    }

    return errors.isEmpty ? null : errors.join(', ');
  }
}

/// 비밀번호 강도
enum PasswordStrength {
  none,
  weak,
  medium,
  strong;

  String get label {
    switch (this) {
      case PasswordStrength.none:
        return '';
      case PasswordStrength.weak:
        return '약함';
      case PasswordStrength.medium:
        return '보통';
      case PasswordStrength.strong:
        return '강함';
    }
  }
}
