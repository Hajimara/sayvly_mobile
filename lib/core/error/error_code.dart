/// 백엔드 ErrorCode와 매핑되는 에러 코드 enum
/// 모바일에서 사용자 친화적인 메시지를 우선 사용
enum ErrorCode {
  // Common (1xxx)
  requestParamCannotBeEmpty(1000, '필수 정보를 입력해주세요'),
  invalidInputValue(1001, '입력한 내용을 확인해주세요'),

  // Auth (2xxx)
  unauthorized(2000, '다시 로그인해주세요'),
  invalidToken(2001, '로그인 세션이 만료되었습니다'),
  expiredToken(2002, '로그인 세션이 만료되었습니다'),
  refreshTokenNotFound(2003, '다시 로그인해주세요'),
  refreshTokenExpired(2004, '로그인 세션이 만료되었습니다'),
  socialAuthFailed(2005, '소셜 로그인에 실패했습니다'),
  tooManyLoginAttempts(2006, '로그인 시도가 너무 많습니다. 잠시 후 다시 시도해주세요'),
  invalidPasswordFormat(2007, '비밀번호는 8자 이상, 영문, 숫자, 특수문자를 포함해야 합니다'),
  emailAlreadyRegisteredWithOtherProvider(2008, '이미 다른 로그인 방식으로 가입된 이메일입니다'),
  socialLoginRequired(2009, '소셜 로그인으로 가입된 계정입니다'),

  // User (3xxx)
  userNotFound(3001, '사용자 정보를 찾을 수 없습니다'),
  userAlreadyExists(3002, '이미 가입된 사용자입니다'),
  passwordNotMatched(3003, '비밀번호가 일치하지 않습니다'),
  nicknameAlreadyExists(3004, '이미 사용 중인 닉네임입니다'),
  invalidNicknameFormat(3005, '닉네임은 2-12자로 입력해주세요'),
  onboardingAlreadyCompleted(3006, '이미 온보딩이 완료되었습니다'),
  userDeleted(3007, '탈퇴한 사용자입니다'),
  nicknameChangeCooldown(3008, '닉네임 변경은 30일에 한 번만 가능합니다'),
  invalidCurrentPassword(3009, '현재 비밀번호가 일치하지 않습니다'),
  withdrawAlreadyRequested(3010, '이미 탈퇴가 요청되었습니다'),
  withdrawNotRequested(3011, '탈퇴 요청이 없습니다'),

  // Couple (4xxx)
  coupleNotFound(4001, '커플 정보를 찾을 수 없습니다'),
  alreadyCoupled(4002, '이미 커플로 연결되어 있습니다'),
  invalidInviteCode(4003, '유효하지 않은 초대 코드입니다'),
  inviteCodeExpired(4004, '만료된 초대 코드입니다'),
  cannotInviteSelf(4005, '자기 자신을 초대할 수 없습니다'),
  subscriptionRequired(4006, '프리미엄 구독이 필요합니다'),
  partnerNotFound(4007, '파트너를 찾을 수 없습니다'),
  shareSettingsNotFound(4008, '공유 설정을 찾을 수 없습니다'),
  chatMessageNotFound(4009, '메시지를 찾을 수 없습니다'),
  chatMessageTooLong(4010, '메시지는 1000자 이하여야 합니다'),
  chatNotAvailable(4011, '채팅을 사용할 수 없습니다'),
  quickMessageLimitExceeded(4012, '빠른 메시지는 최대 20개까지 생성할 수 있습니다'),

  // Cycle (5xxx)
  cycleNotFound(5001, '생리 주기를 찾을 수 없습니다'),
  cycleAlreadyInProgress(5002, '이미 진행 중인 생리 주기가 있습니다'),
  cycleNotInProgress(5003, '진행 중인 생리 주기가 없습니다'),
  invalidCycleEndDate(5004, '종료일은 시작일 이후여야 합니다'),
  invalidCycleDateRange(5005, '유효하지 않은 날짜 범위입니다'),
  cycleDateOverlap(5006, '다른 주기와 날짜가 겹칩니다'),
  noCycleDataForPrediction(5007, '예측을 위한 주기 데이터가 없습니다'),

  // Symptom (51xx)
  symptomNotFound(5101, '증상 기록을 찾을 수 없습니다'),
  invalidSymptomIntensity(5102, '증상 강도는 1-3 사이여야 합니다'),
  futureDateNotAllowed(5103, '미래 날짜에는 기록할 수 없습니다'),

  // SymptomPreset (511x)
  symptomPresetNotFound(5111, '증상 프리셋을 찾을 수 없습니다'),
  maxPresetLimitExceeded(5112, '프리셋은 최대 10개까지 생성할 수 있습니다'),

  // PredictedSymptom (52xx)
  insufficientCycleData(5201, '예상 증상 계산에 충분한 주기 데이터가 없습니다'),
  predictionNotAvailable(5202, '미래 날짜에만 예상 증상을 제공합니다'),
  alreadyRecordedForPhase(5203, '해당 Phase에 이미 기록되어 있습니다'),

  // Image (6xxx)
  invalidImageType(6001, '지원하지 않는 이미지 형식입니다'),
  imageSizeExceeded(6002, '이미지 크기는 5MB 이하여야 합니다'),
  imageUploadFailed(6003, '이미지 업로드에 실패했습니다'),

  // Notification (7xxx)
  notificationNotFound(7001, '알림을 찾을 수 없습니다'),
  deviceTokenNotFound(7002, '디바이스 토큰을 찾을 수 없습니다'),
  notificationSendFailed(7003, '알림 전송에 실패했습니다'),

  // Subscription (8xxx)
  subscriptionNotFound(8001, '구독 정보를 찾을 수 없습니다'),
  subscriptionAlreadyActive(8002, '이미 활성 구독이 존재합니다'),
  invalidReceipt(8003, '유효하지 않은 영수증입니다'),
  storeVerificationFailed(8004, '스토어 검증에 실패했습니다'),
  trialAlreadyUsed(8005, '이미 무료 체험을 사용했습니다'),
  trialNotFound(8006, '무료 체험 정보를 찾을 수 없습니다'),
  duplicateTransaction(8007, '이미 처리된 거래입니다'),
  restoreFailed(8008, '구독 복원에 실패했습니다'),

  // Admin (9xxx) - 모바일에서는 사용하지 않지만 호환성을 위해 포함
  adminNotFound(9001, '관리자를 찾을 수 없습니다'),
  adminInvalidCredentials(9002, '이메일 또는 비밀번호가 올바르지 않습니다'),
  adminAccountDisabled(9003, '비활성화된 관리자 계정입니다'),
  adminInsufficientPermission(9004, '권한이 부족합니다'),

  // Admin Content (91xx)
  careGuideNotFound(9101, '배려 가이드를 찾을 수 없습니다'),
  announcementNotFound(9102, '공지사항을 찾을 수 없습니다'),

  // Admin Push (92xx)
  pushCampaignNotFound(9201, '푸시 캠페인을 찾을 수 없습니다'),
  invalidPushSegment(9202, '유효하지 않은 발송 대상입니다'),
  pushCampaignAlreadySent(9203, '이미 발송된 캠페인입니다'),
  pushCampaignCancelled(9204, '취소된 캠페인입니다'),

  // Admin Settings (93xx)
  featureFlagNotFound(9301, '기능 플래그를 찾을 수 없습니다'),
  appConfigNotFound(9302, '앱 설정을 찾을 수 없습니다'),

  // Admin Account (94xx)
  adminEmailAlreadyExists(9401, '이미 사용 중인 이메일입니다'),
  cannotDeactivateSelf(9402, '자기 자신을 비활성화할 수 없습니다'),
  cannotDeleteSuperAdmin(9403, '슈퍼 관리자는 삭제할 수 없습니다');

  final int code;
  final String userFriendlyMessage;

  const ErrorCode(this.code, this.userFriendlyMessage);

  /// 에러 코드로 ErrorCode 찾기
  static ErrorCode? fromCode(int code) {
    try {
      return ErrorCode.values.firstWhere((e) => e.code == code);
    } catch (_) {
      return null;
    }
  }

  /// 에러 코드로 ErrorCode 찾기 (없으면 null 반환)
  static ErrorCode? fromCodeOrNull(int? code) {
    if (code == null) return null;
    return fromCode(code);
  }
}
