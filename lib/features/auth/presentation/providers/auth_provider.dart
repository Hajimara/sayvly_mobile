import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/error/error_handler_extension.dart';
import '../../../../../core/notification/fcm_service.dart';
import '../../data/models/auth_request.dart';
import '../../data/models/auth_response.dart';
import '../../data/repositories/auth_repository.dart';
import '../widgets/social_login_button.dart';
import '../../../user/presentation/providers/user_provider.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

class AuthNotifier extends AsyncNotifier<AuthResponse?> {
  @override
  Future<AuthResponse?> build() async {
    final repository = ref.read(authRepositoryProvider);
    final authData = await repository.getStoredAuthData();

    if (authData != null) {
      await FcmService.registerCurrentToken();
    }

    return authData;
  }

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

    if (state.hasValue && state.value != null) {
      await ref.read(userProfileProvider.notifier).loadProfile();
      await FcmService.registerCurrentToken();
    }
  }

  Future<void> login({required String email, required String password}) async {
    state = const AsyncValue.loading();
    state = await AsyncErrorHandler.safeAsyncOperation(
      () => ref
          .read(authRepositoryProvider)
          .login(LoginRequest(email: email, password: password)),
      context: 'Login',
      ref: ref,
    );

    if (state.hasValue && state.value != null) {
      await ref.read(userProfileProvider.notifier).loadProfile();
      await FcmService.registerCurrentToken();
    }
  }

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

    if (state.hasValue && state.value != null) {
      await ref.read(userProfileProvider.notifier).loadProfile();
      await FcmService.registerCurrentToken();
    }
  }

  Future<void> logout() async {
    await ref.read(authRepositoryProvider).logout();
    state = const AsyncValue.data(null);
  }

  void clearError() {
    if (state.hasError) {
      state = const AsyncValue.data(null);
    }
  }
}

final authProvider = AsyncNotifierProvider<AuthNotifier, AuthResponse?>(() {
  return AuthNotifier();
});

final isLoggedInProvider = Provider<bool>((ref) {
  final authState = ref.watch(authProvider);
  return authState.hasValue && authState.value != null;
});
