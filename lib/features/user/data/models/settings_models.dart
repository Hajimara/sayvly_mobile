import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_models.freezed.dart';
part 'settings_models.g.dart';

/// 테마 설정
enum ThemeMode {
  @JsonValue('LIGHT')
  light,
  @JsonValue('DARK')
  dark,
  @JsonValue('SYSTEM')
  system,
}

/// 사용자 설정 응답
/// GET /api/v1/settings
@freezed
class UserSettingsResponse with _$UserSettingsResponse {
  const factory UserSettingsResponse({
    // 알림 설정
    @Default(true) bool notificationPeriodReminder,
    @Default(false) bool notificationOvulation,
    @Default(true) bool notificationAnniversary,
    @Default(true) bool notificationDailyRecord,

    // 파트너 알림 (남성)
    @Default(true) bool notificationPartnerPeriod,
    @Default(true) bool notificationPartnerPms,
    @Default(true) bool notificationCareTips,

    // 알림 시간
    String? notificationTime,
    String? doNotDisturbStart,
    String? doNotDisturbEnd,

    // 앱 설정
    @Default(ThemeMode.system) ThemeMode theme,
    @Default('ko') String language,
  }) = _UserSettingsResponse;

  factory UserSettingsResponse.fromJson(Map<String, dynamic> json) =>
      _$UserSettingsResponseFromJson(json);
}

/// 설정 수정 요청
/// PATCH /api/v1/settings
@freezed
class UpdateSettingsRequest with _$UpdateSettingsRequest {
  const factory UpdateSettingsRequest({
    // 알림 설정
    bool? notificationPeriodReminder,
    bool? notificationOvulation,
    bool? notificationAnniversary,
    bool? notificationDailyRecord,

    // 파트너 알림 (남성)
    bool? notificationPartnerPeriod,
    bool? notificationPartnerPms,
    bool? notificationCareTips,

    // 알림 시간
    String? notificationTime,
    String? doNotDisturbStart,
    String? doNotDisturbEnd,

    // 앱 설정
    ThemeMode? theme,
    String? language,
  }) = _UpdateSettingsRequest;

  factory UpdateSettingsRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateSettingsRequestFromJson(json);
}
