import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../features/auth/presentation/providers/auth_provider.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/auth/presentation/screens/signup_screen.dart';
import '../features/user/presentation/providers/user_provider.dart';
import '../features/user/presentation/screens/onboarding/onboarding_screen.dart';
import '../features/user/presentation/screens/profile/profile_screen.dart';
import '../features/user/presentation/screens/profile/edit_profile_screen.dart';
import '../features/user/presentation/screens/account/account_management_screen.dart';
import '../features/user/presentation/screens/account/change_password_screen.dart';
import '../features/user/presentation/screens/account/devices_screen.dart';
import '../features/user/presentation/screens/account/withdraw_screen.dart';
import '../features/user/presentation/screens/settings/settings_screen.dart';

/// 앱 라우터 Provider
final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);
  final profile = ref.watch(currentProfileProvider);

  return GoRouter(
    initialLocation: '/login',
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isLoggedIn = authState is AuthAuthenticated;
      final isAuthRoute = state.matchedLocation == '/login' ||
          state.matchedLocation == '/signup';
      final isOnboardingRoute = state.matchedLocation == '/onboarding';

      // 비로그인 상태
      if (!isLoggedIn) {
        // 인증 화면이 아니면 로그인으로
        if (!isAuthRoute && state.matchedLocation != '/') {
          return '/login';
        }
        return null;
      }

      // 로그인 상태
      // 인증 화면 접근 시 리다이렉트
      if (isAuthRoute) {
        // 온보딩 완료 여부 확인
        if (profile != null && !profile.onboardingCompleted) {
          return '/onboarding';
        }
        return '/home';
      }

      // 온보딩 미완료 시 온보딩으로 리다이렉트 (온보딩 화면 제외)
      if (profile != null &&
          !profile.onboardingCompleted &&
          !isOnboardingRoute) {
        return '/onboarding';
      }

      // 온보딩 완료 후 온보딩 화면 접근 시 홈으로
      if (profile != null &&
          profile.onboardingCompleted &&
          isOnboardingRoute) {
        return '/home';
      }

      return null;
    },
    routes: [
      // 루트 경로
      GoRoute(
        path: '/',
        redirect: (context, state) => '/login',
      ),

      // ==================== 인증 ====================

      // 로그인
      GoRoute(
        path: '/login',
        name: 'login',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const LoginScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),

      // 회원가입
      GoRoute(
        path: '/signup',
        name: 'signup',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const SignupScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        ),
      ),

      // ==================== 온보딩 ====================

      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const OnboardingScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),

      // ==================== 홈 ====================

      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const _PlaceholderScreen(title: '홈'),
      ),

      // ==================== 프로필 ====================

      GoRoute(
        path: '/profile',
        name: 'profile',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const ProfileScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
              )),
              child: child,
            );
          },
        ),
      ),

      GoRoute(
        path: '/profile/edit',
        name: 'editProfile',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const EditProfileScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
              )),
              child: child,
            );
          },
        ),
      ),

      // ==================== 계정 관리 ====================

      GoRoute(
        path: '/account',
        name: 'account',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const AccountManagementScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
              )),
              child: child,
            );
          },
        ),
      ),

      GoRoute(
        path: '/account/password',
        name: 'changePassword',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const ChangePasswordScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
              )),
              child: child,
            );
          },
        ),
      ),

      GoRoute(
        path: '/account/devices',
        name: 'devices',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const DevicesScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
              )),
              child: child,
            );
          },
        ),
      ),

      GoRoute(
        path: '/account/withdraw',
        name: 'withdraw',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const WithdrawScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
              )),
              child: child,
            );
          },
        ),
      ),

      // ==================== 설정 ====================

      GoRoute(
        path: '/settings',
        name: 'settings',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const SettingsScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
              )),
              child: child,
            );
          },
        ),
      ),
    ],

    // 에러 페이지
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text('페이지를 찾을 수 없습니다: ${state.uri}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go('/login'),
              child: const Text('로그인으로 이동'),
            ),
          ],
        ),
      ),
    ),
  );
});

/// 임시 플레이스홀더 화면
class _PlaceholderScreen extends StatelessWidget {
  final String title;

  const _PlaceholderScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$title 화면',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 16),
            const Text('구현 예정'),
            const SizedBox(height: 24),
            if (title == '홈') ...[
              ElevatedButton(
                onPressed: () => context.push('/settings'),
                child: const Text('설정'),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  context.read<AuthNotifier>().logout();
                  context.go('/login');
                },
                child: const Text('로그아웃'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

extension on BuildContext {
  AuthNotifier read<T>() {
    return ProviderScope.containerOf(this).read(authProvider.notifier);
  }
}
