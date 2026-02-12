import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_models.freezed.dart';
part 'user_models.g.dart';

/// 성별
enum Gender {
  @JsonValue('MALE')
  male,
  @JsonValue('FEMALE')
  female,
  @JsonValue('OTHER')
  other,
}

/// 인증 제공자
enum AuthProvider {
  @JsonValue('EMAIL')
  email,
  @JsonValue('GOOGLE')
  google,
  @JsonValue('KAKAO')
  kakao,
  @JsonValue('NAVER')
  naver,
}

/// 구독 티어
enum SubscriptionTier {
  @JsonValue('FREE')
  free,
  @JsonValue('PREMIUM')
  premium,
}

/// 주기 정보 요약
@freezed
class CycleInfoSummary with _$CycleInfoSummary {
  const factory CycleInfoSummary({
    int? averageCycleLength,
    DateTime? lastPeriodDate,
    DateTime? nextPeriodDate,
    int? currentCycleDay,
  }) = _CycleInfoSummary;

  factory CycleInfoSummary.fromJson(Map<String, dynamic> json) =>
      _$CycleInfoSummaryFromJson(json);
}

/// 프로필 응답
/// GET /api/v1/profile/me
@freezed
class ProfileResponse with _$ProfileResponse {
  const factory ProfileResponse({
    required int id,
    required String email,
    String? nickname,
    Gender? gender,
    DateTime? birthDate,
    String? profileImageUrl,
    required AuthProvider provider,
    required SubscriptionTier subscriptionTier,
    DateTime? subscriptionExpiresAt,
    @Default(false) bool emailVerified,
    @Default(false) bool onboardingCompleted,
    required DateTime createdAt,
    CycleInfoSummary? cycleInfo,
    DateTime? nicknameChangedAt,
  }) = _ProfileResponse;

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseFromJson(json);
}

/// 프로필 수정 요청
/// PATCH /api/v1/profile/me
@freezed
class UpdateProfileRequest with _$UpdateProfileRequest {
  const factory UpdateProfileRequest({
    String? nickname,
    DateTime? birthDate,
    int? averageCycleLength,
    int? averagePeriodLength,
  }) = _UpdateProfileRequest;

  factory UpdateProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileRequestFromJson(json);
}

/// 프로필 이미지 업로드 응답
@freezed
class ProfileImageResponse with _$ProfileImageResponse {
  const factory ProfileImageResponse({required String imageUrl}) =
      _ProfileImageResponse;

  factory ProfileImageResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileImageResponseFromJson(json);
}
