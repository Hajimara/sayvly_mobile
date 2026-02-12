import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';
import '../../domain/validators/nickname_validator.dart';

/// 닉네임 입력 필드
/// 실시간 유효성 검사 및 쿨다운 표시 지원
class NicknameTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? initialValue;
  final DateTime? lastChangedAt;
  final bool enabled;
  final ValueChanged<String>? onChanged;
  final String? externalError;

  const NicknameTextField({
    super.key,
    this.controller,
    this.initialValue,
    this.lastChangedAt,
    this.enabled = true,
    this.onChanged,
    this.externalError,
  });

  @override
  State<NicknameTextField> createState() => _NicknameTextFieldState();
}

class _NicknameTextFieldState extends State<NicknameTextField> {
  late TextEditingController _controller;
  String? _validationError;
  bool _hasInteracted = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ??
        TextEditingController(text: widget.initialValue ?? '');
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _onTextChanged() {
    if (_hasInteracted) {
      _validate();
    }
    widget.onChanged?.call(_controller.text);
  }

  void _validate() {
    final result = NicknameValidator.validate(_controller.text);
    setState(() {
      _validationError = result.isValid ? null : result.errorMessage;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final canChange = NicknameValidator.canChangeNickname(widget.lastChangedAt);
    final cooldownMessage =
        NicknameValidator.getCooldownMessage(widget.lastChangedAt);

    final displayError = widget.externalError ?? _validationError;
    final isEnabled = widget.enabled && canChange;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // 라벨
        Row(
          children: [
            Text(
              '닉네임',
              style: AppTypography.label1(
                color: isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            Text(
              '(${NicknameValidator.minLength}-${NicknameValidator.maxLength}자)',
              style: AppTypography.caption(
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondaryLight,
              ),
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.sm),

        // 입력 필드
        TextField(
          controller: _controller,
          enabled: isEnabled,
          maxLength: NicknameValidator.maxLength,
          onTap: () {
            setState(() {
              _hasInteracted = true;
            });
          },
          decoration: InputDecoration(
            hintText: '닉네임을 입력해주세요',
            hintStyle: AppTypography.body4(
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
            ),
            counterText: '',
            filled: true,
            fillColor:
                isEnabled
                    ? (isDark ? AppColors.surfaceDark : AppColors.surfaceLight)
                    : (isDark ? AppColors.gray900 : AppColors.gray60),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.base,
              vertical: AppSpacing.md,
            ),
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
            errorBorder: OutlineInputBorder(
              borderRadius: AppSpacing.borderRadiusMd,
              borderSide: const BorderSide(
                color: AppColors.error,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: AppSpacing.borderRadiusMd,
              borderSide: const BorderSide(
                color: AppColors.error,
                width: 2,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: AppSpacing.borderRadiusMd,
              borderSide: BorderSide(
                color: isDark ? AppColors.borderDark : AppColors.borderLight,
              ),
            ),
            suffixIcon: _controller.text.isNotEmpty && isEnabled
                ? IconButton(
                    icon: const Icon(Icons.clear, size: AppSpacing.iconSm),
                    onPressed: () {
                      _controller.clear();
                      setState(() {
                        _validationError = null;
                        _hasInteracted = false;
                      });
                    },
                  )
                : null,
          ),
          style: AppTypography.body4(
            color: isEnabled
                ? (isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight)
                : (isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondaryLight),
          ),
        ),

        // 에러 메시지 또는 쿨다운 메시지
        if (displayError != null || cooldownMessage != null) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(
            displayError ?? cooldownMessage!,
            style: AppTypography.caption(
              color:
                  displayError != null ? AppColors.error : AppColors.warning,
            ),
          ),
        ],

        // 글자 수 카운터
        if (_hasInteracted) ...[
          const SizedBox(height: AppSpacing.xs),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '${_controller.text.length}/${NicknameValidator.maxLength}',
              style: AppTypography.small(
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondaryLight,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
