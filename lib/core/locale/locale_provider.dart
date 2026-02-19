import 'dart:ui';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../network/dio_client.dart';
import '../storage/local_storage.dart';

class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier() : super(const Locale('ko')) {
    _initializeLocale();
  }

  LocalStorage? _localStorage;

  Future<void> _initializeLocale() async {
    _localStorage ??= await LocalStorage.getInstance();

    final savedLanguage = _localStorage!.getLanguage();
    if (savedLanguage != null) {
      state = Locale(savedLanguage);
      DioClient.setLanguage(savedLanguage);
      return;
    }

    final systemLocale = PlatformDispatcher.instance.locale;
    final languageCode = systemLocale.languageCode;

    if (languageCode == 'ko' || languageCode == 'en') {
      state = Locale(languageCode);
      DioClient.setLanguage(languageCode);
      await _localStorage!.saveLanguage(languageCode);
    } else {
      state = const Locale('ko');
      DioClient.setLanguage('ko');
      await _localStorage!.saveLanguage('ko');
    }
  }

  Future<void> setLocale(Locale locale) async {
    state = locale;
    DioClient.setLanguage(locale.languageCode);
    _localStorage ??= await LocalStorage.getInstance();
    await _localStorage!.saveLanguage(locale.languageCode);
  }

  List<Locale> get supportedLocales => const [
    Locale('ko'),
    Locale('en'),
  ];
}

final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  return LocaleNotifier();
});
