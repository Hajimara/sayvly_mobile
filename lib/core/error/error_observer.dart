import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'error_code.dart';
import 'error_logger.dart';
import 'app_exception.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';

/// 전역 에러 감지 및 처리 Observer
class ErrorObserver extends ProviderObserver {
  final ProviderContainer _container;

  ErrorObserver(this._container);

  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    // 에러 상태 감지
    if (newValue is AsyncValue && newValue.hasError) {
      _handleAsyncError(newValue.error!, newValue.stackTrace, provider);
    }
  }

  @override
  void didDisposeProvider(ProviderBase<Object?> provider, ProviderContainer container) {
    // Provider가 dispose될 때 필요한 정리 작업
  }

  /// AsyncValue 에러 처리
  void _handleAsyncError(
    Object error,
    StackTrace? stackTrace,
    ProviderBase<Object?> provider,
  ) {
    // AppException으로 변환 시도
    AppException? appException;
    if (error is AppException) {
      appException = error;
    }

    // 에러 로깅
    ErrorLogger.logError(
      error,
      stackTrace: stackTrace,
      errorCode: appException?.errorCode,
      context: 'Provider: ${provider.name ?? provider.runtimeType}',
    );

    // 인증 관련 에러 처리
    if (appException != null) {
      _handleAuthError(appException);
    }
  }

  /// 인증 관련 에러 처리
  void _handleAuthError(AppException exception) {
    final errorCode = exception.errorCode;

    // 인증 만료 또는 토큰 무효화 에러
    if (errorCode == ErrorCode.unauthorized ||
        errorCode == ErrorCode.invalidToken ||
        errorCode == ErrorCode.expiredToken ||
        errorCode == ErrorCode.refreshTokenExpired) {
      _handleAuthExpiration();
    }
  }

  /// 인증 만료 처리
  void _handleAuthExpiration() {
    // 로그아웃 처리
    try {
      final authNotifier = _container.read(authProvider.notifier);
      authNotifier.logout();
    } catch (e) {
      // 로그아웃 실패 시에도 에러 로깅
      ErrorLogger.logError(
        e,
        context: 'Auth Expiration Logout',
      );
    }

    // 로그인 화면으로 이동은 UI 레벨에서 처리
    // (Observer에서는 직접 네비게이션하지 않음)
  }
}
