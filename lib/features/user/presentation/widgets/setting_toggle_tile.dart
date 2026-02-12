import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';

/// 설정 토글 타일
/// 스위치가 있는 설정 항목 위젯
class SettingToggleTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? leadingIcon;
  final bool value;
  final ValueChanged<bool>? onChanged;
  final bool enabled;

  const SettingToggleTile({
    super.key,
    required this.title,
    this.subtitle,
    this.leadingIcon,
    required this.value,
    this.onChanged,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final textColor = enabled
        ? (isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight)
        : (isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight);

    final subtitleColor =
        isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;

    return InkWell(
      onTap: enabled ? () => onChanged?.call(!value) : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.pageHorizontal,
          vertical: AppSpacing.md,
        ),
        child: Row(
          children: [
            // 아이콘 (선택)
            if (leadingIcon != null) ...[
              Icon(
                leadingIcon,
                size: AppSpacing.iconBase,
                color: textColor,
              ),
              const SizedBox(width: AppSpacing.md),
            ],

            // 텍스트
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.body4(color: textColor),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      subtitle!,
                      style: AppTypography.caption(color: subtitleColor),
                    ),
                  ],
                ],
              ),
            ),

            // 스위치
            Switch.adaptive(
              value: value,
              onChanged: enabled ? onChanged : null,
              activeColor: AppColors.primary,
              activeTrackColor: AppColors.primary.withValues(alpha: 0.3),
              inactiveThumbColor: AppColors.gray300,
              inactiveTrackColor: AppColors.gray100,
            ),
          ],
        ),
      ),
    );
  }
}

/// 설정 선택 타일
/// 화살표가 있는 설정 항목 위젯 (다른 화면으로 이동)
class SettingNavigationTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? value;
  final IconData? leadingIcon;
  final VoidCallback? onTap;
  final bool enabled;
  final bool showDivider;

  const SettingNavigationTile({
    super.key,
    required this.title,
    this.subtitle,
    this.value,
    this.leadingIcon,
    this.onTap,
    this.enabled = true,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final textColor = enabled
        ? (isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight)
        : (isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight);

    final subtitleColor =
        isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: enabled ? onTap : null,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.pageHorizontal,
              vertical: AppSpacing.md,
            ),
            child: Row(
              children: [
                // 아이콘 (선택)
                if (leadingIcon != null) ...[
                  Icon(
                    leadingIcon,
                    size: AppSpacing.iconBase,
                    color: textColor,
                  ),
                  const SizedBox(width: AppSpacing.md),
                ],

                // 텍스트
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppTypography.body4(color: textColor),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: AppSpacing.xxs),
                        Text(
                          subtitle!,
                          style: AppTypography.caption(color: subtitleColor),
                        ),
                      ],
                    ],
                  ),
                ),

                // 값 표시 (선택)
                if (value != null) ...[
                  Text(
                    value!,
                    style: AppTypography.body5(color: subtitleColor),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                ],

                // 화살표
                Icon(
                  Icons.chevron_right,
                  size: AppSpacing.iconBase,
                  color: subtitleColor,
                ),
              ],
            ),
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            indent: leadingIcon != null
                ? AppSpacing.pageHorizontal + AppSpacing.iconBase + AppSpacing.md
                : AppSpacing.pageHorizontal,
            endIndent: AppSpacing.pageHorizontal,
            color: isDark ? AppColors.borderDark : AppColors.borderLight,
          ),
      ],
    );
  }
}

/// 설정 섹션 헤더
class SettingSectionHeader extends StatelessWidget {
  final String title;

  const SettingSectionHeader({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.pageHorizontal,
        AppSpacing.lg,
        AppSpacing.pageHorizontal,
        AppSpacing.sm,
      ),
      child: Text(
        title,
        style: AppTypography.label2Bold(
          color:
              isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
        ),
      ),
    );
  }
}

/// 위험한 액션 타일 (탈퇴 등)
class SettingDangerTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? leadingIcon;
  final VoidCallback? onTap;

  const SettingDangerTile({
    super.key,
    required this.title,
    this.subtitle,
    this.leadingIcon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.pageHorizontal,
          vertical: AppSpacing.md,
        ),
        child: Row(
          children: [
            // 아이콘 (선택)
            if (leadingIcon != null) ...[
              Icon(
                leadingIcon,
                size: AppSpacing.iconBase,
                color: AppColors.error,
              ),
              const SizedBox(width: AppSpacing.md),
            ],

            // 텍스트
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.body4(color: AppColors.error),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      subtitle!,
                      style: AppTypography.caption(
                        color: AppColors.error.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // 화살표
            const Icon(
              Icons.chevron_right,
              size: AppSpacing.iconBase,
              color: AppColors.error,
            ),
          ],
        ),
      ),
    );
  }
}
