import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/theme.dart';
import '../../../common/widgets/bottom_navigation_bar.dart';
import '../../data/models/couple_models.dart';
import '../providers/couple_provider.dart';

class PartnerScreen extends ConsumerWidget {
  const PartnerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(coupleProvider);
    final notifier = ref.read(coupleProvider.notifier);
    final currentPath = GoRouter.of(
      context,
    ).routerDelegate.currentConfiguration.uri.path;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '파트너',
          style: AppTypography.title3(color: AppColors.textPrimaryLight),
        ),
        actions: [
          IconButton(
            onPressed: state.isLoading ? null : notifier.initialize,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: AppSpacing.pageHorizontalPadding,
              children: [
                if (state.errorMessage != null) ...[
                  _ErrorCard(message: state.errorMessage!),
                  const SizedBox(height: AppSpacing.base),
                ],
                if (state.couple == null)
                  _DisconnectedView(state: state, notifier: notifier)
                else
                  _ConnectedView(state: state, notifier: notifier),
              ],
            ),
      bottomNavigationBar: SayvlyBottomNavigationBar(currentPath: currentPath),
    );
  }
}

class _DisconnectedView extends StatefulWidget {
  final CoupleState state;
  final CoupleNotifier notifier;

  const _DisconnectedView({required this.state, required this.notifier});

  @override
  State<_DisconnectedView> createState() => _DisconnectedViewState();
}

class _DisconnectedViewState extends State<_DisconnectedView> {
  late final TextEditingController _codeController;

  @override
  void initState() {
    super.initState();
    _codeController = TextEditingController();
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.state;
    final notifier = widget.notifier;
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
          Text('연결된 파트너가 없어요.', style: AppTypography.body3Bold()),
          const SizedBox(height: AppSpacing.sm),
          if (state.inviteCode != null)
            Text(
              '내 초대 코드: ${state.inviteCode}',
              style: AppTypography.body4Bold(),
            ),
          const SizedBox(height: AppSpacing.sm),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: state.isSubmitting
                  ? null
                  : () async {
                      await notifier.createInviteCode();
                    },
              child: const Text('초대 코드 만들기'),
            ),
          ),
          const SizedBox(height: AppSpacing.base),
          TextField(
            controller: _codeController,
            decoration: const InputDecoration(
              labelText: '초대 코드 입력',
              hintText: '예: ABC123',
            ),
            textCapitalization: TextCapitalization.characters,
          ),
          const SizedBox(height: AppSpacing.sm),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: state.isSubmitting
                  ? null
                  : () async {
                      final code = _codeController.text.trim();
                      if (code.isEmpty) return;
                      await notifier.connectByCode(code);
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
              ),
              child: const Text('연결하기'),
            ),
          ),
        ],
      ),
    );
  }
}

class _ConnectedView extends StatelessWidget {
  final CoupleState state;
  final CoupleNotifier notifier;

  const _ConnectedView({required this.state, required this.notifier});

  @override
  Widget build(BuildContext context) {
    final couple = state.couple!;
    final partner = state.partnerStatus;
    final settings = state.shareSettings;
    final calendar = state.partnerCalendar;
    final upcoming = state.upcomingEvents;
    final month = state.calendarMonth ?? DateTime.now();

    return Column(
      children: [
        _Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('연결된 파트너', style: AppTypography.body4Bold()),
              const SizedBox(height: AppSpacing.xs),
              Text(couple.partner.nickname, style: AppTypography.title3()),
              const SizedBox(height: AppSpacing.xs),
              if (partner != null) ...[
                if (partner.isOnPeriod == true)
                  Text(
                    partner.dayOfPeriod == null
                        ? '현재 생리 중'
                        : '현재 생리 ${partner.dayOfPeriod}일차',
                    style: AppTypography.body5Bold(color: AppColors.menstruation),
                  ),
                if (partner.isPms == true)
                  Text(
                    '현재 PMS 기간',
                    style: AppTypography.body5Bold(color: AppColors.pms),
                  ),
                if (partner.nextPeriodDate != null)
                  Text(
                    '다음 예상 생리: '
                    '${partner.nextPeriodDate!.month}/${partner.nextPeriodDate!.day} '
                    '(D-${partner.daysUntil ?? '-'})',
                    style: AppTypography.body6(
                      color: AppColors.textSecondaryLight,
                    ),
                  ),
              ],
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.base),
        _UpcomingEventsCard(upcoming: upcoming),
        const SizedBox(height: AppSpacing.base),
        _Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _CalendarHeader(
                month: month,
                isLoading: state.isSubmitting,
                onPrevious: () =>
                    notifier.loadPartnerCalendar(DateTime(month.year, month.month - 1)),
                onNext: () =>
                    notifier.loadPartnerCalendar(DateTime(month.year, month.month + 1)),
              ),
              if (state.isSubmitting) const LinearProgressIndicator(),
              const SizedBox(height: AppSpacing.sm),
              if (calendar == null)
                Text('달력 정보를 불러올 수 없어요.', style: AppTypography.body6())
              else
                _CalendarGrid(days: calendar.days),
              const SizedBox(height: AppSpacing.sm),
              const _LegendRow(),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.base),
        if (settings != null)
          _Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('공유 설정', style: AppTypography.body4Bold()),
                const SizedBox(height: AppSpacing.xs),
                _ShareSwitch(
                  label: '예상 생리',
                  value: settings.sharePeriodExpected,
                  onChanged: (v) =>
                      notifier.toggleShareSetting(key: 'periodExpected', value: v),
                ),
                _ShareSwitch(
                  label: '현재 생리',
                  value: settings.sharePeriodCurrent,
                  onChanged: (v) =>
                      notifier.toggleShareSetting(key: 'periodCurrent', value: v),
                ),
                _ShareSwitch(
                  label: 'PMS',
                  value: settings.sharePms,
                  onChanged: (v) => notifier.toggleShareSetting(key: 'pms', value: v),
                ),
                _ShareSwitch(
                  label: '가임기',
                  value: settings.shareFertile,
                  onChanged: (v) =>
                      notifier.toggleShareSetting(key: 'fertile', value: v),
                ),
                _ShareSwitch(
                  label: '기념일',
                  value: settings.shareAnniversary,
                  onChanged: (v) =>
                      notifier.toggleShareSetting(key: 'anniversary', value: v),
                ),
              ],
            ),
          ),
        const SizedBox(height: AppSpacing.base),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: state.isSubmitting
                ? null
                : () async {
                    final ok = await showDialog<bool>(
                      context: context,
                      builder: (dialogContext) => AlertDialog(
                        title: const Text('파트너 연결 해제'),
                        content: const Text('정말 연결을 해제할까요?'),
                        actions: [
                          TextButton(
                            onPressed: () =>
                                Navigator.of(dialogContext).pop(false),
                            child: const Text('취소'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(dialogContext).pop(true),
                            child: const Text('해제'),
                          ),
                        ],
                      ),
                    );
                    if (ok == true) {
                      await notifier.disconnect();
                    }
                  },
            child: const Text('파트너 연결 해제'),
          ),
        ),
      ],
    );
  }
}

class _CalendarHeader extends StatelessWidget {
  final DateTime month;
  final bool isLoading;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const _CalendarHeader({
    required this.month,
    required this.isLoading,
    required this.onPrevious,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('${month.year}.${month.month}', style: AppTypography.body4Bold()),
        const Spacer(),
        IconButton(
          onPressed: isLoading ? null : onPrevious,
          icon: const Icon(Icons.chevron_left),
        ),
        IconButton(
          onPressed: isLoading ? null : onNext,
          icon: const Icon(Icons.chevron_right),
        ),
      ],
    );
  }
}

class _CalendarGrid extends StatelessWidget {
  final List<PartnerCalendarDayModel> days;

  const _CalendarGrid({required this.days});

  static const _weekdays = ['일', '월', '화', '수', '목', '금', '토'];

  @override
  Widget build(BuildContext context) {
    if (days.isEmpty) {
      return Text('이 달의 달력 데이터가 없어요.', style: AppTypography.body6());
    }

    final sortedDays = [...days]..sort((a, b) => a.date.compareTo(b.date));
    final offset = sortedDays.first.date.weekday % 7;
    final slots = <_CalendarSlot>[
      ...List.generate(offset, (_) => const _CalendarSlot.empty()),
      ...sortedDays.map((day) => _CalendarSlot.day(day)),
    ];
    final remainder = slots.length % 7;
    if (remainder != 0) {
      slots.addAll(List.generate(7 - remainder, (_) => const _CalendarSlot.empty()));
    }

    return Column(
      children: [
        Row(
          children: _weekdays
              .map(
                (weekday) => Expanded(
                  child: Center(
                    child: Text(
                      weekday,
                      style: AppTypography.body6(color: AppColors.textSecondaryLight),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: AppSpacing.xs),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            mainAxisSpacing: 6,
            crossAxisSpacing: 6,
            childAspectRatio: 0.95,
          ),
          itemCount: slots.length,
          itemBuilder: (_, index) {
            final slot = slots[index];
            if (slot.day == null) {
              return const SizedBox.shrink();
            }
            return _CalendarDayCell(day: slot.day!);
          },
        ),
      ],
    );
  }
}

class _CalendarSlot {
  final PartnerCalendarDayModel? day;

  const _CalendarSlot._(this.day);

  const _CalendarSlot.empty() : day = null;

  factory _CalendarSlot.day(PartnerCalendarDayModel day) {
    return _CalendarSlot._(day);
  }
}

class _CalendarDayCell extends StatelessWidget {
  final PartnerCalendarDayModel day;

  const _CalendarDayCell({required this.day});

  @override
  Widget build(BuildContext context) {
    Color bg = AppColors.surfaceLight;
    Color border = AppColors.borderLight;
    Color text = AppColors.textPrimaryLight;

    if (day.isPeriod == true) {
      bg = AppColors.menstruation.withValues(alpha: 0.25);
      border = AppColors.menstruation.withValues(alpha: 0.45);
    } else if (day.isPredictedPeriod == true) {
      bg = AppColors.menstruation.withValues(alpha: 0.10);
      border = AppColors.menstruation.withValues(alpha: 0.5);
    } else if (day.isPms == true) {
      bg = AppColors.pms.withValues(alpha: 0.20);
      border = AppColors.pms.withValues(alpha: 0.4);
    } else if (day.isFertile == true) {
      bg = AppColors.fertile.withValues(alpha: 0.20);
      border = AppColors.fertile.withValues(alpha: 0.4);
    }

    if (day.hasAnniversary) {
      text = AppColors.primary;
    }

    return Container(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: AppSpacing.borderRadiusMd,
        border: Border.all(color: border),
      ),
      child: Stack(
        children: [
          Center(
            child: Text(
              '${day.date.day}',
              style: AppTypography.body6(color: text),
            ),
          ),
          if (day.hasAnniversary)
            Positioned(
              right: 4,
              top: 4,
              child: Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _UpcomingEventsCard extends StatelessWidget {
  final UpcomingEventsModel? upcoming;

  const _UpcomingEventsCard({required this.upcoming});

  @override
  Widget build(BuildContext context) {
    if (upcoming == null) {
      return _Card(
        child: Text('다가오는 일정 정보를 불러올 수 없어요.', style: AppTypography.body6()),
      );
    }

    final anniversaries = upcoming!.upcomingAnniversaries;
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('다가오는 일정', style: AppTypography.body4Bold()),
          const SizedBox(height: AppSpacing.xs),
          if (upcoming!.nextPeriod != null)
            Text(
              '다음 예상 생리: ${upcoming!.nextPeriod!.expectedDate.month}/${upcoming!.nextPeriod!.expectedDate.day}'
              ' (D-${upcoming!.nextPeriod!.daysUntil})',
              style: AppTypography.body6(),
            ),
          if (anniversaries.isEmpty)
            Text('30일 이내 기념일이 없어요.', style: AppTypography.body6()),
          for (final ann in anniversaries)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                '${ann.name}: ${ann.date.month}/${ann.date.day} (D-${ann.daysUntil})',
                style: AppTypography.body6(
                  color: AppColors.textSecondaryLight,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _LegendRow extends StatelessWidget {
  const _LegendRow();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 6,
      children: const [
        _LegendItem(label: '생리', color: AppColors.menstruation),
        _LegendItem(
          label: '예상 생리',
          color: AppColors.menstruation,
          isSoft: true,
        ),
        _LegendItem(label: 'PMS', color: AppColors.pms),
        _LegendItem(label: '가임기', color: AppColors.fertile),
        _LegendItem(label: '기념일', color: AppColors.primary),
      ],
    );
  }
}

class _LegendItem extends StatelessWidget {
  final String label;
  final Color color;
  final bool isSoft;

  const _LegendItem({
    required this.label,
    required this.color,
    this.isSoft = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color.withValues(alpha: isSoft ? 0.2 : 0.4),
            border: isSoft ? Border.all(color: color.withValues(alpha: 0.7)) : null,
            borderRadius: BorderRadius.circular(999),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: AppTypography.body6(color: AppColors.textSecondaryLight),
        ),
      ],
    );
  }
}

class _ShareSwitch extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _ShareSwitch({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(label, style: AppTypography.body5()),
      value: value,
      onChanged: onChanged,
    );
  }
}

class _ErrorCard extends StatelessWidget {
  final String message;
  const _ErrorCard({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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

class _Card extends StatelessWidget {
  final Widget child;

  const _Card({required this.child});

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
      child: child,
    );
  }
}
