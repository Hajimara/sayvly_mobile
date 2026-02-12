import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/error/error_handler_extension.dart';
import '../../data/models/settings_models.dart';
import '../../data/repositories/settings_repository.dart';

/// SettingsRepository Provider
final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  return SettingsRepository();
});

/// 설정 Notifier (AsyncNotifier 사용)
class SettingsNotifier extends AsyncNotifier<UserSettingsResponse> {
  @override
  Future<UserSettingsResponse> build() async {
    // 초기 로드 시 설정 조회
    return await ref.read(settingsRepositoryProvider).getSettings();
  }

  /// 설정 조회
  Future<void> loadSettings() async {
    state = const AsyncValue.loading();
    state = await AsyncErrorHandler.safeAsyncOperation(
      () => ref.read(settingsRepositoryProvider).getSettings(),
      context: 'Load Settings',
      ref: ref,
    );
  }

  /// 설정 수정
  Future<bool> updateSettings(UpdateSettingsRequest request) async {
    if (!state.hasValue) return false;

    state = const AsyncValue.loading();
    state = await AsyncErrorHandler.safeAsyncOperation(
      () => ref.read(settingsRepositoryProvider).updateSettings(request),
      context: 'Update Settings',
      ref: ref,
    );

    return state.hasValue;
  }

  /// 테마 변경
  Future<bool> updateTheme(ThemeMode theme) async {
    return updateSettings(UpdateSettingsRequest(theme: theme));
  }

  /// 언어 변경
  Future<bool> updateLanguage(String language) async {
    return updateSettings(UpdateSettingsRequest(language: language));
  }

  /// 알림 설정 토글
  Future<bool> toggleNotification({
    bool? periodReminder,
    bool? ovulation,
    bool? anniversary,
    bool? dailyRecord,
    bool? partnerPeriod,
    bool? partnerPms,
    bool? careTips,
  }) async {
    return updateSettings(UpdateSettingsRequest(
      notificationPeriodReminder: periodReminder,
      notificationOvulation: ovulation,
      notificationAnniversary: anniversary,
      notificationDailyRecord: dailyRecord,
      notificationPartnerPeriod: partnerPeriod,
      notificationPartnerPms: partnerPms,
      notificationCareTips: careTips,
    ));
  }

  /// 알림 시간 변경
  Future<bool> updateNotificationTime(String time) async {
    return updateSettings(UpdateSettingsRequest(notificationTime: time));
  }

  /// 방해금지 시간 설정
  Future<bool> updateDoNotDisturb({
    String? start,
    String? end,
  }) async {
    return updateSettings(UpdateSettingsRequest(
      doNotDisturbStart: start,
      doNotDisturbEnd: end,
    ));
  }

  /// 에러 상태 초기화
  void clearError() {
    if (state.hasError) {
      // 이전 값이 있으면 복원, 없으면 다시 로드
      if (state.hasValue) {
        state = AsyncValue.data(state.value!);
      } else {
        loadSettings();
      }
    }
  }
}

/// SettingsNotifier Provider
final settingsProvider =
    AsyncNotifierProvider<SettingsNotifier, UserSettingsResponse>(() {
  return SettingsNotifier();
});

/// 현재 설정 Provider
final currentSettingsProvider = Provider<UserSettingsResponse?>((ref) {
  final state = ref.watch(settingsProvider);
  return state.valueOrNull;
});

/// 현재 테마 Provider
final currentThemeProvider = Provider<ThemeMode?>((ref) {
  final settings = ref.watch(currentSettingsProvider);
  return settings?.theme;
});

/// 현재 언어 Provider
final currentLanguageProvider = Provider<String?>((ref) {
  final settings = ref.watch(currentSettingsProvider);
  return settings?.language;
});
