import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/error/error_code.dart';
import '../../../../../core/error/error_handler_extension.dart';
import '../../data/models/account_models.dart';
import '../../data/repositories/account_repository.dart';

/// AccountRepository Provider
final accountRepositoryProvider = Provider<AccountRepository>((ref) {
  return AccountRepository();
});

/// 비밀번호 변경 결과
class ChangePasswordResult {
  final bool success;
  final ErrorCode? errorCode;

  const ChangePasswordResult({required this.success, this.errorCode});

  bool get isCurrentPasswordInvalid => errorCode == ErrorCode.invalidCurrentPassword;
  bool get isSocialLoginAccount => errorCode == ErrorCode.socialLoginRequired;
}

/// 비밀번호 변경 Notifier (AsyncNotifier 사용)
class ChangePasswordNotifier extends AsyncNotifier<ChangePasswordResult?> {
  @override
  Future<ChangePasswordResult?> build() async {
    return null; // 초기 상태
  }

  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncErrorHandler.safeAsyncOperation(
      () async {
        await ref.read(accountRepositoryProvider).changePassword(
              ChangePasswordRequest(
                currentPassword: currentPassword,
                newPassword: newPassword,
              ),
            );
        return const ChangePasswordResult(success: true);
      },
      context: 'Change Password',
      ref: ref,
    );

    if (state.hasValue && state.value != null) {
      return state.value!.success;
    }
    return false;
  }

  void reset() {
    state = const AsyncValue.data(null);
  }
}

/// ChangePasswordNotifier Provider
final changePasswordProvider =
    AsyncNotifierProvider<ChangePasswordNotifier, ChangePasswordResult?>(() {
  return ChangePasswordNotifier();
});

/// 기기 관리 Notifier (AsyncNotifier 사용)
class DevicesNotifier extends AsyncNotifier<List<DeviceInfo>> {
  @override
  Future<List<DeviceInfo>> build() async {
    // 초기 로드 시 기기 목록 조회
    return await ref.read(accountRepositoryProvider).getDevices();
  }

  /// 기기 목록 조회
  Future<void> loadDevices() async {
    state = const AsyncValue.loading();
    state = await AsyncErrorHandler.safeAsyncOperation(
      () => ref.read(accountRepositoryProvider).getDevices(),
      context: 'Load Devices',
      ref: ref,
    );
  }

  /// 특정 기기 로그아웃
  Future<bool> logoutDevice(String tokenId) async {
    if (!state.hasValue) return false;

    final currentDevices = state.value!;
    state = const AsyncValue.loading();
    
    state = await AsyncErrorHandler.safeAsyncOperation(
      () async {
        await ref.read(accountRepositoryProvider).logoutDevice(tokenId);
        // 목록에서 제거
        return currentDevices.where((d) => d.tokenId != tokenId).toList();
      },
      context: 'Logout Device',
      ref: ref,
    );

    return state.hasValue;
  }

  /// 모든 기기 로그아웃
  Future<bool> logoutAllDevices() async {
    state = const AsyncValue.loading();
    
    state = await AsyncErrorHandler.safeAsyncOperation(
      () async {
        await ref.read(accountRepositoryProvider).logoutAllDevices();
        await ref.read(accountRepositoryProvider).clearLocalData();
        return <DeviceInfo>[];
      },
      context: 'Logout All Devices',
      ref: ref,
    );

    return state.hasValue;
  }
}

/// DevicesNotifier Provider
final devicesProvider =
    AsyncNotifierProvider<DevicesNotifier, List<DeviceInfo>>(() {
  return DevicesNotifier();
});

/// 탈퇴 Notifier (AsyncNotifier 사용)
class WithdrawNotifier extends AsyncNotifier<WithdrawResponse?> {
  @override
  Future<WithdrawResponse?> build() async {
    // 초기 상태는 null
    return null;
  }

  /// 탈퇴 요청
  Future<bool> requestWithdraw({String? reason, String? feedback}) async {
    state = const AsyncValue.loading();
    state = await AsyncErrorHandler.safeAsyncOperation(
      () => ref.read(accountRepositoryProvider).requestWithdraw(
            WithdrawRequest(reason: reason, feedback: feedback),
          ),
      context: 'Request Withdraw',
      ref: ref,
    );

    return state.hasValue;
  }

  /// 탈퇴 취소
  Future<bool> cancelWithdraw() async {
    state = const AsyncValue.loading();
    state = await AsyncErrorHandler.safeAsyncOperation(
      () async {
        await ref.read(accountRepositoryProvider).cancelWithdraw();
        return null; // 취소 후 상태 초기화
      },
      context: 'Cancel Withdraw',
      ref: ref,
    );

    return state.hasValue;
  }

  void reset() {
    state = const AsyncValue.data(null);
  }
}

/// WithdrawNotifier Provider
final withdrawProvider =
    AsyncNotifierProvider<WithdrawNotifier, WithdrawResponse?>(() {
  return WithdrawNotifier();
});
