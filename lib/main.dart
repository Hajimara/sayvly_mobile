import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/error/error_observer.dart';
import 'core/error/global_error_handler.dart';
import 'core/locale/locale_provider.dart';
import 'core/notification/fcm_service.dart';
import 'core/theme/theme.dart';
import 'routes/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FcmService.initialize();

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
    final locale = ref.watch(localeProvider);

    return MaterialApp.router(
      title: 'Sayvly',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      locale: locale,
      supportedLocales: const [
        Locale('ko'),
        Locale('en'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: router,
      builder: (context, child) {
        return GlobalErrorHandler(
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}
