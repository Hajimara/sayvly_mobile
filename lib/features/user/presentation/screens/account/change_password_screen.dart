import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/theme/theme.dart';
import '../../../../auth/domain/validators/password_validator.dart';
import '../../providers/account_provider.dart';

/// 비밀번호 변경 화면
class ChangePasswordScreen extends ConsumerStatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  ConsumerState<ChangePasswordScreen> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _changePassword() async {
    if (!_formKey.currentState!.validate()) return;

    final success = await ref.read(changePasswordProvider.notifier).changePassword(
          currentPassword: _currentPasswordController.text,
          newPassword: _newPasswordController.text,
        );

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('비밀번호가 변경되었습니다.')),
      );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final state = ref.watch(changePasswordProvider);

    final isLoading = state is ChangePasswordLoading;
    final error = state is ChangePasswordError ? state : null;

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(
          '비밀번호 변경',
          style: AppTypography.title3(
            color: isDark
                ? AppColors.textPrimaryDark
                : AppColors.textPrimaryLight,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: AppSpacing.pagePadding,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 안내 텍스트
              Text(
                '보안을 위해 비밀번호를 주기적으로 변경해주세요.',
                style: AppTypography.body4(
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
                ),
              ),

              const SizedBox(height: AppSpacing.xxl),

              // 현재 비밀번호
              _buildPasswordField(
                label: '현재 비밀번호',
                controller: _currentPasswordController,
                obscureText: _obscureCurrentPassword,
                onToggleObscure: () {
                  setState(() {
                    _obscureCurrentPassword = !_obscureCurrentPassword;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '현재 비밀번호를 입력해주세요.';
                  }
                  return null;
                },
                errorText: error?.isCurrentPasswordInvalid == true
                    ? '현재 비밀번호가 일치하지 않습니다.'
                    : null,
                isDark: isDark,
              ),

              const SizedBox(height: AppSpacing.lg),

              // 새 비밀번호
              _buildPasswordField(
                label: '새 비밀번호',
                controller: _newPasswordController,
                obscureText: _obscureNewPassword,
                onToggleObscure: () {
                  setState(() {
                    _obscureNewPassword = !_obscureNewPassword;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '새 비밀번호를 입력해주세요.';
                  }
                  final result = PasswordValidator.validate(value);
                  if (!result.isValid) {
                    return result.errorMessage;
                  }
                  if (value == _currentPasswordController.text) {
                    return '현재 비밀번호와 다른 비밀번호를 입력해주세요.';
                  }
                  return null;
                },
                isDark: isDark,
              ),

              const SizedBox(height: AppSpacing.sm),

              // 비밀번호 규칙 안내
              Text(
                '8자 이상, 영문/숫자/특수문자 포함',
                style: AppTypography.caption(
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
                ),
              ),

              const SizedBox(height: AppSpacing.lg),

              // 새 비밀번호 확인
              _buildPasswordField(
                label: '새 비밀번호 확인',
                controller: _confirmPasswordController,
                obscureText: _obscureConfirmPassword,
                onToggleObscure: () {
                  setState(() {
                    _obscureConfirmPassword = !_obscureConfirmPassword;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '비밀번호 확인을 입력해주세요.';
                  }
                  if (value != _newPasswordController.text) {
                    return '비밀번호가 일치하지 않습니다.';
                  }
                  return null;
                },
                isDark: isDark,
              ),

              const SizedBox(height: AppSpacing.xxl),

              // 변경 버튼
              SizedBox(
                width: double.infinity,
                height: AppSpacing.buttonHeightLg,
                child: ElevatedButton(
                  onPressed: isLoading ? null : _changePassword,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.white,
                    disabledBackgroundColor: AppColors.gray200,
                    shape: RoundedRectangleBorder(
                      borderRadius: AppSpacing.borderRadiusLg,
                    ),
                    elevation: 0,
                  ),
                  child: isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.white,
                          ),
                        )
                      : Text(
                          '비밀번호 변경',
                          style:
                              AppTypography.body2Bold(color: AppColors.white),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required String label,
    required TextEditingController controller,
    required bool obscureText,
    required VoidCallback onToggleObscure,
    required String? Function(String?) validator,
    String? errorText,
    required bool isDark,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.label1(
            color: isDark
                ? AppColors.textPrimaryDark
                : AppColors.textPrimaryLight,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          validator: validator,
          decoration: InputDecoration(
            hintText: label,
            hintStyle: AppTypography.body4(
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
            ),
            errorText: errorText,
            filled: true,
            fillColor: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.base,
              vertical: AppSpacing.md,
            ),
            border: OutlineInputBorder(
              borderRadius: AppSpacing.borderRadiusMd,
              borderSide: BorderSide(
                color: isDark ? AppColors.borderDark : AppColors.borderLight,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: AppSpacing.borderRadiusMd,
              borderSide: BorderSide(
                color: isDark ? AppColors.borderDark : AppColors.borderLight,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: AppSpacing.borderRadiusMd,
              borderSide: const BorderSide(
                color: AppColors.primary,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: AppSpacing.borderRadiusMd,
              borderSide: const BorderSide(
                color: AppColors.error,
              ),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                obscureText ? Icons.visibility_off : Icons.visibility,
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondaryLight,
              ),
              onPressed: onToggleObscure,
            ),
          ),
          style: AppTypography.body4(
            color: isDark
                ? AppColors.textPrimaryDark
                : AppColors.textPrimaryLight,
          ),
        ),
      ],
    );
  }
}
