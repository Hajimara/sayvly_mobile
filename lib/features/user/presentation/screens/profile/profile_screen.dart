import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/theme/theme.dart';
import '../../../data/models/user_models.dart';
import '../../providers/user_provider.dart';
import '../../widgets/profile_image_picker.dart';
import '../../../../common/widgets/bottom_navigation_bar.dart';

/// 프로필 조회 화면
class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 날짜가 바뀌었을 때만 새로고침 (로딩 표시 없이)
      ref.read(userProfileProvider.notifier).refreshIfNeeded();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final state = ref.watch(userProfileProvider);
    final router = GoRouter.of(context);
    final currentPath = router.routerDelegate.currentConfiguration.uri.path;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(
          '프로필',
          style: AppTypography.title3(
            color: isDark
                ? AppColors.textPrimaryDark
                : AppColors.textPrimaryLight,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => context.push('/profile/edit'),
            icon: Icon(
              Icons.edit_outlined,
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
            ),
          ),
        ],
      ),
      body: _buildBody(state, isDark),
      bottomNavigationBar: SayvlyBottomNavigationBar(currentPath: currentPath),
    );
  }

  Widget _buildBody(AsyncValue<ProfileResponse> state, bool isDark) {
    // 데이터가 없으면 로딩 표시 (초기 로드 또는 에러 후 재시도 중)
    if (!state.hasValue) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      );
    }

    final profile = state.value!;

    return SingleChildScrollView(
      padding: AppSpacing.pagePadding,
      child: Column(
        children: [
          // 프로필 이미지
          ProfileImagePicker(
            currentImageUrl: profile.profileImageUrl,
            size: AppSpacing.avatar2xl,
            enabled: false,
          ),

          const SizedBox(height: AppSpacing.lg),

          // 닉네임
          Text(
            profile.nickname ?? '닉네임 없음',
            style: AppTypography.title2(
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
            ),
          ),

          const SizedBox(height: AppSpacing.xs),

          // 이메일
          Text(
            profile.email,
            style: AppTypography.body4(
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
            ),
          ),

          const SizedBox(height: AppSpacing.xxl),

          // 프로필 정보 카드
          _ProfileInfoCard(profile: profile, isDark: isDark),

          // 주기 정보 카드 (여성만)
          const SizedBox(height: AppSpacing.base),
          _CycleInfoCard(cycleInfo: profile.cycleInfo!, isDark: isDark),

          const SizedBox(height: AppSpacing.base),

          // 구독 정보 카드
          _SubscriptionCard(profile: profile, isDark: isDark),
        ],
      ),
    );
  }
}

class _ProfileInfoCard extends StatelessWidget {
  final ProfileResponse profile;
  final bool isDark;

  const _ProfileInfoCard({required this.profile, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: AppSpacing.cardInsets,
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        borderRadius: AppSpacing.borderRadiusXl,
        boxShadow: AppShadows.softCard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '기본 정보',
            style: AppTypography.body3Bold(
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          _InfoRow(
            label: '성별',
            value: _getGenderText(profile.gender),
            isDark: isDark,
          ),
          const SizedBox(height: AppSpacing.sm),

          _InfoRow(
            label: '생년월일',
            value: profile.birthDate != null
                ? _formatDate(profile.birthDate!)
                : '미설정',
            isDark: isDark,
          ),
          const SizedBox(height: AppSpacing.sm),

          _InfoRow(
            label: '가입일',
            value: _formatDate(profile.createdAt),
            isDark: isDark,
          ),
          const SizedBox(height: AppSpacing.sm),

          _InfoRow(
            label: '로그인 방식',
            value: _getProviderName(profile.provider),
            isDark: isDark,
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}.${date.month.toString().padLeft(2, '0')}.${date.day.toString().padLeft(2, '0')}';
  }

  String _getGenderText(Gender? gender) {
    if (gender == null) return '미정';
    switch (gender) {
      case Gender.female:
        return '여성';
      case Gender.male:
        return '남성';
      case Gender.other:
        return '미정';
    }
  }

  String _getProviderName(AuthProvider provider) {
    switch (provider) {
      case AuthProvider.email:
        return '이메일';
      case AuthProvider.google:
        return 'Google';
      case AuthProvider.kakao:
        return '카카오';
      case AuthProvider.naver:
        return '네이버';
    }
  }
}

class _SubscriptionCard extends StatelessWidget {
  final ProfileResponse profile;
  final bool isDark;

  const _SubscriptionCard({required this.profile, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final isPremium = profile.subscriptionTier == SubscriptionTier.premium;

    return Container(
      width: double.infinity,
      padding: AppSpacing.cardInsets,
      decoration: BoxDecoration(
        color: isPremium
            ? AppColors.accent.withValues(alpha: 0.1)
            : (isDark ? AppColors.surfaceDark : AppColors.surfaceLight),
        borderRadius: AppSpacing.borderRadiusXl,
        border: isPremium
            ? Border.all(color: AppColors.accent, width: 1)
            : null,
        boxShadow: AppShadows.softCard,
      ),
      child: Row(
        children: [
          // 아이콘
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: isPremium
                  ? AppColors.accent.withValues(alpha: 0.2)
                  : AppColors.gray100,
              borderRadius: AppSpacing.borderRadiusLg,
            ),
            child: Icon(
              isPremium ? Icons.diamond : Icons.star_border,
              color: isPremium ? AppColors.accent : AppColors.gray500,
            ),
          ),
          const SizedBox(width: AppSpacing.md),

          // 텍스트
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isPremium ? 'Premium' : 'Free',
                  style: AppTypography.body2Bold(
                    color: isPremium
                        ? AppColors.accent
                        : (isDark
                              ? AppColors.textPrimaryDark
                              : AppColors.textPrimaryLight),
                  ),
                ),
                if (isPremium && profile.subscriptionExpiresAt != null)
                  Text(
                    '${_formatDate(profile.subscriptionExpiresAt!)}까지',
                    style: AppTypography.caption(
                      color: isDark
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondaryLight,
                    ),
                  ),
              ],
            ),
          ),

          // 업그레이드 버튼 (무료 사용자만)
          if (!isPremium)
            TextButton(
              onPressed: () {
                // TODO: 구독 화면으로 이동
              },
              child: const Text('업그레이드'),
            ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}.${date.month}.${date.day}';
  }
}

class _CycleInfoCard extends StatelessWidget {
  final CycleInfoSummary cycleInfo;
  final bool isDark;

  const _CycleInfoCard({required this.cycleInfo, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: AppSpacing.cardInsets,
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        borderRadius: AppSpacing.borderRadiusXl,
        boxShadow: AppShadows.softCard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '주기 정보',
            style: AppTypography.body3Bold(
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          _InfoRow(
            label: '평균 주기',
            value: cycleInfo.averageCycleLength != null
                ? '${cycleInfo.averageCycleLength}일'
                : '미설정',
            isDark: isDark,
          ),
          const SizedBox(height: AppSpacing.sm),

          _InfoRow(
            label: '마지막 생리',
            value: cycleInfo.lastPeriodDate != null
                ? _formatDate(cycleInfo.lastPeriodDate!)
                : '기록 없음',
            isDark: isDark,
          ),
          const SizedBox(height: AppSpacing.sm),

          _InfoRow(
            label: '다음 예정일',
            value: cycleInfo.nextPeriodDate != null
                ? _formatDate(cycleInfo.nextPeriodDate!)
                : '예측 불가',
            isDark: isDark,
            valueColor: AppColors.primary,
          ),

          if (cycleInfo.currentCycleDay != null) ...[
            const SizedBox(height: AppSpacing.sm),
            _InfoRow(
              label: '현재 주기일',
              value: '${cycleInfo.currentCycleDay}일째',
              isDark: isDark,
            ),
          ],
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.month}월 ${date.day}일';
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isDark;
  final Color? valueColor;

  const _InfoRow({
    required this.label,
    required this.value,
    required this.isDark,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTypography.body5(
            color: isDark
                ? AppColors.textSecondaryDark
                : AppColors.textSecondaryLight,
          ),
        ),
        Text(
          value,
          style: AppTypography.body5Bold(
            color:
                valueColor ??
                (isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight),
          ),
        ),
      ],
    );
  }
}
