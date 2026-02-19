import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/theme.dart';
import '../../data/models/notification_models.dart';
import '../providers/notification_provider.dart';

class NotificationScreen extends ConsumerStatefulWidget {
  const NotificationScreen({super.key});

  @override
  ConsumerState<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends ConsumerState<NotificationScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ref.read(notificationProvider.notifier).refresh();
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 200) {
      ref.read(notificationProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(notificationProvider);
    final notifier = ref.read(notificationProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '알림',
          style: AppTypography.title3(color: AppColors.textPrimaryLight),
        ),
        actions: [
          TextButton(
            onPressed: state.isLoading || state.isSubmitting
                ? null
                : notifier.markAllAsRead,
            child: Text(
              '전체 읽음',
              style: AppTypography.body6(color: AppColors.primary),
            ),
          ),
          IconButton(
            onPressed: state.isLoading ? null : notifier.refresh,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Column(
        children: [
          if (state.isSubmitting) const LinearProgressIndicator(),
          if (state.errorMessage != null) _ErrorBar(message: state.errorMessage!),
          Expanded(
            child: state.isLoading
                ? const Center(child: CircularProgressIndicator())
                : state.items.isEmpty
                ? Center(
                    child: Text(
                      '알림이 없어요.',
                      style: AppTypography.body5(
                        color: AppColors.textSecondaryLight,
                      ),
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: notifier.refresh,
                    child: ListView.separated(
                      controller: _scrollController,
                      padding: AppSpacing.pageHorizontalPadding,
                      itemCount: state.items.length + (state.hasMore ? 1 : 0),
                      separatorBuilder: (_, _) => const SizedBox(height: 10),
                      itemBuilder: (_, index) {
                        if (index >= state.items.length) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                            child: Center(
                              child: state.isLoadingMore
                                  ? const CircularProgressIndicator()
                                  : Text(
                                      '아래로 더 내려서 계속 불러오세요.',
                                      style: AppTypography.caption(
                                        color: AppColors.textSecondaryLight,
                                      ),
                                    ),
                            ),
                          );
                        }

                        final item = state.items[index];
                        return _NotificationCard(
                          item: item,
                          onTap: () => _handleTap(context, item),
                          onDelete: () => notifier.deleteNotification(item),
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleTap(BuildContext context, NotificationItemModel item) async {
    final notifier = ref.read(notificationProvider.notifier);
    await notifier.markAsRead(item);

    final targetRoute = _routeByType(item.type);
    if (targetRoute != null && context.mounted) {
      context.push(targetRoute);
    }
  }

  String? _routeByType(String type) {
    switch (type) {
      case 'PERIOD_REMINDER':
      case 'PERIOD_START':
      case 'OVULATION':
      case 'DAILY_RECORD':
        return '/calendar';
      case 'PARTNER_PERIOD':
      case 'PARTNER_PMS':
      case 'CARE_TIP':
        return '/partner';
      case 'ANNIVERSARY':
        return '/partner';
      case 'SUBSCRIPTION_EXPIRING':
      case 'SUBSCRIPTION_EXPIRED':
      case 'TRIAL_ENDING':
        return '/settings';
      case 'ANNOUNCEMENT':
      case 'CHAT_MESSAGE':
        return '/home';
      default:
        return null;
    }
  }
}

class _NotificationCard extends StatelessWidget {
  final NotificationItemModel item;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const _NotificationCard({
    required this.item,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final created = item.createdAt;
    final createdText =
        '${created.month}/${created.day} ${created.hour.toString().padLeft(2, '0')}:${created.minute.toString().padLeft(2, '0')}';

    return InkWell(
      onTap: onTap,
      borderRadius: AppSpacing.borderRadiusLg,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.base),
        decoration: BoxDecoration(
          color: item.isRead
              ? AppColors.surfaceLight
              : AppColors.primary.withValues(alpha: 0.06),
          borderRadius: AppSpacing.borderRadiusLg,
          border: Border.all(
            color: item.isRead
                ? AppColors.borderLight
                : AppColors.primary.withValues(alpha: 0.3),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Icon(
                _iconByType(item.type),
                color: _iconColorByType(item.type),
                size: 20,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.title,
                          style: item.isRead
                              ? AppTypography.body4()
                              : AppTypography.body4Bold(),
                        ),
                      ),
                      if (!item.isRead)
                        Container(
                          width: 8,
                          height: 8,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                      IconButton(
                        onPressed: onDelete,
                        icon: const Icon(Icons.close, size: 18),
                        visualDensity: VisualDensity.compact,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(item.body, style: AppTypography.body6()),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    createdText,
                    style: AppTypography.caption(color: AppColors.textSecondaryLight),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _iconByType(String type) {
    switch (type) {
      case 'PERIOD_REMINDER':
      case 'PERIOD_START':
      case 'OVULATION':
      case 'DAILY_RECORD':
        return Icons.calendar_today_outlined;
      case 'PARTNER_PERIOD':
      case 'PARTNER_PMS':
      case 'CARE_TIP':
        return Icons.favorite_outline;
      case 'ANNIVERSARY':
        return Icons.cake_outlined;
      case 'SUBSCRIPTION_EXPIRING':
      case 'SUBSCRIPTION_EXPIRED':
      case 'TRIAL_ENDING':
        return Icons.workspace_premium_outlined;
      case 'ANNOUNCEMENT':
        return Icons.campaign_outlined;
      case 'CHAT_MESSAGE':
        return Icons.chat_bubble_outline;
      default:
        return Icons.notifications_none;
    }
  }

  Color _iconColorByType(String type) {
    switch (type) {
      case 'PARTNER_PERIOD':
      case 'PARTNER_PMS':
      case 'CARE_TIP':
        return AppColors.secondary;
      case 'ANNIVERSARY':
        return AppColors.accent;
      case 'SUBSCRIPTION_EXPIRING':
      case 'SUBSCRIPTION_EXPIRED':
      case 'TRIAL_ENDING':
        return AppColors.warning;
      default:
        return AppColors.primary;
    }
  }
}

class _ErrorBar extends StatelessWidget {
  final String message;

  const _ErrorBar({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(
        AppSpacing.pageHorizontal,
        AppSpacing.sm,
        AppSpacing.pageHorizontal,
        0,
      ),
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.08),
        borderRadius: AppSpacing.borderRadiusMd,
      ),
      child: Text(
        message,
        style: AppTypography.body6(color: AppColors.error),
      ),
    );
  }
}
