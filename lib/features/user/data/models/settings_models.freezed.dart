// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UserSettingsResponse _$UserSettingsResponseFromJson(Map<String, dynamic> json) {
  return _UserSettingsResponse.fromJson(json);
}

/// @nodoc
mixin _$UserSettingsResponse {
  // 알림 설정
  bool get notificationPeriodReminder => throw _privateConstructorUsedError;
  bool get notificationOvulation => throw _privateConstructorUsedError;
  bool get notificationAnniversary => throw _privateConstructorUsedError;
  bool get notificationDailyRecord =>
      throw _privateConstructorUsedError; // 파트너 알림 (남성)
  bool get notificationPartnerPeriod => throw _privateConstructorUsedError;
  bool get notificationPartnerPms => throw _privateConstructorUsedError;
  bool get notificationCareTips => throw _privateConstructorUsedError; // 알림 시간
  String? get notificationTime => throw _privateConstructorUsedError;
  String? get doNotDisturbStart => throw _privateConstructorUsedError;
  String? get doNotDisturbEnd => throw _privateConstructorUsedError; // 앱 설정
  ThemeMode get theme => throw _privateConstructorUsedError;
  String get language => throw _privateConstructorUsedError;

  /// Serializes this UserSettingsResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserSettingsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserSettingsResponseCopyWith<UserSettingsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserSettingsResponseCopyWith<$Res> {
  factory $UserSettingsResponseCopyWith(
    UserSettingsResponse value,
    $Res Function(UserSettingsResponse) then,
  ) = _$UserSettingsResponseCopyWithImpl<$Res, UserSettingsResponse>;
  @useResult
  $Res call({
    bool notificationPeriodReminder,
    bool notificationOvulation,
    bool notificationAnniversary,
    bool notificationDailyRecord,
    bool notificationPartnerPeriod,
    bool notificationPartnerPms,
    bool notificationCareTips,
    String? notificationTime,
    String? doNotDisturbStart,
    String? doNotDisturbEnd,
    ThemeMode theme,
    String language,
  });
}

/// @nodoc
class _$UserSettingsResponseCopyWithImpl<
  $Res,
  $Val extends UserSettingsResponse
>
    implements $UserSettingsResponseCopyWith<$Res> {
  _$UserSettingsResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserSettingsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notificationPeriodReminder = null,
    Object? notificationOvulation = null,
    Object? notificationAnniversary = null,
    Object? notificationDailyRecord = null,
    Object? notificationPartnerPeriod = null,
    Object? notificationPartnerPms = null,
    Object? notificationCareTips = null,
    Object? notificationTime = freezed,
    Object? doNotDisturbStart = freezed,
    Object? doNotDisturbEnd = freezed,
    Object? theme = null,
    Object? language = null,
  }) {
    return _then(
      _value.copyWith(
            notificationPeriodReminder: null == notificationPeriodReminder
                ? _value.notificationPeriodReminder
                : notificationPeriodReminder // ignore: cast_nullable_to_non_nullable
                      as bool,
            notificationOvulation: null == notificationOvulation
                ? _value.notificationOvulation
                : notificationOvulation // ignore: cast_nullable_to_non_nullable
                      as bool,
            notificationAnniversary: null == notificationAnniversary
                ? _value.notificationAnniversary
                : notificationAnniversary // ignore: cast_nullable_to_non_nullable
                      as bool,
            notificationDailyRecord: null == notificationDailyRecord
                ? _value.notificationDailyRecord
                : notificationDailyRecord // ignore: cast_nullable_to_non_nullable
                      as bool,
            notificationPartnerPeriod: null == notificationPartnerPeriod
                ? _value.notificationPartnerPeriod
                : notificationPartnerPeriod // ignore: cast_nullable_to_non_nullable
                      as bool,
            notificationPartnerPms: null == notificationPartnerPms
                ? _value.notificationPartnerPms
                : notificationPartnerPms // ignore: cast_nullable_to_non_nullable
                      as bool,
            notificationCareTips: null == notificationCareTips
                ? _value.notificationCareTips
                : notificationCareTips // ignore: cast_nullable_to_non_nullable
                      as bool,
            notificationTime: freezed == notificationTime
                ? _value.notificationTime
                : notificationTime // ignore: cast_nullable_to_non_nullable
                      as String?,
            doNotDisturbStart: freezed == doNotDisturbStart
                ? _value.doNotDisturbStart
                : doNotDisturbStart // ignore: cast_nullable_to_non_nullable
                      as String?,
            doNotDisturbEnd: freezed == doNotDisturbEnd
                ? _value.doNotDisturbEnd
                : doNotDisturbEnd // ignore: cast_nullable_to_non_nullable
                      as String?,
            theme: null == theme
                ? _value.theme
                : theme // ignore: cast_nullable_to_non_nullable
                      as ThemeMode,
            language: null == language
                ? _value.language
                : language // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserSettingsResponseImplCopyWith<$Res>
    implements $UserSettingsResponseCopyWith<$Res> {
  factory _$$UserSettingsResponseImplCopyWith(
    _$UserSettingsResponseImpl value,
    $Res Function(_$UserSettingsResponseImpl) then,
  ) = __$$UserSettingsResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool notificationPeriodReminder,
    bool notificationOvulation,
    bool notificationAnniversary,
    bool notificationDailyRecord,
    bool notificationPartnerPeriod,
    bool notificationPartnerPms,
    bool notificationCareTips,
    String? notificationTime,
    String? doNotDisturbStart,
    String? doNotDisturbEnd,
    ThemeMode theme,
    String language,
  });
}

/// @nodoc
class __$$UserSettingsResponseImplCopyWithImpl<$Res>
    extends _$UserSettingsResponseCopyWithImpl<$Res, _$UserSettingsResponseImpl>
    implements _$$UserSettingsResponseImplCopyWith<$Res> {
  __$$UserSettingsResponseImplCopyWithImpl(
    _$UserSettingsResponseImpl _value,
    $Res Function(_$UserSettingsResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserSettingsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notificationPeriodReminder = null,
    Object? notificationOvulation = null,
    Object? notificationAnniversary = null,
    Object? notificationDailyRecord = null,
    Object? notificationPartnerPeriod = null,
    Object? notificationPartnerPms = null,
    Object? notificationCareTips = null,
    Object? notificationTime = freezed,
    Object? doNotDisturbStart = freezed,
    Object? doNotDisturbEnd = freezed,
    Object? theme = null,
    Object? language = null,
  }) {
    return _then(
      _$UserSettingsResponseImpl(
        notificationPeriodReminder: null == notificationPeriodReminder
            ? _value.notificationPeriodReminder
            : notificationPeriodReminder // ignore: cast_nullable_to_non_nullable
                  as bool,
        notificationOvulation: null == notificationOvulation
            ? _value.notificationOvulation
            : notificationOvulation // ignore: cast_nullable_to_non_nullable
                  as bool,
        notificationAnniversary: null == notificationAnniversary
            ? _value.notificationAnniversary
            : notificationAnniversary // ignore: cast_nullable_to_non_nullable
                  as bool,
        notificationDailyRecord: null == notificationDailyRecord
            ? _value.notificationDailyRecord
            : notificationDailyRecord // ignore: cast_nullable_to_non_nullable
                  as bool,
        notificationPartnerPeriod: null == notificationPartnerPeriod
            ? _value.notificationPartnerPeriod
            : notificationPartnerPeriod // ignore: cast_nullable_to_non_nullable
                  as bool,
        notificationPartnerPms: null == notificationPartnerPms
            ? _value.notificationPartnerPms
            : notificationPartnerPms // ignore: cast_nullable_to_non_nullable
                  as bool,
        notificationCareTips: null == notificationCareTips
            ? _value.notificationCareTips
            : notificationCareTips // ignore: cast_nullable_to_non_nullable
                  as bool,
        notificationTime: freezed == notificationTime
            ? _value.notificationTime
            : notificationTime // ignore: cast_nullable_to_non_nullable
                  as String?,
        doNotDisturbStart: freezed == doNotDisturbStart
            ? _value.doNotDisturbStart
            : doNotDisturbStart // ignore: cast_nullable_to_non_nullable
                  as String?,
        doNotDisturbEnd: freezed == doNotDisturbEnd
            ? _value.doNotDisturbEnd
            : doNotDisturbEnd // ignore: cast_nullable_to_non_nullable
                  as String?,
        theme: null == theme
            ? _value.theme
            : theme // ignore: cast_nullable_to_non_nullable
                  as ThemeMode,
        language: null == language
            ? _value.language
            : language // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserSettingsResponseImpl implements _UserSettingsResponse {
  const _$UserSettingsResponseImpl({
    this.notificationPeriodReminder = true,
    this.notificationOvulation = false,
    this.notificationAnniversary = true,
    this.notificationDailyRecord = true,
    this.notificationPartnerPeriod = true,
    this.notificationPartnerPms = true,
    this.notificationCareTips = true,
    this.notificationTime,
    this.doNotDisturbStart,
    this.doNotDisturbEnd,
    this.theme = ThemeMode.system,
    this.language = 'ko',
  });

  factory _$UserSettingsResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserSettingsResponseImplFromJson(json);

  // 알림 설정
  @override
  @JsonKey()
  final bool notificationPeriodReminder;
  @override
  @JsonKey()
  final bool notificationOvulation;
  @override
  @JsonKey()
  final bool notificationAnniversary;
  @override
  @JsonKey()
  final bool notificationDailyRecord;
  // 파트너 알림 (남성)
  @override
  @JsonKey()
  final bool notificationPartnerPeriod;
  @override
  @JsonKey()
  final bool notificationPartnerPms;
  @override
  @JsonKey()
  final bool notificationCareTips;
  // 알림 시간
  @override
  final String? notificationTime;
  @override
  final String? doNotDisturbStart;
  @override
  final String? doNotDisturbEnd;
  // 앱 설정
  @override
  @JsonKey()
  final ThemeMode theme;
  @override
  @JsonKey()
  final String language;

  @override
  String toString() {
    return 'UserSettingsResponse(notificationPeriodReminder: $notificationPeriodReminder, notificationOvulation: $notificationOvulation, notificationAnniversary: $notificationAnniversary, notificationDailyRecord: $notificationDailyRecord, notificationPartnerPeriod: $notificationPartnerPeriod, notificationPartnerPms: $notificationPartnerPms, notificationCareTips: $notificationCareTips, notificationTime: $notificationTime, doNotDisturbStart: $doNotDisturbStart, doNotDisturbEnd: $doNotDisturbEnd, theme: $theme, language: $language)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserSettingsResponseImpl &&
            (identical(
                  other.notificationPeriodReminder,
                  notificationPeriodReminder,
                ) ||
                other.notificationPeriodReminder ==
                    notificationPeriodReminder) &&
            (identical(other.notificationOvulation, notificationOvulation) ||
                other.notificationOvulation == notificationOvulation) &&
            (identical(
                  other.notificationAnniversary,
                  notificationAnniversary,
                ) ||
                other.notificationAnniversary == notificationAnniversary) &&
            (identical(
                  other.notificationDailyRecord,
                  notificationDailyRecord,
                ) ||
                other.notificationDailyRecord == notificationDailyRecord) &&
            (identical(
                  other.notificationPartnerPeriod,
                  notificationPartnerPeriod,
                ) ||
                other.notificationPartnerPeriod == notificationPartnerPeriod) &&
            (identical(other.notificationPartnerPms, notificationPartnerPms) ||
                other.notificationPartnerPms == notificationPartnerPms) &&
            (identical(other.notificationCareTips, notificationCareTips) ||
                other.notificationCareTips == notificationCareTips) &&
            (identical(other.notificationTime, notificationTime) ||
                other.notificationTime == notificationTime) &&
            (identical(other.doNotDisturbStart, doNotDisturbStart) ||
                other.doNotDisturbStart == doNotDisturbStart) &&
            (identical(other.doNotDisturbEnd, doNotDisturbEnd) ||
                other.doNotDisturbEnd == doNotDisturbEnd) &&
            (identical(other.theme, theme) || other.theme == theme) &&
            (identical(other.language, language) ||
                other.language == language));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    notificationPeriodReminder,
    notificationOvulation,
    notificationAnniversary,
    notificationDailyRecord,
    notificationPartnerPeriod,
    notificationPartnerPms,
    notificationCareTips,
    notificationTime,
    doNotDisturbStart,
    doNotDisturbEnd,
    theme,
    language,
  );

  /// Create a copy of UserSettingsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserSettingsResponseImplCopyWith<_$UserSettingsResponseImpl>
  get copyWith =>
      __$$UserSettingsResponseImplCopyWithImpl<_$UserSettingsResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UserSettingsResponseImplToJson(this);
  }
}

abstract class _UserSettingsResponse implements UserSettingsResponse {
  const factory _UserSettingsResponse({
    final bool notificationPeriodReminder,
    final bool notificationOvulation,
    final bool notificationAnniversary,
    final bool notificationDailyRecord,
    final bool notificationPartnerPeriod,
    final bool notificationPartnerPms,
    final bool notificationCareTips,
    final String? notificationTime,
    final String? doNotDisturbStart,
    final String? doNotDisturbEnd,
    final ThemeMode theme,
    final String language,
  }) = _$UserSettingsResponseImpl;

  factory _UserSettingsResponse.fromJson(Map<String, dynamic> json) =
      _$UserSettingsResponseImpl.fromJson;

  // 알림 설정
  @override
  bool get notificationPeriodReminder;
  @override
  bool get notificationOvulation;
  @override
  bool get notificationAnniversary;
  @override
  bool get notificationDailyRecord; // 파트너 알림 (남성)
  @override
  bool get notificationPartnerPeriod;
  @override
  bool get notificationPartnerPms;
  @override
  bool get notificationCareTips; // 알림 시간
  @override
  String? get notificationTime;
  @override
  String? get doNotDisturbStart;
  @override
  String? get doNotDisturbEnd; // 앱 설정
  @override
  ThemeMode get theme;
  @override
  String get language;

  /// Create a copy of UserSettingsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserSettingsResponseImplCopyWith<_$UserSettingsResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

UpdateSettingsRequest _$UpdateSettingsRequestFromJson(
  Map<String, dynamic> json,
) {
  return _UpdateSettingsRequest.fromJson(json);
}

/// @nodoc
mixin _$UpdateSettingsRequest {
  // 알림 설정
  bool? get notificationPeriodReminder => throw _privateConstructorUsedError;
  bool? get notificationOvulation => throw _privateConstructorUsedError;
  bool? get notificationAnniversary => throw _privateConstructorUsedError;
  bool? get notificationDailyRecord =>
      throw _privateConstructorUsedError; // 파트너 알림 (남성)
  bool? get notificationPartnerPeriod => throw _privateConstructorUsedError;
  bool? get notificationPartnerPms => throw _privateConstructorUsedError;
  bool? get notificationCareTips => throw _privateConstructorUsedError; // 알림 시간
  String? get notificationTime => throw _privateConstructorUsedError;
  String? get doNotDisturbStart => throw _privateConstructorUsedError;
  String? get doNotDisturbEnd => throw _privateConstructorUsedError; // 앱 설정
  ThemeMode? get theme => throw _privateConstructorUsedError;
  String? get language => throw _privateConstructorUsedError;

  /// Serializes this UpdateSettingsRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UpdateSettingsRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdateSettingsRequestCopyWith<UpdateSettingsRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateSettingsRequestCopyWith<$Res> {
  factory $UpdateSettingsRequestCopyWith(
    UpdateSettingsRequest value,
    $Res Function(UpdateSettingsRequest) then,
  ) = _$UpdateSettingsRequestCopyWithImpl<$Res, UpdateSettingsRequest>;
  @useResult
  $Res call({
    bool? notificationPeriodReminder,
    bool? notificationOvulation,
    bool? notificationAnniversary,
    bool? notificationDailyRecord,
    bool? notificationPartnerPeriod,
    bool? notificationPartnerPms,
    bool? notificationCareTips,
    String? notificationTime,
    String? doNotDisturbStart,
    String? doNotDisturbEnd,
    ThemeMode? theme,
    String? language,
  });
}

/// @nodoc
class _$UpdateSettingsRequestCopyWithImpl<
  $Res,
  $Val extends UpdateSettingsRequest
>
    implements $UpdateSettingsRequestCopyWith<$Res> {
  _$UpdateSettingsRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdateSettingsRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notificationPeriodReminder = freezed,
    Object? notificationOvulation = freezed,
    Object? notificationAnniversary = freezed,
    Object? notificationDailyRecord = freezed,
    Object? notificationPartnerPeriod = freezed,
    Object? notificationPartnerPms = freezed,
    Object? notificationCareTips = freezed,
    Object? notificationTime = freezed,
    Object? doNotDisturbStart = freezed,
    Object? doNotDisturbEnd = freezed,
    Object? theme = freezed,
    Object? language = freezed,
  }) {
    return _then(
      _value.copyWith(
            notificationPeriodReminder: freezed == notificationPeriodReminder
                ? _value.notificationPeriodReminder
                : notificationPeriodReminder // ignore: cast_nullable_to_non_nullable
                      as bool?,
            notificationOvulation: freezed == notificationOvulation
                ? _value.notificationOvulation
                : notificationOvulation // ignore: cast_nullable_to_non_nullable
                      as bool?,
            notificationAnniversary: freezed == notificationAnniversary
                ? _value.notificationAnniversary
                : notificationAnniversary // ignore: cast_nullable_to_non_nullable
                      as bool?,
            notificationDailyRecord: freezed == notificationDailyRecord
                ? _value.notificationDailyRecord
                : notificationDailyRecord // ignore: cast_nullable_to_non_nullable
                      as bool?,
            notificationPartnerPeriod: freezed == notificationPartnerPeriod
                ? _value.notificationPartnerPeriod
                : notificationPartnerPeriod // ignore: cast_nullable_to_non_nullable
                      as bool?,
            notificationPartnerPms: freezed == notificationPartnerPms
                ? _value.notificationPartnerPms
                : notificationPartnerPms // ignore: cast_nullable_to_non_nullable
                      as bool?,
            notificationCareTips: freezed == notificationCareTips
                ? _value.notificationCareTips
                : notificationCareTips // ignore: cast_nullable_to_non_nullable
                      as bool?,
            notificationTime: freezed == notificationTime
                ? _value.notificationTime
                : notificationTime // ignore: cast_nullable_to_non_nullable
                      as String?,
            doNotDisturbStart: freezed == doNotDisturbStart
                ? _value.doNotDisturbStart
                : doNotDisturbStart // ignore: cast_nullable_to_non_nullable
                      as String?,
            doNotDisturbEnd: freezed == doNotDisturbEnd
                ? _value.doNotDisturbEnd
                : doNotDisturbEnd // ignore: cast_nullable_to_non_nullable
                      as String?,
            theme: freezed == theme
                ? _value.theme
                : theme // ignore: cast_nullable_to_non_nullable
                      as ThemeMode?,
            language: freezed == language
                ? _value.language
                : language // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UpdateSettingsRequestImplCopyWith<$Res>
    implements $UpdateSettingsRequestCopyWith<$Res> {
  factory _$$UpdateSettingsRequestImplCopyWith(
    _$UpdateSettingsRequestImpl value,
    $Res Function(_$UpdateSettingsRequestImpl) then,
  ) = __$$UpdateSettingsRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool? notificationPeriodReminder,
    bool? notificationOvulation,
    bool? notificationAnniversary,
    bool? notificationDailyRecord,
    bool? notificationPartnerPeriod,
    bool? notificationPartnerPms,
    bool? notificationCareTips,
    String? notificationTime,
    String? doNotDisturbStart,
    String? doNotDisturbEnd,
    ThemeMode? theme,
    String? language,
  });
}

/// @nodoc
class __$$UpdateSettingsRequestImplCopyWithImpl<$Res>
    extends
        _$UpdateSettingsRequestCopyWithImpl<$Res, _$UpdateSettingsRequestImpl>
    implements _$$UpdateSettingsRequestImplCopyWith<$Res> {
  __$$UpdateSettingsRequestImplCopyWithImpl(
    _$UpdateSettingsRequestImpl _value,
    $Res Function(_$UpdateSettingsRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UpdateSettingsRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notificationPeriodReminder = freezed,
    Object? notificationOvulation = freezed,
    Object? notificationAnniversary = freezed,
    Object? notificationDailyRecord = freezed,
    Object? notificationPartnerPeriod = freezed,
    Object? notificationPartnerPms = freezed,
    Object? notificationCareTips = freezed,
    Object? notificationTime = freezed,
    Object? doNotDisturbStart = freezed,
    Object? doNotDisturbEnd = freezed,
    Object? theme = freezed,
    Object? language = freezed,
  }) {
    return _then(
      _$UpdateSettingsRequestImpl(
        notificationPeriodReminder: freezed == notificationPeriodReminder
            ? _value.notificationPeriodReminder
            : notificationPeriodReminder // ignore: cast_nullable_to_non_nullable
                  as bool?,
        notificationOvulation: freezed == notificationOvulation
            ? _value.notificationOvulation
            : notificationOvulation // ignore: cast_nullable_to_non_nullable
                  as bool?,
        notificationAnniversary: freezed == notificationAnniversary
            ? _value.notificationAnniversary
            : notificationAnniversary // ignore: cast_nullable_to_non_nullable
                  as bool?,
        notificationDailyRecord: freezed == notificationDailyRecord
            ? _value.notificationDailyRecord
            : notificationDailyRecord // ignore: cast_nullable_to_non_nullable
                  as bool?,
        notificationPartnerPeriod: freezed == notificationPartnerPeriod
            ? _value.notificationPartnerPeriod
            : notificationPartnerPeriod // ignore: cast_nullable_to_non_nullable
                  as bool?,
        notificationPartnerPms: freezed == notificationPartnerPms
            ? _value.notificationPartnerPms
            : notificationPartnerPms // ignore: cast_nullable_to_non_nullable
                  as bool?,
        notificationCareTips: freezed == notificationCareTips
            ? _value.notificationCareTips
            : notificationCareTips // ignore: cast_nullable_to_non_nullable
                  as bool?,
        notificationTime: freezed == notificationTime
            ? _value.notificationTime
            : notificationTime // ignore: cast_nullable_to_non_nullable
                  as String?,
        doNotDisturbStart: freezed == doNotDisturbStart
            ? _value.doNotDisturbStart
            : doNotDisturbStart // ignore: cast_nullable_to_non_nullable
                  as String?,
        doNotDisturbEnd: freezed == doNotDisturbEnd
            ? _value.doNotDisturbEnd
            : doNotDisturbEnd // ignore: cast_nullable_to_non_nullable
                  as String?,
        theme: freezed == theme
            ? _value.theme
            : theme // ignore: cast_nullable_to_non_nullable
                  as ThemeMode?,
        language: freezed == language
            ? _value.language
            : language // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdateSettingsRequestImpl implements _UpdateSettingsRequest {
  const _$UpdateSettingsRequestImpl({
    this.notificationPeriodReminder,
    this.notificationOvulation,
    this.notificationAnniversary,
    this.notificationDailyRecord,
    this.notificationPartnerPeriod,
    this.notificationPartnerPms,
    this.notificationCareTips,
    this.notificationTime,
    this.doNotDisturbStart,
    this.doNotDisturbEnd,
    this.theme,
    this.language,
  });

  factory _$UpdateSettingsRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateSettingsRequestImplFromJson(json);

  // 알림 설정
  @override
  final bool? notificationPeriodReminder;
  @override
  final bool? notificationOvulation;
  @override
  final bool? notificationAnniversary;
  @override
  final bool? notificationDailyRecord;
  // 파트너 알림 (남성)
  @override
  final bool? notificationPartnerPeriod;
  @override
  final bool? notificationPartnerPms;
  @override
  final bool? notificationCareTips;
  // 알림 시간
  @override
  final String? notificationTime;
  @override
  final String? doNotDisturbStart;
  @override
  final String? doNotDisturbEnd;
  // 앱 설정
  @override
  final ThemeMode? theme;
  @override
  final String? language;

  @override
  String toString() {
    return 'UpdateSettingsRequest(notificationPeriodReminder: $notificationPeriodReminder, notificationOvulation: $notificationOvulation, notificationAnniversary: $notificationAnniversary, notificationDailyRecord: $notificationDailyRecord, notificationPartnerPeriod: $notificationPartnerPeriod, notificationPartnerPms: $notificationPartnerPms, notificationCareTips: $notificationCareTips, notificationTime: $notificationTime, doNotDisturbStart: $doNotDisturbStart, doNotDisturbEnd: $doNotDisturbEnd, theme: $theme, language: $language)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateSettingsRequestImpl &&
            (identical(
                  other.notificationPeriodReminder,
                  notificationPeriodReminder,
                ) ||
                other.notificationPeriodReminder ==
                    notificationPeriodReminder) &&
            (identical(other.notificationOvulation, notificationOvulation) ||
                other.notificationOvulation == notificationOvulation) &&
            (identical(
                  other.notificationAnniversary,
                  notificationAnniversary,
                ) ||
                other.notificationAnniversary == notificationAnniversary) &&
            (identical(
                  other.notificationDailyRecord,
                  notificationDailyRecord,
                ) ||
                other.notificationDailyRecord == notificationDailyRecord) &&
            (identical(
                  other.notificationPartnerPeriod,
                  notificationPartnerPeriod,
                ) ||
                other.notificationPartnerPeriod == notificationPartnerPeriod) &&
            (identical(other.notificationPartnerPms, notificationPartnerPms) ||
                other.notificationPartnerPms == notificationPartnerPms) &&
            (identical(other.notificationCareTips, notificationCareTips) ||
                other.notificationCareTips == notificationCareTips) &&
            (identical(other.notificationTime, notificationTime) ||
                other.notificationTime == notificationTime) &&
            (identical(other.doNotDisturbStart, doNotDisturbStart) ||
                other.doNotDisturbStart == doNotDisturbStart) &&
            (identical(other.doNotDisturbEnd, doNotDisturbEnd) ||
                other.doNotDisturbEnd == doNotDisturbEnd) &&
            (identical(other.theme, theme) || other.theme == theme) &&
            (identical(other.language, language) ||
                other.language == language));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    notificationPeriodReminder,
    notificationOvulation,
    notificationAnniversary,
    notificationDailyRecord,
    notificationPartnerPeriod,
    notificationPartnerPms,
    notificationCareTips,
    notificationTime,
    doNotDisturbStart,
    doNotDisturbEnd,
    theme,
    language,
  );

  /// Create a copy of UpdateSettingsRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateSettingsRequestImplCopyWith<_$UpdateSettingsRequestImpl>
  get copyWith =>
      __$$UpdateSettingsRequestImplCopyWithImpl<_$UpdateSettingsRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateSettingsRequestImplToJson(this);
  }
}

abstract class _UpdateSettingsRequest implements UpdateSettingsRequest {
  const factory _UpdateSettingsRequest({
    final bool? notificationPeriodReminder,
    final bool? notificationOvulation,
    final bool? notificationAnniversary,
    final bool? notificationDailyRecord,
    final bool? notificationPartnerPeriod,
    final bool? notificationPartnerPms,
    final bool? notificationCareTips,
    final String? notificationTime,
    final String? doNotDisturbStart,
    final String? doNotDisturbEnd,
    final ThemeMode? theme,
    final String? language,
  }) = _$UpdateSettingsRequestImpl;

  factory _UpdateSettingsRequest.fromJson(Map<String, dynamic> json) =
      _$UpdateSettingsRequestImpl.fromJson;

  // 알림 설정
  @override
  bool? get notificationPeriodReminder;
  @override
  bool? get notificationOvulation;
  @override
  bool? get notificationAnniversary;
  @override
  bool? get notificationDailyRecord; // 파트너 알림 (남성)
  @override
  bool? get notificationPartnerPeriod;
  @override
  bool? get notificationPartnerPms;
  @override
  bool? get notificationCareTips; // 알림 시간
  @override
  String? get notificationTime;
  @override
  String? get doNotDisturbStart;
  @override
  String? get doNotDisturbEnd; // 앱 설정
  @override
  ThemeMode? get theme;
  @override
  String? get language;

  /// Create a copy of UpdateSettingsRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateSettingsRequestImplCopyWith<_$UpdateSettingsRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}
