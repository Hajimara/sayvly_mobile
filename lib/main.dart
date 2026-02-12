import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/theme.dart';
import 'core/error/error_observer.dart';
import 'core/error/global_error_handler.dart';
import 'routes/app_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // ProviderScope 생성 (Observer는 나중에 등록)
  final container = ProviderContainer(
    observers: [
      ErrorObserver(ProviderContainer()),
    ],
  );
  
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const SayvlyApp(),
    ),
  );
}

class SayvlyApp extends ConsumerWidget {
  const SayvlyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'Sayvly',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      routerConfig: router,
      builder: (context, child) {
        return GlobalErrorHandler(
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}
