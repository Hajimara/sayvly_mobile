// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChangePasswordRequestImpl _$$ChangePasswordRequestImplFromJson(
  Map<String, dynamic> json,
) => _$ChangePasswordRequestImpl(
  currentPassword: json['currentPassword'] as String,
  newPassword: json['newPassword'] as String,
);

Map<String, dynamic> _$$ChangePasswordRequestImplToJson(
  _$ChangePasswordRequestImpl instance,
) => <String, dynamic>{
  'currentPassword': instance.currentPassword,
  'newPassword': instance.newPassword,
};

_$DeviceInfoImpl _$$DeviceInfoImplFromJson(Map<String, dynamic> json) =>
    _$DeviceInfoImpl(
      tokenId: json['tokenId'] as String,
      deviceName: json['deviceName'] as String,
      deviceType: json['deviceType'] as String,
      ipAddress: json['ipAddress'] as String?,
      lastUsedAt: DateTime.parse(json['lastUsedAt'] as String),
      isCurrentDevice: json['isCurrentDevice'] as bool? ?? false,
    );

Map<String, dynamic> _$$DeviceInfoImplToJson(_$DeviceInfoImpl instance) =>
    <String, dynamic>{
      'tokenId': instance.tokenId,
      'deviceName': instance.deviceName,
      'deviceType': instance.deviceType,
      'ipAddress': instance.ipAddress,
      'lastUsedAt': instance.lastUsedAt.toIso8601String(),
      'isCurrentDevice': instance.isCurrentDevice,
    };

_$WithdrawRequestImpl _$$WithdrawRequestImplFromJson(
  Map<String, dynamic> json,
) => _$WithdrawRequestImpl(
  reason: json['reason'] as String?,
  feedback: json['feedback'] as String?,
);

Map<String, dynamic> _$$WithdrawRequestImplToJson(
  _$WithdrawRequestImpl instance,
) => <String, dynamic>{
  'reason': instance.reason,
  'feedback': instance.feedback,
};

_$WithdrawResponseImpl _$$WithdrawResponseImplFromJson(
  Map<String, dynamic> json,
) => _$WithdrawResponseImpl(
  scheduledDeleteAt: DateTime.parse(json['scheduledDeleteAt'] as String),
  message: json['message'] as String,
);

Map<String, dynamic> _$$WithdrawResponseImplToJson(
  _$WithdrawResponseImpl instance,
) => <String, dynamic>{
  'scheduledDeleteAt': instance.scheduledDeleteAt.toIso8601String(),
  'message': instance.message,
};

_$WithdrawStatusResponseImpl _$$WithdrawStatusResponseImplFromJson(
  Map<String, dynamic> json,
) => _$WithdrawStatusResponseImpl(
  isWithdrawRequested: json['isWithdrawRequested'] as bool,
  scheduledDeleteAt: json['scheduledDeleteAt'] == null
      ? null
      : DateTime.parse(json['scheduledDeleteAt'] as String),
  withdrawRequestedAt: json['withdrawRequestedAt'] == null
      ? null
      : DateTime.parse(json['withdrawRequestedAt'] as String),
);

Map<String, dynamic> _$$WithdrawStatusResponseImplToJson(
  _$WithdrawStatusResponseImpl instance,
) => <String, dynamic>{
  'isWithdrawRequested': instance.isWithdrawRequested,
  'scheduledDeleteAt': instance.scheduledDeleteAt?.toIso8601String(),
  'withdrawRequestedAt': instance.withdrawRequestedAt?.toIso8601String(),
};
