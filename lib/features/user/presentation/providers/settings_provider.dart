import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/settings_models.dart';
import '../../data/repositories/settings_repository.dart';

/// SettingsRepository Provider
final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  return SettingsRepository();
});

/// 설정 상태
sealed class SettingsState {
  const SettingsState();
}

class SettingsInitial extends SettingsState {
  const SettingsInitial();
}

class SettingsLoading extends SettingsState {
  const SettingsLoading();
}

class SettingsLoaded extends SettingsState {
  final UserSettingsResponse settings;
  const SettingsLoaded(this.settings);
}

class SettingsError extends SettingsState {
  final String message;
  final String? errorCode;
  const SettingsError(this.message, {this.errorCode});
}

/// 설정 Notifier
class SettingsNotifier extends StateNotifier<SettingsState> {
  final SettingsRepository _repository;

  SettingsNotifier(this._repository) : super(const SettingsInitial());

  /// 설정 조회
  Future<void> loadSettings() async {
    state = const SettingsLoading();
    try {
      final settings = await _repository.getSettings();
      state = SettingsLoaded(settings);
    } on SettingsException catch (e) {
      state = SettingsError(e.message, errorCode: e.errorCode);
    } catch (e) {
      state = SettingsError(e.toString());
    }
  }

  /// 설정 수정
  Future<bool> updateSettings(UpdateSettingsRequest request) async {
    final currentState = state;
    if (currentState is! SettingsLoaded) return false;

    state = const SettingsLoading();
    try {
      final settings = await _repository.updateSettings(request);
      state = SettingsLoaded(settings);
      return true;
    } on SettingsException catch (e) {
      state = SettingsError(e.message, errorCode: e.errorCode);
      return false;
    } catch (e) {
      state = SettingsError(e.toString());
      return false;
    }
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
    if (state is SettingsError) {
      state = const SettingsInitial();
    }
  }
}

/// SettingsNotifier Provider
final settingsProvider =
    StateNotifierProvider<SettingsNotifier, SettingsState>((ref) {
  final repository = ref.watch(settingsRepositoryProvider);
  return SettingsNotifier(repository);
});

/// 현재 설정 Provider (Loaded 상태에서만 값 반환)
final currentSettingsProvider = Provider<UserSettingsResponse?>((ref) {
  final state = ref.watch(settingsProvider);
  if (state is SettingsLoaded) {
    return state.settings;
  }
  return null;
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
