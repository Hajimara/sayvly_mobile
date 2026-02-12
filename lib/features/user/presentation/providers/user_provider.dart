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
  /// 마지막 프로필 로드 날짜 (날짜가 바뀌면 새로고침)
  DateTime? _lastLoadedDate;

  @override
  Future<ProfileResponse> build() async {
    // 초기 로드 시 프로필 조회
    final profile = await ref.read(userRepositoryProvider).getMyProfile();
    _lastLoadedDate = DateTime.now();
    return profile;
  }

  /// 프로필 조회 (강제 새로고침)
  Future<void> loadProfile() async {
    state = const AsyncValue.loading();
    state = await AsyncErrorHandler.safeAsyncOperation(
      () async {
        final profile = await ref.read(userRepositoryProvider).getMyProfile();
        _lastLoadedDate = DateTime.now();
        return profile;
      },
      context: 'Load Profile',
      ref: ref,
    );
  }

  /// 날짜가 바뀌었으면 프로필 새로고침 (로딩 상태 없이)
  Future<void> refreshIfNeeded() async {
    final now = DateTime.now();
    final lastDate = _lastLoadedDate;

    // 캐시된 데이터가 없거나 날짜가 바뀌었으면 새로고침
    if (!state.hasValue ||
        lastDate == null ||
        now.year != lastDate.year ||
        now.month != lastDate.month ||
        now.day != lastDate.day) {
      // 기존 데이터가 있으면 로딩 표시 없이 백그라운드에서 갱신
      if (state.hasValue) {
        final result = await AsyncErrorHandler.safeAsyncOperation(
          () async {
            final profile =
                await ref.read(userRepositoryProvider).getMyProfile();
            _lastLoadedDate = DateTime.now();
            return profile;
          },
          context: 'Refresh Profile',
          ref: ref,
        );
        // 에러가 아닌 경우에만 상태 업데이트
        if (result.hasValue) {
          state = result;
        }
      } else {
        // 데이터가 없으면 일반 로드
        await loadProfile();
      }
    }
  }

  /// 프로필 수정
  Future<bool> updateProfile(UpdateProfileRequest request) async {
    if (!state.hasValue) return false;

    // 기존 값을 보관 (에러 시 복원용)
    final previousValue = state.value;

    state = const AsyncValue.loading();
    state = await AsyncErrorHandler.safeAsyncOperation(
      () => ref.read(userRepositoryProvider).updateProfile(request),
      context: 'Update Profile',
      ref: ref,
    );

    // 에러 발생 시 이전 값 복원 후 false 반환
    if (state.hasError) {
      if (previousValue != null) {
        state = AsyncValue.data(previousValue);
      }
      return false;
    }

    return true;
  }

  /// 닉네임 변경
  Future<bool> updateNickname(String nickname) async {
    return updateProfile(UpdateProfileRequest(nickname: nickname));
  }

  /// 프로필 이미지 업로드
  Future<bool> uploadProfileImage(File imageFile) async {
    if (!state.hasValue) return false;

    final previousValue = state.value;

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

    if (state.hasError) {
      if (previousValue != null) {
        state = AsyncValue.data(previousValue);
      }
      return false;
    }

    return true;
  }

  /// 프로필 이미지 삭제
  Future<bool> deleteProfileImage() async {
    if (!state.hasValue) return false;

    final previousValue = state.value;

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

    if (state.hasError) {
      if (previousValue != null) {
        state = AsyncValue.data(previousValue);
      }
      return false;
    }

    return true;
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

/// 온보딩 표시 여부 Provider
/// 온보딩이 완료되지 않았고, 오늘 가입한 계정이 30분이 지나지 않았고, 평균주기가 정해지지 않았으면 온보딩 표시
/// 단, onboardingCompleted가 true이면 온보딩을 표시하지 않음 (건너뛰기 포함)
final shouldShowOnboardingProvider = Provider<bool>((ref) {
  final profile = ref.watch(currentProfileProvider);
  if (profile == null) return false;

  // 온보딩이 이미 완료되었으면 표시하지 않음 (건너뛰기 포함)
  if (profile.onboardingCompleted) return false;

  final now = DateTime.now();
  final createdAt = profile.createdAt;

  // 오늘 가입한 계정인지 확인
  final isToday =
      createdAt.year == now.year &&
      createdAt.month == now.month &&
      createdAt.day == now.day;

  if (!isToday) return false;

  // 30분이 지나지 않았는지 확인
  final timeDifference = now.difference(createdAt);
  if (timeDifference.inMinutes >= 30) return false;

  // 평균주기가 정해지지 않았는지 확인
  final hasAverageCycleLength = profile.cycleInfo?.averageCycleLength != null;
  if (hasAverageCycleLength) return false;

  return true;
});
