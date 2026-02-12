import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/theme/theme.dart';
import '../../../data/models/account_models.dart';
import '../../providers/account_provider.dart';

/// 로그인 기기 관리 화면
class DevicesScreen extends ConsumerStatefulWidget {
  const DevicesScreen({super.key});

  @override
  ConsumerState<DevicesScreen> createState() => _DevicesScreenState();
}

class _DevicesScreenState extends ConsumerState<DevicesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(devicesProvider.notifier).loadDevices();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final state = ref.watch(devicesProvider);

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(
          '로그인 기기',
          style: AppTypography.title3(
            color: isDark
                ? AppColors.textPrimaryDark
                : AppColors.textPrimaryLight,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () => _showLogoutAllDialog(context),
            child: Text(
              '모두 로그아웃',
              style: AppTypography.body5(color: AppColors.error),
            ),
          ),
        ],
      ),
      body: _buildBody(state, isDark),
    );
  }

  Widget _buildBody(AsyncValue<List<DeviceInfo>> state, bool isDark) {
    // 데이터가 없으면 로딩 표시
    if (!state.hasValue) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      );
    }

    if (state.value!.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.devices_outlined,
              size: 64,
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
            ),
            const SizedBox(height: AppSpacing.base),
            Text(
              '로그인된 기기가 없습니다.',
              style: AppTypography.body3(
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondaryLight,
              ),
            ),
          ],
        ),
      );
    }

    final devices = state.value!;

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.base),
      itemCount: devices.length,
      itemBuilder: (context, index) {
        final device = devices[index];
        return _DeviceTile(
          device: device,
          onLogout: () => _logoutDevice(device),
          isDark: isDark,
        );
      },
    );
  }

  Future<void> _logoutDevice(DeviceInfo device) async {
    if (device.isCurrentDevice) {
      _showCurrentDeviceDialog();
      return;
    }

    final confirmed = await _showLogoutConfirmDialog(device.deviceName);
    if (confirmed == true) {
      await ref.read(devicesProvider.notifier).logoutDevice(device.tokenId);
    }
  }

  void _showCurrentDeviceDialog() {
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
          '현재 기기',
          style: AppTypography.title3(
            color: isDark
                ? AppColors.textPrimaryDark
                : AppColors.textPrimaryLight,
          ),
        ),
        content: Text(
          '현재 사용 중인 기기입니다.\n로그아웃하려면 계정 관리에서 로그아웃하세요.',
          style: AppTypography.body4(
            color: isDark
                ? AppColors.textSecondaryDark
                : AppColors.textSecondaryLight,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }

  Future<bool?> _showLogoutConfirmDialog(String deviceName) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor:
            isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacing.borderRadiusXl,
        ),
        title: Text(
          '기기 로그아웃',
          style: AppTypography.title3(
            color: isDark
                ? AppColors.textPrimaryDark
                : AppColors.textPrimaryLight,
          ),
        ),
        content: Text(
          '$deviceName에서 로그아웃하시겠습니까?',
          style: AppTypography.body4(
            color: isDark
                ? AppColors.textSecondaryDark
                : AppColors.textSecondaryLight,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
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
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              '로그아웃',
              style: AppTypography.body4Bold(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutAllDialog(BuildContext context) {
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
          '모든 기기 로그아웃',
          style: AppTypography.title3(
            color: isDark
                ? AppColors.textPrimaryDark
                : AppColors.textPrimaryLight,
          ),
        ),
        content: Text(
          '모든 기기에서 로그아웃됩니다.\n현재 기기도 로그아웃되며 다시 로그인해야 합니다.',
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
              await ref.read(devicesProvider.notifier).logoutAllDevices();
              if (mounted) {
                // 로그인 화면으로 이동
              }
            },
            child: Text(
              '모두 로그아웃',
              style: AppTypography.body4Bold(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}

class _DeviceTile extends StatelessWidget {
  final DeviceInfo device;
  final VoidCallback onLogout;
  final bool isDark;

  const _DeviceTile({
    required this.device,
    required this.onLogout,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.pageHorizontal,
        vertical: AppSpacing.xs,
      ),
      padding: AppSpacing.cardInsets,
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        borderRadius: AppSpacing.borderRadiusXl,
        border: device.isCurrentDevice
            ? Border.all(color: AppColors.primary, width: 1)
            : null,
        boxShadow: AppShadows.softCard,
      ),
      child: Row(
        children: [
          // 기기 아이콘
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: device.isCurrentDevice
                  ? AppColors.primary.withValues(alpha: 0.1)
                  : AppColors.gray100,
              borderRadius: AppSpacing.borderRadiusLg,
            ),
            child: Icon(
              _getDeviceIcon(),
              color: device.isCurrentDevice
                  ? AppColors.primary
                  : AppColors.gray500,
            ),
          ),
          const SizedBox(width: AppSpacing.md),

          // 기기 정보
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      device.deviceName,
                      style: AppTypography.body4Bold(
                        color: isDark
                            ? AppColors.textPrimaryDark
                            : AppColors.textPrimaryLight,
                      ),
                    ),
                    if (device.isCurrentDevice) ...[
                      const SizedBox(width: AppSpacing.xs),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.xs,
                          vertical: AppSpacing.xxs,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          borderRadius: AppSpacing.borderRadiusSm,
                        ),
                        child: Text(
                          '현재 기기',
                          style: AppTypography.small(color: AppColors.primary),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  '마지막 활동: ${_formatDate(device.lastUsedAt)}',
                  style: AppTypography.caption(
                    color: isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondaryLight,
                  ),
                ),
                if (device.ipAddress != null)
                  Text(
                    'IP: ${device.ipAddress}',
                    style: AppTypography.small(
                      color: isDark
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondaryLight,
                    ),
                  ),
              ],
            ),
          ),

          // 로그아웃 버튼
          IconButton(
            onPressed: onLogout,
            icon: Icon(
              Icons.logout,
              color: device.isCurrentDevice
                  ? AppColors.gray300
                  : AppColors.error,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getDeviceIcon() {
    switch (device.deviceType.toLowerCase()) {
      case 'mobile':
      case 'android':
      case 'ios':
        return Icons.smartphone;
      case 'tablet':
      case 'ipad':
        return Icons.tablet;
      case 'desktop':
      case 'web':
        return Icons.computer;
      default:
        return Icons.devices;
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inMinutes < 1) {
      return '방금 전';
    } else if (diff.inHours < 1) {
      return '${diff.inMinutes}분 전';
    } else if (diff.inDays < 1) {
      return '${diff.inHours}시간 전';
    } else if (diff.inDays < 7) {
      return '${diff.inDays}일 전';
    } else {
      return '${date.month}/${date.day}';
    }
  }
}
