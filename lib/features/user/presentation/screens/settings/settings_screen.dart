import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/locale/app_strings.dart';
import '../../../../../core/locale/locale_provider.dart';
import '../../../../../core/theme/theme.dart';
import '../../../../common/widgets/bottom_navigation_bar.dart';
import '../../../data/models/settings_models.dart' as settings_models;
import '../../../data/models/user_models.dart';
import '../../providers/settings_provider.dart';
import '../../providers/user_provider.dart';
import '../../widgets/picker_bottom_sheet.dart';
import '../../widgets/setting_toggle_tile.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool get _shouldShowDeveloperTestMenu =>
      !kReleaseMode && defaultTargetPlatform == TargetPlatform.android;

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final settingsState = ref.watch(settingsProvider);
    final profile = ref.watch(currentProfileProvider);
    final router = GoRouter.of(context);
    final currentPath = router.routerDelegate.currentConfiguration.uri.path;

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(
          s.t('settings.title'),
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
    final s = AppStrings.of(context);

    if (!settingsState.hasValue) {
      return const Center(child: CircularProgressIndicator(color: AppColors.primary));
    }

    final settings = settingsState.valueOrNull;

    return ListView(
      children: [
        SettingSectionHeader(title: s.t('settings.section.notifications')),

        if (profile?.gender == Gender.female) ...[
          SettingToggleTile(
            title: s.t('settings.period_reminder.title'),
            subtitle: s.t('settings.period_reminder.subtitle'),
            leadingIcon: Icons.event_note_outlined,
            value: settings?.notificationPeriodReminder ?? true,
            onChanged: (value) {
              ref.read(settingsProvider.notifier).toggleNotification(periodReminder: value);
            },
          ),
          SettingToggleTile(
            title: s.t('settings.ovulation.title'),
            subtitle: s.t('settings.ovulation.subtitle'),
            leadingIcon: Icons.favorite_outline,
            value: settings?.notificationOvulation ?? false,
            onChanged: (value) {
              ref.read(settingsProvider.notifier).toggleNotification(ovulation: value);
            },
          ),
        ] else ...[
          SettingToggleTile(
            title: s.t('settings.partner_period.title'),
            subtitle: s.t('settings.partner_period.subtitle'),
            leadingIcon: Icons.notifications_outlined,
            value: settings?.notificationPartnerPeriod ?? true,
            onChanged: (value) {
              ref.read(settingsProvider.notifier).toggleNotification(partnerPeriod: value);
            },
          ),
          SettingToggleTile(
            title: s.t('settings.partner_pms.title'),
            subtitle: s.t('settings.partner_pms.subtitle'),
            leadingIcon: Icons.sentiment_satisfied_alt_outlined,
            value: settings?.notificationPartnerPms ?? true,
            onChanged: (value) {
              ref.read(settingsProvider.notifier).toggleNotification(partnerPms: value);
            },
          ),
          SettingToggleTile(
            title: s.t('settings.care_tip.title'),
            subtitle: s.t('settings.care_tip.subtitle'),
            leadingIcon: Icons.lightbulb_outline,
            value: settings?.notificationCareTips ?? true,
            onChanged: (value) {
              ref.read(settingsProvider.notifier).toggleNotification(careTips: value);
            },
          ),
        ],

        SettingToggleTile(
          title: s.t('settings.anniversary.title'),
          leadingIcon: Icons.cake_outlined,
          value: settings?.notificationAnniversary ?? true,
          onChanged: (value) {
            ref.read(settingsProvider.notifier).toggleNotification(anniversary: value);
          },
        ),

        SettingToggleTile(
          title: s.t('settings.daily_record.title'),
          subtitle: s.t('settings.daily_record.subtitle'),
          leadingIcon: Icons.edit_note_outlined,
          value: settings?.notificationDailyRecord ?? true,
          onChanged: (value) {
            ref.read(settingsProvider.notifier).toggleNotification(dailyRecord: value);
          },
        ),

        SettingNavigationTile(
          title: s.t('settings.notification_time'),
          leadingIcon: Icons.access_time_outlined,
          value: _formatNotificationTime(settings?.notificationTime),
          onTap: _showTimePickerDialog,
        ),

        SettingNavigationTile(
          title: s.t('settings.notification_center.title'),
          subtitle: s.t('settings.notification_center.subtitle'),
          leadingIcon: Icons.notifications_none_outlined,
          onTap: () => context.push('/notifications'),
        ),

        const SizedBox(height: AppSpacing.lg),
        SettingSectionHeader(title: s.t('settings.section.app')),

        SettingNavigationTile(
          title: s.t('settings.language'),
          leadingIcon: Icons.language_outlined,
          value: _getLanguageName(settings?.language),
          onTap: () => _showLanguagePickerDialog(settings?.language),
        ),

        const SizedBox(height: AppSpacing.lg),
        SettingSectionHeader(title: s.t('settings.section.account')),

        SettingNavigationTile(
          title: s.t('settings.profile'),
          leadingIcon: Icons.person_outline,
          onTap: () => context.push('/profile'),
        ),

        SettingNavigationTile(
          title: s.t('settings.account_management'),
          leadingIcon: Icons.manage_accounts_outlined,
          onTap: () => context.push('/account'),
        ),

        if (_shouldShowDeveloperTestMenu)
          SettingNavigationTile(
            title: s.t('settings.developer_test.title'),
            subtitle: s.t('settings.developer_test.subtitle'),
            leadingIcon: Icons.developer_mode_outlined,
            onTap: () => context.push('/settings/developer-test'),
          ),

        const SizedBox(height: AppSpacing.lg),
        SettingSectionHeader(title: s.t('settings.section.info')),

        SettingNavigationTile(
          title: s.t('settings.terms'),
          leadingIcon: Icons.description_outlined,
          onTap: () {},
        ),

        SettingNavigationTile(
          title: s.t('settings.privacy'),
          leadingIcon: Icons.privacy_tip_outlined,
          onTap: () {},
        ),

        SettingNavigationTile(
          title: s.t('settings.app_version'),
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
    final s = AppStrings.of(context);
    switch (language) {
      case 'en':
        return 'English';
      case 'ko':
      default:
        return s.t('settings.korean');
    }
  }

  void _showTimePickerDialog() async {
    final s = AppStrings.of(context);
    final settings = ref.read(currentSettingsProvider);
    final initial = _parseNotificationTime(settings?.notificationTime);

    final picked = await showTimePickerBottomSheet(
      context: context,
      initialTime: initial,
      title: s.t('settings.notification_time.select'),
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
    return TimeOfDay(hour: hour.clamp(0, 23), minute: minute.clamp(0, 59));
  }

  String _formatNotificationTime(String? raw) {
    final t = _parseNotificationTime(raw);
    final hh = t.hour.toString().padLeft(2, '0');
    final mm = t.minute.toString().padLeft(2, '0');
    return '$hh:$mm';
  }

  void _showLanguagePickerDialog(String? currentLanguage) {
    final s = AppStrings.of(context);
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
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.pageHorizontal),
              child: Text(
                s.t('settings.language_select'),
                style: AppTypography.title3(
                  color: isDark
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimaryLight,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.base),
            _ThemeOption(
              title: s.t('settings.korean'),
              isSelected: currentLanguage == 'ko' || currentLanguage == null,
              onTap: () async {
                Navigator.pop(context);
                final localeNotifier = ref.read(localeProvider.notifier);
                final previousLocale = ref.read(localeProvider);
                await localeNotifier.setLocale(const Locale('ko'));
                final success = await ref.read(settingsProvider.notifier).updateLanguage('ko');
                if (!success) await localeNotifier.setLocale(previousLocale);
              },
            ),
            _ThemeOption(
              title: 'English',
              isSelected: currentLanguage == 'en',
              onTap: () async {
                Navigator.pop(context);
                final localeNotifier = ref.read(localeProvider.notifier);
                final previousLocale = ref.read(localeProvider);
                await localeNotifier.setLocale(const Locale('en'));
                final success = await ref.read(settingsProvider.notifier).updateLanguage('en');
                if (!success) await localeNotifier.setLocale(previousLocale);
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
  final bool isSelected;
  final VoidCallback onTap;

  const _ThemeOption({
    required this.title,
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
              child: Text(
                title,
                style: AppTypography.body3(
                  color: isDark
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimaryLight,
                ),
              ),
            ),
            if (isSelected) const Icon(Icons.check, color: AppColors.primary),
          ],
        ),
      ),
    );
  }
}
