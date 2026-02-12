import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/theme/theme.dart';
import '../../../../../features/auth/presentation/providers/auth_provider.dart';
import '../../providers/user_provider.dart';
import '../../widgets/setting_toggle_tile.dart';

/// 계정 관리 메인 화면
class AccountManagementScreen extends ConsumerWidget {
  const AccountManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isSocialLogin = ref.watch(isSocialLoginProvider);

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(
          '계정 관리',
          style: AppTypography.title3(
            color: isDark
                ? AppColors.textPrimaryDark
                : AppColors.textPrimaryLight,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        children: [
          // 보안 섹션
          const SettingSectionHeader(title: '보안'),

          // 비밀번호 변경 (이메일 로그인만)
          if (isSocialLogin == false)
            SettingNavigationTile(
              title: '비밀번호 변경',
              leadingIcon: Icons.lock_outline,
              onTap: () => context.push('/account/password'),
            ),

          // 로그인 기기 관리
          SettingNavigationTile(
            title: '로그인 기기 관리',
            subtitle: '다른 기기에서 로그아웃하기',
            leadingIcon: Icons.devices_outlined,
            onTap: () => context.push('/account/devices'),
          ),

          const SizedBox(height: AppSpacing.lg),

          // 계정 섹션
          const SettingSectionHeader(title: '계정'),

          // 로그아웃
          SettingNavigationTile(
            title: '로그아웃',
            leadingIcon: Icons.logout,
            onTap: () => _showLogoutDialog(context, ref),
          ),

          const SizedBox(height: AppSpacing.lg),

          // 위험 섹션
          const SettingSectionHeader(title: ''),

          // 계정 탈퇴
          SettingDangerTile(
            title: '계정 탈퇴',
            subtitle: '모든 데이터가 삭제됩니다',
            leadingIcon: Icons.person_remove_outlined,
            onTap: () => context.push('/account/withdraw'),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor:
            isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacing.borderRadiusXl,
        ),
        title: Text(
          '로그아웃',
          style: AppTypography.title3(
            color: isDark
                ? AppColors.textPrimaryDark
                : AppColors.textPrimaryLight,
          ),
        ),
        content: Text(
          '정말 로그아웃 하시겠습니까?',
          style: AppTypography.body4(
            color: isDark
                ? AppColors.textSecondaryDark
                : AppColors.textSecondaryLight,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              '취소',
              style: AppTypography.body4(
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondaryLight,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              // 로그아웃 처리
              await ref.read(authProvider.notifier).logout();
              if (context.mounted) {
                context.go('/login');
              }
            },
            child: Text(
              '로그아웃',
              style: AppTypography.body4Bold(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}
