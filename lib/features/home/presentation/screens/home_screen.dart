import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/locale/app_strings.dart';
import '../../../../core/theme/theme.dart';
import '../../../common/widgets/bottom_navigation_bar.dart';
import '../../../cycle/data/models/cycle_calendar_models.dart';
import '../../../cycle/data/repositories/cycle_repository.dart';
import '../../../notification/data/repositories/notification_repository.dart';

final _homeCycleRepositoryProvider = Provider<CycleRepository>((ref) {
  return CycleRepository();
});

final _homeNotificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  return NotificationRepository();
});

final _currentCycleFutureProvider = FutureProvider<CurrentCycleResponse>((ref) {
  return ref.watch(_homeCycleRepositoryProvider).getCurrentCycle();
});

final _unreadNotificationCountProvider = FutureProvider<int>((ref) async {
  final unread = await ref.watch(_homeNotificationRepositoryProvider).getUnreadCount();
  return unread.count;
});

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = AppStrings.of(context);
    final currentPath = GoRouter.of(context).routerDelegate.currentConfiguration.uri.path;
    final cycleAsync = ref.watch(_currentCycleFutureProvider);
    final unreadCountAsync = ref.watch(_unreadNotificationCountProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          s.t('home.title'),
          style: AppTypography.title3(color: AppColors.textPrimaryLight),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () async {
                  await context.push('/notifications');
                  ref.invalidate(_unreadNotificationCountProvider);
                },
                icon: const Icon(Icons.notifications_outlined),
              ),
              unreadCountAsync.when(
                data: (count) {
                  if (count <= 0) return const SizedBox.shrink();
                  return Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                      decoration: BoxDecoration(
                        color: AppColors.error,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        count > 99 ? '99+' : '$count',
                        style: AppTypography.label3Bold(color: AppColors.white),
                      ),
                    ),
                  );
                },
                loading: () => const SizedBox.shrink(),
                error: (_, _) => const SizedBox.shrink(),
              ),
            ],
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(_currentCycleFutureProvider);
          ref.invalidate(_unreadNotificationCountProvider);
          await ref.read(_currentCycleFutureProvider.future);
        },
        child: ListView(
          padding: AppSpacing.pageHorizontalPadding,
          children: [
            const SizedBox(height: AppSpacing.sm),
            cycleAsync.when(
              data: (cycle) => _CurrentCycleSummary(cycle: cycle),
              loading: () => const SizedBox(
                height: 160,
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (_, _) => _SimpleCard(
                title: s.t('home.current_cycle'),
                body: s.t('home.current_cycle_load_fail'),
              ),
            ),
            const SizedBox(height: AppSpacing.base),
            _SimpleCard(
              title: s.t('home.shortcut'),
              body: s.t('home.shortcut_body'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SayvlyBottomNavigationBar(currentPath: currentPath),
    );
  }
}

class _CurrentCycleSummary extends StatelessWidget {
  final CurrentCycleResponse cycle;

  const _CurrentCycleSummary({required this.cycle});

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    final day = cycle.dayOfCycle;
    final dayOfPeriod = cycle.dayOfPeriod;

    String status;
    switch (cycle.phase) {
      case 'MENSTRUATION':
        status = dayOfPeriod == null
            ? s.t('home.status.menstruation')
            : s.t('home.status.menstruation_day', params: {'day': '$dayOfPeriod'});
        break;
      case 'OVULATION':
        status = s.t('home.status.ovulation');
        break;
      case 'PMS':
        status = s.t('home.status.pms');
        break;
      case 'FOLLICULAR':
        status = s.t('home.status.follicular');
        break;
      case 'LUTEAL':
        status = s.t('home.status.luteal');
        break;
      default:
        status = day == null
            ? s.t('home.status.calculating')
            : s.t('home.status.cycle_day', params: {'day': '$day'});
    }

    return _SimpleCard(
      title: s.t('home.current_cycle'),
      body: status,
      footer: cycle.nextPeriodDate == null
          ? null
          : s.t('home.next_period', params: {
              'month': '${cycle.nextPeriodDate!.month}',
              'day': '${cycle.nextPeriodDate!.day}',
            }),
    );
  }
}

class _SimpleCard extends StatelessWidget {
  final String title;
  final String body;
  final String? footer;

  const _SimpleCard({required this.title, required this.body, this.footer});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.base),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: AppSpacing.borderRadiusXl,
        boxShadow: AppShadows.softCard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTypography.body4Bold()),
          const SizedBox(height: AppSpacing.xs),
          Text(body, style: AppTypography.body5()),
          if (footer != null) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(
              footer!,
              style: AppTypography.body6(color: AppColors.textSecondaryLight),
            ),
          ],
        ],
      ),
    );
  }
}
