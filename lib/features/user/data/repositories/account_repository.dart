import 'package:dio/dio.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/storage/secure_storage.dart';
import '../models/account_models.dart';

/// 계정 관리 관련 API 저장소
class AccountRepository {
  final Dio _dio;
  final SecureStorage _storage;

  AccountRepository({Dio? dio, SecureStorage? storage})
      : _dio = dio ?? DioClient.instance,
        _storage = storage ?? SecureStorage();

  /// 비밀번호 변경
  /// POST /api/v1/account/password
  Future<void> changePassword(ChangePasswordRequest request) async {
    try {
      await _dio.post('/account/password', data: request.toJson());
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// 로그인 기기 목록 조회
  /// GET /api/v1/account/devices
  Future<List<DeviceInfo>> getDevices() async {
    try {
      final response = await _dio.get('/account/devices');
      final dataList = response.data['data'] as List<dynamic>;
      return dataList
          .map((json) => DeviceInfo.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// 기기 로그아웃 (원격 로그아웃)
  /// DELETE /api/v1/account/devices/{tokenId}
  Future<void> logoutDevice(String tokenId) async {
    try {
      await _dio.delete('/account/devices/$tokenId');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// 모든 기기 로그아웃
  /// DELETE /api/v1/account/devices
  Future<void> logoutAllDevices() async {
    try {
      await _dio.delete('/account/devices');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// 계정 탈퇴 요청
  /// POST /api/v1/account/withdraw
  Future<WithdrawResponse> requestWithdraw(WithdrawRequest request) async {
    try {
      final response = await _dio.post(
        '/account/withdraw',
        data: request.toJson(),
      );
      return WithdrawResponse.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// 계정 탈퇴 취소
  /// DELETE /api/v1/account/withdraw
  Future<void> cancelWithdraw() async {
    try {
      await _dio.delete('/account/withdraw');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// 탈퇴 상태 조회
  /// GET /api/v1/account/withdraw/status
  Future<WithdrawStatusResponse> getWithdrawStatus() async {
    try {
      final response = await _dio.get('/account/withdraw/status');
      return WithdrawStatusResponse.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// 로그아웃 후 로컬 데이터 삭제
  Future<void> clearLocalData() async {
    await _storage.clearAll();
    DioClient.reset();
  }

  /// 에러 처리
  Exception _handleError(DioException e) {
    final data = e.response?.data;

    if (data is Map<String, dynamic>) {
      final message = data['message'] as String?;
      final errorCode = data['errorCode'] as String?;

      if (message != null) {
        return AccountException(message, errorCode: errorCode);
      }
    }

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return AccountException('서버 연결 시간이 초과되었습니다.');
      case DioExceptionType.connectionError:
        return AccountException('네트워크 연결을 확인해주세요.');
      default:
        return AccountException('알 수 없는 오류가 발생했습니다.');
    }
  }
}

/// 계정 관련 예외
class AccountException implements Exception {
  final String message;
  final String? errorCode;

  AccountException(this.message, {this.errorCode});

  /// 현재 비밀번호 불일치 여부
  bool get isCurrentPasswordInvalid => errorCode == '3009';

  /// 소셜 로그인 계정 (비밀번호 변경 불가)
  bool get isSocialLoginAccount => errorCode == '2009';

  @override
  String toString() => message;
}
