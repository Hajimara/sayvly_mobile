import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_exception.dart';
import 'error_handler.dart';

/// 재시도 정책
class RetryPolicy {
  final int maxRetries;
  final Duration initialDelay;
  final Duration maxDelay;
  final double backoffMultiplier;
  final bool Function(AppException)? shouldRetry;

  const RetryPolicy({
    this.maxRetries = 3,
    this.initialDelay = const Duration(seconds: 1),
    this.maxDelay = const Duration(seconds: 10),
    this.backoffMultiplier = 2.0,
    this.shouldRetry,
  });

  /// 기본 재시도 정책 (네트워크 에러만)
  static const RetryPolicy networkOnly = RetryPolicy(
    maxRetries: 3,
    initialDelay: Duration(seconds: 1),
    shouldRetry: _isNetworkError,
  );

  /// 모든 에러에 대한 재시도 정책
  static const RetryPolicy allErrors = RetryPolicy(
    maxRetries: 3,
    initialDelay: Duration(seconds: 1),
  );

  /// 재시도 여부 확인
  bool canRetry(AppException exception, int attemptCount) {
    if (attemptCount >= maxRetries) return false;
    if (shouldRetry != null) {
      return shouldRetry!(exception);
    }
    return true;
  }

  /// 재시도 지연 시간 계산
  Duration getDelay(int attemptCount) {
    final delay = initialDelay * (backoffMultiplier * attemptCount);
    return delay > maxDelay ? maxDelay : delay;
  }

  /// 네트워크 에러 확인
  static bool _isNetworkError(AppException exception) {
    return exception is NetworkException;
  }
}

/// 재시도 상태
class RetryState {
  final int attemptCount;
  final AppException? lastError;
  final bool isRetrying;
  final RetryPolicy policy;

  const RetryState({
    this.attemptCount = 0,
    this.lastError,
    this.isRetrying = false,
    required this.policy,
  });

  RetryState copyWith({
    int? attemptCount,
    AppException? lastError,
    bool? isRetrying,
    bool clearError = false,
  }) {
    return RetryState(
      attemptCount: attemptCount ?? this.attemptCount,
      lastError: clearError ? null : (lastError ?? this.lastError),
      isRetrying: isRetrying ?? this.isRetrying,
      policy: policy,
    );
  }

  bool get canRetry => policy.canRetry(lastError!, attemptCount);
  bool get hasReachedMaxRetries => attemptCount >= policy.maxRetries;
}

/// 에러 리커버리 Notifier
class ErrorRecoveryNotifier extends StateNotifier<RetryState> {
  ErrorRecoveryNotifier(RetryPolicy policy)
      : super(RetryState(policy: policy));

  /// 재시도 실행
  Future<T> retry<T>(Future<T> Function() operation) async {
    int attemptCount = 0;

    while (true) {
      try {
        state = state.copyWith(
          isRetrying: attemptCount > 0,
          attemptCount: attemptCount,
        );

        final result = await operation();
        
        // 성공 시 상태 초기화
        state = state.copyWith(
          isRetrying: false,
          clearError: true,
        );

        return result;
      } on AppException catch (e) {
        attemptCount++;
        
        state = state.copyWith(
          attemptCount: attemptCount,
          lastError: e,
          isRetrying: false,
        );

        // 재시도 가능 여부 확인
        if (!state.canRetry) {
          rethrow;
        }

        // 재시도 지연
        final delay = state.policy.getDelay(attemptCount - 1);
        await Future.delayed(delay);
      } catch (e) {
        // AppException이 아닌 경우 재시도하지 않음
        rethrow;
      }
    }
  }

  /// 수동 재시도
  Future<T> manualRetry<T>(
    Future<T> Function() operation,
  ) async {
    state = state.copyWith(attemptCount: 0, clearError: true);
    return retry(operation);
  }

  /// 재시도 상태 초기화
  void reset() {
    state = RetryState(policy: state.policy);
  }
}

/// 에러 리커버리 Provider (기본 정책)
final errorRecoveryProvider =
    StateNotifierProvider<ErrorRecoveryNotifier, RetryState>((ref) {
  return ErrorRecoveryNotifier(RetryPolicy.networkOnly);
});

/// 에러 리커버리 Provider (네트워크 에러만)
final networkErrorRecoveryProvider =
    StateNotifierProvider<ErrorRecoveryNotifier, RetryState>((ref) {
  return ErrorRecoveryNotifier(RetryPolicy.networkOnly);
});

/// 에러 리커버리 Provider (모든 에러)
final allErrorRecoveryProvider =
    StateNotifierProvider<ErrorRecoveryNotifier, RetryState>((ref) {
  return ErrorRecoveryNotifier(RetryPolicy.allErrors);
});

/// 재시도 가능 여부 Provider
final canRetryProvider = Provider<bool>((ref) {
  final retryState = ref.watch(errorRecoveryProvider);
  return retryState.canRetry;
});

/// 재시도 중 여부 Provider
final isRetryingProvider = Provider<bool>((ref) {
  return ref.watch(errorRecoveryProvider).isRetrying;
});
