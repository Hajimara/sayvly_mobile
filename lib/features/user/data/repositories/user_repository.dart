import 'dart:io';
import 'package:dio/dio.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/error/error_handler.dart';
import '../../../../core/error/error_code.dart';
import '../models/user_models.dart';
import '../models/onboarding_models.dart';

/// 사용자/프로필/온보딩 관련 API 저장소
class UserRepository {
  final Dio _dio;

  UserRepository({Dio? dio}) : _dio = dio ?? DioClient.instance;

  // ========== 프로필 API ==========

  /// 내 프로필 조회
  /// GET /api/v1/profile/me
  Future<ProfileResponse> getMyProfile() async {
    try {
      final response = await _dio.get('/profile/me');
      return ProfileResponse.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// 프로필 수정
  /// PATCH /api/v1/profile/me
  Future<ProfileResponse> updateProfile(UpdateProfileRequest request) async {
    try {
      final response = await _dio.patch(
        '/profile/me',
        data: request.toJson(),
      );
      return ProfileResponse.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// 프로필 이미지 업로드
  /// POST /api/v1/profile/me/image
  Future<ProfileImageResponse> uploadProfileImage(File imageFile) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path.split('/').last,
        ),
      });

      final response = await _dio.post(
        '/profile/me/image',
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
        ),
      );
      return ProfileImageResponse.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// 프로필 이미지 삭제
  /// DELETE /api/v1/profile/me/image
  Future<void> deleteProfileImage() async {
    try {
      await _dio.delete('/profile/me/image');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // ========== 온보딩 API ==========

  /// 온보딩 상태 조회
  /// GET /api/v1/onboarding/status
  Future<OnboardingStatusResponse> getOnboardingStatus() async {
    try {
      final response = await _dio.get('/onboarding/status');
      return OnboardingStatusResponse.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// 주기 정보 설정 (여성)
  /// POST /api/v1/onboarding/cycle
  Future<void> setCycleInfo(CycleSetupRequest request) async {
    try {
      await _dio.post('/onboarding/cycle', data: request.toJson());
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// 온보딩 완료
  /// POST /api/v1/onboarding/complete
  Future<void> completeOnboarding() async {
    try {
      await _dio.post('/onboarding/complete');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// 온보딩 데이터 일괄 제출 (성별, 생년월일, 주기 정보)
  /// POST /api/v1/onboarding
  Future<void> submitOnboarding(OnboardingRequest request) async {
    try {
      await _dio.post('/onboarding', data: request.toJson());
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// 에러 처리
  Exception _handleError(DioException e) {
    final appException = ErrorHandler.handle(e);
    
    // ServerException을 UserException으로 변환
    if (appException is ServerException) {
      return UserException(
        appException.userMessage,
        errorCode: appException.errorCode,
      );
    }
    
    // NetworkException을 UserException으로 변환
    return UserException(appException.userMessage);
  }
}

/// 사용자 관련 예외
class UserException implements Exception {
  final String message;
  final ErrorCode? errorCode;

  UserException(this.message, {this.errorCode});

  /// 닉네임 중복 여부
  bool get isNicknameDuplicate => errorCode == ErrorCode.nicknameAlreadyExists;

  /// 닉네임 형식 오류 여부
  bool get isNicknameInvalid => errorCode == ErrorCode.invalidNicknameFormat;

  /// 닉네임 변경 쿨다운 여부
  bool get isNicknameCooldown => errorCode == ErrorCode.nicknameChangeCooldown;

  @override
  String toString() => message;
}
