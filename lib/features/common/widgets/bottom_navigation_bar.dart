import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/locale/app_strings.dart';
import '../../../../core/theme/theme.dart';

enum BottomNavItem {
  home('/home', Icons.home_outlined, Icons.home, 'nav.home'),
  calendar('/calendar', Icons.calendar_today_outlined, Icons.calendar_today, 'nav.calendar'),
  partner('/partner', Icons.favorite_outline, Icons.favorite, 'nav.partner'),
  profile('/profile', Icons.person_outline, Icons.person, 'nav.profile'),
  settings('/settings', Icons.settings_outlined, Icons.settings, 'nav.settings');

  final String path;
  final IconData outlineIcon;
  final IconData filledIcon;
  final String labelKey;

  const BottomNavItem(this.path, this.outlineIcon, this.filledIcon, this.labelKey);
}

class SayvlyBottomNavigationBar extends StatelessWidget {
  final String currentPath;

  const SayvlyBottomNavigationBar({super.key, required this.currentPath});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final s = AppStrings.of(context);

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
                label: s.t(item.labelKey),
                item: item,
                isSelected: isSelected,
                isDark: isDark,
                onTap: () {
                  if (!isSelected) context.go(item.path);
                },
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  bool _isSelected(String path) {
    if (currentPath == path) return true;
    if (path == '/home' && currentPath == '/') return true;
    return currentPath.startsWith('$path/');
  }
}

class _NavItem extends StatelessWidget {
  final BottomNavItem item;
  final String label;
  final bool isSelected;
  final bool isDark;
  final VoidCallback onTap;

  const _NavItem({
    required this.item,
    required this.label,
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
                  : (isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight),
              size: 24,
            ),
            const SizedBox(height: AppSpacing.xxs),
            Text(
              label,
              style: isSelected
                  ? AppTypography.label3Bold(color: AppColors.primary)
                  : AppTypography.label3(
                      color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
