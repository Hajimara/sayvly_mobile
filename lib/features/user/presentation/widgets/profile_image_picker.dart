import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/theme/theme.dart';

/// 프로필 이미지 선택 콜백
typedef OnImageSelected = void Function(File imageFile);
typedef OnImageDeleted = void Function();

/// 프로필 이미지 피커
/// 바텀시트로 카메라/갤러리/기본이미지 선택
class ProfileImagePicker extends StatelessWidget {
  final String? currentImageUrl;
  final double size;
  final OnImageSelected? onImageSelected;
  final OnImageDeleted? onImageDeleted;
  final bool isLoading;
  final bool enabled;

  const ProfileImagePicker({
    super.key,
    this.currentImageUrl,
    this.size = AppSpacing.avatarXl,
    this.onImageSelected,
    this.onImageDeleted,
    this.isLoading = false,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? () => _showImagePickerBottomSheet(context) : null,
      child: Stack(
        children: [
          // 프로필 이미지
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.gray100,
              border: Border.all(
                color: AppColors.borderLight,
                width: 2,
              ),
              boxShadow: AppShadows.softCard,
            ),
            child: ClipOval(
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.primary,
                      ),
                    )
                  : currentImageUrl != null
                      ? Image.network(
                          currentImageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              _buildDefaultAvatar(),
                        )
                      : _buildDefaultAvatar(),
            ),
          ),

          // 편집 아이콘
          if (enabled)
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: size * 0.3,
                height: size * 0.3,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary,
                  border: Border.all(
                    color: AppColors.white,
                    width: 2,
                  ),
                ),
                child: Icon(
                  Icons.camera_alt,
                  size: size * 0.15,
                  color: AppColors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDefaultAvatar() {
    return Container(
      color: AppColors.gray100,
      child: Icon(
        Icons.person,
        size: size * 0.5,
        color: AppColors.gray400,
      ),
    );
  }

  void _showImagePickerBottomSheet(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
      shape: const RoundedRectangleBorder(
        borderRadius: AppSpacing.borderRadiusBottomSheet,
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppSpacing.lg,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 핸들
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.gray200,
                  borderRadius: AppSpacing.borderRadiusCircle,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // 타이틀
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.pageHorizontal,
                ),
                child: Text(
                  '프로필 사진',
                  style: AppTypography.title3(
                    color: isDark
                        ? AppColors.textPrimaryDark
                        : AppColors.textPrimaryLight,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // 옵션들
              _ImagePickerOption(
                icon: Icons.camera_alt_outlined,
                label: '카메라로 촬영',
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              _ImagePickerOption(
                icon: Icons.photo_library_outlined,
                label: '갤러리에서 선택',
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
              if (currentImageUrl != null)
                _ImagePickerOption(
                  icon: Icons.delete_outline,
                  label: '기본 이미지로 변경',
                  isDestructive: true,
                  onTap: () {
                    Navigator.pop(context);
                    onImageDeleted?.call();
                  },
                ),

              const SizedBox(height: AppSpacing.sm),

              // 취소 버튼
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.pageHorizontal,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      '취소',
                      style: AppTypography.body3(
                        color: isDark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondaryLight,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: source,
        maxWidth: 500,
        maxHeight: 500,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        final imageFile = File(pickedFile.path);
        onImageSelected?.call(imageFile);
      }
    } catch (e) {
      debugPrint('Image picker error: $e');
    }
  }
}

class _ImagePickerOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isDestructive;

  const _ImagePickerOption({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDestructive
        ? AppColors.error
        : (isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight);

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.pageHorizontal,
          vertical: AppSpacing.md,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: AppSpacing.iconBase,
              color: textColor,
            ),
            const SizedBox(width: AppSpacing.md),
            Text(
              label,
              style: AppTypography.body3(color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}
