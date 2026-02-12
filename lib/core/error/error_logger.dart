import 'package:flutter/foundation.dart';
import 'error_code.dart';
import 'app_exception.dart';

/// 에러 로깅 및 모니터링 서비스
class ErrorLogger {
  ErrorLogger._();

  /// 에러 로깅
  static void logError(
    Object error, {
    StackTrace? stackTrace,
    ErrorCode? errorCode,
    String? context,
    Map<String, dynamic>? extra,
  }) {
    if (kDebugMode) {
      _logToConsole(error, stackTrace, errorCode, context, extra);
    }

    // 프로덕션 환경에서는 에러 수집 서비스로 전송 (선택적)
    // 예: Firebase Crashlytics, Sentry 등
    if (kReleaseMode) {
      _logToProduction(error, stackTrace, errorCode, context, extra);
    }
  }

  /// AppException 로깅
  static void logAppException(
    AppException exception, {
    String? context,
    Map<String, dynamic>? extra,
  }) {
    logError(
      exception,
      stackTrace: StackTrace.current,
      errorCode: exception.errorCode,
      context: context,
      extra: extra,
    );
  }

  /// 네트워크 에러 로깅
  static void logNetworkError(
    Object error, {
    String? url,
    String? method,
    int? statusCode,
    Map<String, dynamic>? extra,
  }) {
    final networkExtra = {
      if (url != null) 'url': url,
      if (method != null) 'method': method,
      if (statusCode != null) 'statusCode': statusCode,
      ...?extra,
    };

    logError(
      error,
      context: 'Network Error',
      extra: networkExtra,
    );
  }

  /// 인증 에러 로깅
  static void logAuthError(
    AppException exception, {
    String? action,
    Map<String, dynamic>? extra,
  }) {
    logAppException(
      exception,
      context: 'Auth Error${action != null ? ': $action' : ''}',
      extra: extra,
    );
  }

  /// 디버그 모드 콘솔 로깅
  static void _logToConsole(
    Object error,
    StackTrace? stackTrace,
    ErrorCode? errorCode,
    String? context,
    Map<String, dynamic>? extra,
  ) {
    debugPrint('┌────────────────────────────────────────────────────────');
    debugPrint('│ [ERROR] ${context ?? 'Error'}');
    debugPrint('│ Error: $error');
    if (errorCode != null) {
      debugPrint('│ ErrorCode: ${errorCode.code} (${errorCode.name})');
    }
    if (extra != null && extra.isNotEmpty) {
      debugPrint('│ Extra: $extra');
    }
    if (stackTrace != null) {
      debugPrint('│ StackTrace:');
      debugPrint(stackTrace.toString());
    }
    debugPrint('└────────────────────────────────────────────────────────');
  }

  /// 프로덕션 환경 에러 수집
  static void _logToProduction(
    Object error,
    StackTrace? stackTrace,
    ErrorCode? errorCode,
    String? context,
    Map<String, dynamic>? extra,
  ) {
    // TODO: 프로덕션 환경 에러 수집 서비스 연동
    // 예: Firebase Crashlytics, Sentry 등
    // 
    // 예시:
    // FirebaseCrashlytics.instance.recordError(
    //   error,
    //   stackTrace,
    //   reason: context,
    //   information: [
    //     if (errorCode != null) 'ErrorCode: ${errorCode.code}',
    //     ...?extra?.entries.map((e) => '${e.key}: ${e.value}'),
    //   ],
    // );
  }

  /// 에러 통계 수집 (선택적)
  static void logErrorStatistics({
    required ErrorCode errorCode,
    required int count,
    required DateTime timestamp,
  }) {
    if (kDebugMode) {
      debugPrint('[Error Statistics] ${errorCode.name}: $count at $timestamp');
    }

    // TODO: 에러 통계를 서버로 전송하거나 로컬에 저장
  }
}
