// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SignupRequestImpl _$$SignupRequestImplFromJson(Map<String, dynamic> json) =>
    _$SignupRequestImpl(
      email: json['email'] as String,
      password: json['password'] as String,
      nickname: json['nickname'] as String,
    );

Map<String, dynamic> _$$SignupRequestImplToJson(_$SignupRequestImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'nickname': instance.nickname,
    };

_$LoginRequestImpl _$$LoginRequestImplFromJson(Map<String, dynamic> json) =>
    _$LoginRequestImpl(
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$$LoginRequestImplToJson(_$LoginRequestImpl instance) =>
    <String, dynamic>{'email': instance.email, 'password': instance.password};

_$SocialLoginRequestImpl _$$SocialLoginRequestImplFromJson(
  Map<String, dynamic> json,
) => _$SocialLoginRequestImpl(
  provider: json['provider'] as String,
  accessToken: json['accessToken'] as String,
  email: json['email'] as String?,
  nickname: json['nickname'] as String?,
  profileImageUrl: json['profileImageUrl'] as String?,
);

Map<String, dynamic> _$$SocialLoginRequestImplToJson(
  _$SocialLoginRequestImpl instance,
) => <String, dynamic>{
  'provider': instance.provider,
  'accessToken': instance.accessToken,
  'email': instance.email,
  'nickname': instance.nickname,
  'profileImageUrl': instance.profileImageUrl,
};

_$RefreshTokenRequestImpl _$$RefreshTokenRequestImplFromJson(
  Map<String, dynamic> json,
) => _$RefreshTokenRequestImpl(refreshToken: json['refreshToken'] as String);

Map<String, dynamic> _$$RefreshTokenRequestImplToJson(
  _$RefreshTokenRequestImpl instance,
) => <String, dynamic>{'refreshToken': instance.refreshToken};
