import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/theme.dart';
import '../../../common/widgets/bottom_navigation_bar.dart';
import '../../../notification/data/repositories/notification_repository.dart';
import '../../data/models/cycle_calendar_models.dart';
import '../providers/cycle_calendar_provider.dart';

final _calendarNotificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  return NotificationRepository();
});

final _calendarUnreadNotificationCountProvider = FutureProvider<int>((ref) async {
  final unread = await ref.watch(_calendarNotificationRepositoryProvider).getUnreadCount();
  return unread.count;
});

class CalendarScreen extends ConsumerWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(cycleCalendarProvider);
    final notifier = ref.read(cycleCalendarProvider.notifier);
    final unreadCountAsync = ref.watch(_calendarUnreadNotificationCountProvider);
    final currentPath = GoRouter.of(
      context,
    ).routerDelegate.currentConfiguration.uri.path;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sayvly 캘린더',
          style: AppTypography.title3(color: AppColors.textPrimaryLight),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () async {
                  await context.push('/notifications');
                  ref.invalidate(_calendarUnreadNotificationCountProvider);
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
          TextButton(
            onPressed: state.isLoadingMonth || state.isLoadingDay
                ? null
                : notifier.goToToday,
            child: const Text('오늘'),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: notifier.refreshAll,
        child: ListView(
          padding: AppSpacing.pageHorizontalPadding,
          children: [
            const SizedBox(height: AppSpacing.sm),
            _CurrentCycleCard(
              state: state,
              onOpenTodayMenu: () =>
                  _openDateActionMenu(context, ref, DateTime.now()),
            ),
            const SizedBox(height: AppSpacing.lg),
            _MonthHeader(
              focusedMonth: state.focusedMonth,
              onPrev: notifier.goToPreviousMonth,
              onNext: notifier.goToNextMonth,
            ),
            const SizedBox(height: AppSpacing.sm),
            _CalendarGrid(
              state: state,
              onTapDate: notifier.selectDate,
            ),
            const SizedBox(height: AppSpacing.lg),
            _DayDetailCard(
              state: state,
              onTapPredictedSymptom: (symptom) {
                _showPredictedSymptomBottomSheet(
                  context,
                  ref,
                  symptom,
                  state.dayDetail?.phase ?? 'UNKNOWN',
                );
              },
            ),
            const SizedBox(height: AppSpacing.section),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final selected = ref.read(cycleCalendarProvider).selectedDate;
          final today = DateTime.now();
          final normalizedToday = DateTime(today.year, today.month, today.day);
          if (selected.isAfter(normalizedToday)) {
            if (!context.mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('미래 날짜는 수정할 수 없습니다.'),
              ),
            );
            return;
          }
          await _openDateActionMenu(context, ref, selected);
        },
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        child: const Icon(Icons.today),
      ),
      bottomNavigationBar: SayvlyBottomNavigationBar(currentPath: currentPath),
    );
  }

  Future<void> _openDateActionMenu(
    BuildContext context,
    WidgetRef ref,
    DateTime targetDate,
  ) async {
    final notifier = ref.read(cycleCalendarProvider.notifier);
    final state = ref.read(cycleCalendarProvider);
    final normalized = DateTime(
      targetDate.year,
      targetDate.month,
      targetDate.day,
    );
    final ongoingCycle = state.currentCycle?.currentCycle;
    final canRecoverOngoing = ongoingCycle != null && ongoingCycle.isOngoing;

    // 선택된 날짜의 주기 정보 (dayDetail에서 확인)
    final selectedDayCycle = state.dayDetail?.cycle;
    final hasSelectedDayCycle = selectedDayCycle != null;

    await showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: AppSpacing.borderRadiusBottomSheet,
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.base,
              AppSpacing.base,
              AppSpacing.base,
              AppSpacing.xl,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${normalized.month}월 ${normalized.day}일 메뉴',
                  style: AppTypography.title3(),
                ),
                const SizedBox(height: AppSpacing.base),
                _ActionTile(
                  icon: Icons.play_circle_outline,
                  label: '생리 시작',
                  onTap: () async {
                    Navigator.of(context).pop();
                    final ok = await notifier.startCycleOn(normalized);
                    if (context.mounted) {
                      final message =
                          ok
                              ? '생리 시작 완료'
                              : (ref.read(cycleCalendarProvider).errorMessage ??
                                  '처리에 실패했습니다.');
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(message)));
                    }
                  },
                ),
                _ActionTile(
                  icon: Icons.stop_circle_outlined,
                  label: '생리 종료',
                  onTap: () async {
                    Navigator.of(context).pop();
                    final ok = await notifier.endCycleOn(normalized);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            ok
                                ? '생리 종료가 기록되었습니다.'
                                : (ref
                                          .read(cycleCalendarProvider)
                                          .errorMessage ??
                                      '처리에 실패했습니다.'),
                          ),
                        ),
                      );
                    }
                  },
                ),
                _ActionTile(
                  icon: Icons.edit_note,
                  label: '증상 기록',
                  onTap: () async {
                    Navigator.of(context).pop();
                    if (context.mounted) {
                      await _showSymptomRecordBottomSheet(
                        context,
                        ref,
                        normalized,
                      );
                    }
                  },
                ),
                // 진행 중인 주기일 때: 시작일 수정 + 삭제
                if (canRecoverOngoing) ...[
                  const Divider(height: AppSpacing.lg),
                  _ActionTile(
                    icon: Icons.edit_calendar_outlined,
                    label: '시작일 수정',
                    onTap: () async {
                      Navigator.of(context).pop();
                      final ok = await notifier.updateCycleStartDate(
                        cycleId: ongoingCycle.id,
                        startDate: normalized,
                      );
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              ok
                                  ? '시작일 수정 완료'
                                  : (ref
                                            .read(cycleCalendarProvider)
                                            .errorMessage ??
                                        '수정 실패'),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  _ActionTile(
                    icon: Icons.delete_outline,
                    label: '기록 삭제',
                    onTap: () async {
                      Navigator.of(context).pop();
                      final confirmed = await showDialog<bool>(
                        context: context,
                        builder: (dialogContext) {
                          return AlertDialog(
                            title: const Text('기록 삭제'),
                            content: const Text('진행 중 주기를 삭제할까요?'),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(dialogContext).pop(false),
                                child: const Text('취소'),
                              ),
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(dialogContext).pop(true),
                                child: const Text('삭제'),
                              ),
                            ],
                          );
                        },
                      );
                      if (confirmed != true) return;

                      final ok = await notifier.deleteCycle(ongoingCycle.id);
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              ok
                                  ? '삭제 완료'
                                  : (ref.read(cycleCalendarProvider).errorMessage ??
                                        '삭제 실패'),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
                // 선택된 날짜에 완료된 주기가 있을 때: 해당 주기 삭제
                if (!canRecoverOngoing && hasSelectedDayCycle) ...[
                  const Divider(height: AppSpacing.lg),
                  _ActionTile(
                    icon: Icons.delete_outline,
                    label: '해당 주기 삭제',
                    onTap: () async {
                      Navigator.of(context).pop();
                      final cycleStart = selectedDayCycle.startDate;
                      final confirmed = await showDialog<bool>(
                        context: context,
                        builder: (dialogContext) {
                          return AlertDialog(
                            title: const Text('주기 삭제'),
                            content: Text(
                              '${cycleStart.month}월 ${cycleStart.day}일 시작 주기를 삭제할까요?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(dialogContext).pop(false),
                                child: const Text('취소'),
                              ),
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(dialogContext).pop(true),
                                child: const Text('삭제'),
                              ),
                            ],
                          );
                        },
                      );
                      if (confirmed != true) return;

                      final ok = await notifier.deleteCycle(selectedDayCycle.id);
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              ok
                                  ? '삭제 완료'
                                  : (ref.read(cycleCalendarProvider).errorMessage ??
                                        '삭제 실패'),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showSymptomRecordBottomSheet(
    BuildContext context,
    WidgetRef ref,
    DateTime date,
  ) async {
    final notifier = ref.read(cycleCalendarProvider.notifier);
    final symptomTypes = await notifier.getSymptomTypes();
    if (!context.mounted) return;

    if (symptomTypes.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('증상 목록이 비어 있습니다.')));
      return;
    }

    SymptomTypeItem selected = symptomTypes.first;
    int intensity = 2;
    final memoController = TextEditingController();

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: AppSpacing.borderRadiusBottomSheet,
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.fromLTRB(
                AppSpacing.base,
                AppSpacing.base,
                AppSpacing.base,
                MediaQuery.of(context).viewInsets.bottom + AppSpacing.base,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('증상 기록', style: AppTypography.title3()),
                  const SizedBox(height: AppSpacing.sm),
                  DropdownButtonFormField<String>(
                    initialValue: selected.type,
                    decoration: const InputDecoration(labelText: '증상'),
                    items: symptomTypes
                        .map(
                          (e) => DropdownMenuItem(
                            value: e.type,
                            child: Text('${e.displayName} (${e.category})'),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value == null) return;
                      setModalState(() {
                        selected = symptomTypes.firstWhere(
                          (e) => e.type == value,
                        );
                      });
                    },
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text('강도: $intensity', style: AppTypography.body5Bold()),
                  Slider(
                    value: intensity.toDouble(),
                    min: 1,
                    max: 3,
                    divisions: 2,
                    onChanged: (value) {
                      setModalState(() {
                        intensity = value.round();
                      });
                    },
                  ),
                  TextField(
                    controller: memoController,
                    decoration: const InputDecoration(labelText: '메모 (선택)'),
                    maxLines: 2,
                  ),
                  const SizedBox(height: AppSpacing.base),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('취소'),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            final ok = await notifier.recordSymptomOn(
                              date: date,
                              symptomType: selected.type,
                              intensity: intensity,
                              memo: memoController.text,
                            );
                            if (context.mounted) {
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    ok
                                        ? '증상이 기록되었습니다.'
                                        : (ref
                                                  .read(cycleCalendarProvider)
                                                  .errorMessage ??
                                              '기록에 실패했습니다.'),
                                  ),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: AppColors.white,
                          ),
                          child: const Text('저장'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _showPredictedSymptomBottomSheet(
    BuildContext context,
    WidgetRef ref,
    PredictedSymptomSummary symptom,
    String phase,
  ) async {
    final notifier = ref.read(cycleCalendarProvider.notifier);

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: AppSpacing.borderRadiusBottomSheet,
      ),
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.78,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.base,
              AppSpacing.base,
              AppSpacing.base,
              AppSpacing.xl,
            ),
            child: FutureBuilder<PredictedSymptomHistoryResponse>(
              future: notifier.getPredictedSymptomHistory(
                symptomType: symptom.symptomType,
                phase: phase,
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return _BottomSheetError(
                    message: '예상 증상 상세를 불러오지 못했습니다.',
                    onClose: () => Navigator.of(context).pop(),
                  );
                }

                final history = snapshot.data;
                if (history == null) {
                  return _BottomSheetError(
                    message: '상세 데이터가 없습니다.',
                    onClose: () => Navigator.of(context).pop(),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 36,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: AppSpacing.base),
                      decoration: BoxDecoration(
                        color: AppColors.gray200,
                        borderRadius: AppSpacing.borderRadiusCircle,
                      ),
                    ),
                    Text(history.displayName, style: AppTypography.title2()),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      '발생 확률 ${history.currentProbability}%',
                      style: AppTypography.body4(
                        color: AppColors.textSecondaryLight,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.base),
                    Expanded(
                      child: history.history.isEmpty
                          ? Center(
                              child: Text(
                                '과거 기록이 없습니다.',
                                style: AppTypography.body4(),
                              ),
                            )
                          : ListView.separated(
                              itemCount: history.history.length,
                              separatorBuilder: (_, _) =>
                                  const Divider(height: 1),
                              itemBuilder: (context, index) {
                                final item = history.history[index];
                                final occurred = item.occurred;
                                final status = occurred == null
                                    ? '기록 없음'
                                    : (occurred ? '발생' : '없었음');
                                final icon = occurred == null
                                    ? Icons.remove_circle_outline
                                    : (occurred
                                          ? Icons.check_circle
                                          : Icons.cancel);
                                final iconColor = occurred == null
                                    ? AppColors.gray400
                                    : (occurred
                                          ? AppColors.success
                                          : AppColors.error);

                                return ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: Icon(icon, color: iconColor),
                                  title: Text(
                                    '${item.cycleNumber}주기 전 • $status',
                                    style: AppTypography.body5Bold(),
                                  ),
                                  subtitle: Text(
                                    _formatDate(item.cycleStartDate),
                                    style: AppTypography.body6(
                                      color: AppColors.textSecondaryLight,
                                    ),
                                  ),
                                  trailing: item.intensity == null
                                      ? null
                                      : Text(
                                          '강도 ${item.intensity}',
                                          style: AppTypography.body6(),
                                        ),
                                );
                              },
                            ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('날짜 메뉴에서 증상을 기록해주세요.'),
                                ),
                              );
                            },
                            child: const Text('기록하기'),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              final ok = await notifier.recordNonOccurrence(
                                symptom.symptomType,
                              );
                              if (context.mounted) {
                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      ok
                                          ? '기록되었습니다.'
                                          : (ref
                                                    .read(cycleCalendarProvider)
                                                    .errorMessage ??
                                                '기록에 실패했습니다.'),
                                    ),
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: AppColors.white,
                            ),
                            child: const Text('이번엔 없었어요'),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  static String _formatDate(DateTime date) {
    return '${date.year}.${date.month.toString().padLeft(2, '0')}.${date.day.toString().padLeft(2, '0')}';
  }
}

class _CurrentCycleCard extends StatelessWidget {
  final CycleCalendarState state;
  final Future<void> Function() onOpenTodayMenu;

  const _CurrentCycleCard({required this.state, required this.onOpenTodayMenu});

  @override
  Widget build(BuildContext context) {
    final cycle = state.currentCycle;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.base),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: AppSpacing.borderRadiusXl,
        boxShadow: AppShadows.softCard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('오늘 상태', style: AppTypography.body4Bold()),
          const SizedBox(height: AppSpacing.xs),
          Text(
            _friendlyStatusText(cycle),
            style: AppTypography.body5(color: AppColors.textSecondaryLight),
          ),
        ],
      ),
    );
  }

  static String _friendlyStatusText(CurrentCycleResponse? cycle) {
    if (cycle == null) {
      return '주기 데이터를 불러오는 중입니다.';
    }

    final phase = cycle.phase;
    final dayOfCycle = cycle.dayOfCycle;
    final dayOfPeriod = cycle.dayOfPeriod;

    if (phase == 'MENSTRUATION') {
      final dayText = dayOfPeriod == null ? '' : ' $dayOfPeriod일차';
      return '현재 생리 기간$dayText 입니다.';
    }
    if (phase == 'OVULATION') {
      return '현재 배란기입니다.';
    }
    if (phase == 'PMS') {
      return '현재 PMS 가능 기간입니다.';
    }
    if (phase == 'FOLLICULAR') {
      return '현재 난포기입니다.';
    }
    if (phase == 'LUTEAL') {
      return '현재 황체기입니다.';
    }

    if (dayOfCycle != null) {
      return '현재 주기 $dayOfCycle일차 입니다.';
    }
    return '현재 상태를 확인 중입니다.';
  }
}

class _MonthHeader extends StatelessWidget {
  final DateTime focusedMonth;
  final Future<void> Function() onPrev;
  final Future<void> Function() onNext;

  const _MonthHeader({
    required this.focusedMonth,
    required this.onPrev,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(onPressed: onPrev, icon: const Icon(Icons.chevron_left)),
        Expanded(
          child: Text(
            '${focusedMonth.year}년 ${focusedMonth.month}월',
            textAlign: TextAlign.center,
            style: AppTypography.body3Bold(),
          ),
        ),
        IconButton(onPressed: onNext, icon: const Icon(Icons.chevron_right)),
      ],
    );
  }
}

class _CalendarGrid extends StatelessWidget {
  final CycleCalendarState state;
  final Future<void> Function(DateTime date) onTapDate;

  const _CalendarGrid({required this.state, required this.onTapDate});

  @override
  Widget build(BuildContext context) {
    if (state.isLoadingMonth || state.monthly == null) {
      return const SizedBox(
        height: 320,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    final month = state.focusedMonth;
    final first = DateTime(month.year, month.month, 1);
    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    final leadingBlanks = first.weekday % 7;

    final daysByKey = <String, CalendarDayModel>{
      for (final day in state.monthly!.days) _dateKey(day.date): day,
    };

    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        borderRadius: AppSpacing.borderRadiusXl,
        color: AppColors.surfaceLight,
        boxShadow: AppShadows.softCard,
      ),
      child: Column(
        children: [
          Row(
            children: const ['일', '월', '화', '수', '목', '금', '토']
                .map(
                  (e) => Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: AppSpacing.xs),
                      child: Center(child: Text(e)),
                    ),
                  ),
                )
                .toList(),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 42,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 0.95,
            ),
            itemBuilder: (context, index) {
              final dayNumber = index - leadingBlanks + 1;
              if (dayNumber < 1 || dayNumber > daysInMonth) {
                return const SizedBox.shrink();
              }

              final date = DateTime(month.year, month.month, dayNumber);
              final dayModel = daysByKey[_dateKey(date)];
              final isSelected = _isSameDate(date, state.selectedDate);
              final dayColor = _dayColor(dayModel);

              return InkWell(
                borderRadius: AppSpacing.borderRadiusMd,
                onTap: () => onTapDate(date),
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.xxs),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary.withValues(alpha: 0.16)
                          : Colors.transparent,
                      borderRadius: AppSpacing.borderRadiusMd,
                      border: isSelected
                          ? Border.all(color: AppColors.primary, width: 1.2)
                          : null,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('$dayNumber', style: AppTypography.label2Bold()),
                        const SizedBox(height: 2),
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: dayColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  static String _dateKey(DateTime date) {
    final y = date.year.toString().padLeft(4, '0');
    final m = date.month.toString().padLeft(2, '0');
    final d = date.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }

  static bool _isSameDate(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  static Color _dayColor(CalendarDayModel? day) {
    if (day == null) {
      return AppColors.gray200;
    }
    if (day.isPeriod || day.isPredictedPeriod) {
      return AppColors.menstruation;
    }
    // Phase 기반 색상 결정
    final phase = day.phase;
    if (phase != null) {
      switch (phase) {
        case 'MENSTRUATION':
          return AppColors.menstruation;
        case 'FOLLICULAR':
          return AppColors.gray300; // 난포기는 색칠 안 함
        case 'OVULATION':
          return AppColors.fertile;
        case 'LUTEAL':
          return AppColors.gray300; // 황체기는 색칠 안 함
        case 'PMS':
          return AppColors.pms;
      }
    }
    // phase null이면 boolean 플래그 확인
    if (day.isOvulation || day.isFertile) {
      return AppColors.fertile;
    }
    if (day.isPms) {
      return AppColors.pms;
    }
    return AppColors.gray300;
  }
}

class _DayDetailCard extends StatelessWidget {
  final CycleCalendarState state;
  final void Function(PredictedSymptomSummary symptom) onTapPredictedSymptom;

  const _DayDetailCard({
    required this.state,
    required this.onTapPredictedSymptom,
  });

  @override
  Widget build(BuildContext context) {
    if (state.isLoadingDay || state.dayDetail == null) {
      return const SizedBox(
        height: 220,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    final detail = state.dayDetail!;
    final calendarDay = state.monthly?.days
        .where(
          (d) =>
              d.date.year == detail.date.year &&
              d.date.month == detail.date.month &&
              d.date.day == detail.date.day,
        )
        .cast<CalendarDayModel?>()
        .firstOrNull;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.base),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: AppSpacing.borderRadiusXl,
        boxShadow: AppShadows.softCard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${detail.date.year}년 ${detail.date.month}월 ${detail.date.day}일',
            style: AppTypography.body3Bold(),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            _friendlyDayDetail(detail, calendarDay),
            style: AppTypography.body5(color: AppColors.textSecondaryLight),
          ),
          const SizedBox(height: AppSpacing.base),
          Text(
            _isFutureDate(detail.date) ? '예상 증상' : '기록된 증상',
            style: AppTypography.body4Bold(),
          ),
          const SizedBox(height: AppSpacing.xs),
          if (_isFutureDate(detail.date) && detail.predictedSymptoms.isNotEmpty)
            ...detail.predictedSymptoms.map(
              (s) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                child: Text(
                  '• ${s.displayName} (${s.probability}%)',
                  style: AppTypography.body5(),
                ),
              ),
            )
          else if (detail.symptoms.isEmpty)
            Text(
              _isFutureDate(detail.date) ? '예상 증상이 없습니다.' : '기록된 증상이 없습니다.',
              style: AppTypography.body5(color: AppColors.textSecondaryLight),
            )
          else
            ...detail.symptoms.map(
              (s) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                child: Text(
                  '• ${s.symptomDisplayName} (강도 ${s.intensity})',
                  style: AppTypography.body5(),
                ),
              ),
            ),
        ],
      ),
    );
  }

  static String _friendlyDayDetail(
    DayDetailResponse detail,
    CalendarDayModel? calendarDay,
  ) {
    final day = detail.dayOfCycle;
    final dayOfPeriod = detail.dayOfPeriod;
    final configuredPeriodLength = detail.cycle?.periodLength;
    final isFuture = _isFutureDate(detail.date);
    final calendarPhase = _phaseFromCalendarDay(calendarDay);
    final displayPhase = calendarDay != null
        ? calendarPhase
        : _predictedPhaseFromBackend(detail);

    if (isFuture) {
      if (displayPhase.isNotEmpty) {
        return '예상 단계: $displayPhase';
      }
    }

    final isDisplayedMenstruation = displayPhase == _phaseLabel('MENSTRUATION');
    if (isDisplayedMenstruation &&
        configuredPeriodLength != null &&
        dayOfPeriod != null &&
        dayOfPeriod > configuredPeriodLength) {
      final inferred = _predictedPhaseWithCalendarPriority(detail, calendarDay);
      return '종료 기록이 없어 생리 상태로 표시 중입니다. 예상 단계: $inferred';
    }

    final phaseLabel = displayPhase;

    if (phaseLabel.isEmpty) {
      return '상태 정보가 없습니다.';
    }
    if (day == null || calendarPhase.isNotEmpty) {
      return phaseLabel;
    }
    return '$phaseLabel • 주기 $day일차';
  }

  static String _predictedPhaseFromBackend(DayDetailResponse detail) {
    final backendPhase = _phaseLabel(detail.phase);
    if (backendPhase.isNotEmpty) return backendPhase;
    if (detail.isPms) return _phaseLabel('PMS');
    if (detail.isOvulation || detail.isFertile) return _phaseLabel('OVULATION');
    if (detail.isPredictedPeriod) return _phaseLabel('MENSTRUATION');
    return '';
  }

  static String _predictedPhaseWithCalendarPriority(
    DayDetailResponse detail,
    CalendarDayModel? calendarDay,
  ) {
    final calendarPhase = _phaseFromCalendarDay(calendarDay);
    if (calendarPhase.isNotEmpty) return calendarPhase;
    return _predictedPhaseFromBackend(detail);
  }

  static String _phaseFromCalendarDay(CalendarDayModel? day) {
    if (day == null) return '';
    if (day.phase != null && day.phase!.isNotEmpty) {
      return _phaseLabel(day.phase!);
    }
    if (day.isPredictedPeriod || day.isPeriod) {
      return _phaseLabel('MENSTRUATION');
    }
    if (day.isPms) return _phaseLabel('PMS');
    if (day.isOvulation || day.isFertile) return _phaseLabel('OVULATION');
    return '';
  }

  static String _phaseLabel(String phase) {
    switch (phase) {
      case 'MENSTRUATION':
        return '생리 기간';
      case 'OVULATION':
        return '배란기';
      case 'PMS':
        return 'PMS 가능 기간';
      case 'FOLLICULAR':
        return '난포기';
      case 'LUTEAL':
        return '황체기';
      default:
        return '';
    }
  }

  static bool _isFutureDate(DateTime date) {
    final today = DateTime.now();
    final normalizedToday = DateTime(today.year, today.month, today.day);
    final normalizedDate = DateTime(date.year, date.month, date.day);
    return normalizedDate.isAfter(normalizedToday);
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: AppColors.primary),
      title: Text(label, style: AppTypography.body4Bold()),
      onTap: onTap,
    );
  }
}

class _BottomSheetError extends StatelessWidget {
  final String message;
  final VoidCallback onClose;

  const _BottomSheetError({required this.message, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(message, style: AppTypography.body4()),
        const SizedBox(height: AppSpacing.base),
        ElevatedButton(onPressed: onClose, child: const Text('닫기')),
      ],
    );
  }
}
