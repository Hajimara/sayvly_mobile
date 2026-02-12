import 'package:dio/dio.dart';
import 'error_code.dart';
import 'error_message_service.dart';
import 'app_exception.dart';

/// 공통 에러 처리 유틸리티
/// DioException을 AppException으로 변환
class ErrorHandler {
  ErrorHandler._();

  /// DioException을 처리하여 AppException 반환
  static AppException handle(DioException e) {
    // 네트워크 에러 처리
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return NetworkException(
        ErrorMessageService.getNetworkErrorMessage('connectionTimeout'),
      );
    }

    if (e.type == DioExceptionType.connectionError) {
      return NetworkException(
        ErrorMessageService.getNetworkErrorMessage('connectionError'),
      );
    }

    if (e.type == DioExceptionType.badResponse) {
      return _handleBadResponse(e);
    }

    if (e.type == DioExceptionType.cancel) {
      return NetworkException(
        ErrorMessageService.getNetworkErrorMessage('cancel'),
      );
    }

    // 기타 에러
    return NetworkException(
      ErrorMessageService.getNetworkErrorMessage('unknown'),
    );
  }

  /// 백엔드 응답 에러 처리
  static AppException _handleBadResponse(DioException e) {
    final data = e.response?.data;

    if (data is Map<String, dynamic>) {
      // 백엔드 ApiResult 형식 파싱
      final errorCodeValue = data['errorCode'] as int?;
      final errorMessage = data['errorMessage'] as String?;

      // 에러 코드를 ErrorCode enum으로 변환
      final errorCode = ErrorCode.fromCodeOrNull(errorCodeValue);

      // 사용자 친화적인 메시지 가져오기 (모바일 메시지 우선)
      final userMessage = ErrorMessageService.getMessage(
        errorCode: errorCode,
        backendMessage: errorMessage,
      );

      return ServerException(
        userMessage,
        errorCode: errorCode,
        httpStatus: e.response?.statusCode,
      );
    }

    // 응답 데이터가 없거나 형식이 맞지 않는 경우
    return ServerException(
      ErrorMessageService.getNetworkErrorMessage('badResponse'),
      httpStatus: e.response?.statusCode,
    );
  }
}

/// 네트워크 관련 예외
class NetworkException extends AppException {
  NetworkException(super.userMessage) : super();
}

/// 서버 응답 예외
class ServerException extends AppException {
  final int? httpStatus;

  ServerException(super.userMessage, {super.errorCode, this.httpStatus});
}
