import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/error/error_code.dart';
import '../../../../../core/error/error_handler_extension.dart';
import '../../../../../core/theme/theme.dart';
import '../../../data/models/user_models.dart';
import '../../providers/user_provider.dart';
import '../../widgets/profile_image_picker.dart';
import '../../widgets/nickname_text_field.dart';

/// 프로필 수정 화면
class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  late TextEditingController _nicknameController;
  DateTime? _birthDate;
  bool _isLoading = false;
  bool _isImageLoading = false;
  String? _nicknameError;

  @override
  void initState() {
    super.initState();
    _nicknameController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadInitialData();
    });
  }

  void _loadInitialData() {
    final profile = ref.read(currentProfileProvider);
    if (profile != null) {
      _nicknameController.text = profile.nickname ?? '';
      setState(() {
        _birthDate = profile.birthDate;
      });
    }
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    super.dispose();
  }

  Future<void> _uploadImage(File imageFile) async {
    setState(() {
      _isImageLoading = true;
    });

    final success = await ref
        .read(userProfileProvider.notifier)
        .uploadProfileImage(imageFile);

    setState(() {
      _isImageLoading = false;
    });

    if (success && mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('프로필 이미지가 변경되었습니다.')));
    }
  }

  Future<void> _deleteImage() async {
    setState(() {
      _isImageLoading = true;
    });

    final success = await ref
        .read(userProfileProvider.notifier)
        .deleteProfileImage();

    setState(() {
      _isImageLoading = false;
    });

    if (success && mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('프로필 이미지가 삭제되었습니다.')));
    }
  }

  Future<void> _selectBirthDate() async {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final now = DateTime.now();

    final picked = await showDatePicker(
      context: context,
      initialDate: _birthDate ?? DateTime(now.year - 25, 1, 1),
      firstDate: DateTime(1900),
      lastDate: now,
      initialDatePickerMode: DatePickerMode.year,
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
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _birthDate = picked;
      });
    }
  }

  Future<void> _saveProfile() async {
    final currentNickname = ref.read(currentProfileProvider)?.nickname;
    final newNickname = _nicknameController.text.trim();

    // 변경사항이 없으면 저장하지 않음
    if (newNickname == currentNickname &&
        _birthDate == ref.read(currentProfileProvider)?.birthDate) {
      context.pop();
      return;
    }

    setState(() {
      _isLoading = true;
      _nicknameError = null;
    });

    final request = UpdateProfileRequest(
      nickname: newNickname.isNotEmpty ? newNickname : null,
      birthDate: _birthDate,
    );

    final success = await ref
        .read(userProfileProvider.notifier)
        .updateProfile(request);

    setState(() {
      _isLoading = false;
    });

    if (success && mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('프로필이 저장되었습니다.')));
      context.pop();
    } else {
      // 필드 특정 에러만 인라인으로 표시 (일반 에러는 전역 토스트가 처리)
      final state = ref.read(userProfileProvider);
      if (state.hasError) {
        final errorCode = state.errorCode;
        if (errorCode == ErrorCode.nicknameAlreadyExists) {
          setState(() {
            _nicknameError = '이미 사용 중인 닉네임입니다.';
          });
        } else if (errorCode == ErrorCode.nicknameChangeCooldown) {
          setState(() {
            _nicknameError = '닉네임 변경은 30일에 한 번만 가능합니다.';
          });
        }
        // 일반 에러는 전역 에러 핸들러가 토스트로 표시하므로 제거
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final profile = ref.watch(currentProfileProvider);

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(
          '프로필 수정',
          style: AppTypography.title3(
            color: isDark
                ? AppColors.textPrimaryDark
                : AppColors.textPrimaryLight,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _saveProfile,
            child: _isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.primary,
                    ),
                  )
                : Text(
                    '저장',
                    style: AppTypography.body3Bold(color: AppColors.primary),
                  ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: AppSpacing.pagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 프로필 이미지
            ProfileImagePicker(
              currentImageUrl: profile?.profileImageUrl,
              size: AppSpacing.avatar2xl,
              isLoading: _isImageLoading,
              onImageSelected: _uploadImage,
              onImageDeleted: _deleteImage,
            ),

            const SizedBox(height: AppSpacing.xxl),

            // 닉네임 입력
            NicknameTextField(
              controller: _nicknameController,
              lastChangedAt: profile?.nicknameChangedAt,
              externalError: _nicknameError,
              onChanged: (_) {
                if (_nicknameError != null) {
                  setState(() {
                    _nicknameError = null;
                  });
                }
              },
            ),

            const SizedBox(height: AppSpacing.lg),

            // 생년월일
            _buildDateField(isDark),

            const SizedBox(height: AppSpacing.lg),

            // 이메일 (읽기 전용)
            _buildReadOnlyField(
              label: '이메일',
              value: profile?.email ?? '',
              isDark: isDark,
            ),

            const SizedBox(height: AppSpacing.lg),

            // 성별 (읽기 전용)
            _buildReadOnlyField(
              label: '성별',
              value: _getGenderText(profile?.gender),
              isDark: isDark,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateField(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '생년월일',
          style: AppTypography.label1(
            color: isDark
                ? AppColors.textPrimaryDark
                : AppColors.textPrimaryLight,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        GestureDetector(
          onTap: _selectBirthDate,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.base,
              vertical: AppSpacing.md,
            ),
            decoration: BoxDecoration(
              color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
              borderRadius: AppSpacing.borderRadiusMd,
              border: Border.all(
                color: isDark ? AppColors.borderDark : AppColors.borderLight,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _birthDate != null
                        ? '${_birthDate!.year}년 ${_birthDate!.month}월 ${_birthDate!.day}일'
                        : '생년월일 선택',
                    style: AppTypography.body4(
                      color: _birthDate != null
                          ? (isDark
                                ? AppColors.textPrimaryDark
                                : AppColors.textPrimaryLight)
                          : (isDark
                                ? AppColors.textSecondaryDark
                                : AppColors.textSecondaryLight),
                    ),
                  ),
                ),
                Icon(
                  Icons.calendar_today_outlined,
                  size: AppSpacing.iconSm,
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _getGenderText(Gender? gender) {
    if (gender == null) return '미정';
    switch (gender) {
      case Gender.female:
        return '여성';
      case Gender.male:
        return '남성';
      case Gender.other:
        return '미정';
    }
  }

  Widget _buildReadOnlyField({
    required String label,
    required String value,
    required bool isDark,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.label1(
            color: isDark
                ? AppColors.textPrimaryDark
                : AppColors.textPrimaryLight,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.base,
            vertical: AppSpacing.md,
          ),
          decoration: BoxDecoration(
            color: isDark ? AppColors.gray900 : AppColors.gray60,
            borderRadius: AppSpacing.borderRadiusMd,
            border: Border.all(
              color: isDark ? AppColors.borderDark : AppColors.borderLight,
            ),
          ),
          child: Text(
            value,
            style: AppTypography.body4(
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
            ),
          ),
        ),
      ],
    );
  }
}
