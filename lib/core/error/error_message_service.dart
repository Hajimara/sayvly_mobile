import 'error_code.dart';

/// 에러 메시지 매핑 서비스
/// 모바일에서 정의한 사용자 친화적인 메시지를 우선 사용
class ErrorMessageService {
  ErrorMessageService._();

  /// 에러 코드에 대한 사용자 친화적인 메시지 반환
  /// 우선순위: 모바일 userFriendlyMessage > 백엔드 errorMessage > 기본 메시지
  static String getMessage({
    ErrorCode? errorCode,
    String? backendMessage,
    String? defaultMessage,
  }) {
    // 1. 모바일에서 정의한 메시지 우선
    if (errorCode != null) {
      return errorCode.userFriendlyMessage;
    }

    // 2. 백엔드에서 받은 메시지 (fallback)
    if (backendMessage != null && backendMessage.isNotEmpty) {
      return backendMessage;
    }

    // 3. 기본 메시지
    return defaultMessage ?? '오류가 발생했습니다. 다시 시도해주세요.';
  }

  /// 네트워크 에러에 대한 사용자 친화적인 메시지 반환
  static String getNetworkErrorMessage(String errorType) {
    switch (errorType) {
      case 'connectionTimeout':
      case 'sendTimeout':
      case 'receiveTimeout':
        return '서버 연결 시간이 초과되었습니다. 다시 시도해주세요.';
      case 'connectionError':
        return '네트워크 연결을 확인해주세요.';
      case 'badResponse':
        return '서버에서 오류가 발생했습니다.';
      case 'cancel':
        return '요청이 취소되었습니다.';
      default:
        return '네트워크 오류가 발생했습니다. 다시 시도해주세요.';
    }
  }
}
