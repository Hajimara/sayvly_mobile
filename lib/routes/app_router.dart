import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../features/auth/presentation/providers/auth_provider.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/auth/presentation/screens/signup_screen.dart';

/// 앱 라우터 Provider
final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: '/login',
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isLoggedIn = authState is AuthAuthenticated;
      final isAuthRoute = state.matchedLocation == '/login' ||
          state.matchedLocation == '/signup';

      // 로그인된 상태에서 인증 화면 접근 시 홈으로 리다이렉트
      if (isLoggedIn && isAuthRoute) {
        return '/home';
      }

      // 비로그인 상태에서 인증이 필요한 화면 접근 시 로그인으로 리다이렉트
      if (!isLoggedIn && !isAuthRoute && state.matchedLocation != '/') {
        return '/login';
      }

      return null;
    },
    routes: [
      // 루트 경로
      GoRoute(
        path: '/',
        redirect: (context, state) => '/login',
      ),

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

      // 온보딩 (TODO: 구현 필요)
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (context, state) => const _PlaceholderScreen(title: '온보딩'),
      ),

      // 홈 (TODO: 구현 필요)
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const _PlaceholderScreen(title: '홈'),
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
            if (title == '홈')
              ElevatedButton(
                onPressed: () {
                  context.read<AuthNotifier>().logout();
                  context.go('/login');
                },
                child: const Text('로그아웃'),
              ),
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
