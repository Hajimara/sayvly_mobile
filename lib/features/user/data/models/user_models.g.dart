// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CycleInfoSummaryImpl _$$CycleInfoSummaryImplFromJson(
  Map<String, dynamic> json,
) => _$CycleInfoSummaryImpl(
  averageCycleLength: (json['averageCycleLength'] as num?)?.toInt(),
  lastPeriodDate: json['lastPeriodDate'] == null
      ? null
      : DateTime.parse(json['lastPeriodDate'] as String),
  nextPeriodDate: json['nextPeriodDate'] == null
      ? null
      : DateTime.parse(json['nextPeriodDate'] as String),
  currentCycleDay: (json['currentCycleDay'] as num?)?.toInt(),
);

Map<String, dynamic> _$$CycleInfoSummaryImplToJson(
  _$CycleInfoSummaryImpl instance,
) => <String, dynamic>{
  'averageCycleLength': instance.averageCycleLength,
  'lastPeriodDate': instance.lastPeriodDate?.toIso8601String(),
  'nextPeriodDate': instance.nextPeriodDate?.toIso8601String(),
  'currentCycleDay': instance.currentCycleDay,
};

_$ProfileResponseImpl _$$ProfileResponseImplFromJson(
  Map<String, dynamic> json,
) => _$ProfileResponseImpl(
  id: (json['id'] as num).toInt(),
  email: json['email'] as String,
  nickname: json['nickname'] as String?,
  gender: $enumDecodeNullable(_$GenderEnumMap, json['gender']),
  birthDate: json['birthDate'] == null
      ? null
      : DateTime.parse(json['birthDate'] as String),
  profileImageUrl: json['profileImageUrl'] as String?,
  provider: $enumDecode(_$AuthProviderEnumMap, json['provider']),
  subscriptionTier: $enumDecode(
    _$SubscriptionTierEnumMap,
    json['subscriptionTier'],
  ),
  subscriptionExpiresAt: json['subscriptionExpiresAt'] == null
      ? null
      : DateTime.parse(json['subscriptionExpiresAt'] as String),
  emailVerified: json['emailVerified'] as bool? ?? false,
  onboardingCompleted: json['onboardingCompleted'] as bool? ?? false,
  createdAt: DateTime.parse(json['createdAt'] as String),
  cycleInfo: json['cycleInfo'] == null
      ? null
      : CycleInfoSummary.fromJson(json['cycleInfo'] as Map<String, dynamic>),
  nicknameChangedAt: json['nicknameChangedAt'] == null
      ? null
      : DateTime.parse(json['nicknameChangedAt'] as String),
);

Map<String, dynamic> _$$ProfileResponseImplToJson(
  _$ProfileResponseImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'nickname': instance.nickname,
  'gender': _$GenderEnumMap[instance.gender],
  'birthDate': instance.birthDate?.toIso8601String(),
  'profileImageUrl': instance.profileImageUrl,
  'provider': _$AuthProviderEnumMap[instance.provider]!,
  'subscriptionTier': _$SubscriptionTierEnumMap[instance.subscriptionTier]!,
  'subscriptionExpiresAt': instance.subscriptionExpiresAt?.toIso8601String(),
  'emailVerified': instance.emailVerified,
  'onboardingCompleted': instance.onboardingCompleted,
  'createdAt': instance.createdAt.toIso8601String(),
  'cycleInfo': instance.cycleInfo,
  'nicknameChangedAt': instance.nicknameChangedAt?.toIso8601String(),
};

const _$GenderEnumMap = {
  Gender.male: 'MALE',
  Gender.female: 'FEMALE',
  Gender.other: 'OTHER',
};

const _$AuthProviderEnumMap = {
  AuthProvider.email: 'EMAIL',
  AuthProvider.google: 'GOOGLE',
  AuthProvider.kakao: 'KAKAO',
  AuthProvider.naver: 'NAVER',
};

const _$SubscriptionTierEnumMap = {
  SubscriptionTier.free: 'FREE',
  SubscriptionTier.premium: 'PREMIUM',
};

_$UpdateProfileRequestImpl _$$UpdateProfileRequestImplFromJson(
  Map<String, dynamic> json,
) => _$UpdateProfileRequestImpl(
  nickname: json['nickname'] as String?,
  birthDate: json['birthDate'] == null
      ? null
      : DateTime.parse(json['birthDate'] as String),
  averageCycleLength: (json['averageCycleLength'] as num?)?.toInt(),
  averagePeriodLength: (json['averagePeriodLength'] as num?)?.toInt(),
);

Map<String, dynamic> _$$UpdateProfileRequestImplToJson(
  _$UpdateProfileRequestImpl instance,
) => <String, dynamic>{
  'nickname': instance.nickname,
  'birthDate': instance.birthDate?.toIso8601String(),
  'averageCycleLength': instance.averageCycleLength,
  'averagePeriodLength': instance.averagePeriodLength,
};

_$ProfileImageResponseImpl _$$ProfileImageResponseImplFromJson(
  Map<String, dynamic> json,
) => _$ProfileImageResponseImpl(imageUrl: json['imageUrl'] as String);

Map<String, dynamic> _$$ProfileImageResponseImplToJson(
  _$ProfileImageResponseImpl instance,
) => <String, dynamic>{'imageUrl': instance.imageUrl};
