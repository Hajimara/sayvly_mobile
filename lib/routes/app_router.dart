import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/presentation/providers/auth_provider.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/auth/presentation/screens/signup_screen.dart';
import '../features/common/screens/splash_screen.dart';
import '../features/couple/presentation/screens/partner_screen.dart';
import '../features/cycle/presentation/screens/calendar_screen.dart';
import '../features/home/presentation/screens/home_screen.dart';
import '../features/notification/presentation/screens/notification_screen.dart';
import '../features/user/presentation/providers/user_provider.dart'
    show shouldShowOnboardingProvider;
import '../features/user/presentation/screens/account/account_management_screen.dart';
import '../features/user/presentation/screens/account/change_password_screen.dart';
import '../features/user/presentation/screens/account/devices_screen.dart';
import '../features/user/presentation/screens/account/withdraw_screen.dart';
import '../features/user/presentation/screens/onboarding/onboarding_screen.dart';
import '../features/user/presentation/screens/profile/edit_profile_screen.dart';
import '../features/user/presentation/screens/profile/profile_screen.dart';
import '../features/user/presentation/screens/settings/developer_test_screen.dart';
import '../features/user/presentation/screens/settings/settings_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);
  final shouldShowOnboarding = ref.watch(shouldShowOnboardingProvider);

  return GoRouter(
    initialLocation: '/splash',
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final path = state.matchedLocation;
      final isSplashRoute = path == '/splash';
      final isAuthRoute = path == '/login' || path == '/signup';
      final isOnboardingRoute = path == '/onboarding';
      final isDeveloperTestRoute = path == '/settings/developer-test';
      final isLoggedIn = authState.hasValue && authState.value != null;
      final isDeveloperTestEnabled =
          !kReleaseMode && defaultTargetPlatform == TargetPlatform.android;

      if (authState.isLoading) {
        return isSplashRoute ? null : '/splash';
      }

      if (isSplashRoute) {
        if (!isLoggedIn) return '/login';
        if (shouldShowOnboarding) return '/onboarding';
        return '/home';
      }

      if (!isLoggedIn) {
        if (!isAuthRoute && path != '/') {
          return '/login';
        }
        return null;
      }

      if (shouldShowOnboarding && !isOnboardingRoute) {
        return '/onboarding';
      }

      if (isAuthRoute) {
        return '/home';
      }

      if (!shouldShowOnboarding && isOnboardingRoute) {
        return '/home';
      }

      if (isDeveloperTestRoute && !isDeveloperTestEnabled) {
        return '/settings';
      }

      return null;
    },
    routes: [
      GoRoute(path: '/', redirect: (context, state) => '/splash'),
      GoRoute(
        path: '/splash',
        name: 'splash',
        pageBuilder: (context, state) =>
            NoTransitionPage(key: state.pageKey, child: const SplashScreen()),
      ),
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
      GoRoute(
        path: '/home',
        name: 'home',
        pageBuilder: (context, state) =>
            NoTransitionPage(key: state.pageKey, child: const HomeScreen()),
      ),
      GoRoute(
        path: '/calendar',
        name: 'calendar',
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const CalendarScreen(),
        ),
      ),
      GoRoute(
        path: '/partner',
        name: 'partner',
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const PartnerScreen(),
        ),
      ),
      GoRoute(
        path: '/settings',
        name: 'settings',
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const SettingsScreen(),
        ),
      ),
      GoRoute(
        path: '/settings/developer-test',
        name: 'developerTest',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const DeveloperTestScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
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
        path: '/notifications',
        name: 'notifications',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const NotificationScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
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
              position: Tween<Offset>(
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
              position: Tween<Offset>(
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
              position: Tween<Offset>(
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
              position: Tween<Offset>(
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
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text('페이지를 찾을 수 없어요: ${state.uri}'),
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
