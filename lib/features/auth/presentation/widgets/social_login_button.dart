import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';

/// 소셜 로그인 버튼 타입
enum SocialLoginType {
  google,
  kakao,
  naver;

  String get label {
    switch (this) {
      case SocialLoginType.google:
        return 'Google로 계속하기';
      case SocialLoginType.kakao:
        return '카카오로 계속하기';
      case SocialLoginType.naver:
        return '네이버로 계속하기';
    }
  }

  String get provider {
    switch (this) {
      case SocialLoginType.google:
        return 'GOOGLE';
      case SocialLoginType.kakao:
        return 'KAKAO';
      case SocialLoginType.naver:
        return 'NAVER';
    }
  }

  Color get backgroundColor {
    switch (this) {
      case SocialLoginType.google:
        return AppColors.white;
      case SocialLoginType.kakao:
        return AppColors.kakao;
      case SocialLoginType.naver:
        return AppColors.naver;
    }
  }

  Color get foregroundColor {
    switch (this) {
      case SocialLoginType.google:
        return AppColors.textPrimaryLight;
      case SocialLoginType.kakao:
        return AppColors.kakaoText;
      case SocialLoginType.naver:
        return AppColors.white;
    }
  }

  Color? get borderColor {
    switch (this) {
      case SocialLoginType.google:
        return AppColors.borderLight;
      case SocialLoginType.kakao:
      case SocialLoginType.naver:
        return null;
    }
  }

  String get iconPath {
    switch (this) {
      case SocialLoginType.google:
        return 'assets/icons/google.png';
      case SocialLoginType.kakao:
        return 'assets/icons/kakao.png';
      case SocialLoginType.naver:
        return 'assets/icons/naver.png';
    }
  }
}

/// 소셜 로그인 버튼
class SocialLoginButton extends StatelessWidget {
  final SocialLoginType type;
  final VoidCallback? onPressed;
  final bool isLoading;

  const SocialLoginButton({
    super.key,
    required this.type,
    this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSpacing.buttonHeightBase,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: type.backgroundColor,
          foregroundColor: type.foregroundColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: AppSpacing.borderRadiusLg,
            side: type.borderColor != null
                ? BorderSide(color: type.borderColor!)
                : BorderSide.none,
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation(type.foregroundColor),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildIcon(),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    type.label,
                    style: AppTypography.body4Bold(color: type.foregroundColor),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildIcon() {
    // TODO: 실제 아이콘 에셋 추가 후 Image.asset 사용
    // return Image.asset(type.iconPath, width: 24, height: 24);

    switch (type) {
      case SocialLoginType.google:
        return const Icon(Icons.g_mobiledata, size: 28);
      case SocialLoginType.kakao:
        return const Icon(Icons.chat_bubble, size: 24);
      case SocialLoginType.naver:
        return const Text('N', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
    }
  }
}
