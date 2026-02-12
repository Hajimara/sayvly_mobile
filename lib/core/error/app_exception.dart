import 'error_code.dart';

/// 통합 예외 클래스
/// 모든 도메인 예외의 기본 클래스
abstract class AppException implements Exception {
  final ErrorCode? errorCode;
  final String userMessage;

  AppException(this.userMessage, {this.errorCode});

  @override
  String toString() => userMessage;

  /// 에러 코드가 특정 값인지 확인
  bool hasErrorCode(ErrorCode code) => errorCode == code;
}
