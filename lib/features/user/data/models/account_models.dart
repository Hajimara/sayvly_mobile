import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_models.freezed.dart';
part 'account_models.g.dart';

/// 비밀번호 변경 요청
/// POST /api/v1/account/password
@freezed
class ChangePasswordRequest with _$ChangePasswordRequest {
  const factory ChangePasswordRequest({
    required String currentPassword,
    required String newPassword,
  }) = _ChangePasswordRequest;

  factory ChangePasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordRequestFromJson(json);
}

/// 디바이스 정보
/// GET /api/v1/account/devices
@freezed
class DeviceInfo with _$DeviceInfo {
  const factory DeviceInfo({
    required String tokenId,
    required String deviceName,
    required String deviceType,
    String? ipAddress,
    required DateTime lastUsedAt,
    @Default(false) bool isCurrentDevice,
  }) = _DeviceInfo;

  factory DeviceInfo.fromJson(Map<String, dynamic> json) =>
      _$DeviceInfoFromJson(json);
}

/// 탈퇴 요청
/// POST /api/v1/account/withdraw
@freezed
class WithdrawRequest with _$WithdrawRequest {
  const factory WithdrawRequest({
    String? reason,
    String? feedback,
  }) = _WithdrawRequest;

  factory WithdrawRequest.fromJson(Map<String, dynamic> json) =>
      _$WithdrawRequestFromJson(json);
}

/// 탈퇴 응답
@freezed
class WithdrawResponse with _$WithdrawResponse {
  const factory WithdrawResponse({
    required DateTime scheduledDeleteAt,
    required String message,
  }) = _WithdrawResponse;

  factory WithdrawResponse.fromJson(Map<String, dynamic> json) =>
      _$WithdrawResponseFromJson(json);
}

/// 탈퇴 상태 응답
@freezed
class WithdrawStatusResponse with _$WithdrawStatusResponse {
  const factory WithdrawStatusResponse({
    required bool isWithdrawRequested,
    DateTime? scheduledDeleteAt,
    DateTime? withdrawRequestedAt,
  }) = _WithdrawStatusResponse;

  factory WithdrawStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$WithdrawStatusResponseFromJson(json);
}
