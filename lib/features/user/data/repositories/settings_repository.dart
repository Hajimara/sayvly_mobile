import 'package:dio/dio.dart';
import '../../../../core/network/dio_client.dart';
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
    final data = e.response?.data;

    if (data is Map<String, dynamic>) {
      final message = data['message'] as String?;
      final errorCode = data['errorCode'] as String?;

      if (message != null) {
        return SettingsException(message, errorCode: errorCode);
      }
    }

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return SettingsException('서버 연결 시간이 초과되었습니다.');
      case DioExceptionType.connectionError:
        return SettingsException('네트워크 연결을 확인해주세요.');
      default:
        return SettingsException('알 수 없는 오류가 발생했습니다.');
    }
  }
}

/// 설정 관련 예외
class SettingsException implements Exception {
  final String message;
  final String? errorCode;

  SettingsException(this.message, {this.errorCode});

  @override
  String toString() => message;
}
