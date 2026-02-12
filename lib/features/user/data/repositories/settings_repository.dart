import 'package:dio/dio.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/error/error_handler.dart';
import '../../../../core/error/error_code.dart';
import '../models/settings_models.dart';

/// 설정 관련 API 저장소
class SettingsRepository {
  final Dio _dio;

  SettingsRepository({Dio? dio}) : _dio = dio ?? DioClient.instance;

  /// 설정 조회
  /// GET /api/v1/settings
  Future<UserSettingsResponse> getSettings() async {
    try {
      final response = await _dio.get('/settings');
      return UserSettingsResponse.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// 설정 수정
  /// PATCH /api/v1/settings
  Future<UserSettingsResponse> updateSettings(
      UpdateSettingsRequest request) async {
    try {
      final response = await _dio.patch(
        '/settings',
        data: request.toJson(),
      );
      return UserSettingsResponse.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// 에러 처리
  Exception _handleError(DioException e) {
    final appException = ErrorHandler.handle(e);
    
    // ServerException을 SettingsException으로 변환
    if (appException is ServerException) {
      return SettingsException(
        appException.userMessage,
        errorCode: appException.errorCode,
      );
    }
    
    // NetworkException을 SettingsException으로 변환
    return SettingsException(appException.userMessage);
  }
}

/// 설정 관련 예외
class SettingsException implements Exception {
  final String message;
  final ErrorCode? errorCode;

  SettingsException(this.message, {this.errorCode});

  @override
  String toString() => message;
}
