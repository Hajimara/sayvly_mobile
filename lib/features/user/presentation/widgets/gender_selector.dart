import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';
import '../../data/models/user_models.dart';

/// 성별 선택 위젯
/// 남성/여성 카드형 선택 UI
class GenderSelector extends StatelessWidget {
  final Gender? selectedGender;
  final ValueChanged<Gender> onGenderSelected;

  const GenderSelector({
    super.key,
    required this.selectedGender,
    required this.onGenderSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _GenderCard(
            gender: Gender.female,
            isSelected: selectedGender == Gender.female,
            onTap: () => onGenderSelected(Gender.female),
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: _GenderCard(
            gender: Gender.male,
            isSelected: selectedGender == Gender.male,
            onTap: () => onGenderSelected(Gender.male),
          ),
        ),
      ],
    );
  }
}

class _GenderCard extends StatelessWidget {
  final Gender gender;
  final bool isSelected;
  final VoidCallback onTap;

  const _GenderCard({
    required this.gender,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final backgroundColor = isSelected
        ? (gender == Gender.female
            ? AppColors.primary.withValues(alpha: 0.1)
            : AppColors.secondary.withValues(alpha: 0.1))
        : (isDark ? AppColors.surfaceDark : AppColors.surfaceLight);

    final borderColor = isSelected
        ? (gender == Gender.female ? AppColors.primary : AppColors.secondary)
        : (isDark ? AppColors.borderDark : AppColors.borderLight);

    final iconColor = isSelected
        ? (gender == Gender.female ? AppColors.primary : AppColors.secondary)
        : (isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight);

    final textColor = isSelected
        ? (isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight)
        : (isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.xl,
          horizontal: AppSpacing.base,
        ),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: AppSpacing.borderRadiusXl,
          border: Border.all(
            color: borderColor,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected ? AppShadows.softCard : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              gender == Gender.female ? Icons.female : Icons.male,
              size: AppSpacing.icon3xl,
              color: iconColor,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              gender == Gender.female ? '여성' : '남성',
              style: AppTypography.body2Bold(color: textColor),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              gender == Gender.female
                  ? '주기 기록 및 예측'
                  : '파트너 연결 및 케어',
              style: AppTypography.caption(color: textColor),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
