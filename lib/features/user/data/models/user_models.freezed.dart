// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CycleInfoSummary _$CycleInfoSummaryFromJson(Map<String, dynamic> json) {
  return _CycleInfoSummary.fromJson(json);
}

/// @nodoc
mixin _$CycleInfoSummary {
  int? get averageCycleLength => throw _privateConstructorUsedError;
  DateTime? get lastPeriodDate => throw _privateConstructorUsedError;
  DateTime? get nextPeriodDate => throw _privateConstructorUsedError;
  int? get currentCycleDay => throw _privateConstructorUsedError;

  /// Serializes this CycleInfoSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CycleInfoSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CycleInfoSummaryCopyWith<CycleInfoSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CycleInfoSummaryCopyWith<$Res> {
  factory $CycleInfoSummaryCopyWith(
    CycleInfoSummary value,
    $Res Function(CycleInfoSummary) then,
  ) = _$CycleInfoSummaryCopyWithImpl<$Res, CycleInfoSummary>;
  @useResult
  $Res call({
    int? averageCycleLength,
    DateTime? lastPeriodDate,
    DateTime? nextPeriodDate,
    int? currentCycleDay,
  });
}

/// @nodoc
class _$CycleInfoSummaryCopyWithImpl<$Res, $Val extends CycleInfoSummary>
    implements $CycleInfoSummaryCopyWith<$Res> {
  _$CycleInfoSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CycleInfoSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? averageCycleLength = freezed,
    Object? lastPeriodDate = freezed,
    Object? nextPeriodDate = freezed,
    Object? currentCycleDay = freezed,
  }) {
    return _then(
      _value.copyWith(
            averageCycleLength: freezed == averageCycleLength
                ? _value.averageCycleLength
                : averageCycleLength // ignore: cast_nullable_to_non_nullable
                      as int?,
            lastPeriodDate: freezed == lastPeriodDate
                ? _value.lastPeriodDate
                : lastPeriodDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            nextPeriodDate: freezed == nextPeriodDate
                ? _value.nextPeriodDate
                : nextPeriodDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            currentCycleDay: freezed == currentCycleDay
                ? _value.currentCycleDay
                : currentCycleDay // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CycleInfoSummaryImplCopyWith<$Res>
    implements $CycleInfoSummaryCopyWith<$Res> {
  factory _$$CycleInfoSummaryImplCopyWith(
    _$CycleInfoSummaryImpl value,
    $Res Function(_$CycleInfoSummaryImpl) then,
  ) = __$$CycleInfoSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int? averageCycleLength,
    DateTime? lastPeriodDate,
    DateTime? nextPeriodDate,
    int? currentCycleDay,
  });
}

/// @nodoc
class __$$CycleInfoSummaryImplCopyWithImpl<$Res>
    extends _$CycleInfoSummaryCopyWithImpl<$Res, _$CycleInfoSummaryImpl>
    implements _$$CycleInfoSummaryImplCopyWith<$Res> {
  __$$CycleInfoSummaryImplCopyWithImpl(
    _$CycleInfoSummaryImpl _value,
    $Res Function(_$CycleInfoSummaryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CycleInfoSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? averageCycleLength = freezed,
    Object? lastPeriodDate = freezed,
    Object? nextPeriodDate = freezed,
    Object? currentCycleDay = freezed,
  }) {
    return _then(
      _$CycleInfoSummaryImpl(
        averageCycleLength: freezed == averageCycleLength
            ? _value.averageCycleLength
            : averageCycleLength // ignore: cast_nullable_to_non_nullable
                  as int?,
        lastPeriodDate: freezed == lastPeriodDate
            ? _value.lastPeriodDate
            : lastPeriodDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        nextPeriodDate: freezed == nextPeriodDate
            ? _value.nextPeriodDate
            : nextPeriodDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        currentCycleDay: freezed == currentCycleDay
            ? _value.currentCycleDay
            : currentCycleDay // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CycleInfoSummaryImpl implements _CycleInfoSummary {
  const _$CycleInfoSummaryImpl({
    this.averageCycleLength,
    this.lastPeriodDate,
    this.nextPeriodDate,
    this.currentCycleDay,
  });

  factory _$CycleInfoSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$CycleInfoSummaryImplFromJson(json);

  @override
  final int? averageCycleLength;
  @override
  final DateTime? lastPeriodDate;
  @override
  final DateTime? nextPeriodDate;
  @override
  final int? currentCycleDay;

  @override
  String toString() {
    return 'CycleInfoSummary(averageCycleLength: $averageCycleLength, lastPeriodDate: $lastPeriodDate, nextPeriodDate: $nextPeriodDate, currentCycleDay: $currentCycleDay)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CycleInfoSummaryImpl &&
            (identical(other.averageCycleLength, averageCycleLength) ||
                other.averageCycleLength == averageCycleLength) &&
            (identical(other.lastPeriodDate, lastPeriodDate) ||
                other.lastPeriodDate == lastPeriodDate) &&
            (identical(other.nextPeriodDate, nextPeriodDate) ||
                other.nextPeriodDate == nextPeriodDate) &&
            (identical(other.currentCycleDay, currentCycleDay) ||
                other.currentCycleDay == currentCycleDay));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    averageCycleLength,
    lastPeriodDate,
    nextPeriodDate,
    currentCycleDay,
  );

  /// Create a copy of CycleInfoSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CycleInfoSummaryImplCopyWith<_$CycleInfoSummaryImpl> get copyWith =>
      __$$CycleInfoSummaryImplCopyWithImpl<_$CycleInfoSummaryImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CycleInfoSummaryImplToJson(this);
  }
}

abstract class _CycleInfoSummary implements CycleInfoSummary {
  const factory _CycleInfoSummary({
    final int? averageCycleLength,
    final DateTime? lastPeriodDate,
    final DateTime? nextPeriodDate,
    final int? currentCycleDay,
  }) = _$CycleInfoSummaryImpl;

  factory _CycleInfoSummary.fromJson(Map<String, dynamic> json) =
      _$CycleInfoSummaryImpl.fromJson;

  @override
  int? get averageCycleLength;
  @override
  DateTime? get lastPeriodDate;
  @override
  DateTime? get nextPeriodDate;
  @override
  int? get currentCycleDay;

  /// Create a copy of CycleInfoSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CycleInfoSummaryImplCopyWith<_$CycleInfoSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProfileResponse _$ProfileResponseFromJson(Map<String, dynamic> json) {
  return _ProfileResponse.fromJson(json);
}

/// @nodoc
mixin _$ProfileResponse {
  int get id => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String? get nickname => throw _privateConstructorUsedError;
  Gender? get gender => throw _privateConstructorUsedError;
  DateTime? get birthDate => throw _privateConstructorUsedError;
  String? get profileImageUrl => throw _privateConstructorUsedError;
  AuthProvider get provider => throw _privateConstructorUsedError;
  SubscriptionTier get subscriptionTier => throw _privateConstructorUsedError;
  DateTime? get subscriptionExpiresAt => throw _privateConstructorUsedError;
  bool get emailVerified => throw _privateConstructorUsedError;
  bool get onboardingCompleted => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  CycleInfoSummary? get cycleInfo => throw _privateConstructorUsedError;
  DateTime? get nicknameChangedAt => throw _privateConstructorUsedError;

  /// Serializes this ProfileResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProfileResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfileResponseCopyWith<ProfileResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileResponseCopyWith<$Res> {
  factory $ProfileResponseCopyWith(
    ProfileResponse value,
    $Res Function(ProfileResponse) then,
  ) = _$ProfileResponseCopyWithImpl<$Res, ProfileResponse>;
  @useResult
  $Res call({
    int id,
    String email,
    String? nickname,
    Gender? gender,
    DateTime? birthDate,
    String? profileImageUrl,
    AuthProvider provider,
    SubscriptionTier subscriptionTier,
    DateTime? subscriptionExpiresAt,
    bool emailVerified,
    bool onboardingCompleted,
    DateTime createdAt,
    CycleInfoSummary? cycleInfo,
    DateTime? nicknameChangedAt,
  });

  $CycleInfoSummaryCopyWith<$Res>? get cycleInfo;
}

/// @nodoc
class _$ProfileResponseCopyWithImpl<$Res, $Val extends ProfileResponse>
    implements $ProfileResponseCopyWith<$Res> {
  _$ProfileResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProfileResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? nickname = freezed,
    Object? gender = freezed,
    Object? birthDate = freezed,
    Object? profileImageUrl = freezed,
    Object? provider = null,
    Object? subscriptionTier = null,
    Object? subscriptionExpiresAt = freezed,
    Object? emailVerified = null,
    Object? onboardingCompleted = null,
    Object? createdAt = null,
    Object? cycleInfo = freezed,
    Object? nicknameChangedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            nickname: freezed == nickname
                ? _value.nickname
                : nickname // ignore: cast_nullable_to_non_nullable
                      as String?,
            gender: freezed == gender
                ? _value.gender
                : gender // ignore: cast_nullable_to_non_nullable
                      as Gender?,
            birthDate: freezed == birthDate
                ? _value.birthDate
                : birthDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            profileImageUrl: freezed == profileImageUrl
                ? _value.profileImageUrl
                : profileImageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            provider: null == provider
                ? _value.provider
                : provider // ignore: cast_nullable_to_non_nullable
                      as AuthProvider,
            subscriptionTier: null == subscriptionTier
                ? _value.subscriptionTier
                : subscriptionTier // ignore: cast_nullable_to_non_nullable
                      as SubscriptionTier,
            subscriptionExpiresAt: freezed == subscriptionExpiresAt
                ? _value.subscriptionExpiresAt
                : subscriptionExpiresAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            emailVerified: null == emailVerified
                ? _value.emailVerified
                : emailVerified // ignore: cast_nullable_to_non_nullable
                      as bool,
            onboardingCompleted: null == onboardingCompleted
                ? _value.onboardingCompleted
                : onboardingCompleted // ignore: cast_nullable_to_non_nullable
                      as bool,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            cycleInfo: freezed == cycleInfo
                ? _value.cycleInfo
                : cycleInfo // ignore: cast_nullable_to_non_nullable
                      as CycleInfoSummary?,
            nicknameChangedAt: freezed == nicknameChangedAt
                ? _value.nicknameChangedAt
                : nicknameChangedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }

  /// Create a copy of ProfileResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CycleInfoSummaryCopyWith<$Res>? get cycleInfo {
    if (_value.cycleInfo == null) {
      return null;
    }

    return $CycleInfoSummaryCopyWith<$Res>(_value.cycleInfo!, (value) {
      return _then(_value.copyWith(cycleInfo: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProfileResponseImplCopyWith<$Res>
    implements $ProfileResponseCopyWith<$Res> {
  factory _$$ProfileResponseImplCopyWith(
    _$ProfileResponseImpl value,
    $Res Function(_$ProfileResponseImpl) then,
  ) = __$$ProfileResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String email,
    String? nickname,
    Gender? gender,
    DateTime? birthDate,
    String? profileImageUrl,
    AuthProvider provider,
    SubscriptionTier subscriptionTier,
    DateTime? subscriptionExpiresAt,
    bool emailVerified,
    bool onboardingCompleted,
    DateTime createdAt,
    CycleInfoSummary? cycleInfo,
    DateTime? nicknameChangedAt,
  });

  @override
  $CycleInfoSummaryCopyWith<$Res>? get cycleInfo;
}

/// @nodoc
class __$$ProfileResponseImplCopyWithImpl<$Res>
    extends _$ProfileResponseCopyWithImpl<$Res, _$ProfileResponseImpl>
    implements _$$ProfileResponseImplCopyWith<$Res> {
  __$$ProfileResponseImplCopyWithImpl(
    _$ProfileResponseImpl _value,
    $Res Function(_$ProfileResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProfileResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? nickname = freezed,
    Object? gender = freezed,
    Object? birthDate = freezed,
    Object? profileImageUrl = freezed,
    Object? provider = null,
    Object? subscriptionTier = null,
    Object? subscriptionExpiresAt = freezed,
    Object? emailVerified = null,
    Object? onboardingCompleted = null,
    Object? createdAt = null,
    Object? cycleInfo = freezed,
    Object? nicknameChangedAt = freezed,
  }) {
    return _then(
      _$ProfileResponseImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        nickname: freezed == nickname
            ? _value.nickname
            : nickname // ignore: cast_nullable_to_non_nullable
                  as String?,
        gender: freezed == gender
            ? _value.gender
            : gender // ignore: cast_nullable_to_non_nullable
                  as Gender?,
        birthDate: freezed == birthDate
            ? _value.birthDate
            : birthDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        profileImageUrl: freezed == profileImageUrl
            ? _value.profileImageUrl
            : profileImageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        provider: null == provider
            ? _value.provider
            : provider // ignore: cast_nullable_to_non_nullable
                  as AuthProvider,
        subscriptionTier: null == subscriptionTier
            ? _value.subscriptionTier
            : subscriptionTier // ignore: cast_nullable_to_non_nullable
                  as SubscriptionTier,
        subscriptionExpiresAt: freezed == subscriptionExpiresAt
            ? _value.subscriptionExpiresAt
            : subscriptionExpiresAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        emailVerified: null == emailVerified
            ? _value.emailVerified
            : emailVerified // ignore: cast_nullable_to_non_nullable
                  as bool,
        onboardingCompleted: null == onboardingCompleted
            ? _value.onboardingCompleted
            : onboardingCompleted // ignore: cast_nullable_to_non_nullable
                  as bool,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        cycleInfo: freezed == cycleInfo
            ? _value.cycleInfo
            : cycleInfo // ignore: cast_nullable_to_non_nullable
                  as CycleInfoSummary?,
        nicknameChangedAt: freezed == nicknameChangedAt
            ? _value.nicknameChangedAt
            : nicknameChangedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfileResponseImpl implements _ProfileResponse {
  const _$ProfileResponseImpl({
    required this.id,
    required this.email,
    this.nickname,
    this.gender,
    this.birthDate,
    this.profileImageUrl,
    required this.provider,
    required this.subscriptionTier,
    this.subscriptionExpiresAt,
    this.emailVerified = false,
    this.onboardingCompleted = false,
    required this.createdAt,
    this.cycleInfo,
    this.nicknameChangedAt,
  });

  factory _$ProfileResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfileResponseImplFromJson(json);

  @override
  final int id;
  @override
  final String email;
  @override
  final String? nickname;
  @override
  final Gender? gender;
  @override
  final DateTime? birthDate;
  @override
  final String? profileImageUrl;
  @override
  final AuthProvider provider;
  @override
  final SubscriptionTier subscriptionTier;
  @override
  final DateTime? subscriptionExpiresAt;
  @override
  @JsonKey()
  final bool emailVerified;
  @override
  @JsonKey()
  final bool onboardingCompleted;
  @override
  final DateTime createdAt;
  @override
  final CycleInfoSummary? cycleInfo;
  @override
  final DateTime? nicknameChangedAt;

  @override
  String toString() {
    return 'ProfileResponse(id: $id, email: $email, nickname: $nickname, gender: $gender, birthDate: $birthDate, profileImageUrl: $profileImageUrl, provider: $provider, subscriptionTier: $subscriptionTier, subscriptionExpiresAt: $subscriptionExpiresAt, emailVerified: $emailVerified, onboardingCompleted: $onboardingCompleted, createdAt: $createdAt, cycleInfo: $cycleInfo, nicknameChangedAt: $nicknameChangedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.birthDate, birthDate) ||
                other.birthDate == birthDate) &&
            (identical(other.profileImageUrl, profileImageUrl) ||
                other.profileImageUrl == profileImageUrl) &&
            (identical(other.provider, provider) ||
                other.provider == provider) &&
            (identical(other.subscriptionTier, subscriptionTier) ||
                other.subscriptionTier == subscriptionTier) &&
            (identical(other.subscriptionExpiresAt, subscriptionExpiresAt) ||
                other.subscriptionExpiresAt == subscriptionExpiresAt) &&
            (identical(other.emailVerified, emailVerified) ||
                other.emailVerified == emailVerified) &&
            (identical(other.onboardingCompleted, onboardingCompleted) ||
                other.onboardingCompleted == onboardingCompleted) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.cycleInfo, cycleInfo) ||
                other.cycleInfo == cycleInfo) &&
            (identical(other.nicknameChangedAt, nicknameChangedAt) ||
                other.nicknameChangedAt == nicknameChangedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    email,
    nickname,
    gender,
    birthDate,
    profileImageUrl,
    provider,
    subscriptionTier,
    subscriptionExpiresAt,
    emailVerified,
    onboardingCompleted,
    createdAt,
    cycleInfo,
    nicknameChangedAt,
  );

  /// Create a copy of ProfileResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileResponseImplCopyWith<_$ProfileResponseImpl> get copyWith =>
      __$$ProfileResponseImplCopyWithImpl<_$ProfileResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfileResponseImplToJson(this);
  }
}

abstract class _ProfileResponse implements ProfileResponse {
  const factory _ProfileResponse({
    required final int id,
    required final String email,
    final String? nickname,
    final Gender? gender,
    final DateTime? birthDate,
    final String? profileImageUrl,
    required final AuthProvider provider,
    required final SubscriptionTier subscriptionTier,
    final DateTime? subscriptionExpiresAt,
    final bool emailVerified,
    final bool onboardingCompleted,
    required final DateTime createdAt,
    final CycleInfoSummary? cycleInfo,
    final DateTime? nicknameChangedAt,
  }) = _$ProfileResponseImpl;

  factory _ProfileResponse.fromJson(Map<String, dynamic> json) =
      _$ProfileResponseImpl.fromJson;

  @override
  int get id;
  @override
  String get email;
  @override
  String? get nickname;
  @override
  Gender? get gender;
  @override
  DateTime? get birthDate;
  @override
  String? get profileImageUrl;
  @override
  AuthProvider get provider;
  @override
  SubscriptionTier get subscriptionTier;
  @override
  DateTime? get subscriptionExpiresAt;
  @override
  bool get emailVerified;
  @override
  bool get onboardingCompleted;
  @override
  DateTime get createdAt;
  @override
  CycleInfoSummary? get cycleInfo;
  @override
  DateTime? get nicknameChangedAt;

  /// Create a copy of ProfileResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileResponseImplCopyWith<_$ProfileResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UpdateProfileRequest _$UpdateProfileRequestFromJson(Map<String, dynamic> json) {
  return _UpdateProfileRequest.fromJson(json);
}

/// @nodoc
mixin _$UpdateProfileRequest {
  String? get nickname => throw _privateConstructorUsedError;
  DateTime? get birthDate => throw _privateConstructorUsedError;
  int? get averageCycleLength => throw _privateConstructorUsedError;
  int? get averagePeriodLength => throw _privateConstructorUsedError;

  /// Serializes this UpdateProfileRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UpdateProfileRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdateProfileRequestCopyWith<UpdateProfileRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateProfileRequestCopyWith<$Res> {
  factory $UpdateProfileRequestCopyWith(
    UpdateProfileRequest value,
    $Res Function(UpdateProfileRequest) then,
  ) = _$UpdateProfileRequestCopyWithImpl<$Res, UpdateProfileRequest>;
  @useResult
  $Res call({
    String? nickname,
    DateTime? birthDate,
    int? averageCycleLength,
    int? averagePeriodLength,
  });
}

/// @nodoc
class _$UpdateProfileRequestCopyWithImpl<
  $Res,
  $Val extends UpdateProfileRequest
>
    implements $UpdateProfileRequestCopyWith<$Res> {
  _$UpdateProfileRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdateProfileRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nickname = freezed,
    Object? birthDate = freezed,
    Object? averageCycleLength = freezed,
    Object? averagePeriodLength = freezed,
  }) {
    return _then(
      _value.copyWith(
            nickname: freezed == nickname
                ? _value.nickname
                : nickname // ignore: cast_nullable_to_non_nullable
                      as String?,
            birthDate: freezed == birthDate
                ? _value.birthDate
                : birthDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            averageCycleLength: freezed == averageCycleLength
                ? _value.averageCycleLength
                : averageCycleLength // ignore: cast_nullable_to_non_nullable
                      as int?,
            averagePeriodLength: freezed == averagePeriodLength
                ? _value.averagePeriodLength
                : averagePeriodLength // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UpdateProfileRequestImplCopyWith<$Res>
    implements $UpdateProfileRequestCopyWith<$Res> {
  factory _$$UpdateProfileRequestImplCopyWith(
    _$UpdateProfileRequestImpl value,
    $Res Function(_$UpdateProfileRequestImpl) then,
  ) = __$$UpdateProfileRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? nickname,
    DateTime? birthDate,
    int? averageCycleLength,
    int? averagePeriodLength,
  });
}

/// @nodoc
class __$$UpdateProfileRequestImplCopyWithImpl<$Res>
    extends _$UpdateProfileRequestCopyWithImpl<$Res, _$UpdateProfileRequestImpl>
    implements _$$UpdateProfileRequestImplCopyWith<$Res> {
  __$$UpdateProfileRequestImplCopyWithImpl(
    _$UpdateProfileRequestImpl _value,
    $Res Function(_$UpdateProfileRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UpdateProfileRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nickname = freezed,
    Object? birthDate = freezed,
    Object? averageCycleLength = freezed,
    Object? averagePeriodLength = freezed,
  }) {
    return _then(
      _$UpdateProfileRequestImpl(
        nickname: freezed == nickname
            ? _value.nickname
            : nickname // ignore: cast_nullable_to_non_nullable
                  as String?,
        birthDate: freezed == birthDate
            ? _value.birthDate
            : birthDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        averageCycleLength: freezed == averageCycleLength
            ? _value.averageCycleLength
            : averageCycleLength // ignore: cast_nullable_to_non_nullable
                  as int?,
        averagePeriodLength: freezed == averagePeriodLength
            ? _value.averagePeriodLength
            : averagePeriodLength // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdateProfileRequestImpl implements _UpdateProfileRequest {
  const _$UpdateProfileRequestImpl({
    this.nickname,
    this.birthDate,
    this.averageCycleLength,
    this.averagePeriodLength,
  });

  factory _$UpdateProfileRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateProfileRequestImplFromJson(json);

  @override
  final String? nickname;
  @override
  final DateTime? birthDate;
  @override
  final int? averageCycleLength;
  @override
  final int? averagePeriodLength;

  @override
  String toString() {
    return 'UpdateProfileRequest(nickname: $nickname, birthDate: $birthDate, averageCycleLength: $averageCycleLength, averagePeriodLength: $averagePeriodLength)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateProfileRequestImpl &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.birthDate, birthDate) ||
                other.birthDate == birthDate) &&
            (identical(other.averageCycleLength, averageCycleLength) ||
                other.averageCycleLength == averageCycleLength) &&
            (identical(other.averagePeriodLength, averagePeriodLength) ||
                other.averagePeriodLength == averagePeriodLength));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    nickname,
    birthDate,
    averageCycleLength,
    averagePeriodLength,
  );

  /// Create a copy of UpdateProfileRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateProfileRequestImplCopyWith<_$UpdateProfileRequestImpl>
  get copyWith =>
      __$$UpdateProfileRequestImplCopyWithImpl<_$UpdateProfileRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateProfileRequestImplToJson(this);
  }
}

abstract class _UpdateProfileRequest implements UpdateProfileRequest {
  const factory _UpdateProfileRequest({
    final String? nickname,
    final DateTime? birthDate,
    final int? averageCycleLength,
    final int? averagePeriodLength,
  }) = _$UpdateProfileRequestImpl;

  factory _UpdateProfileRequest.fromJson(Map<String, dynamic> json) =
      _$UpdateProfileRequestImpl.fromJson;

  @override
  String? get nickname;
  @override
  DateTime? get birthDate;
  @override
  int? get averageCycleLength;
  @override
  int? get averagePeriodLength;

  /// Create a copy of UpdateProfileRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateProfileRequestImplCopyWith<_$UpdateProfileRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}

ProfileImageResponse _$ProfileImageResponseFromJson(Map<String, dynamic> json) {
  return _ProfileImageResponse.fromJson(json);
}

/// @nodoc
mixin _$ProfileImageResponse {
  String get imageUrl => throw _privateConstructorUsedError;

  /// Serializes this ProfileImageResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProfileImageResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfileImageResponseCopyWith<ProfileImageResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileImageResponseCopyWith<$Res> {
  factory $ProfileImageResponseCopyWith(
    ProfileImageResponse value,
    $Res Function(ProfileImageResponse) then,
  ) = _$ProfileImageResponseCopyWithImpl<$Res, ProfileImageResponse>;
  @useResult
  $Res call({String imageUrl});
}

/// @nodoc
class _$ProfileImageResponseCopyWithImpl<
  $Res,
  $Val extends ProfileImageResponse
>
    implements $ProfileImageResponseCopyWith<$Res> {
  _$ProfileImageResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProfileImageResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? imageUrl = null}) {
    return _then(
      _value.copyWith(
            imageUrl: null == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProfileImageResponseImplCopyWith<$Res>
    implements $ProfileImageResponseCopyWith<$Res> {
  factory _$$ProfileImageResponseImplCopyWith(
    _$ProfileImageResponseImpl value,
    $Res Function(_$ProfileImageResponseImpl) then,
  ) = __$$ProfileImageResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String imageUrl});
}

/// @nodoc
class __$$ProfileImageResponseImplCopyWithImpl<$Res>
    extends _$ProfileImageResponseCopyWithImpl<$Res, _$ProfileImageResponseImpl>
    implements _$$ProfileImageResponseImplCopyWith<$Res> {
  __$$ProfileImageResponseImplCopyWithImpl(
    _$ProfileImageResponseImpl _value,
    $Res Function(_$ProfileImageResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProfileImageResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? imageUrl = null}) {
    return _then(
      _$ProfileImageResponseImpl(
        imageUrl: null == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfileImageResponseImpl implements _ProfileImageResponse {
  const _$ProfileImageResponseImpl({required this.imageUrl});

  factory _$ProfileImageResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfileImageResponseImplFromJson(json);

  @override
  final String imageUrl;

  @override
  String toString() {
    return 'ProfileImageResponse(imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileImageResponseImpl &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, imageUrl);

  /// Create a copy of ProfileImageResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileImageResponseImplCopyWith<_$ProfileImageResponseImpl>
  get copyWith =>
      __$$ProfileImageResponseImplCopyWithImpl<_$ProfileImageResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfileImageResponseImplToJson(this);
  }
}

abstract class _ProfileImageResponse implements ProfileImageResponse {
  const factory _ProfileImageResponse({required final String imageUrl}) =
      _$ProfileImageResponseImpl;

  factory _ProfileImageResponse.fromJson(Map<String, dynamic> json) =
      _$ProfileImageResponseImpl.fromJson;

  @override
  String get imageUrl;

  /// Create a copy of ProfileImageResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileImageResponseImplCopyWith<_$ProfileImageResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}
