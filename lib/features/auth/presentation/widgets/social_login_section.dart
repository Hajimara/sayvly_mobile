import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';
import 'social_login_button.dart';

/// 소셜 로그인 섹션
/// 개발 모드에서만 토글로 표시/숨김 가능
class SocialLoginSection extends StatefulWidget {
  final void Function(SocialLoginType type)? onSocialLogin;
  final SocialLoginType? loadingType;

  const SocialLoginSection({
    super.key,
    this.onSocialLogin,
    this.loadingType,
  });

  @override
  State<SocialLoginSection> createState() => _SocialLoginSectionState();
}

class _SocialLoginSectionState extends State<SocialLoginSection> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    // 릴리즈 모드에서는 소셜 로그인 숨김
    if (kReleaseMode) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        // 토글 버튼
        _buildToggleButton(),

        // 소셜 로그인 버튼들
        AnimatedCrossFade(
          duration: const Duration(milliseconds: 200),
          firstChild: const SizedBox.shrink(),
          secondChild: _buildSocialButtons(),
          crossFadeState: _isExpanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
        ),
      ],
    );
  }

  Widget _buildToggleButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton.icon(
        onPressed: () => setState(() => _isExpanded = !_isExpanded),
        icon: Icon(
          _isExpanded ? Icons.expand_less : Icons.expand_more,
          size: 18,
          color: AppColors.textSecondaryLight,
        ),
        label: Text(
          _isExpanded ? '소셜 로그인 숨기기' : '소셜 로그인 (개발용)',
          style: AppTypography.label3(color: AppColors.textSecondaryLight),
        ),
      ),
    );
  }

  Widget _buildSocialButtons() {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.md),
      child: Column(
        children: [
          // 구분선
          Row(
            children: [
              const Expanded(child: Divider()),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: Text(
                  '또는',
                  style: AppTypography.label3(color: AppColors.textSecondaryLight),
                ),
              ),
              const Expanded(child: Divider()),
            ],
          ),
          const SizedBox(height: AppSpacing.base),

          // Google
          SocialLoginButton(
            type: SocialLoginType.google,
            onPressed: () => widget.onSocialLogin?.call(SocialLoginType.google),
            isLoading: widget.loadingType == SocialLoginType.google,
          ),
          const SizedBox(height: AppSpacing.sm),

          // Kakao
          SocialLoginButton(
            type: SocialLoginType.kakao,
            onPressed: () => widget.onSocialLogin?.call(SocialLoginType.kakao),
            isLoading: widget.loadingType == SocialLoginType.kakao,
          ),
          const SizedBox(height: AppSpacing.sm),

          // Naver
          SocialLoginButton(
            type: SocialLoginType.naver,
            onPressed: () => widget.onSocialLogin?.call(SocialLoginType.naver),
            isLoading: widget.loadingType == SocialLoginType.naver,
          ),
        ],
      ),
    );
  }
}
