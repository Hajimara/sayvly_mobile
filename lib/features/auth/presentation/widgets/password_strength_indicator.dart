import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';
import '../../domain/validators/password_validator.dart';

/// 비밀번호 강도 표시기
class PasswordStrengthIndicator extends StatelessWidget {
  final String password;
  final bool showChecklist;

  const PasswordStrengthIndicator({
    super.key,
    required this.password,
    this.showChecklist = true,
  });

  @override
  Widget build(BuildContext context) {
    final strength = PasswordValidator.calculateStrength(password);
    final result = PasswordValidator.validate(password);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 강도 바
        _buildStrengthBar(strength),
        const SizedBox(height: AppSpacing.xs),

        // 강도 라벨
        if (password.isNotEmpty) ...[
          Text(
            strength.label,
            style: AppTypography.label3(color: _getStrengthColor(strength)),
          ),
          const SizedBox(height: AppSpacing.sm),
        ],

        // 체크리스트
        if (showChecklist && password.isNotEmpty) _buildChecklist(result),
      ],
    );
  }

  Widget _buildStrengthBar(PasswordStrength strength) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 4,
            decoration: BoxDecoration(
              color: _getBarColor(strength, 0),
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(2),
              ),
            ),
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Container(
            height: 4,
            color: _getBarColor(strength, 1),
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Container(
            height: 4,
            decoration: BoxDecoration(
              color: _getBarColor(strength, 2),
              borderRadius: const BorderRadius.horizontal(
                right: Radius.circular(2),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Color _getBarColor(PasswordStrength strength, int index) {
    if (strength == PasswordStrength.none) {
      return AppColors.gray100;
    }

    switch (strength) {
      case PasswordStrength.weak:
        return index == 0 ? AppColors.error : AppColors.gray100;
      case PasswordStrength.medium:
        return index <= 1 ? AppColors.warning : AppColors.gray100;
      case PasswordStrength.strong:
        return AppColors.success;
      default:
        return AppColors.gray100;
    }
  }

  Color _getStrengthColor(PasswordStrength strength) {
    switch (strength) {
      case PasswordStrength.weak:
        return AppColors.error;
      case PasswordStrength.medium:
        return AppColors.warning;
      case PasswordStrength.strong:
        return AppColors.success;
      default:
        return AppColors.textSecondaryLight;
    }
  }

  Widget _buildChecklist(PasswordValidationResult result) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCheckItem('8자 이상', result.hasMinLength),
        const SizedBox(height: AppSpacing.xs),
        _buildCheckItem('영문 포함', result.hasLetter),
        const SizedBox(height: AppSpacing.xs),
        _buildCheckItem('숫자 포함', result.hasDigit),
        const SizedBox(height: AppSpacing.xs),
        _buildCheckItem('특수문자 포함', result.hasSpecialChar),
      ],
    );
  }

  Widget _buildCheckItem(String label, bool isValid) {
    return Row(
      children: [
        Icon(
          isValid ? Icons.check_circle : Icons.circle_outlined,
          size: 16,
          color: isValid ? AppColors.success : AppColors.gray300,
        ),
        const SizedBox(width: AppSpacing.xs),
        Text(
          label,
          style: AppTypography.label3(
            color: isValid ? AppColors.textPrimaryLight : AppColors.textSecondaryLight,
          ),
        ),
      ],
    );
  }
}
