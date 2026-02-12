import 'package:freezed_annotation/freezed_annotation.dart';
import 'user_models.dart';

part 'onboarding_models.freezed.dart';
part 'onboarding_models.g.dart';

/// 온보딩 상태 응답
/// GET /api/v1/onboarding/status
@freezed
class OnboardingStatusResponse with _$OnboardingStatusResponse {
  const factory OnboardingStatusResponse({
    required bool isCompleted,
    required int currentStep,
    required int totalSteps,
    @Default([]) List<String> missingSteps,
  }) = _OnboardingStatusResponse;

  factory OnboardingStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$OnboardingStatusResponseFromJson(json);
}

/// 온보딩 완료 요청
/// POST /api/v1/onboarding/complete
@freezed
class OnboardingRequest with _$OnboardingRequest {
  const factory OnboardingRequest({
    required Gender gender,
    DateTime? birthDate,
    @Default(28) int cycleLength,
    @Default(5) int periodLength,
    DateTime? lastPeriodStartDate,
  }) = _OnboardingRequest;

  factory OnboardingRequest.fromJson(Map<String, dynamic> json) =>
      _$OnboardingRequestFromJson(json);
}

/// 주기 정보 설정 요청 (여성만)
/// POST /api/v1/onboarding/cycle
@freezed
class CycleSetupRequest with _$CycleSetupRequest {
  const factory CycleSetupRequest({
    required DateTime lastPeriodDate,
    @Default(28) int averageCycleLength,
    @Default(5) int averagePeriodLength,
  }) = _CycleSetupRequest;

  factory CycleSetupRequest.fromJson(Map<String, dynamic> json) =>
      _$CycleSetupRequestFromJson(json);
}
