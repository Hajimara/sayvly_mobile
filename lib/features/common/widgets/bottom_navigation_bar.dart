import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/theme.dart';

/// 바텀 네비게이션 바 아이템
enum BottomNavItem {
  home('/home', Icons.home_outlined, Icons.home, '홈'),
  calendar(
    '/calendar',
    Icons.calendar_today_outlined,
    Icons.calendar_today,
    '캘린더',
  ),
  partner('/partner', Icons.favorite_outline, Icons.favorite, '파트너'),
  profile('/profile', Icons.person_outline, Icons.person, '프로필'),
  settings('/settings', Icons.settings_outlined, Icons.settings, '설정');

  final String path;
  final IconData outlineIcon;
  final IconData filledIcon;
  final String label;

  const BottomNavItem(this.path, this.outlineIcon, this.filledIcon, this.label);
}

/// Sayvly 스타일 바텀 네비게이션 바
class SayvlyBottomNavigationBar extends StatelessWidget {
  final String currentPath;

  const SayvlyBottomNavigationBar({super.key, required this.currentPath});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        boxShadow: AppShadows.bottomNav,
      ),
      child: SafeArea(
        child: Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: BottomNavItem.values.map((item) {
              final isSelected = _isSelected(item.path);
              return _NavItem(
                item: item,
                isSelected: isSelected,
                isDark: isDark,
                onTap: () {
                  if (!isSelected) {
                    context.go(item.path);
                  }
                },
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  bool _isSelected(String path) {
    // 정확히 일치하거나 하위 경로인지 확인
    if (currentPath == path) return true;
    if (path == '/home' && currentPath == '/') return true;
    return currentPath.startsWith('$path/');
  }
}

/// 네비게이션 아이템 위젯
class _NavItem extends StatelessWidget {
  final BottomNavItem item;
  final bool isSelected;
  final bool isDark;
  final VoidCallback onTap;

  const _NavItem({
    required this.item,
    required this.isSelected,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: AppSpacing.borderRadiusMd,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSelected ? item.filledIcon : item.outlineIcon,
              color: isSelected
                  ? AppColors.primary
                  : (isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondaryLight),
              size: 24,
            ),
            const SizedBox(height: AppSpacing.xxs),
            Text(
              item.label,
              style: isSelected
                  ? AppTypography.label3Bold(color: AppColors.primary)
                  : AppTypography.label3(
                      color: isDark
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondaryLight,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
