import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/theme/theme.dart';
import '../../providers/onboarding_provider.dart';

/// 온보딩 Step 3: 주기 설정 (모든 성별)
class CycleSetupScreen extends ConsumerStatefulWidget {
  final VoidCallback onComplete;
  final VoidCallback onBack;

  const CycleSetupScreen({
    super.key,
    required this.onComplete,
    required this.onBack,
  });

  @override
  ConsumerState<CycleSetupScreen> createState() => _CycleSetupScreenState();
}

class _CycleSetupScreenState extends ConsumerState<CycleSetupScreen> {
  DateTime? _lastPeriodDate;
  int _cycleLength = 28;
  int _periodLength = 5;

  @override
  void initState() {
    super.initState();
    final data = ref.read(onboardingDataProvider);
    if (data != null) {
      _lastPeriodDate = data.lastPeriodStartDate;
      _cycleLength = data.cycleLength;
      _periodLength = data.periodLength;
    }
  }

  Future<void> _selectLastPeriodDate() async {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final data = ref.read(onboardingDataProvider);

    final now = DateTime.now();
    final initialDate = _lastPeriodDate ?? now.subtract(const Duration(days: 14));
    final firstDate = now.subtract(const Duration(days: 90));
    final lastDate = now;

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      helpText: data?.isFemale ?? false
          ? '마지막 생리 시작일을 선택하세요'
          : '반려자의 마지막 생리 시작일을 선택하세요',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: AppColors.white,
              surface: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
              onSurface: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
            ),
            dialogTheme: DialogThemeData(
              backgroundColor:
                  isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _lastPeriodDate = picked;
      });
      ref.read(onboardingProvider.notifier).setLastPeriodStartDate(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final data = ref.watch(onboardingDataProvider);
    final isFemale = data?.isFemale ?? false;

    // 성별에 따라 다른 텍스트 표시
    final title = isFemale
        ? '주기 정보를 알려주세요'
        : '반려자의 주기 정보를 알려주세요';
    final description = isFemale
        ? '정확한 예측을 위해 필요해요'
        : '반려자의 생리 주기를 등록해주세요';

    return SingleChildScrollView(
      padding: AppSpacing.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSpacing.xxl),

          // 타이틀
          Text(
            title,
            style: AppTypography.title1(
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
            ),
          ),

          const SizedBox(height: AppSpacing.sm),

          // 설명
          Text(
            description,
            style: AppTypography.body3(
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
            ),
          ),

          const SizedBox(height: AppSpacing.xxl),

          // 마지막 생리 시작일
          _SectionTitle(
            title: '마지막 생리 시작일',
            isRequired: true,
          ),
          const SizedBox(height: AppSpacing.sm),
          GestureDetector(
            onTap: _selectLastPeriodDate,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.base,
                vertical: AppSpacing.lg,
              ),
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                borderRadius: AppSpacing.borderRadiusXl,
                border: Border.all(
                  color: _lastPeriodDate != null
                      ? AppColors.primary
                      : (isDark ? AppColors.borderDark : AppColors.borderLight),
                  width: _lastPeriodDate != null ? 2 : 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    color: _lastPeriodDate != null
                        ? AppColors.primary
                        : (isDark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondaryLight),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Text(
                    _lastPeriodDate != null
                        ? _formatDate(_lastPeriodDate!)
                        : '날짜를 선택해주세요',
                    style: AppTypography.body2(
                      color: _lastPeriodDate != null
                          ? (isDark
                              ? AppColors.textPrimaryDark
                              : AppColors.textPrimaryLight)
                          : (isDark
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondaryLight),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: AppSpacing.xl),

          // 평균 주기 길이
          _SectionTitle(title: '평균 주기 길이'),
          const SizedBox(height: AppSpacing.sm),
          _SliderSection(
            value: _cycleLength,
            min: 21,
            max: 45,
            unit: '일',
            onChanged: (value) {
              setState(() {
                _cycleLength = value;
              });
              ref.read(onboardingProvider.notifier).setCycleLength(value);
            },
          ),

          const SizedBox(height: AppSpacing.xl),

          // 평균 생리 기간
          _SectionTitle(title: '평균 생리 기간'),
          const SizedBox(height: AppSpacing.sm),
          _SliderSection(
            value: _periodLength,
            min: 2,
            max: 10,
            unit: '일',
            onChanged: (value) {
              setState(() {
                _periodLength = value;
              });
              ref.read(onboardingProvider.notifier).setPeriodLength(value);
            },
          ),

          const SizedBox(height: AppSpacing.xxl),

          // 완료 버튼
          SizedBox(
            width: double.infinity,
            height: AppSpacing.buttonHeightLg,
            child: ElevatedButton(
              onPressed: _lastPeriodDate != null ? widget.onComplete : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                disabledBackgroundColor: AppColors.gray200,
                disabledForegroundColor: AppColors.gray500,
                shape: RoundedRectangleBorder(
                  borderRadius: AppSpacing.borderRadiusLg,
                ),
                elevation: 0,
              ),
              child: Text(
                '시작하기',
                style: AppTypography.body2Bold(
                  color: _lastPeriodDate != null
                      ? AppColors.white
                      : AppColors.gray500,
                ),
              ),
            ),
          ),

          const SizedBox(height: AppSpacing.base),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}년 ${date.month}월 ${date.day}일';
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final bool isRequired;

  const _SectionTitle({
    required this.title,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      children: [
        Text(
          title,
          style: AppTypography.body3Bold(
            color: isDark
                ? AppColors.textPrimaryDark
                : AppColors.textPrimaryLight,
          ),
        ),
        if (isRequired) ...[
          const SizedBox(width: AppSpacing.xxs),
          Text(
            '*',
            style: AppTypography.body3Bold(color: AppColors.error),
          ),
        ],
      ],
    );
  }
}

class _SliderSection extends StatelessWidget {
  final int value;
  final int min;
  final int max;
  final String unit;
  final ValueChanged<int> onChanged;

  const _SliderSection({
    required this.value,
    required this.min,
    required this.max,
    required this.unit,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.base),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        borderRadius: AppSpacing.borderRadiusXl,
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
        ),
      ),
      child: Column(
        children: [
          // 현재 값 표시
          Text(
            '$value$unit',
            style: AppTypography.title2(color: AppColors.primary),
          ),
          const SizedBox(height: AppSpacing.sm),

          // 슬라이더
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: AppColors.primary,
              inactiveTrackColor: AppColors.gray200,
              thumbColor: AppColors.primary,
              overlayColor: AppColors.primary.withValues(alpha: 0.2),
              trackHeight: 4,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
            ),
            child: Slider(
              value: value.toDouble(),
              min: min.toDouble(),
              max: max.toDouble(),
              divisions: max - min,
              onChanged: (newValue) => onChanged(newValue.round()),
            ),
          ),

          // 범위 표시
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$min$unit',
                style: AppTypography.caption(
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
                ),
              ),
              Text(
                '$max$unit',
                style: AppTypography.caption(
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
