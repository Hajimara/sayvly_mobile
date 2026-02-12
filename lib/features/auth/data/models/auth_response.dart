import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_response.freezed.dart';
part 'auth_response.g.dart';

/// 인증 응답
/// 백엔드 AuthResponse와 1:1 매칭
/// - userId: Long (Kotlin) -> int (Dart)
/// - accessToken: String
/// - refreshToken: String
/// - expiresIn: Long (Kotlin) -> int (Dart)
/// - isNewUser: Boolean
@freezed
class AuthResponse with _$AuthResponse {
  const factory AuthResponse({
    required int userId,
    required String accessToken,
    required String refreshToken,
    required int expiresIn,
    @Default(false) bool isNewUser,
  }) = _AuthResponse;

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);
}

/// 사용자 정보
@freezed
class UserInfo with _$UserInfo {
  const factory UserInfo({
    required String id,
    required String email,
    String? nickname,
    String? profileImageUrl,
    DateTime? createdAt,
  }) = _UserInfo;

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    // 모든 필드를 안전하게 처리
    final id = json['id'];
    final idString = id is String
        ? id
        : id is int
        ? id.toString()
        : id?.toString() ?? '';

    final email = json['email'];
    final emailString = email is String ? email : email?.toString() ?? '';

    final nickname = json['nickname'];
    final nicknameString = nickname == null
        ? null
        : nickname is String
        ? nickname
        : nickname.toString();

    final profileImageUrl = json['profileImageUrl'];
    final profileImageUrlString = profileImageUrl == null
        ? null
        : profileImageUrl is String
        ? profileImageUrl
        : profileImageUrl.toString();

    final createdAt = json['createdAt'];
    final createdAtDateTime = createdAt == null
        ? null
        : createdAt is String
        ? DateTime.tryParse(createdAt)
        : null;

    return UserInfo(
      id: idString,
      email: emailString,
      nickname: nicknameString,
      profileImageUrl: profileImageUrlString,
      createdAt: createdAtDateTime,
    );
  }
}
