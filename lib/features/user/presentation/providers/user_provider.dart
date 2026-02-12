import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/error/error_handler_extension.dart';
import '../../data/models/user_models.dart';
import '../../data/repositories/user_repository.dart';

/// UserRepository Provider
final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository();
});

/// 사용자 프로필 Notifier (AsyncNotifier 사용)
class UserProfileNotifier extends AsyncNotifier<ProfileResponse> {
  @override
  Future<ProfileResponse> build() async {
    // 초기 로드 시 프로필 조회
    return await ref.read(userRepositoryProvider).getMyProfile();
  }

  /// 프로필 조회
  Future<void> loadProfile() async {
    state = const AsyncValue.loading();
    state = await AsyncErrorHandler.safeAsyncOperation(
      () => ref.read(userRepositoryProvider).getMyProfile(),
      context: 'Load Profile',
      ref: ref,
    );
  }

  /// 프로필 수정
  Future<bool> updateProfile(UpdateProfileRequest request) async {
    if (!state.hasValue) return false;

    state = const AsyncValue.loading();
    state = await AsyncErrorHandler.safeAsyncOperation(
      () => ref.read(userRepositoryProvider).updateProfile(request),
      context: 'Update Profile',
      ref: ref,
    );
    
    return state.hasValue;
  }

  /// 닉네임 변경
  Future<bool> updateNickname(String nickname) async {
    return updateProfile(UpdateProfileRequest(nickname: nickname));
  }

  /// 프로필 이미지 업로드
  Future<bool> uploadProfileImage(File imageFile) async {
    if (!state.hasValue) return false;

    state = const AsyncValue.loading();
    state = await AsyncErrorHandler.safeAsyncOperation(
      () async {
        await ref.read(userRepositoryProvider).uploadProfileImage(imageFile);
        // 프로필 다시 로드하여 새 이미지 URL 반영
        return await ref.read(userRepositoryProvider).getMyProfile();
      },
      context: 'Upload Profile Image',
      ref: ref,
    );
    
    return state.hasValue;
  }

  /// 프로필 이미지 삭제
  Future<bool> deleteProfileImage() async {
    if (!state.hasValue) return false;

    state = const AsyncValue.loading();
    state = await AsyncErrorHandler.safeAsyncOperation(
      () async {
        await ref.read(userRepositoryProvider).deleteProfileImage();
        // 프로필 다시 로드하여 이미지 삭제 반영
        return await ref.read(userRepositoryProvider).getMyProfile();
      },
      context: 'Delete Profile Image',
      ref: ref,
    );
    
    return state.hasValue;
  }

  /// 에러 상태 초기화
  void clearError() {
    if (state.hasError) {
      // 이전 값이 있으면 복원, 없으면 다시 로드
      if (state.hasValue) {
        state = AsyncValue.data(state.value!);
      } else {
        loadProfile();
      }
    }
  }
}

/// UserProfileNotifier Provider
final userProfileProvider =
    AsyncNotifierProvider<UserProfileNotifier, ProfileResponse>(() {
  return UserProfileNotifier();
});

/// 현재 프로필 Provider
final currentProfileProvider = Provider<ProfileResponse?>((ref) {
  final state = ref.watch(userProfileProvider);
  return state.valueOrNull;
});

/// 온보딩 완료 여부 Provider
final isOnboardingCompletedProvider = Provider<bool?>((ref) {
  final profile = ref.watch(currentProfileProvider);
  return profile?.onboardingCompleted;
});

/// 소셜 로그인 계정 여부 Provider
final isSocialLoginProvider = Provider<bool?>((ref) {
  final profile = ref.watch(currentProfileProvider);
  if (profile == null) return null;
  return profile.provider != AuthProvider.email;
});
