// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

OnboardingStatusResponse _$OnboardingStatusResponseFromJson(
  Map<String, dynamic> json,
) {
  return _OnboardingStatusResponse.fromJson(json);
}

/// @nodoc
mixin _$OnboardingStatusResponse {
  bool get isCompleted => throw _privateConstructorUsedError;
  int get currentStep => throw _privateConstructorUsedError;
  int get totalSteps => throw _privateConstructorUsedError;
  List<String> get missingSteps => throw _privateConstructorUsedError;

  /// Serializes this OnboardingStatusResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OnboardingStatusResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OnboardingStatusResponseCopyWith<OnboardingStatusResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OnboardingStatusResponseCopyWith<$Res> {
  factory $OnboardingStatusResponseCopyWith(
    OnboardingStatusResponse value,
    $Res Function(OnboardingStatusResponse) then,
  ) = _$OnboardingStatusResponseCopyWithImpl<$Res, OnboardingStatusResponse>;
  @useResult
  $Res call({
    bool isCompleted,
    int currentStep,
    int totalSteps,
    List<String> missingSteps,
  });
}

/// @nodoc
class _$OnboardingStatusResponseCopyWithImpl<
  $Res,
  $Val extends OnboardingStatusResponse
>
    implements $OnboardingStatusResponseCopyWith<$Res> {
  _$OnboardingStatusResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OnboardingStatusResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isCompleted = null,
    Object? currentStep = null,
    Object? totalSteps = null,
    Object? missingSteps = null,
  }) {
    return _then(
      _value.copyWith(
            isCompleted: null == isCompleted
                ? _value.isCompleted
                : isCompleted // ignore: cast_nullable_to_non_nullable
                      as bool,
            currentStep: null == currentStep
                ? _value.currentStep
                : currentStep // ignore: cast_nullable_to_non_nullable
                      as int,
            totalSteps: null == totalSteps
                ? _value.totalSteps
                : totalSteps // ignore: cast_nullable_to_non_nullable
                      as int,
            missingSteps: null == missingSteps
                ? _value.missingSteps
                : missingSteps // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OnboardingStatusResponseImplCopyWith<$Res>
    implements $OnboardingStatusResponseCopyWith<$Res> {
  factory _$$OnboardingStatusResponseImplCopyWith(
    _$OnboardingStatusResponseImpl value,
    $Res Function(_$OnboardingStatusResponseImpl) then,
  ) = __$$OnboardingStatusResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool isCompleted,
    int currentStep,
    int totalSteps,
    List<String> missingSteps,
  });
}

/// @nodoc
class __$$OnboardingStatusResponseImplCopyWithImpl<$Res>
    extends
        _$OnboardingStatusResponseCopyWithImpl<
          $Res,
          _$OnboardingStatusResponseImpl
        >
    implements _$$OnboardingStatusResponseImplCopyWith<$Res> {
  __$$OnboardingStatusResponseImplCopyWithImpl(
    _$OnboardingStatusResponseImpl _value,
    $Res Function(_$OnboardingStatusResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OnboardingStatusResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isCompleted = null,
    Object? currentStep = null,
    Object? totalSteps = null,
    Object? missingSteps = null,
  }) {
    return _then(
      _$OnboardingStatusResponseImpl(
        isCompleted: null == isCompleted
            ? _value.isCompleted
            : isCompleted // ignore: cast_nullable_to_non_nullable
                  as bool,
        currentStep: null == currentStep
            ? _value.currentStep
            : currentStep // ignore: cast_nullable_to_non_nullable
                  as int,
        totalSteps: null == totalSteps
            ? _value.totalSteps
            : totalSteps // ignore: cast_nullable_to_non_nullable
                  as int,
        missingSteps: null == missingSteps
            ? _value._missingSteps
            : missingSteps // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OnboardingStatusResponseImpl implements _OnboardingStatusResponse {
  const _$OnboardingStatusResponseImpl({
    required this.isCompleted,
    required this.currentStep,
    required this.totalSteps,
    final List<String> missingSteps = const [],
  }) : _missingSteps = missingSteps;

  factory _$OnboardingStatusResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$OnboardingStatusResponseImplFromJson(json);

  @override
  final bool isCompleted;
  @override
  final int currentStep;
  @override
  final int totalSteps;
  final List<String> _missingSteps;
  @override
  @JsonKey()
  List<String> get missingSteps {
    if (_missingSteps is EqualUnmodifiableListView) return _missingSteps;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_missingSteps);
  }

  @override
  String toString() {
    return 'OnboardingStatusResponse(isCompleted: $isCompleted, currentStep: $currentStep, totalSteps: $totalSteps, missingSteps: $missingSteps)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnboardingStatusResponseImpl &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.currentStep, currentStep) ||
                other.currentStep == currentStep) &&
            (identical(other.totalSteps, totalSteps) ||
                other.totalSteps == totalSteps) &&
            const DeepCollectionEquality().equals(
              other._missingSteps,
              _missingSteps,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    isCompleted,
    currentStep,
    totalSteps,
    const DeepCollectionEquality().hash(_missingSteps),
  );

  /// Create a copy of OnboardingStatusResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OnboardingStatusResponseImplCopyWith<_$OnboardingStatusResponseImpl>
  get copyWith =>
      __$$OnboardingStatusResponseImplCopyWithImpl<
        _$OnboardingStatusResponseImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OnboardingStatusResponseImplToJson(this);
  }
}

abstract class _OnboardingStatusResponse implements OnboardingStatusResponse {
  const factory _OnboardingStatusResponse({
    required final bool isCompleted,
    required final int currentStep,
    required final int totalSteps,
    final List<String> missingSteps,
  }) = _$OnboardingStatusResponseImpl;

  factory _OnboardingStatusResponse.fromJson(Map<String, dynamic> json) =
      _$OnboardingStatusResponseImpl.fromJson;

  @override
  bool get isCompleted;
  @override
  int get currentStep;
  @override
  int get totalSteps;
  @override
  List<String> get missingSteps;

  /// Create a copy of OnboardingStatusResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OnboardingStatusResponseImplCopyWith<_$OnboardingStatusResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

OnboardingRequest _$OnboardingRequestFromJson(Map<String, dynamic> json) {
  return _OnboardingRequest.fromJson(json);
}

/// @nodoc
mixin _$OnboardingRequest {
  Gender get gender => throw _privateConstructorUsedError;
  DateTime? get birthDate => throw _privateConstructorUsedError;
  int get cycleLength => throw _privateConstructorUsedError;
  int get periodLength => throw _privateConstructorUsedError;
  DateTime? get lastPeriodStartDate => throw _privateConstructorUsedError;

  /// Serializes this OnboardingRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OnboardingRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OnboardingRequestCopyWith<OnboardingRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OnboardingRequestCopyWith<$Res> {
  factory $OnboardingRequestCopyWith(
    OnboardingRequest value,
    $Res Function(OnboardingRequest) then,
  ) = _$OnboardingRequestCopyWithImpl<$Res, OnboardingRequest>;
  @useResult
  $Res call({
    Gender gender,
    DateTime? birthDate,
    int cycleLength,
    int periodLength,
    DateTime? lastPeriodStartDate,
  });
}

/// @nodoc
class _$OnboardingRequestCopyWithImpl<$Res, $Val extends OnboardingRequest>
    implements $OnboardingRequestCopyWith<$Res> {
  _$OnboardingRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OnboardingRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gender = null,
    Object? birthDate = freezed,
    Object? cycleLength = null,
    Object? periodLength = null,
    Object? lastPeriodStartDate = freezed,
  }) {
    return _then(
      _value.copyWith(
            gender: null == gender
                ? _value.gender
                : gender // ignore: cast_nullable_to_non_nullable
                      as Gender,
            birthDate: freezed == birthDate
                ? _value.birthDate
                : birthDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            cycleLength: null == cycleLength
                ? _value.cycleLength
                : cycleLength // ignore: cast_nullable_to_non_nullable
                      as int,
            periodLength: null == periodLength
                ? _value.periodLength
                : periodLength // ignore: cast_nullable_to_non_nullable
                      as int,
            lastPeriodStartDate: freezed == lastPeriodStartDate
                ? _value.lastPeriodStartDate
                : lastPeriodStartDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OnboardingRequestImplCopyWith<$Res>
    implements $OnboardingRequestCopyWith<$Res> {
  factory _$$OnboardingRequestImplCopyWith(
    _$OnboardingRequestImpl value,
    $Res Function(_$OnboardingRequestImpl) then,
  ) = __$$OnboardingRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    Gender gender,
    DateTime? birthDate,
    int cycleLength,
    int periodLength,
    DateTime? lastPeriodStartDate,
  });
}

/// @nodoc
class __$$OnboardingRequestImplCopyWithImpl<$Res>
    extends _$OnboardingRequestCopyWithImpl<$Res, _$OnboardingRequestImpl>
    implements _$$OnboardingRequestImplCopyWith<$Res> {
  __$$OnboardingRequestImplCopyWithImpl(
    _$OnboardingRequestImpl _value,
    $Res Function(_$OnboardingRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OnboardingRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gender = null,
    Object? birthDate = freezed,
    Object? cycleLength = null,
    Object? periodLength = null,
    Object? lastPeriodStartDate = freezed,
  }) {
    return _then(
      _$OnboardingRequestImpl(
        gender: null == gender
            ? _value.gender
            : gender // ignore: cast_nullable_to_non_nullable
                  as Gender,
        birthDate: freezed == birthDate
            ? _value.birthDate
            : birthDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        cycleLength: null == cycleLength
            ? _value.cycleLength
            : cycleLength // ignore: cast_nullable_to_non_nullable
                  as int,
        periodLength: null == periodLength
            ? _value.periodLength
            : periodLength // ignore: cast_nullable_to_non_nullable
                  as int,
        lastPeriodStartDate: freezed == lastPeriodStartDate
            ? _value.lastPeriodStartDate
            : lastPeriodStartDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OnboardingRequestImpl implements _OnboardingRequest {
  const _$OnboardingRequestImpl({
    required this.gender,
    this.birthDate,
    this.cycleLength = 28,
    this.periodLength = 5,
    this.lastPeriodStartDate,
  });

  factory _$OnboardingRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$OnboardingRequestImplFromJson(json);

  @override
  final Gender gender;
  @override
  final DateTime? birthDate;
  @override
  @JsonKey()
  final int cycleLength;
  @override
  @JsonKey()
  final int periodLength;
  @override
  final DateTime? lastPeriodStartDate;

  @override
  String toString() {
    return 'OnboardingRequest(gender: $gender, birthDate: $birthDate, cycleLength: $cycleLength, periodLength: $periodLength, lastPeriodStartDate: $lastPeriodStartDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnboardingRequestImpl &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.birthDate, birthDate) ||
                other.birthDate == birthDate) &&
            (identical(other.cycleLength, cycleLength) ||
                other.cycleLength == cycleLength) &&
            (identical(other.periodLength, periodLength) ||
                other.periodLength == periodLength) &&
            (identical(other.lastPeriodStartDate, lastPeriodStartDate) ||
                other.lastPeriodStartDate == lastPeriodStartDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    gender,
    birthDate,
    cycleLength,
    periodLength,
    lastPeriodStartDate,
  );

  /// Create a copy of OnboardingRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OnboardingRequestImplCopyWith<_$OnboardingRequestImpl> get copyWith =>
      __$$OnboardingRequestImplCopyWithImpl<_$OnboardingRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$OnboardingRequestImplToJson(this);
  }
}

abstract class _OnboardingRequest implements OnboardingRequest {
  const factory _OnboardingRequest({
    required final Gender gender,
    final DateTime? birthDate,
    final int cycleLength,
    final int periodLength,
    final DateTime? lastPeriodStartDate,
  }) = _$OnboardingRequestImpl;

  factory _OnboardingRequest.fromJson(Map<String, dynamic> json) =
      _$OnboardingRequestImpl.fromJson;

  @override
  Gender get gender;
  @override
  DateTime? get birthDate;
  @override
  int get cycleLength;
  @override
  int get periodLength;
  @override
  DateTime? get lastPeriodStartDate;

  /// Create a copy of OnboardingRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OnboardingRequestImplCopyWith<_$OnboardingRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CycleSetupRequest _$CycleSetupRequestFromJson(Map<String, dynamic> json) {
  return _CycleSetupRequest.fromJson(json);
}

/// @nodoc
mixin _$CycleSetupRequest {
  DateTime get lastPeriodDate => throw _privateConstructorUsedError;
  int get averageCycleLength => throw _privateConstructorUsedError;
  int get averagePeriodLength => throw _privateConstructorUsedError;

  /// Serializes this CycleSetupRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CycleSetupRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CycleSetupRequestCopyWith<CycleSetupRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CycleSetupRequestCopyWith<$Res> {
  factory $CycleSetupRequestCopyWith(
    CycleSetupRequest value,
    $Res Function(CycleSetupRequest) then,
  ) = _$CycleSetupRequestCopyWithImpl<$Res, CycleSetupRequest>;
  @useResult
  $Res call({
    DateTime lastPeriodDate,
    int averageCycleLength,
    int averagePeriodLength,
  });
}

/// @nodoc
class _$CycleSetupRequestCopyWithImpl<$Res, $Val extends CycleSetupRequest>
    implements $CycleSetupRequestCopyWith<$Res> {
  _$CycleSetupRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CycleSetupRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lastPeriodDate = null,
    Object? averageCycleLength = null,
    Object? averagePeriodLength = null,
  }) {
    return _then(
      _value.copyWith(
            lastPeriodDate: null == lastPeriodDate
                ? _value.lastPeriodDate
                : lastPeriodDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            averageCycleLength: null == averageCycleLength
                ? _value.averageCycleLength
                : averageCycleLength // ignore: cast_nullable_to_non_nullable
                      as int,
            averagePeriodLength: null == averagePeriodLength
                ? _value.averagePeriodLength
                : averagePeriodLength // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CycleSetupRequestImplCopyWith<$Res>
    implements $CycleSetupRequestCopyWith<$Res> {
  factory _$$CycleSetupRequestImplCopyWith(
    _$CycleSetupRequestImpl value,
    $Res Function(_$CycleSetupRequestImpl) then,
  ) = __$$CycleSetupRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    DateTime lastPeriodDate,
    int averageCycleLength,
    int averagePeriodLength,
  });
}

/// @nodoc
class __$$CycleSetupRequestImplCopyWithImpl<$Res>
    extends _$CycleSetupRequestCopyWithImpl<$Res, _$CycleSetupRequestImpl>
    implements _$$CycleSetupRequestImplCopyWith<$Res> {
  __$$CycleSetupRequestImplCopyWithImpl(
    _$CycleSetupRequestImpl _value,
    $Res Function(_$CycleSetupRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CycleSetupRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lastPeriodDate = null,
    Object? averageCycleLength = null,
    Object? averagePeriodLength = null,
  }) {
    return _then(
      _$CycleSetupRequestImpl(
        lastPeriodDate: null == lastPeriodDate
            ? _value.lastPeriodDate
            : lastPeriodDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        averageCycleLength: null == averageCycleLength
            ? _value.averageCycleLength
            : averageCycleLength // ignore: cast_nullable_to_non_nullable
                  as int,
        averagePeriodLength: null == averagePeriodLength
            ? _value.averagePeriodLength
            : averagePeriodLength // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CycleSetupRequestImpl implements _CycleSetupRequest {
  const _$CycleSetupRequestImpl({
    required this.lastPeriodDate,
    this.averageCycleLength = 28,
    this.averagePeriodLength = 5,
  });

  factory _$CycleSetupRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$CycleSetupRequestImplFromJson(json);

  @override
  final DateTime lastPeriodDate;
  @override
  @JsonKey()
  final int averageCycleLength;
  @override
  @JsonKey()
  final int averagePeriodLength;

  @override
  String toString() {
    return 'CycleSetupRequest(lastPeriodDate: $lastPeriodDate, averageCycleLength: $averageCycleLength, averagePeriodLength: $averagePeriodLength)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CycleSetupRequestImpl &&
            (identical(other.lastPeriodDate, lastPeriodDate) ||
                other.lastPeriodDate == lastPeriodDate) &&
            (identical(other.averageCycleLength, averageCycleLength) ||
                other.averageCycleLength == averageCycleLength) &&
            (identical(other.averagePeriodLength, averagePeriodLength) ||
                other.averagePeriodLength == averagePeriodLength));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    lastPeriodDate,
    averageCycleLength,
    averagePeriodLength,
  );

  /// Create a copy of CycleSetupRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CycleSetupRequestImplCopyWith<_$CycleSetupRequestImpl> get copyWith =>
      __$$CycleSetupRequestImplCopyWithImpl<_$CycleSetupRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CycleSetupRequestImplToJson(this);
  }
}

abstract class _CycleSetupRequest implements CycleSetupRequest {
  const factory _CycleSetupRequest({
    required final DateTime lastPeriodDate,
    final int averageCycleLength,
    final int averagePeriodLength,
  }) = _$CycleSetupRequestImpl;

  factory _CycleSetupRequest.fromJson(Map<String, dynamic> json) =
      _$CycleSetupRequestImpl.fromJson;

  @override
  DateTime get lastPeriodDate;
  @override
  int get averageCycleLength;
  @override
  int get averagePeriodLength;

  /// Create a copy of CycleSetupRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CycleSetupRequestImplCopyWith<_$CycleSetupRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
