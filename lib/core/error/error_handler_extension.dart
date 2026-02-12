import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_exception.dart';
import 'error_code.dart';
import 'error_logger.dart';
import 'global_error_provider.dart';

/// AsyncNotifier 에러 처리 헬퍼
class AsyncErrorHandler {
  /// 비동기 작업을 안전하게 실행하고 에러 처리
  static Future<AsyncValue<T>> safeAsyncOperation<T>(
    Future<T> Function() operation, {
    String? context,
    bool logError = true,
    bool addToGlobalError = false,
    Ref? ref,
  }) async {
    try {
      final result = await operation();
      return AsyncValue.data(result);
    } on AppException catch (e) {
      if (logError) {
        ErrorLogger.logAppException(
          e,
          context: context,
        );
      }
      
      if (addToGlobalError && ref != null) {
        ref.read(globalErrorProvider.notifier).addException(
          e,
          context: context,
        );
      }
      
      return AsyncValue.error(e, StackTrace.current);
    } catch (e, stackTrace) {
      if (logError) {
        ErrorLogger.logError(
          e,
          stackTrace: stackTrace,
          context: context,
        );
      }
      
      return AsyncValue.error(e, stackTrace);
    }
  }
}

/// AsyncValue 에러 처리 헬퍼
extension AsyncValueErrorExtension<T> on AsyncValue<T> {
  /// 에러가 AppException인지 확인
  bool get isAppException => hasError && error is AppException;

  /// AppException으로 변환 (에러가 AppException인 경우)
  AppException? get appException {
    if (!hasError) return null;
    if (error is AppException) return error as AppException;
    return null;
  }

  /// 에러 메시지 가져오기
  String get errorMessage {
    if (!hasError) return '';
    if (error is AppException) {
      return (error as AppException).userMessage;
    }
    return error.toString();
  }

  /// 에러 코드 가져오기
  ErrorCode? get errorCode {
    final exception = appException;
    return exception?.errorCode;
  }
}
