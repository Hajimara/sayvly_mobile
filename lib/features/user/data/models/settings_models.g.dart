// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserSettingsResponseImpl _$$UserSettingsResponseImplFromJson(
  Map<String, dynamic> json,
) => _$UserSettingsResponseImpl(
  notificationPeriodReminder:
      json['notificationPeriodReminder'] as bool? ?? true,
  notificationOvulation: json['notificationOvulation'] as bool? ?? false,
  notificationAnniversary: json['notificationAnniversary'] as bool? ?? true,
  notificationDailyRecord: json['notificationDailyRecord'] as bool? ?? true,
  notificationPartnerPeriod: json['notificationPartnerPeriod'] as bool? ?? true,
  notificationPartnerPms: json['notificationPartnerPms'] as bool? ?? true,
  notificationCareTips: json['notificationCareTips'] as bool? ?? true,
  notificationTime: json['notificationTime'] as String?,
  doNotDisturbStart: json['doNotDisturbStart'] as String?,
  doNotDisturbEnd: json['doNotDisturbEnd'] as String?,
  theme:
      $enumDecodeNullable(_$ThemeModeEnumMap, json['theme']) ??
      ThemeMode.system,
  language: json['language'] as String? ?? 'ko',
);

Map<String, dynamic> _$$UserSettingsResponseImplToJson(
  _$UserSettingsResponseImpl instance,
) => <String, dynamic>{
  'notificationPeriodReminder': instance.notificationPeriodReminder,
  'notificationOvulation': instance.notificationOvulation,
  'notificationAnniversary': instance.notificationAnniversary,
  'notificationDailyRecord': instance.notificationDailyRecord,
  'notificationPartnerPeriod': instance.notificationPartnerPeriod,
  'notificationPartnerPms': instance.notificationPartnerPms,
  'notificationCareTips': instance.notificationCareTips,
  'notificationTime': instance.notificationTime,
  'doNotDisturbStart': instance.doNotDisturbStart,
  'doNotDisturbEnd': instance.doNotDisturbEnd,
  'theme': _$ThemeModeEnumMap[instance.theme]!,
  'language': instance.language,
};

const _$ThemeModeEnumMap = {
  ThemeMode.light: 'LIGHT',
  ThemeMode.dark: 'DARK',
  ThemeMode.system: 'SYSTEM',
};

_$UpdateSettingsRequestImpl _$$UpdateSettingsRequestImplFromJson(
  Map<String, dynamic> json,
) => _$UpdateSettingsRequestImpl(
  notificationPeriodReminder: json['notificationPeriodReminder'] as bool?,
  notificationOvulation: json['notificationOvulation'] as bool?,
  notificationAnniversary: json['notificationAnniversary'] as bool?,
  notificationDailyRecord: json['notificationDailyRecord'] as bool?,
  notificationPartnerPeriod: json['notificationPartnerPeriod'] as bool?,
  notificationPartnerPms: json['notificationPartnerPms'] as bool?,
  notificationCareTips: json['notificationCareTips'] as bool?,
  notificationTime: json['notificationTime'] as String?,
  doNotDisturbStart: json['doNotDisturbStart'] as String?,
  doNotDisturbEnd: json['doNotDisturbEnd'] as String?,
  theme: $enumDecodeNullable(_$ThemeModeEnumMap, json['theme']),
  language: json['language'] as String?,
);

Map<String, dynamic> _$$UpdateSettingsRequestImplToJson(
  _$UpdateSettingsRequestImpl instance,
) => <String, dynamic>{
  'notificationPeriodReminder': instance.notificationPeriodReminder,
  'notificationOvulation': instance.notificationOvulation,
  'notificationAnniversary': instance.notificationAnniversary,
  'notificationDailyRecord': instance.notificationDailyRecord,
  'notificationPartnerPeriod': instance.notificationPartnerPeriod,
  'notificationPartnerPms': instance.notificationPartnerPms,
  'notificationCareTips': instance.notificationCareTips,
  'notificationTime': instance.notificationTime,
  'doNotDisturbStart': instance.doNotDisturbStart,
  'doNotDisturbEnd': instance.doNotDisturbEnd,
  'theme': _$ThemeModeEnumMap[instance.theme],
  'language': instance.language,
};
