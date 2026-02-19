import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/theme/theme.dart';
import '../../../../../core/locale/locale_provider.dart';
import '../../../data/models/settings_models.dart' as settings_models;
import '../../../data/models/user_models.dart';
import '../../providers/settings_provider.dart';
import '../../providers/user_provider.dart';
import '../../widgets/picker_bottom_sheet.dart';
import '../../widgets/setting_toggle_tile.dart';
import '../../../../common/widgets/bottom_navigation_bar.dart';

/// 설정 화면
class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final settingsState = ref.watch(settingsProvider);
    final profile = ref.watch(currentProfileProvider);
    final router = GoRouter.of(context);
    final currentPath = router.routerDelegate.currentConfiguration.uri.path;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(
          '설정',
          style: AppTypography.title3(
            color: isDark
                ? AppColors.textPrimaryDark
                : AppColors.textPrimaryLight,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: _buildBody(settingsState, profile, isDark),
      bottomNavigationBar: SayvlyBottomNavigationBar(currentPath: currentPath),
    );
  }

  Widget _buildBody(
    AsyncValue<settings_models.UserSettingsResponse> settingsState,
    ProfileResponse? profile,
    bool isDark,
  ) {
    // 데이터가 없으면 로딩 표시
    if (!settingsState.hasValue) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      );
    }

    final settings = settingsState.valueOrNull;

    return ListView(
      children: [
        // 알림 섹션
        const SettingSectionHeader(title: '알림'),

        if (profile?.gender == Gender.female) ...[
          // 여성용 알림 설정
          SettingToggleTile(
            title: '생리 예정일 알림',
            subtitle: '예정일 1-2일 전 알림',
            leadingIcon: Icons.event_note_outlined,
            value: settings?.notificationPeriodReminder ?? true,
            onChanged: (value) {
              ref
                  .read(settingsProvider.notifier)
                  .toggleNotification(periodReminder: value);
            },
          ),
          SettingToggleTile(
            title: '배란일 알림',
            subtitle: '배란 예정일 알림',
            leadingIcon: Icons.favorite_outline,
            value: settings?.notificationOvulation ?? false,
            onChanged: (value) {
              ref
                  .read(settingsProvider.notifier)
                  .toggleNotification(ovulation: value);
            },
          ),
        ] else ...[
          // 남성용 알림 설정
          SettingToggleTile(
            title: '파트너 생리 시작 알림',
            subtitle: '파트너 생리 시작 시 알림',
            leadingIcon: Icons.notifications_outlined,
            value: settings?.notificationPartnerPeriod ?? true,
            onChanged: (value) {
              ref
                  .read(settingsProvider.notifier)
                  .toggleNotification(partnerPeriod: value);
            },
          ),
          SettingToggleTile(
            title: 'PMS 기간 알림',
            subtitle: '파트너 PMS 기간 시작 알림',
            leadingIcon: Icons.sentiment_satisfied_alt_outlined,
            value: settings?.notificationPartnerPms ?? true,
            onChanged: (value) {
              ref
                  .read(settingsProvider.notifier)
                  .toggleNotification(partnerPms: value);
            },
          ),
          SettingToggleTile(
            title: '케어 팁 알림',
            subtitle: '파트너 케어 팁 받기',
            leadingIcon: Icons.lightbulb_outline,
            value: settings?.notificationCareTips ?? true,
            onChanged: (value) {
              ref
                  .read(settingsProvider.notifier)
                  .toggleNotification(careTips: value);
            },
          ),
        ],

        SettingToggleTile(
          title: '기념일 알림',
          leadingIcon: Icons.cake_outlined,
          value: settings?.notificationAnniversary ?? true,
          onChanged: (value) {
            ref
                .read(settingsProvider.notifier)
                .toggleNotification(anniversary: value);
          },
        ),

        SettingToggleTile(
          title: '기록 리마인더',
          subtitle: '매일 기록 알림',
          leadingIcon: Icons.edit_note_outlined,
          value: settings?.notificationDailyRecord ?? true,
          onChanged: (value) {
            ref
                .read(settingsProvider.notifier)
                .toggleNotification(dailyRecord: value);
          },
        ),

        SettingNavigationTile(
          title: '알림 시간',
          leadingIcon: Icons.access_time_outlined,
          value: _formatNotificationTime(settings?.notificationTime),
          onTap: () => _showTimePickerDialog(),
        ),

        const SizedBox(height: AppSpacing.lg),

        // 앱 설정 섹션
        const SettingSectionHeader(title: '앱 설정'),

        SettingNavigationTile(
          title: '언어',
          leadingIcon: Icons.language_outlined,
          value: _getLanguageName(settings?.language),
          onTap: () => _showLanguagePickerDialog(settings?.language),
        ),

        const SizedBox(height: AppSpacing.lg),

        // 계정 섹션
        const SettingSectionHeader(title: '계정'),

        SettingNavigationTile(
          title: '프로필',
          leadingIcon: Icons.person_outline,
          onTap: () => context.push('/profile'),
        ),

        SettingNavigationTile(
          title: '계정 관리',
          leadingIcon: Icons.manage_accounts_outlined,
          onTap: () => context.push('/account'),
        ),

        const SizedBox(height: AppSpacing.lg),

        // 정보 섹션
        const SettingSectionHeader(title: '정보'),

        SettingNavigationTile(
          title: '이용약관',
          leadingIcon: Icons.description_outlined,
          onTap: () {
            // TODO: 이용약관 화면으로 이동
          },
        ),

        SettingNavigationTile(
          title: '개인정보처리방침',
          leadingIcon: Icons.privacy_tip_outlined,
          onTap: () {
            // TODO: 개인정보처리방침 화면으로 이동
          },
        ),

        SettingNavigationTile(
          title: '앱 버전',
          leadingIcon: Icons.info_outline,
          value: '1.0.0',
          showDivider: false,
          showArrow: false,
        ),

        const SizedBox(height: AppSpacing.xxl),
      ],
    );
  }

  String _getLanguageName(String? language) {
    switch (language) {
      case 'en':
        return 'English';
      case 'ko':
      default:
        return '한국어';
    }
  }

  void _showTimePickerDialog() async {
    final settings = ref.read(currentSettingsProvider);
    final initial = _parseNotificationTime(settings?.notificationTime);

    final picked = await showTimePickerBottomSheet(
      context: context,
      initialTime: initial,
      title: '알림 시간 선택',
    );

    if (picked != null) {
      final timeString =
          '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
      ref.read(settingsProvider.notifier).updateNotificationTime(timeString);
    }
  }

  TimeOfDay _parseNotificationTime(String? raw) {
    if (raw == null || raw.trim().isEmpty) {
      return const TimeOfDay(hour: 21, minute: 0);
    }

    final parts = raw.split(':');
    final hour = int.tryParse(parts.isNotEmpty ? parts[0] : '') ?? 21;
    final minute = int.tryParse(parts.length > 1 ? parts[1] : '') ?? 0;
    return TimeOfDay(
      hour: hour.clamp(0, 23),
      minute: minute.clamp(0, 59),
    );
  }

  String _formatNotificationTime(String? raw) {
    final t = _parseNotificationTime(raw);
    final hh = t.hour.toString().padLeft(2, '0');
    final mm = t.minute.toString().padLeft(2, '0');
    return '$hh:$mm';
  }

  void _showLanguagePickerDialog(String? currentLanguage) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
      shape: const RoundedRectangleBorder(
        borderRadius: AppSpacing.borderRadiusBottomSheet,
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: AppSpacing.lg),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.gray200,
                borderRadius: AppSpacing.borderRadiusCircle,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.pageHorizontal,
              ),
              child: Text(
                '언어 선택',
                style: AppTypography.title3(
                  color: isDark
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimaryLight,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.base),
            _ThemeOption(
              title: '한국어',
              isSelected: currentLanguage == 'ko' || currentLanguage == null,
              onTap: () {
                Navigator.pop(context);
                // Locale Provider와 Settings Provider 모두 업데이트
                ref.read(localeProvider.notifier).setLocale(const Locale('ko'));
                ref.read(settingsProvider.notifier).updateLanguage('ko');
              },
            ),
            _ThemeOption(
              title: 'English',
              isSelected: currentLanguage == 'en',
              onTap: () {
                Navigator.pop(context);
                // Locale Provider와 Settings Provider 모두 업데이트
                ref.read(localeProvider.notifier).setLocale(const Locale('en'));
                ref.read(settingsProvider.notifier).updateLanguage('en');
              },
            ),
            const SizedBox(height: AppSpacing.lg),
          ],
        ),
      ),
    );
  }
}

class _ThemeOption extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  const _ThemeOption({
    required this.title,
    this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.pageHorizontal,
          vertical: AppSpacing.md,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.body3(
                      color: isDark
                          ? AppColors.textPrimaryDark
                          : AppColors.textPrimaryLight,
                    ),
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle!,
                      style: AppTypography.caption(
                        color: isDark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondaryLight,
                      ),
                    ),
                ],
              ),
            ),
            if (isSelected) const Icon(Icons.check, color: AppColors.primary),
          ],
        ),
      ),
    );
  }
}
