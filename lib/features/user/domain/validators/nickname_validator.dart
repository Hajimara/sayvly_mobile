/// 닉네임 유효성 검사 결과
class NicknameValidationResult {
  final bool isValid;
  final String? errorMessage;

  const NicknameValidationResult._({
    required this.isValid,
    this.errorMessage,
  });

  factory NicknameValidationResult.valid() =>
      const NicknameValidationResult._(isValid: true);

  factory NicknameValidationResult.invalid(String message) =>
      NicknameValidationResult._(isValid: false, errorMessage: message);
}

/// 닉네임 유효성 검사기
/// 정책: 2-12자, 한글/영문/숫자만 허용
class NicknameValidator {
  /// 최소 길이
  static const int minLength = 2;

  /// 최대 길이
  static const int maxLength = 12;

  /// 허용 문자 패턴 (한글, 영문, 숫자)
  static final RegExp _allowedPattern = RegExp(r'^[가-힣a-zA-Z0-9]+$');

  /// 닉네임 유효성 검사
  static NicknameValidationResult validate(String? nickname) {
    if (nickname == null || nickname.isEmpty) {
      return NicknameValidationResult.invalid('닉네임을 입력해주세요.');
    }

    final trimmed = nickname.trim();

    // 길이 검사
    if (trimmed.length < minLength) {
      return NicknameValidationResult.invalid(
        '닉네임은 $minLength자 이상이어야 합니다.',
      );
    }

    if (trimmed.length > maxLength) {
      return NicknameValidationResult.invalid(
        '닉네임은 $maxLength자 이하여야 합니다.',
      );
    }

    // 허용 문자 검사
    if (!_allowedPattern.hasMatch(trimmed)) {
      return NicknameValidationResult.invalid(
        '닉네임은 한글, 영문, 숫자만 사용할 수 있습니다.',
      );
    }

    return NicknameValidationResult.valid();
  }

  /// 닉네임 변경 쿨다운 일수 계산
  /// [lastChangedAt]이 null이면 변경 가능
  /// 30일 쿨다운
  static int? getRemainingCooldownDays(DateTime? lastChangedAt) {
    if (lastChangedAt == null) return null;

    const cooldownDays = 30;
    final now = DateTime.now();
    final nextAvailableDate = lastChangedAt.add(
      const Duration(days: cooldownDays),
    );

    if (now.isAfter(nextAvailableDate)) {
      return null; // 쿨다운 완료
    }

    return nextAvailableDate.difference(now).inDays + 1;
  }

  /// 닉네임 변경 가능 여부
  static bool canChangeNickname(DateTime? lastChangedAt) {
    return getRemainingCooldownDays(lastChangedAt) == null;
  }

  /// 쿨다운 안내 메시지
  static String? getCooldownMessage(DateTime? lastChangedAt) {
    final remainingDays = getRemainingCooldownDays(lastChangedAt);
    if (remainingDays == null) return null;

    return 'D-$remainingDays 후 닉네임을 변경할 수 있습니다.';
  }
}
