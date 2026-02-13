import 'dart:ui';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../storage/local_storage.dart';

/// Locale Notifier
/// 시스템 언어 감지 및 저장된 언어 사용
class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier() : super(const Locale('ko')) {
    _initializeLocale();
  }

  LocalStorage? _localStorage;

  /// 초기화: 저장된 언어 또는 시스템 언어 사용
  Future<void> _initializeLocale() async {
    _localStorage ??= await LocalStorage.getInstance();
    
    // 저장된 언어가 있으면 사용
    final savedLanguage = _localStorage!.getLanguage();
    if (savedLanguage != null) {
      state = Locale(savedLanguage);
      return;
    }

    // 저장된 언어가 없으면 시스템 언어 사용
    final systemLocale = PlatformDispatcher.instance.locale;
    final languageCode = systemLocale.languageCode;
    
    // 지원하는 언어인지 확인 (ko, en만 지원)
    if (languageCode == 'ko' || languageCode == 'en') {
      state = Locale(languageCode);
      // 시스템 언어를 저장
      await _localStorage!.saveLanguage(languageCode);
    } else {
      // 지원하지 않는 언어면 기본값(한국어) 사용
      state = const Locale('ko');
      await _localStorage!.saveLanguage('ko');
    }
  }

  /// 언어 변경
  Future<void> setLocale(Locale locale) async {
    state = locale;
    _localStorage ??= await LocalStorage.getInstance();
    await _localStorage!.saveLanguage(locale.languageCode);
  }

  /// 지원하는 언어 목록
  List<Locale> get supportedLocales => const [
    Locale('ko'),
    Locale('en'),
  ];
}

/// Locale Provider
final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  return LocaleNotifier();
});
