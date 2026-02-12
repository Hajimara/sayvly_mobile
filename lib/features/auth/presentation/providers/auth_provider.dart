import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/auth_request.dart';
import '../../data/models/auth_response.dart';
import '../../data/repositories/auth_repository.dart';
import '../widgets/social_login_button.dart';

/// AuthRepository Provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

/// 인증 상태
sealed class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthAuthenticated extends AuthState {
  final AuthResponse response;
  const AuthAuthenticated(this.response);
}

class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

class AuthError extends AuthState {
  final String message;
  final String? errorCode;
  const AuthError(this.message, {this.errorCode});
}

/// 인증 상태 Notifier
class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _repository;

  AuthNotifier(this._repository) : super(const AuthInitial()) {
    _checkAuthStatus();
  }

  /// 앱 시작 시 로그인 상태 확인
  Future<void> _checkAuthStatus() async {
    final authData = await _repository.getStoredAuthData();
    if (authData != null) {
      state = AuthAuthenticated(authData);
    } else {
      state = const AuthUnauthenticated();
    }
  }

  /// 회원가입
  Future<void> signup({
    required String email,
    required String password,
    required String nickname,
  }) async {
    state = const AuthLoading();
    try {
      final response = await _repository.signup(
        SignupRequest(email: email, password: password, nickname: nickname),
      );
      state = AuthAuthenticated(response);
    } on AuthException catch (e) {
      state = AuthError(e.message, errorCode: e.errorCode);
    } catch (e) {
      state = AuthError(e.toString());
    }
  }

  /// 로그인
  Future<void> login({required String email, required String password}) async {
    state = const AuthLoading();
    try {
      final response = await _repository.login(
        LoginRequest(email: email, password: password),
      );
      state = AuthAuthenticated(response);
    } on AuthException catch (e) {
      state = AuthError(e.message, errorCode: e.errorCode);
    } catch (e) {
      state = AuthError(e.toString());
    }
  }

  /// 소셜 로그인
  Future<void> socialLogin({
    required SocialLoginType type,
    required String accessToken,
    String? nickname,
  }) async {
    state = const AuthLoading();
    try {
      final response = await _repository.socialLogin(
        SocialLoginRequest(
          provider: type.provider,
          accessToken: accessToken,
          nickname: nickname,
        ),
      );
      state = AuthAuthenticated(response);
    } on AuthException catch (e) {
      state = AuthError(e.message, errorCode: e.errorCode);
    } catch (e) {
      state = AuthError(e.toString());
    }
  }

  /// 로그아웃
  Future<void> logout() async {
    await _repository.logout();
    state = const AuthUnauthenticated();
  }

  /// 에러 상태 초기화
  void clearError() {
    if (state is AuthError) {
      state = const AuthUnauthenticated();
    }
  }
}

/// AuthNotifier Provider
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return AuthNotifier(repository);
});

/// 로그인 여부 Provider
final isLoggedInProvider = Provider<bool>((ref) {
  final authState = ref.watch(authProvider);
  return authState is AuthAuthenticated;
});
