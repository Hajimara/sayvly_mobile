import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/theme/theme.dart';
import '../../providers/account_provider.dart';

/// 계정 탈퇴 화면
class WithdrawScreen extends ConsumerStatefulWidget {
  const WithdrawScreen({super.key});

  @override
  ConsumerState<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends ConsumerState<WithdrawScreen> {
  String? _selectedReason;
  final _feedbackController = TextEditingController();
  bool _isConfirmed = false;

  final List<String> _reasons = [
    '더 이상 사용하지 않음',
    '다른 앱을 사용함',
    '개인정보가 걱정됨',
    '기능이 부족함',
    '기타',
  ];

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  Future<void> _requestWithdraw() async {
    final confirmed = await _showFinalConfirmDialog();
    if (confirmed != true) return;

    final success = await ref.read(withdrawProvider.notifier).requestWithdraw(
          reason: _selectedReason,
          feedback: _feedbackController.text.isNotEmpty
              ? _feedbackController.text
              : null,
        );

    if (success && mounted) {
      _showWithdrawCompleteDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final state = ref.watch(withdrawProvider);

    final isLoading = state.isLoading;

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(
          '계정 탈퇴',
          style: AppTypography.title3(
            color: isDark
                ? AppColors.textPrimaryDark
                : AppColors.textPrimaryLight,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: AppSpacing.pagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 경고 아이콘
            Center(
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.error.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.warning_amber_rounded,
                  size: 48,
                  color: AppColors.error,
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.lg),

            // 안내 텍스트
            Text(
              '정말 탈퇴하시겠습니까?',
              style: AppTypography.title2(
                color: isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: AppSpacing.base),

            // 탈퇴 시 삭제되는 정보
            Container(
              width: double.infinity,
              padding: AppSpacing.cardInsets,
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                borderRadius: AppSpacing.borderRadiusXl,
                border: Border.all(
                  color: AppColors.error.withValues(alpha: 0.3),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '탈퇴 시 삭제되는 정보',
                    style: AppTypography.body3Bold(
                      color: AppColors.error,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  _buildDeleteInfo('프로필 정보 (닉네임, 생년월일 등)'),
                  _buildDeleteInfo('모든 주기 기록 및 증상 데이터'),
                  _buildDeleteInfo('파트너 연결 정보'),
                  _buildDeleteInfo('구독 정보 (환불 불가)'),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.base),

            // 유예 기간 안내
            Container(
              width: double.infinity,
              padding: AppSpacing.cardInsets,
              decoration: BoxDecoration(
                color: AppColors.info.withValues(alpha: 0.1),
                borderRadius: AppSpacing.borderRadiusXl,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.info_outline,
                    color: AppColors.info,
                    size: AppSpacing.iconBase,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      '탈퇴 요청 후 7일간 유예 기간이 있습니다.\n기간 내 로그인하면 탈퇴를 취소할 수 있습니다.',
                      style: AppTypography.body5(color: AppColors.info),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.xxl),

            // 탈퇴 사유 선택
            Text(
              '탈퇴 사유 (선택)',
              style: AppTypography.body3Bold(
                color: isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),

            ..._reasons.map((reason) => _buildReasonTile(reason, isDark)),

            const SizedBox(height: AppSpacing.lg),

            // 추가 의견
            Text(
              '추가 의견 (선택)',
              style: AppTypography.body3Bold(
                color: isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            TextField(
              controller: _feedbackController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: '서비스 개선에 도움이 됩니다.',
                hintStyle: AppTypography.body4(
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
                ),
                filled: true,
                fillColor:
                    isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                border: OutlineInputBorder(
                  borderRadius: AppSpacing.borderRadiusMd,
                  borderSide: BorderSide(
                    color: isDark ? AppColors.borderDark : AppColors.borderLight,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: AppSpacing.borderRadiusMd,
                  borderSide: BorderSide(
                    color: isDark ? AppColors.borderDark : AppColors.borderLight,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: AppSpacing.borderRadiusMd,
                  borderSide: const BorderSide(
                    color: AppColors.primary,
                    width: 2,
                  ),
                ),
              ),
              style: AppTypography.body4(
                color: isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
              ),
            ),

            const SizedBox(height: AppSpacing.xxl),

            // 확인 체크박스
            GestureDetector(
              onTap: () {
                setState(() {
                  _isConfirmed = !_isConfirmed;
                });
              },
              child: Row(
                children: [
                  Checkbox(
                    value: _isConfirmed,
                    onChanged: (value) {
                      setState(() {
                        _isConfirmed = value ?? false;
                      });
                    },
                    activeColor: AppColors.error,
                  ),
                  Expanded(
                    child: Text(
                      '위 내용을 확인했으며, 탈퇴에 동의합니다.',
                      style: AppTypography.body5(
                        color: isDark
                            ? AppColors.textPrimaryDark
                            : AppColors.textPrimaryLight,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.lg),

            // 탈퇴 버튼
            SizedBox(
              width: double.infinity,
              height: AppSpacing.buttonHeightLg,
              child: ElevatedButton(
                onPressed: (_isConfirmed && !isLoading) ? _requestWithdraw : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.error,
                  foregroundColor: AppColors.white,
                  disabledBackgroundColor: AppColors.gray200,
                  disabledForegroundColor: AppColors.gray500,
                  shape: RoundedRectangleBorder(
                    borderRadius: AppSpacing.borderRadiusLg,
                  ),
                  elevation: 0,
                ),
                child: isLoading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.white,
                        ),
                      )
                    : Text(
                        '탈퇴하기',
                        style: AppTypography.body2Bold(color: AppColors.white),
                      ),
              ),
            ),

            const SizedBox(height: AppSpacing.base),
          ],
        ),
      ),
    );
  }

  Widget _buildDeleteInfo(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.remove,
            size: AppSpacing.iconSm,
            color: AppColors.error,
          ),
          const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: Text(
              text,
              style: AppTypography.body5(
                color: AppColors.error.withValues(alpha: 0.8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReasonTile(String reason, bool isDark) {
    final isSelected = _selectedReason == reason;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedReason = isSelected ? null : reason;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.sm),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.base,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.1)
              : (isDark ? AppColors.surfaceDark : AppColors.surfaceLight),
          borderRadius: AppSpacing.borderRadiusMd,
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : (isDark ? AppColors.borderDark : AppColors.borderLight),
          ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: isSelected
                  ? AppColors.primary
                  : (isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight),
              size: AppSpacing.iconMd,
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(
              reason,
              style: AppTypography.body4(
                color: isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool?> _showFinalConfirmDialog() {
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
          '최종 확인',
          style: AppTypography.title3(
            color: isDark
                ? AppColors.textPrimaryDark
                : AppColors.textPrimaryLight,
          ),
        ),
        content: Text(
          '정말로 계정을 탈퇴하시겠습니까?\n7일 후 모든 데이터가 삭제됩니다.',
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
              '탈퇴하기',
              style: AppTypography.body4Bold(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }

  void _showWithdrawCompleteDialog() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor:
            isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacing.borderRadiusXl,
        ),
        title: Text(
          '탈퇴 요청 완료',
          style: AppTypography.title3(
            color: isDark
                ? AppColors.textPrimaryDark
                : AppColors.textPrimaryLight,
          ),
        ),
        content: Text(
          '7일 후 계정이 삭제됩니다.\n기간 내 로그인하면 탈퇴를 취소할 수 있습니다.',
          style: AppTypography.body4(
            color: isDark
                ? AppColors.textSecondaryDark
                : AppColors.textSecondaryLight,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.go('/login');
            },
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }
}
