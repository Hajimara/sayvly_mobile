import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../features/auth/presentation/providers/auth_provider.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/auth/presentation/screens/signup_screen.dart';
import '../features/user/presentation/providers/user_provider.dart'
    show shouldShowOnboardingProvider;
import '../features/user/presentation/screens/onboarding/onboarding_screen.dart';
import '../features/user/presentation/screens/profile/profile_screen.dart';
import '../features/user/presentation/screens/profile/edit_profile_screen.dart';
import '../features/user/presentation/screens/account/account_management_screen.dart';
import '../features/user/presentation/screens/account/change_password_screen.dart';
import '../features/user/presentation/screens/account/devices_screen.dart';
import '../features/user/presentation/screens/account/withdraw_screen.dart';
import '../features/user/presentation/screens/settings/settings_screen.dart';
import '../features/common/widgets/bottom_navigation_bar.dart';
import '../features/common/screens/splash_screen.dart';
import '../core/theme/theme.dart';

/// 앱 라우터 Provider
final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);
  final shouldShowOnboarding = ref.watch(shouldShowOnboardingProvider);

  return GoRouter(
    initialLocation: '/splash',
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isSplashRoute = state.matchedLocation == '/splash';
      final isAuthRoute =
          state.matchedLocation == '/login' ||
          state.matchedLocation == '/signup';
      final isOnboardingRoute = state.matchedLocation == '/onboarding';
      final isLoggedIn = authState.hasValue && authState.value != null;

      // 인증 상태 로딩 중
      if (authState.isLoading) {
        // 스플래시 화면 유지
        return isSplashRoute ? null : '/splash';
      }

      // 스플래시에서 적절한 화면으로 이동
      if (isSplashRoute) {
        if (!isLoggedIn) {
          return '/login';
        }
        if (shouldShowOnboarding) {
          return '/onboarding';
        }
        return '/home';
      }

      // 비로그인 상태
      if (!isLoggedIn) {
        // 인증 화면이 아니면 로그인으로
        if (!isAuthRoute && state.matchedLocation != '/') {
          return '/login';
        }
        return null;
      }

      // 로그인 상태
      // 온보딩 표시 조건 확인 (온보딩 화면 제외)
      if (shouldShowOnboarding && !isOnboardingRoute) {
        return '/onboarding';
      }

      // 이미 로그인한 사용자가 로그인/회원가입 화면 접근 시 홈으로 리다이렉트
      if (isAuthRoute) {
        return '/home';
      }

      // 온보딩 완료 후 온보딩 화면 접근 시 홈으로
      // (shouldShowOnboarding이 false면 온보딩 완료된 것)
      if (!shouldShowOnboarding && isOnboardingRoute) {
        return '/home';
      }

      return null;
    },
    routes: [
      // 루트 경로
      GoRoute(path: '/', redirect: (context, state) => '/splash'),

      // ==================== 스플래시 ====================
      GoRoute(
        path: '/splash',
        name: 'splash',
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const SplashScreen(),
        ),
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
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const _HomeScreenWithBottomNav(),
        ),
      ),

      // ==================== 캘린더 ====================
      GoRoute(
        path: '/calendar',
        name: 'calendar',
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const _PlaceholderScreen(title: '캘린더'),
        ),
      ),

      // ==================== 파트너 ====================
      GoRoute(
        path: '/partner',
        name: 'partner',
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const _PlaceholderScreen(title: '파트너'),
        ),
      ),

      // ==================== 설정 ====================
      GoRoute(
        path: '/settings',
        name: 'settings',
        pageBuilder: (context, state) =>
            NoTransitionPage(key: state.pageKey, child: const SettingsScreen()),
      ),

      // ==================== 프로필 ====================
      GoRoute(
        path: '/profile',
        name: 'profile',
        pageBuilder: (context, state) =>
            NoTransitionPage(key: state.pageKey, child: const ProfileScreen()),
      ),

      GoRoute(
        path: '/profile/edit',
        name: 'editProfile',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const EditProfileScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position:
                  Tween<Offset>(
                    begin: const Offset(1, 0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOutCubic,
                    ),
                  ),
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
              position:
                  Tween<Offset>(
                    begin: const Offset(1, 0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOutCubic,
                    ),
                  ),
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
              position:
                  Tween<Offset>(
                    begin: const Offset(1, 0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOutCubic,
                    ),
                  ),
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
              position:
                  Tween<Offset>(
                    begin: const Offset(1, 0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOutCubic,
                    ),
                  ),
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
              position:
                  Tween<Offset>(
                    begin: const Offset(1, 0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOutCubic,
                    ),
                  ),
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

/// 홈 화면 (바텀 네비게이션 포함)
class _HomeScreenWithBottomNav extends ConsumerWidget {
  const _HomeScreenWithBottomNav();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = GoRouter.of(context);
    final currentPath = router.routerDelegate.currentConfiguration.uri.path;

    return Scaffold(
      body: const _PlaceholderScreen(title: '홈'),
      bottomNavigationBar: SayvlyBottomNavigationBar(currentPath: currentPath),
    );
  }
}

/// 임시 플레이스홀더 화면
class _PlaceholderScreen extends ConsumerWidget {
  final String title;

  const _PlaceholderScreen({required this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = GoRouter.of(context);
    final currentPath = router.routerDelegate.currentConfiguration.uri.path;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // 바텀 네비게이션이 필요한 화면인지 확인
    // 홈 화면은 _HomeScreenWithBottomNav에서 이미 처리하므로 제외
    final needsBottomNav = [
      '/calendar',
      '/partner',
      '/profile',
    ].contains(currentPath);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: AppTypography.title3(
            color: isDark
                ? AppColors.textPrimaryDark
                : AppColors.textPrimaryLight,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$title 화면',
              style: AppTypography.title2(
                color: isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
              ),
            ),
            const SizedBox(height: AppSpacing.base),
            Text(
              '구현 예정',
              style: AppTypography.body4(
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondaryLight,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: needsBottomNav
          ? SayvlyBottomNavigationBar(currentPath: currentPath)
          : null,
    );
  }
}
