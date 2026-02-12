import 'package:flutter/material.dart';
import '../../../core/theme/theme.dart';

/// 앱 시작 시 인증 상태 확인 중 표시되는 스플래시 화면
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [AppColors.backgroundDark, AppColors.backgroundDark]
                : [AppColors.backgroundLight, AppColors.white],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),

              // 로고
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: AppSpacing.borderRadiusXl,
                  boxShadow: AppShadows.softButton,
                ),
                child: const Icon(
                  Icons.favorite,
                  size: 50,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // 앱 이름
              Text(
                'Sayvly',
                style: AppTypography.title1(
                  color: isDark
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimaryLight,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),

              // 슬로건
              Text(
                '커플을 위한 생리 주기 관리',
                style: AppTypography.body5(
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
                ),
              ),

              const Spacer(flex: 2),

              // 로딩 인디케이터
              SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation(
                    AppColors.primary.withOpacity(0.7),
                  ),
                ),
              ),

              const Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}
