import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
  final unread = await ref
      .watch(_homeNotificationRepositoryProvider)
      .getUnreadCount();
  return unread.count;
});

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPath = GoRouter.of(context).routerDelegate.currentConfiguration.uri.path;
    final cycleAsync = ref.watch(_currentCycleFutureProvider);
    final unreadCountAsync = ref.watch(_unreadNotificationCountProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '홈',
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 1,
                      ),
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
              error: (_, _) => const _SimpleCard(
                title: '현재 주기',
                body: '현재 주기 정보를 불러오지 못했어요.',
              ),
            ),
            const SizedBox(height: AppSpacing.base),
            const _SimpleCard(
              title: '바로가기',
              body: '캘린더에서 주기 기록을 관리하고, 파트너에서 공유 설정을 조정하세요.',
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
    final day = cycle.dayOfCycle;
    final dayOfPeriod = cycle.dayOfPeriod;

    String status;
    switch (cycle.phase) {
      case 'MENSTRUATION':
        status = dayOfPeriod == null
            ? '현재 생리 중입니다.'
            : '현재 생리 $dayOfPeriod일차입니다.';
        break;
      case 'OVULATION':
        status = '현재 배란기입니다.';
        break;
      case 'PMS':
        status = '현재 PMS 기간입니다.';
        break;
      case 'FOLLICULAR':
        status = '현재 난포기입니다.';
        break;
      case 'LUTEAL':
        status = '현재 황체기입니다.';
        break;
      default:
        status = day == null ? '주기 계산 중입니다.' : '현재 주기 $day일차입니다.';
    }

    return _SimpleCard(
      title: '현재 주기',
      body: status,
      footer: cycle.nextPeriodDate == null
          ? null
          : '다음 예상 생리: ${cycle.nextPeriodDate!.month}/${cycle.nextPeriodDate!.day}',
    );
  }
}

class _SimpleCard extends StatelessWidget {
  final String title;
  final String body;
  final String? footer;

  const _SimpleCard({
    required this.title,
    required this.body,
    this.footer,
  });

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
