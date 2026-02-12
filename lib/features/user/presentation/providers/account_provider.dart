import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/account_models.dart';
import '../../data/repositories/account_repository.dart';

/// AccountRepository Provider
final accountRepositoryProvider = Provider<AccountRepository>((ref) {
  return AccountRepository();
});

/// 비밀번호 변경 상태
sealed class ChangePasswordState {
  const ChangePasswordState();
}

class ChangePasswordInitial extends ChangePasswordState {
  const ChangePasswordInitial();
}

class ChangePasswordLoading extends ChangePasswordState {
  const ChangePasswordLoading();
}

class ChangePasswordSuccess extends ChangePasswordState {
  const ChangePasswordSuccess();
}

class ChangePasswordError extends ChangePasswordState {
  final String message;
  final String? errorCode;
  const ChangePasswordError(this.message, {this.errorCode});

  bool get isCurrentPasswordInvalid => errorCode == '3009';
  bool get isSocialLoginAccount => errorCode == '2009';
}

/// 비밀번호 변경 Notifier
class ChangePasswordNotifier extends StateNotifier<ChangePasswordState> {
  final AccountRepository _repository;

  ChangePasswordNotifier(this._repository)
      : super(const ChangePasswordInitial());

  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    state = const ChangePasswordLoading();
    try {
      await _repository.changePassword(
        ChangePasswordRequest(
          currentPassword: currentPassword,
          newPassword: newPassword,
        ),
      );
      state = const ChangePasswordSuccess();
      return true;
    } on AccountException catch (e) {
      state = ChangePasswordError(e.message, errorCode: e.errorCode);
      return false;
    } catch (e) {
      state = ChangePasswordError(e.toString());
      return false;
    }
  }

  void reset() {
    state = const ChangePasswordInitial();
  }
}

/// ChangePasswordNotifier Provider
final changePasswordProvider =
    StateNotifierProvider<ChangePasswordNotifier, ChangePasswordState>((ref) {
  final repository = ref.watch(accountRepositoryProvider);
  return ChangePasswordNotifier(repository);
});

/// 기기 목록 상태
sealed class DevicesState {
  const DevicesState();
}

class DevicesInitial extends DevicesState {
  const DevicesInitial();
}

class DevicesLoading extends DevicesState {
  const DevicesLoading();
}

class DevicesLoaded extends DevicesState {
  final List<DeviceInfo> devices;
  const DevicesLoaded(this.devices);
}

class DevicesError extends DevicesState {
  final String message;
  const DevicesError(this.message);
}

/// 기기 관리 Notifier
class DevicesNotifier extends StateNotifier<DevicesState> {
  final AccountRepository _repository;

  DevicesNotifier(this._repository) : super(const DevicesInitial());

  /// 기기 목록 조회
  Future<void> loadDevices() async {
    state = const DevicesLoading();
    try {
      final devices = await _repository.getDevices();
      state = DevicesLoaded(devices);
    } on AccountException catch (e) {
      state = DevicesError(e.message);
    } catch (e) {
      state = DevicesError(e.toString());
    }
  }

  /// 특정 기기 로그아웃
  Future<bool> logoutDevice(String tokenId) async {
    final currentState = state;
    if (currentState is! DevicesLoaded) return false;

    try {
      await _repository.logoutDevice(tokenId);
      // 목록에서 제거
      final updatedDevices = currentState.devices
          .where((d) => d.tokenId != tokenId)
          .toList();
      state = DevicesLoaded(updatedDevices);
      return true;
    } on AccountException catch (e) {
      state = DevicesError(e.message);
      return false;
    } catch (e) {
      state = DevicesError(e.toString());
      return false;
    }
  }

  /// 모든 기기 로그아웃
  Future<bool> logoutAllDevices() async {
    state = const DevicesLoading();
    try {
      await _repository.logoutAllDevices();
      await _repository.clearLocalData();
      state = const DevicesLoaded([]);
      return true;
    } on AccountException catch (e) {
      state = DevicesError(e.message);
      return false;
    } catch (e) {
      state = DevicesError(e.toString());
      return false;
    }
  }
}

/// DevicesNotifier Provider
final devicesProvider =
    StateNotifierProvider<DevicesNotifier, DevicesState>((ref) {
  final repository = ref.watch(accountRepositoryProvider);
  return DevicesNotifier(repository);
});

/// 탈퇴 상태
sealed class WithdrawState {
  const WithdrawState();
}

class WithdrawInitial extends WithdrawState {
  const WithdrawInitial();
}

class WithdrawLoading extends WithdrawState {
  const WithdrawLoading();
}

class WithdrawRequested extends WithdrawState {
  final WithdrawResponse response;
  const WithdrawRequested(this.response);
}

class WithdrawCancelled extends WithdrawState {
  const WithdrawCancelled();
}

class WithdrawError extends WithdrawState {
  final String message;
  const WithdrawError(this.message);
}

/// 탈퇴 Notifier
class WithdrawNotifier extends StateNotifier<WithdrawState> {
  final AccountRepository _repository;

  WithdrawNotifier(this._repository) : super(const WithdrawInitial());

  /// 탈퇴 요청
  Future<bool> requestWithdraw({String? reason, String? feedback}) async {
    state = const WithdrawLoading();
    try {
      final response = await _repository.requestWithdraw(
        WithdrawRequest(reason: reason, feedback: feedback),
      );
      state = WithdrawRequested(response);
      return true;
    } on AccountException catch (e) {
      state = WithdrawError(e.message);
      return false;
    } catch (e) {
      state = WithdrawError(e.toString());
      return false;
    }
  }

  /// 탈퇴 취소
  Future<bool> cancelWithdraw() async {
    state = const WithdrawLoading();
    try {
      await _repository.cancelWithdraw();
      state = const WithdrawCancelled();
      return true;
    } on AccountException catch (e) {
      state = WithdrawError(e.message);
      return false;
    } catch (e) {
      state = WithdrawError(e.toString());
      return false;
    }
  }

  void reset() {
    state = const WithdrawInitial();
  }
}

/// WithdrawNotifier Provider
final withdrawProvider =
    StateNotifierProvider<WithdrawNotifier, WithdrawState>((ref) {
  final repository = ref.watch(accountRepositoryProvider);
  return WithdrawNotifier(repository);
});
