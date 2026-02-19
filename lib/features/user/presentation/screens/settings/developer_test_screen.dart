import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/theme/theme.dart';
import '../../../../notification/data/repositories/notification_repository.dart';

class DeveloperTestScreen extends StatefulWidget {
  const DeveloperTestScreen({super.key});

  @override
  State<DeveloperTestScreen> createState() => _DeveloperTestScreenState();
}

class _DeveloperTestScreenState extends State<DeveloperTestScreen> {
  final NotificationRepository _notificationRepository = NotificationRepository();
  bool _isCheckingUnread = false;
  bool _isSendingTestPush = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(
          '\uAC1C\uBC1C\uC790 \uD14C\uC2A4\uD2B8',
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
        padding: const EdgeInsets.all(AppSpacing.pageHorizontal),
        children: [
          Text(
            '\uC54C\uB9BC \uAE30\uB2A5 \uD14C\uC2A4\uD2B8',
            style: AppTypography.body3Bold(
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          ElevatedButton.icon(
            onPressed: () => context.push('/notifications'),
            icon: const Icon(Icons.notifications_outlined),
            label: const Text(
              '\uC54C\uB9BC \uC13C\uD130 \uC5F4\uAE30',
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          ElevatedButton.icon(
            onPressed: _isSendingTestPush ? null : _sendTestPush,
            icon: _isSendingTestPush
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.send_outlined),
            label: Text(
              _isSendingTestPush
                  ? '\uBC1C\uC1A1 \uC911...'
                  : '\uD14C\uC2A4\uD2B8 \uD478\uC2DC \uBCF4\uB0B4\uAE30',
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          OutlinedButton.icon(
            onPressed: _isCheckingUnread ? null : _checkUnreadCount,
            icon: _isCheckingUnread
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.refresh),
            label: Text(
              _isCheckingUnread
                  ? '\uC870\uD68C \uC911...'
                  : '\uBBF8\uD655\uC778 \uAC1C\uC218 \uC870\uD68C',
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            '\uD478\uC2DC \uC218\uC2E0 \uD6C4 \uBBF8\uD655\uC778 \uAC1C\uC218\uB97C \uC870\uD68C\uD558\uAC70\uB098 \uC54C\uB9BC \uC13C\uD130\uB85C \uBC14\uB85C \uD655\uC778\uD560 \uC218 \uC788\uC2B5\uB2C8\uB2E4.',
            style: AppTypography.body4(
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _checkUnreadCount() async {
    setState(() => _isCheckingUnread = true);
    try {
      final unread = await _notificationRepository.getUnreadCount();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '\uBBF8\uD655\uC778 \uC54C\uB9BC: ${unread.count}\uAC1C',
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('\uC870\uD68C \uC2E4\uD328: $e'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isCheckingUnread = false);
      }
    }
  }

  Future<void> _sendTestPush() async {
    setState(() => _isSendingTestPush = true);
    try {
      await _notificationRepository.sendTestPush();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            '\uD14C\uC2A4\uD2B8 \uD478\uC2DC \uC694\uCCAD \uC644\uB8CC',
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '\uD478\uC2DC \uC694\uCCAD \uC2E4\uD328: $e',
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isSendingTestPush = false);
      }
    }
  }
}
