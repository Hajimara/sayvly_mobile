import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/theme/theme.dart';
import '../../../data/models/user_models.dart';
import '../../providers/onboarding_provider.dart';
import '../../widgets/gender_selector.dart';

/// 온보딩 Step 1: 성별 선택
class GenderStepScreen extends ConsumerWidget {
  final VoidCallback onNext;

  const GenderStepScreen({
    super.key,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final data = ref.watch(onboardingDataProvider);

    return Padding(
      padding: AppSpacing.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSpacing.xxl),

          // 타이틀
          Text(
            '성별을 선택해주세요',
            style: AppTypography.title1(
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
            ),
          ),

          const SizedBox(height: AppSpacing.sm),

          // 설명
          Text(
            '맞춤형 기능을 제공해드릴게요',
            style: AppTypography.body3(
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
            ),
          ),

          const SizedBox(height: AppSpacing.xxl),

          // 성별 선택 카드
          GenderSelector(
            selectedGender: data?.gender,
            onGenderSelected: (gender) {
              ref.read(onboardingProvider.notifier).selectGender(gender);
            },
          ),

          const Spacer(),

          // 다음 버튼
          SizedBox(
            width: double.infinity,
            height: AppSpacing.buttonHeightLg,
            child: ElevatedButton(
              onPressed: data?.gender != null ? onNext : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                disabledBackgroundColor: AppColors.gray200,
                disabledForegroundColor: AppColors.gray500,
                shape: RoundedRectangleBorder(
                  borderRadius: AppSpacing.borderRadiusLg,
                ),
                elevation: 0,
              ),
              child: Text(
                '다음',
                style: AppTypography.body2Bold(
                  color: data?.gender != null
                      ? AppColors.white
                      : AppColors.gray500,
                ),
              ),
            ),
          ),

          const SizedBox(height: AppSpacing.base),
        ],
      ),
    );
  }
}
