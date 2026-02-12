import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/user_models.dart';
import '../../data/repositories/user_repository.dart';

/// UserRepository Provider
final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository();
});

/// 사용자 프로필 상태
sealed class UserProfileState {
  const UserProfileState();
}

class UserProfileInitial extends UserProfileState {
  const UserProfileInitial();
}

class UserProfileLoading extends UserProfileState {
  const UserProfileLoading();
}

class UserProfileLoaded extends UserProfileState {
  final ProfileResponse profile;
  const UserProfileLoaded(this.profile);
}

class UserProfileError extends UserProfileState {
  final String message;
  final String? errorCode;
  const UserProfileError(this.message, {this.errorCode});
}

/// 사용자 프로필 Notifier
class UserProfileNotifier extends StateNotifier<UserProfileState> {
  final UserRepository _repository;

  UserProfileNotifier(this._repository) : super(const UserProfileInitial());

  /// 프로필 조회
  Future<void> loadProfile() async {
    state = const UserProfileLoading();
    try {
      final profile = await _repository.getMyProfile();
      state = UserProfileLoaded(profile);
    } on UserException catch (e) {
      state = UserProfileError(e.message, errorCode: e.errorCode);
    } catch (e) {
      state = UserProfileError(e.toString());
    }
  }

  /// 프로필 수정
  Future<bool> updateProfile(UpdateProfileRequest request) async {
    final currentState = state;
    if (currentState is! UserProfileLoaded) return false;

    state = const UserProfileLoading();
    try {
      final profile = await _repository.updateProfile(request);
      state = UserProfileLoaded(profile);
      return true;
    } on UserException catch (e) {
      state = UserProfileError(e.message, errorCode: e.errorCode);
      return false;
    } catch (e) {
      state = UserProfileError(e.toString());
      return false;
    }
  }

  /// 닉네임 변경
  Future<bool> updateNickname(String nickname) async {
    return updateProfile(UpdateProfileRequest(nickname: nickname));
  }

  /// 프로필 이미지 업로드
  Future<bool> uploadProfileImage(File imageFile) async {
    final currentState = state;
    if (currentState is! UserProfileLoaded) return false;

    state = const UserProfileLoading();
    try {
      final imageResponse = await _repository.uploadProfileImage(imageFile);
      // 프로필 다시 로드하여 새 이미지 URL 반영
      final profile = await _repository.getMyProfile();
      state = UserProfileLoaded(profile);
      return true;
    } on UserException catch (e) {
      state = UserProfileError(e.message, errorCode: e.errorCode);
      return false;
    } catch (e) {
      state = UserProfileError(e.toString());
      return false;
    }
  }

  /// 프로필 이미지 삭제
  Future<bool> deleteProfileImage() async {
    final currentState = state;
    if (currentState is! UserProfileLoaded) return false;

    state = const UserProfileLoading();
    try {
      await _repository.deleteProfileImage();
      // 프로필 다시 로드하여 이미지 삭제 반영
      final profile = await _repository.getMyProfile();
      state = UserProfileLoaded(profile);
      return true;
    } on UserException catch (e) {
      state = UserProfileError(e.message, errorCode: e.errorCode);
      return false;
    } catch (e) {
      state = UserProfileError(e.toString());
      return false;
    }
  }

  /// 에러 상태 초기화 (이전 프로필 상태로 복원)
  void clearError() {
    if (state is UserProfileError) {
      state = const UserProfileInitial();
    }
  }
}

/// UserProfileNotifier Provider
final userProfileProvider =
    StateNotifierProvider<UserProfileNotifier, UserProfileState>((ref) {
  final repository = ref.watch(userRepositoryProvider);
  return UserProfileNotifier(repository);
});

/// 현재 프로필 Provider (Loaded 상태에서만 값 반환)
final currentProfileProvider = Provider<ProfileResponse?>((ref) {
  final state = ref.watch(userProfileProvider);
  if (state is UserProfileLoaded) {
    return state.profile;
  }
  return null;
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
