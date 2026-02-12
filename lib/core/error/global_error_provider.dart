import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'error_code.dart';
import 'app_exception.dart';

/// 앱 에러 정보
class AppError {
  final ErrorCode? errorCode;
  final String message;
  final DateTime timestamp;
  final StackTrace? stackTrace;
  final String? context;
  final Map<String, dynamic>? extra;

  AppError({
    required this.message,
    this.errorCode,
    StackTrace? stackTrace,
    this.context,
    this.extra,
  })  : timestamp = DateTime.now(),
        stackTrace = stackTrace;

  /// AppException으로부터 생성
  factory AppError.fromException(
    AppException exception, {
    String? context,
    Map<String, dynamic>? extra,
  }) {
    return AppError(
      errorCode: exception.errorCode,
      message: exception.userMessage,
      context: context,
      extra: extra,
    );
  }

  /// 일반 Exception으로부터 생성
  factory AppError.fromObject(
    Object error, {
    ErrorCode? errorCode,
    StackTrace? stackTrace,
    String? context,
    Map<String, dynamic>? extra,
  }) {
    return AppError(
      errorCode: errorCode,
      message: error.toString(),
      stackTrace: stackTrace,
      context: context,
      extra: extra,
    );
  }
}

/// 전역 에러 상태
class GlobalErrorState {
  final List<AppError> recentErrors;
  final AppError? currentError;
  final bool showErrorNotification;
  final int maxRecentErrors;

  const GlobalErrorState({
    this.recentErrors = const [],
    this.currentError,
    this.showErrorNotification = false,
    this.maxRecentErrors = 10,
  });

  GlobalErrorState copyWith({
    List<AppError>? recentErrors,
    AppError? currentError,
    bool? showErrorNotification,
    bool clearCurrentError = false,
  }) {
    return GlobalErrorState(
      recentErrors: recentErrors ?? this.recentErrors,
      currentError: clearCurrentError ? null : (currentError ?? this.currentError),
      showErrorNotification: showErrorNotification ?? this.showErrorNotification,
      maxRecentErrors: maxRecentErrors,
    );
  }

  /// 최근 에러 목록 (최대 개수 제한)
  List<AppError> get limitedRecentErrors {
    if (recentErrors.length <= maxRecentErrors) {
      return recentErrors;
    }
    return recentErrors.take(maxRecentErrors).toList();
  }
}

/// 전역 에러 상태 Notifier
class GlobalErrorNotifier extends StateNotifier<GlobalErrorState> {
  GlobalErrorNotifier() : super(const GlobalErrorState());

  /// 에러 추가
  void addError(
    AppError error, {
    bool showNotification = true,
  }) {
    final updatedErrors = [
      error,
      ...state.recentErrors,
    ].take(state.maxRecentErrors).toList();

    state = state.copyWith(
      recentErrors: updatedErrors,
      currentError: error,
      showErrorNotification: showNotification,
    );
  }

  /// AppException으로부터 에러 추가
  void addException(
    AppException exception, {
    String? context,
    Map<String, dynamic>? extra,
    bool showNotification = true,
  }) {
    final error = AppError.fromException(
      exception,
      context: context,
      extra: extra,
    );
    addError(error, showNotification: showNotification);
  }

  /// 현재 에러 제거
  void clearCurrentError() {
    state = state.copyWith(clearCurrentError: true);
  }

  /// 에러 알림 숨기기
  void hideErrorNotification() {
    state = state.copyWith(showErrorNotification: false);
  }

  /// 모든 에러 초기화
  void clearAllErrors() {
    state = const GlobalErrorState();
  }

  /// 특정 에러 코드의 에러 개수
  int getErrorCount(ErrorCode errorCode) {
    return state.recentErrors
        .where((e) => e.errorCode == errorCode)
        .length;
  }

  /// 최근 N분 내 에러 개수
  int getRecentErrorCount({required Duration duration}) {
    final cutoff = DateTime.now().subtract(duration);
    return state.recentErrors
        .where((e) => e.timestamp.isAfter(cutoff))
        .length;
  }
}

/// 전역 에러 상태 Provider
final globalErrorProvider =
    StateNotifierProvider<GlobalErrorNotifier, GlobalErrorState>((ref) {
  return GlobalErrorNotifier();
});

/// 현재 에러 Provider
final currentErrorProvider = Provider<AppError?>((ref) {
  return ref.watch(globalErrorProvider).currentError;
});

/// 최근 에러 목록 Provider
final recentErrorsProvider = Provider<List<AppError>>((ref) {
  return ref.watch(globalErrorProvider).limitedRecentErrors;
});

/// 에러 알림 표시 여부 Provider
final showErrorNotificationProvider = Provider<bool>((ref) {
  return ref.watch(globalErrorProvider).showErrorNotification;
});
