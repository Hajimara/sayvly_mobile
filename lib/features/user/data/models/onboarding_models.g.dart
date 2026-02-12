// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OnboardingStatusResponseImpl _$$OnboardingStatusResponseImplFromJson(
  Map<String, dynamic> json,
) => _$OnboardingStatusResponseImpl(
  isCompleted: json['isCompleted'] as bool,
  currentStep: (json['currentStep'] as num).toInt(),
  totalSteps: (json['totalSteps'] as num).toInt(),
  missingSteps:
      (json['missingSteps'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
);

Map<String, dynamic> _$$OnboardingStatusResponseImplToJson(
  _$OnboardingStatusResponseImpl instance,
) => <String, dynamic>{
  'isCompleted': instance.isCompleted,
  'currentStep': instance.currentStep,
  'totalSteps': instance.totalSteps,
  'missingSteps': instance.missingSteps,
};

_$OnboardingRequestImpl _$$OnboardingRequestImplFromJson(
  Map<String, dynamic> json,
) => _$OnboardingRequestImpl(
  gender: $enumDecode(_$GenderEnumMap, json['gender']),
  birthDate: json['birthDate'] == null
      ? null
      : DateTime.parse(json['birthDate'] as String),
  cycleLength: (json['cycleLength'] as num?)?.toInt() ?? 28,
  periodLength: (json['periodLength'] as num?)?.toInt() ?? 5,
  lastPeriodStartDate: json['lastPeriodStartDate'] == null
      ? null
      : DateTime.parse(json['lastPeriodStartDate'] as String),
);

Map<String, dynamic> _$$OnboardingRequestImplToJson(
  _$OnboardingRequestImpl instance,
) => <String, dynamic>{
  'gender': _$GenderEnumMap[instance.gender]!,
  'birthDate': instance.birthDate?.toIso8601String(),
  'cycleLength': instance.cycleLength,
  'periodLength': instance.periodLength,
  'lastPeriodStartDate': instance.lastPeriodStartDate?.toIso8601String(),
};

const _$GenderEnumMap = {
  Gender.male: 'MALE',
  Gender.female: 'FEMALE',
  Gender.other: 'OTHER',
};

_$CycleSetupRequestImpl _$$CycleSetupRequestImplFromJson(
  Map<String, dynamic> json,
) => _$CycleSetupRequestImpl(
  lastPeriodDate: DateTime.parse(json['lastPeriodDate'] as String),
  averageCycleLength: (json['averageCycleLength'] as num?)?.toInt() ?? 28,
  averagePeriodLength: (json['averagePeriodLength'] as num?)?.toInt() ?? 5,
);

Map<String, dynamic> _$$CycleSetupRequestImplToJson(
  _$CycleSetupRequestImpl instance,
) => <String, dynamic>{
  'lastPeriodDate': instance.lastPeriodDate.toIso8601String(),
  'averageCycleLength': instance.averageCycleLength,
  'averagePeriodLength': instance.averagePeriodLength,
};
