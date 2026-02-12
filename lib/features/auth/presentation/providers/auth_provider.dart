import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/error/error_handler_extension.dart';
import '../../data/models/auth_request.dart';
import '../../data/models/auth_response.dart';
import '../../data/repositories/auth_repository.dart';
import '../widgets/social_login_button.dart';
import '../../../user/presentation/providers/user_provider.dart';

/// AuthRepository Provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

/// 인증 상태 Notifier (AsyncNotifier 사용)
class AuthNotifier extends AsyncNotifier<AuthResponse?> {
  @override
  Future<AuthResponse?> build() async {
    // 앱 시작 시 저장된 인증 데이터 확인
    final repository = ref.read(authRepositoryProvider);
    return await repository.getStoredAuthData();
  }

  /// 회원가입
  Future<void> signup({
    required String email,
    required String password,
    required String nickname,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncErrorHandler.safeAsyncOperation(
      () => ref
          .read(authRepositoryProvider)
          .signup(
            SignupRequest(email: email, password: password, nickname: nickname),
          ),
      context: 'Signup',
      ref: ref,
    );

    // 성공 시 프로필 Provider 리프레시 (새 프로필 로드 완료 대기)
    if (state.hasValue && state.value != null) {
      await ref.read(userProfileProvider.notifier).loadProfile();
    }
  }

  /// 로그인
  Future<void> login({required String email, required String password}) async {
    state = const AsyncValue.loading();
    state = await AsyncErrorHandler.safeAsyncOperation(
      () => ref
          .read(authRepositoryProvider)
          .login(LoginRequest(email: email, password: password)),
      context: 'Login',
      ref: ref,
    );

    // 성공 시 프로필 Provider 리프레시 (새 프로필 로드 완료 대기)
    if (state.hasValue && state.value != null) {
      await ref.read(userProfileProvider.notifier).loadProfile();
    }
  }

  /// 소셜 로그인
  Future<void> socialLogin({
    required SocialLoginType type,
    required String accessToken,
    String? nickname,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncErrorHandler.safeAsyncOperation(
      () => ref
          .read(authRepositoryProvider)
          .socialLogin(
            SocialLoginRequest(
              provider: type.provider,
              accessToken: accessToken,
              nickname: nickname,
            ),
          ),
      context: 'Social Login',
      ref: ref,
    );

    // 성공 시 프로필 Provider 리프레시 (새 프로필 로드 완료 대기)
    if (state.hasValue && state.value != null) {
      await ref.read(userProfileProvider.notifier).loadProfile();
    }
  }

  /// 로그아웃
  Future<void> logout() async {
    await ref.read(authRepositoryProvider).logout();
    state = const AsyncValue.data(null);
  }

  /// 에러 상태 초기화
  void clearError() {
    if (state.hasError) {
      state = const AsyncValue.data(null);
    }
  }
}

/// AuthNotifier Provider
final authProvider = AsyncNotifierProvider<AuthNotifier, AuthResponse?>(() {
  return AuthNotifier();
});

/// 로그인 여부 Provider
final isLoggedInProvider = Provider<bool>((ref) {
  final authState = ref.watch(authProvider);
  return authState.hasValue && authState.value != null;
});
