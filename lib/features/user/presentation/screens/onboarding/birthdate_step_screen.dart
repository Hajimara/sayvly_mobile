import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/theme/theme.dart';
import '../../providers/onboarding_provider.dart';
import '../../widgets/picker_bottom_sheet.dart';

/// 온보딩 Step 2: 생년월일 입력
class BirthdateStepScreen extends ConsumerStatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const BirthdateStepScreen({
    super.key,
    required this.onNext,
    required this.onBack,
  });

  @override
  ConsumerState<BirthdateStepScreen> createState() =>
      _BirthdateStepScreenState();
}

class _BirthdateStepScreenState extends ConsumerState<BirthdateStepScreen> {
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    final data = ref.read(onboardingDataProvider);
    _selectedDate = data?.birthDate;
  }

  Future<void> _selectDate() async {
    final now = DateTime.now();
    final initialDate = _selectedDate ?? DateTime(now.year - 25, 1, 1);
    final firstDate = DateTime(1900);
    final lastDate = now;

    final picked = await showBirthDatePickerBottomSheet(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
      ref.read(onboardingProvider.notifier).selectBirthDate(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: AppSpacing.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSpacing.xxl),

          // 타이틀
          Text(
            '생년월일을 알려주세요',
            style: AppTypography.title1(
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
            ),
          ),

          const SizedBox(height: AppSpacing.sm),

          // 설명
          Text(
            '나이에 맞는 건강 정보를 제공해드릴게요\n(선택 사항)',
            style: AppTypography.body3(
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
            ),
          ),

          const SizedBox(height: AppSpacing.xxl),

          // 날짜 선택 버튼
          GestureDetector(
            onTap: _selectDate,
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
                  color: _selectedDate != null
                      ? AppColors.primary
                      : (isDark ? AppColors.borderDark : AppColors.borderLight),
                  width: _selectedDate != null ? 2 : 1,
                ),
                boxShadow: _selectedDate != null ? AppShadows.softCard : null,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    color: _selectedDate != null
                        ? AppColors.primary
                        : (isDark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondaryLight),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Text(
                    _selectedDate != null
                        ? _formatDate(_selectedDate!)
                        : '생년월일 선택',
                    style: AppTypography.body2(
                      color: _selectedDate != null
                          ? (isDark
                              ? AppColors.textPrimaryDark
                              : AppColors.textPrimaryLight)
                          : (isDark
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondaryLight),
                    ),
                  ),
                  const Spacer(),
                  if (_selectedDate != null)
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _selectedDate = null;
                        });
                        ref
                            .read(onboardingProvider.notifier)
                            .selectBirthDate(null);
                      },
                      icon: Icon(
                        Icons.close,
                        color: isDark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondaryLight,
                        size: AppSpacing.iconSm,
                      ),
                    ),
                ],
              ),
            ),
          ),

          const Spacer(),

          // 다음 버튼
          SizedBox(
            width: double.infinity,
            height: AppSpacing.buttonHeightLg,
            child: ElevatedButton(
              onPressed: widget.onNext,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: AppSpacing.borderRadiusLg,
                ),
                elevation: 0,
              ),
              child: Text(
                '다음',
                style: AppTypography.body2Bold(color: AppColors.white),
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
