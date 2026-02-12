// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ChangePasswordRequest _$ChangePasswordRequestFromJson(
  Map<String, dynamic> json,
) {
  return _ChangePasswordRequest.fromJson(json);
}

/// @nodoc
mixin _$ChangePasswordRequest {
  String get currentPassword => throw _privateConstructorUsedError;
  String get newPassword => throw _privateConstructorUsedError;

  /// Serializes this ChangePasswordRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChangePasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChangePasswordRequestCopyWith<ChangePasswordRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChangePasswordRequestCopyWith<$Res> {
  factory $ChangePasswordRequestCopyWith(
    ChangePasswordRequest value,
    $Res Function(ChangePasswordRequest) then,
  ) = _$ChangePasswordRequestCopyWithImpl<$Res, ChangePasswordRequest>;
  @useResult
  $Res call({String currentPassword, String newPassword});
}

/// @nodoc
class _$ChangePasswordRequestCopyWithImpl<
  $Res,
  $Val extends ChangePasswordRequest
>
    implements $ChangePasswordRequestCopyWith<$Res> {
  _$ChangePasswordRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChangePasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? currentPassword = null, Object? newPassword = null}) {
    return _then(
      _value.copyWith(
            currentPassword: null == currentPassword
                ? _value.currentPassword
                : currentPassword // ignore: cast_nullable_to_non_nullable
                      as String,
            newPassword: null == newPassword
                ? _value.newPassword
                : newPassword // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChangePasswordRequestImplCopyWith<$Res>
    implements $ChangePasswordRequestCopyWith<$Res> {
  factory _$$ChangePasswordRequestImplCopyWith(
    _$ChangePasswordRequestImpl value,
    $Res Function(_$ChangePasswordRequestImpl) then,
  ) = __$$ChangePasswordRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String currentPassword, String newPassword});
}

/// @nodoc
class __$$ChangePasswordRequestImplCopyWithImpl<$Res>
    extends
        _$ChangePasswordRequestCopyWithImpl<$Res, _$ChangePasswordRequestImpl>
    implements _$$ChangePasswordRequestImplCopyWith<$Res> {
  __$$ChangePasswordRequestImplCopyWithImpl(
    _$ChangePasswordRequestImpl _value,
    $Res Function(_$ChangePasswordRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChangePasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? currentPassword = null, Object? newPassword = null}) {
    return _then(
      _$ChangePasswordRequestImpl(
        currentPassword: null == currentPassword
            ? _value.currentPassword
            : currentPassword // ignore: cast_nullable_to_non_nullable
                  as String,
        newPassword: null == newPassword
            ? _value.newPassword
            : newPassword // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChangePasswordRequestImpl implements _ChangePasswordRequest {
  const _$ChangePasswordRequestImpl({
    required this.currentPassword,
    required this.newPassword,
  });

  factory _$ChangePasswordRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChangePasswordRequestImplFromJson(json);

  @override
  final String currentPassword;
  @override
  final String newPassword;

  @override
  String toString() {
    return 'ChangePasswordRequest(currentPassword: $currentPassword, newPassword: $newPassword)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChangePasswordRequestImpl &&
            (identical(other.currentPassword, currentPassword) ||
                other.currentPassword == currentPassword) &&
            (identical(other.newPassword, newPassword) ||
                other.newPassword == newPassword));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, currentPassword, newPassword);

  /// Create a copy of ChangePasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChangePasswordRequestImplCopyWith<_$ChangePasswordRequestImpl>
  get copyWith =>
      __$$ChangePasswordRequestImplCopyWithImpl<_$ChangePasswordRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ChangePasswordRequestImplToJson(this);
  }
}

abstract class _ChangePasswordRequest implements ChangePasswordRequest {
  const factory _ChangePasswordRequest({
    required final String currentPassword,
    required final String newPassword,
  }) = _$ChangePasswordRequestImpl;

  factory _ChangePasswordRequest.fromJson(Map<String, dynamic> json) =
      _$ChangePasswordRequestImpl.fromJson;

  @override
  String get currentPassword;
  @override
  String get newPassword;

  /// Create a copy of ChangePasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChangePasswordRequestImplCopyWith<_$ChangePasswordRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}

DeviceInfo _$DeviceInfoFromJson(Map<String, dynamic> json) {
  return _DeviceInfo.fromJson(json);
}

/// @nodoc
mixin _$DeviceInfo {
  String get tokenId => throw _privateConstructorUsedError;
  String get deviceName => throw _privateConstructorUsedError;
  String get deviceType => throw _privateConstructorUsedError;
  String? get ipAddress => throw _privateConstructorUsedError;
  DateTime get lastUsedAt => throw _privateConstructorUsedError;
  bool get isCurrentDevice => throw _privateConstructorUsedError;

  /// Serializes this DeviceInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DeviceInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DeviceInfoCopyWith<DeviceInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeviceInfoCopyWith<$Res> {
  factory $DeviceInfoCopyWith(
    DeviceInfo value,
    $Res Function(DeviceInfo) then,
  ) = _$DeviceInfoCopyWithImpl<$Res, DeviceInfo>;
  @useResult
  $Res call({
    String tokenId,
    String deviceName,
    String deviceType,
    String? ipAddress,
    DateTime lastUsedAt,
    bool isCurrentDevice,
  });
}

/// @nodoc
class _$DeviceInfoCopyWithImpl<$Res, $Val extends DeviceInfo>
    implements $DeviceInfoCopyWith<$Res> {
  _$DeviceInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DeviceInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tokenId = null,
    Object? deviceName = null,
    Object? deviceType = null,
    Object? ipAddress = freezed,
    Object? lastUsedAt = null,
    Object? isCurrentDevice = null,
  }) {
    return _then(
      _value.copyWith(
            tokenId: null == tokenId
                ? _value.tokenId
                : tokenId // ignore: cast_nullable_to_non_nullable
                      as String,
            deviceName: null == deviceName
                ? _value.deviceName
                : deviceName // ignore: cast_nullable_to_non_nullable
                      as String,
            deviceType: null == deviceType
                ? _value.deviceType
                : deviceType // ignore: cast_nullable_to_non_nullable
                      as String,
            ipAddress: freezed == ipAddress
                ? _value.ipAddress
                : ipAddress // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastUsedAt: null == lastUsedAt
                ? _value.lastUsedAt
                : lastUsedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            isCurrentDevice: null == isCurrentDevice
                ? _value.isCurrentDevice
                : isCurrentDevice // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DeviceInfoImplCopyWith<$Res>
    implements $DeviceInfoCopyWith<$Res> {
  factory _$$DeviceInfoImplCopyWith(
    _$DeviceInfoImpl value,
    $Res Function(_$DeviceInfoImpl) then,
  ) = __$$DeviceInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String tokenId,
    String deviceName,
    String deviceType,
    String? ipAddress,
    DateTime lastUsedAt,
    bool isCurrentDevice,
  });
}

/// @nodoc
class __$$DeviceInfoImplCopyWithImpl<$Res>
    extends _$DeviceInfoCopyWithImpl<$Res, _$DeviceInfoImpl>
    implements _$$DeviceInfoImplCopyWith<$Res> {
  __$$DeviceInfoImplCopyWithImpl(
    _$DeviceInfoImpl _value,
    $Res Function(_$DeviceInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DeviceInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tokenId = null,
    Object? deviceName = null,
    Object? deviceType = null,
    Object? ipAddress = freezed,
    Object? lastUsedAt = null,
    Object? isCurrentDevice = null,
  }) {
    return _then(
      _$DeviceInfoImpl(
        tokenId: null == tokenId
            ? _value.tokenId
            : tokenId // ignore: cast_nullable_to_non_nullable
                  as String,
        deviceName: null == deviceName
            ? _value.deviceName
            : deviceName // ignore: cast_nullable_to_non_nullable
                  as String,
        deviceType: null == deviceType
            ? _value.deviceType
            : deviceType // ignore: cast_nullable_to_non_nullable
                  as String,
        ipAddress: freezed == ipAddress
            ? _value.ipAddress
            : ipAddress // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastUsedAt: null == lastUsedAt
            ? _value.lastUsedAt
            : lastUsedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        isCurrentDevice: null == isCurrentDevice
            ? _value.isCurrentDevice
            : isCurrentDevice // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DeviceInfoImpl implements _DeviceInfo {
  const _$DeviceInfoImpl({
    required this.tokenId,
    required this.deviceName,
    required this.deviceType,
    this.ipAddress,
    required this.lastUsedAt,
    this.isCurrentDevice = false,
  });

  factory _$DeviceInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeviceInfoImplFromJson(json);

  @override
  final String tokenId;
  @override
  final String deviceName;
  @override
  final String deviceType;
  @override
  final String? ipAddress;
  @override
  final DateTime lastUsedAt;
  @override
  @JsonKey()
  final bool isCurrentDevice;

  @override
  String toString() {
    return 'DeviceInfo(tokenId: $tokenId, deviceName: $deviceName, deviceType: $deviceType, ipAddress: $ipAddress, lastUsedAt: $lastUsedAt, isCurrentDevice: $isCurrentDevice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeviceInfoImpl &&
            (identical(other.tokenId, tokenId) || other.tokenId == tokenId) &&
            (identical(other.deviceName, deviceName) ||
                other.deviceName == deviceName) &&
            (identical(other.deviceType, deviceType) ||
                other.deviceType == deviceType) &&
            (identical(other.ipAddress, ipAddress) ||
                other.ipAddress == ipAddress) &&
            (identical(other.lastUsedAt, lastUsedAt) ||
                other.lastUsedAt == lastUsedAt) &&
            (identical(other.isCurrentDevice, isCurrentDevice) ||
                other.isCurrentDevice == isCurrentDevice));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    tokenId,
    deviceName,
    deviceType,
    ipAddress,
    lastUsedAt,
    isCurrentDevice,
  );

  /// Create a copy of DeviceInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeviceInfoImplCopyWith<_$DeviceInfoImpl> get copyWith =>
      __$$DeviceInfoImplCopyWithImpl<_$DeviceInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeviceInfoImplToJson(this);
  }
}

abstract class _DeviceInfo implements DeviceInfo {
  const factory _DeviceInfo({
    required final String tokenId,
    required final String deviceName,
    required final String deviceType,
    final String? ipAddress,
    required final DateTime lastUsedAt,
    final bool isCurrentDevice,
  }) = _$DeviceInfoImpl;

  factory _DeviceInfo.fromJson(Map<String, dynamic> json) =
      _$DeviceInfoImpl.fromJson;

  @override
  String get tokenId;
  @override
  String get deviceName;
  @override
  String get deviceType;
  @override
  String? get ipAddress;
  @override
  DateTime get lastUsedAt;
  @override
  bool get isCurrentDevice;

  /// Create a copy of DeviceInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeviceInfoImplCopyWith<_$DeviceInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WithdrawRequest _$WithdrawRequestFromJson(Map<String, dynamic> json) {
  return _WithdrawRequest.fromJson(json);
}

/// @nodoc
mixin _$WithdrawRequest {
  String? get reason => throw _privateConstructorUsedError;
  String? get feedback => throw _privateConstructorUsedError;

  /// Serializes this WithdrawRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WithdrawRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WithdrawRequestCopyWith<WithdrawRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WithdrawRequestCopyWith<$Res> {
  factory $WithdrawRequestCopyWith(
    WithdrawRequest value,
    $Res Function(WithdrawRequest) then,
  ) = _$WithdrawRequestCopyWithImpl<$Res, WithdrawRequest>;
  @useResult
  $Res call({String? reason, String? feedback});
}

/// @nodoc
class _$WithdrawRequestCopyWithImpl<$Res, $Val extends WithdrawRequest>
    implements $WithdrawRequestCopyWith<$Res> {
  _$WithdrawRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WithdrawRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? reason = freezed, Object? feedback = freezed}) {
    return _then(
      _value.copyWith(
            reason: freezed == reason
                ? _value.reason
                : reason // ignore: cast_nullable_to_non_nullable
                      as String?,
            feedback: freezed == feedback
                ? _value.feedback
                : feedback // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WithdrawRequestImplCopyWith<$Res>
    implements $WithdrawRequestCopyWith<$Res> {
  factory _$$WithdrawRequestImplCopyWith(
    _$WithdrawRequestImpl value,
    $Res Function(_$WithdrawRequestImpl) then,
  ) = __$$WithdrawRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? reason, String? feedback});
}

/// @nodoc
class __$$WithdrawRequestImplCopyWithImpl<$Res>
    extends _$WithdrawRequestCopyWithImpl<$Res, _$WithdrawRequestImpl>
    implements _$$WithdrawRequestImplCopyWith<$Res> {
  __$$WithdrawRequestImplCopyWithImpl(
    _$WithdrawRequestImpl _value,
    $Res Function(_$WithdrawRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WithdrawRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? reason = freezed, Object? feedback = freezed}) {
    return _then(
      _$WithdrawRequestImpl(
        reason: freezed == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as String?,
        feedback: freezed == feedback
            ? _value.feedback
            : feedback // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WithdrawRequestImpl implements _WithdrawRequest {
  const _$WithdrawRequestImpl({this.reason, this.feedback});

  factory _$WithdrawRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$WithdrawRequestImplFromJson(json);

  @override
  final String? reason;
  @override
  final String? feedback;

  @override
  String toString() {
    return 'WithdrawRequest(reason: $reason, feedback: $feedback)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WithdrawRequestImpl &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.feedback, feedback) ||
                other.feedback == feedback));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, reason, feedback);

  /// Create a copy of WithdrawRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WithdrawRequestImplCopyWith<_$WithdrawRequestImpl> get copyWith =>
      __$$WithdrawRequestImplCopyWithImpl<_$WithdrawRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$WithdrawRequestImplToJson(this);
  }
}

abstract class _WithdrawRequest implements WithdrawRequest {
  const factory _WithdrawRequest({
    final String? reason,
    final String? feedback,
  }) = _$WithdrawRequestImpl;

  factory _WithdrawRequest.fromJson(Map<String, dynamic> json) =
      _$WithdrawRequestImpl.fromJson;

  @override
  String? get reason;
  @override
  String? get feedback;

  /// Create a copy of WithdrawRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WithdrawRequestImplCopyWith<_$WithdrawRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WithdrawResponse _$WithdrawResponseFromJson(Map<String, dynamic> json) {
  return _WithdrawResponse.fromJson(json);
}

/// @nodoc
mixin _$WithdrawResponse {
  DateTime get scheduledDeleteAt => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  /// Serializes this WithdrawResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WithdrawResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WithdrawResponseCopyWith<WithdrawResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WithdrawResponseCopyWith<$Res> {
  factory $WithdrawResponseCopyWith(
    WithdrawResponse value,
    $Res Function(WithdrawResponse) then,
  ) = _$WithdrawResponseCopyWithImpl<$Res, WithdrawResponse>;
  @useResult
  $Res call({DateTime scheduledDeleteAt, String message});
}

/// @nodoc
class _$WithdrawResponseCopyWithImpl<$Res, $Val extends WithdrawResponse>
    implements $WithdrawResponseCopyWith<$Res> {
  _$WithdrawResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WithdrawResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? scheduledDeleteAt = null, Object? message = null}) {
    return _then(
      _value.copyWith(
            scheduledDeleteAt: null == scheduledDeleteAt
                ? _value.scheduledDeleteAt
                : scheduledDeleteAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WithdrawResponseImplCopyWith<$Res>
    implements $WithdrawResponseCopyWith<$Res> {
  factory _$$WithdrawResponseImplCopyWith(
    _$WithdrawResponseImpl value,
    $Res Function(_$WithdrawResponseImpl) then,
  ) = __$$WithdrawResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime scheduledDeleteAt, String message});
}

/// @nodoc
class __$$WithdrawResponseImplCopyWithImpl<$Res>
    extends _$WithdrawResponseCopyWithImpl<$Res, _$WithdrawResponseImpl>
    implements _$$WithdrawResponseImplCopyWith<$Res> {
  __$$WithdrawResponseImplCopyWithImpl(
    _$WithdrawResponseImpl _value,
    $Res Function(_$WithdrawResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WithdrawResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? scheduledDeleteAt = null, Object? message = null}) {
    return _then(
      _$WithdrawResponseImpl(
        scheduledDeleteAt: null == scheduledDeleteAt
            ? _value.scheduledDeleteAt
            : scheduledDeleteAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WithdrawResponseImpl implements _WithdrawResponse {
  const _$WithdrawResponseImpl({
    required this.scheduledDeleteAt,
    required this.message,
  });

  factory _$WithdrawResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$WithdrawResponseImplFromJson(json);

  @override
  final DateTime scheduledDeleteAt;
  @override
  final String message;

  @override
  String toString() {
    return 'WithdrawResponse(scheduledDeleteAt: $scheduledDeleteAt, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WithdrawResponseImpl &&
            (identical(other.scheduledDeleteAt, scheduledDeleteAt) ||
                other.scheduledDeleteAt == scheduledDeleteAt) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, scheduledDeleteAt, message);

  /// Create a copy of WithdrawResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WithdrawResponseImplCopyWith<_$WithdrawResponseImpl> get copyWith =>
      __$$WithdrawResponseImplCopyWithImpl<_$WithdrawResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$WithdrawResponseImplToJson(this);
  }
}

abstract class _WithdrawResponse implements WithdrawResponse {
  const factory _WithdrawResponse({
    required final DateTime scheduledDeleteAt,
    required final String message,
  }) = _$WithdrawResponseImpl;

  factory _WithdrawResponse.fromJson(Map<String, dynamic> json) =
      _$WithdrawResponseImpl.fromJson;

  @override
  DateTime get scheduledDeleteAt;
  @override
  String get message;

  /// Create a copy of WithdrawResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WithdrawResponseImplCopyWith<_$WithdrawResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WithdrawStatusResponse _$WithdrawStatusResponseFromJson(
  Map<String, dynamic> json,
) {
  return _WithdrawStatusResponse.fromJson(json);
}

/// @nodoc
mixin _$WithdrawStatusResponse {
  bool get isWithdrawRequested => throw _privateConstructorUsedError;
  DateTime? get scheduledDeleteAt => throw _privateConstructorUsedError;
  DateTime? get withdrawRequestedAt => throw _privateConstructorUsedError;

  /// Serializes this WithdrawStatusResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WithdrawStatusResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WithdrawStatusResponseCopyWith<WithdrawStatusResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WithdrawStatusResponseCopyWith<$Res> {
  factory $WithdrawStatusResponseCopyWith(
    WithdrawStatusResponse value,
    $Res Function(WithdrawStatusResponse) then,
  ) = _$WithdrawStatusResponseCopyWithImpl<$Res, WithdrawStatusResponse>;
  @useResult
  $Res call({
    bool isWithdrawRequested,
    DateTime? scheduledDeleteAt,
    DateTime? withdrawRequestedAt,
  });
}

/// @nodoc
class _$WithdrawStatusResponseCopyWithImpl<
  $Res,
  $Val extends WithdrawStatusResponse
>
    implements $WithdrawStatusResponseCopyWith<$Res> {
  _$WithdrawStatusResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WithdrawStatusResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isWithdrawRequested = null,
    Object? scheduledDeleteAt = freezed,
    Object? withdrawRequestedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            isWithdrawRequested: null == isWithdrawRequested
                ? _value.isWithdrawRequested
                : isWithdrawRequested // ignore: cast_nullable_to_non_nullable
                      as bool,
            scheduledDeleteAt: freezed == scheduledDeleteAt
                ? _value.scheduledDeleteAt
                : scheduledDeleteAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            withdrawRequestedAt: freezed == withdrawRequestedAt
                ? _value.withdrawRequestedAt
                : withdrawRequestedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WithdrawStatusResponseImplCopyWith<$Res>
    implements $WithdrawStatusResponseCopyWith<$Res> {
  factory _$$WithdrawStatusResponseImplCopyWith(
    _$WithdrawStatusResponseImpl value,
    $Res Function(_$WithdrawStatusResponseImpl) then,
  ) = __$$WithdrawStatusResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool isWithdrawRequested,
    DateTime? scheduledDeleteAt,
    DateTime? withdrawRequestedAt,
  });
}

/// @nodoc
class __$$WithdrawStatusResponseImplCopyWithImpl<$Res>
    extends
        _$WithdrawStatusResponseCopyWithImpl<$Res, _$WithdrawStatusResponseImpl>
    implements _$$WithdrawStatusResponseImplCopyWith<$Res> {
  __$$WithdrawStatusResponseImplCopyWithImpl(
    _$WithdrawStatusResponseImpl _value,
    $Res Function(_$WithdrawStatusResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WithdrawStatusResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isWithdrawRequested = null,
    Object? scheduledDeleteAt = freezed,
    Object? withdrawRequestedAt = freezed,
  }) {
    return _then(
      _$WithdrawStatusResponseImpl(
        isWithdrawRequested: null == isWithdrawRequested
            ? _value.isWithdrawRequested
            : isWithdrawRequested // ignore: cast_nullable_to_non_nullable
                  as bool,
        scheduledDeleteAt: freezed == scheduledDeleteAt
            ? _value.scheduledDeleteAt
            : scheduledDeleteAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        withdrawRequestedAt: freezed == withdrawRequestedAt
            ? _value.withdrawRequestedAt
            : withdrawRequestedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WithdrawStatusResponseImpl implements _WithdrawStatusResponse {
  const _$WithdrawStatusResponseImpl({
    required this.isWithdrawRequested,
    this.scheduledDeleteAt,
    this.withdrawRequestedAt,
  });

  factory _$WithdrawStatusResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$WithdrawStatusResponseImplFromJson(json);

  @override
  final bool isWithdrawRequested;
  @override
  final DateTime? scheduledDeleteAt;
  @override
  final DateTime? withdrawRequestedAt;

  @override
  String toString() {
    return 'WithdrawStatusResponse(isWithdrawRequested: $isWithdrawRequested, scheduledDeleteAt: $scheduledDeleteAt, withdrawRequestedAt: $withdrawRequestedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WithdrawStatusResponseImpl &&
            (identical(other.isWithdrawRequested, isWithdrawRequested) ||
                other.isWithdrawRequested == isWithdrawRequested) &&
            (identical(other.scheduledDeleteAt, scheduledDeleteAt) ||
                other.scheduledDeleteAt == scheduledDeleteAt) &&
            (identical(other.withdrawRequestedAt, withdrawRequestedAt) ||
                other.withdrawRequestedAt == withdrawRequestedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    isWithdrawRequested,
    scheduledDeleteAt,
    withdrawRequestedAt,
  );

  /// Create a copy of WithdrawStatusResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WithdrawStatusResponseImplCopyWith<_$WithdrawStatusResponseImpl>
  get copyWith =>
      __$$WithdrawStatusResponseImplCopyWithImpl<_$WithdrawStatusResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$WithdrawStatusResponseImplToJson(this);
  }
}

abstract class _WithdrawStatusResponse implements WithdrawStatusResponse {
  const factory _WithdrawStatusResponse({
    required final bool isWithdrawRequested,
    final DateTime? scheduledDeleteAt,
    final DateTime? withdrawRequestedAt,
  }) = _$WithdrawStatusResponseImpl;

  factory _WithdrawStatusResponse.fromJson(Map<String, dynamic> json) =
      _$WithdrawStatusResponseImpl.fromJson;

  @override
  bool get isWithdrawRequested;
  @override
  DateTime? get scheduledDeleteAt;
  @override
  DateTime? get withdrawRequestedAt;

  /// Create a copy of WithdrawStatusResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WithdrawStatusResponseImplCopyWith<_$WithdrawStatusResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}
