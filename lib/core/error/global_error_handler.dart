import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/theme.dart';
import 'error_code.dart';
import 'global_error_provider.dart';

/// 전역 에러 핸들러 위젯
/// 앱 최상단에 배치하여 에러 발생 시 토스트 또는 모달을 자동으로 표시
class GlobalErrorHandler extends ConsumerStatefulWidget {
  final Widget child;

  const GlobalErrorHandler({
    super.key,
    required this.child,
  });

  @override
  ConsumerState<GlobalErrorHandler> createState() => _GlobalErrorHandlerState();
}

class _GlobalErrorHandlerState extends ConsumerState<GlobalErrorHandler> {
  @override
  Widget build(BuildContext context) {
    // 에러 상태 감지
    ref.listen<GlobalErrorState>(globalErrorProvider, (previous, next) {
      if (next.showErrorNotification && next.currentError != null) {
        final error = next.currentError!;

        // 에러 알림 표시 후 상태 초기화
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (error.severity == ErrorSeverity.critical) {
            _showErrorModal(context, error);
          } else {
            _showErrorToast(context, error);
          }
          ref.read(globalErrorProvider.notifier).hideErrorNotification();
        });
      }
    });

    return widget.child;
  }

  /// 토스트 (SnackBar) 표시 - 가벼운 에러용
  void _showErrorToast(BuildContext context, AppError error) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.error_outline,
              color: AppColors.white,
              size: 20,
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                error.message,
                style: AppTypography.body4(color: AppColors.white),
              ),
            ),
          ],
        ),
        backgroundColor: isDark ? AppColors.gray800 : AppColors.gray900,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacing.borderRadiusMd,
        ),
        margin: const EdgeInsets.all(AppSpacing.base),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: '확인',
          textColor: AppColors.primary,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  /// 모달 (Dialog) 표시 - 중요한 에러용
  void _showErrorModal(BuildContext context, AppError error) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacing.borderRadiusXl,
        ),
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.error.withValues(alpha: 0.1),
                borderRadius: AppSpacing.borderRadiusCircle,
              ),
              child: const Icon(
                Icons.warning_amber_rounded,
                color: AppColors.error,
                size: 24,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Text(
              _getErrorTitle(error),
              style: AppTypography.title3(
                color: isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
              ),
            ),
          ],
        ),
        content: Text(
          error.message,
          style: AppTypography.body3(
            color: isDark
                ? AppColors.textSecondaryDark
                : AppColors.textSecondaryLight,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _handleErrorAction(error);
            },
            child: Text(
              _getActionButtonText(error),
              style: AppTypography.body3Bold(color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }

  /// 에러 타입에 따른 제목 반환
  String _getErrorTitle(AppError error) {
    switch (error.errorCode) {
      case ErrorCode.unauthorized:
      case ErrorCode.invalidToken:
      case ErrorCode.expiredToken:
      case ErrorCode.refreshTokenNotFound:
      case ErrorCode.refreshTokenExpired:
        return '로그인 필요';
      case ErrorCode.userDeleted:
        return '계정 오류';
      case ErrorCode.subscriptionRequired:
        return '구독 필요';
      default:
        return '오류 발생';
    }
  }

  /// 에러 타입에 따른 액션 버튼 텍스트 반환
  String _getActionButtonText(AppError error) {
    switch (error.errorCode) {
      case ErrorCode.unauthorized:
      case ErrorCode.invalidToken:
      case ErrorCode.expiredToken:
      case ErrorCode.refreshTokenNotFound:
      case ErrorCode.refreshTokenExpired:
        return '로그인하기';
      case ErrorCode.subscriptionRequired:
        return '구독하기';
      default:
        return '확인';
    }
  }

  /// 에러 타입에 따른 액션 처리
  void _handleErrorAction(AppError error) {
    switch (error.errorCode) {
      case ErrorCode.unauthorized:
      case ErrorCode.invalidToken:
      case ErrorCode.expiredToken:
      case ErrorCode.refreshTokenNotFound:
      case ErrorCode.refreshTokenExpired:
      case ErrorCode.userDeleted:
        // TODO: 로그인 화면으로 이동
        break;
      case ErrorCode.subscriptionRequired:
        // TODO: 구독 화면으로 이동
        break;
      default:
        break;
    }
  }
}
