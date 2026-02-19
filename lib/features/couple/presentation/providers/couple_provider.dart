import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/couple_models.dart';
import '../../data/repositories/couple_repository.dart';

final coupleRepositoryProvider = Provider<CoupleRepository>((ref) {
  return CoupleRepository();
});

class CoupleState {
  final bool isLoading;
  final bool isSubmitting;
  final CoupleInfoModel? couple;
  final PartnerStatusModel? partnerStatus;
  final ShareSettingsModel? shareSettings;
  final PartnerCalendarDataModel? partnerCalendar;
  final UpcomingEventsModel? upcomingEvents;
  final DateTime? calendarMonth;
  final String? inviteCode;
  final String? errorMessage;

  const CoupleState({
    required this.isLoading,
    required this.isSubmitting,
    required this.couple,
    required this.partnerStatus,
    required this.shareSettings,
    required this.partnerCalendar,
    required this.upcomingEvents,
    required this.calendarMonth,
    required this.inviteCode,
    required this.errorMessage,
  });

  factory CoupleState.initial() {
    return const CoupleState(
      isLoading: true,
      isSubmitting: false,
      couple: null,
      partnerStatus: null,
      shareSettings: null,
      partnerCalendar: null,
      upcomingEvents: null,
      calendarMonth: null,
      inviteCode: null,
      errorMessage: null,
    );
  }

  CoupleState copyWith({
    bool? isLoading,
    bool? isSubmitting,
    CoupleInfoModel? couple,
    bool clearCouple = false,
    PartnerStatusModel? partnerStatus,
    bool clearPartnerStatus = false,
    ShareSettingsModel? shareSettings,
    bool clearShareSettings = false,
    PartnerCalendarDataModel? partnerCalendar,
    bool clearPartnerCalendar = false,
    UpcomingEventsModel? upcomingEvents,
    bool clearUpcomingEvents = false,
    DateTime? calendarMonth,
    bool clearCalendarMonth = false,
    String? inviteCode,
    bool clearInviteCode = false,
    String? errorMessage,
    bool clearError = false,
  }) {
    return CoupleState(
      isLoading: isLoading ?? this.isLoading,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      couple: clearCouple ? null : (couple ?? this.couple),
      partnerStatus: clearPartnerStatus
          ? null
          : (partnerStatus ?? this.partnerStatus),
      shareSettings: clearShareSettings
          ? null
          : (shareSettings ?? this.shareSettings),
      partnerCalendar: clearPartnerCalendar
          ? null
          : (partnerCalendar ?? this.partnerCalendar),
      upcomingEvents: clearUpcomingEvents
          ? null
          : (upcomingEvents ?? this.upcomingEvents),
      calendarMonth: clearCalendarMonth
          ? null
          : (calendarMonth ?? this.calendarMonth),
      inviteCode: clearInviteCode ? null : (inviteCode ?? this.inviteCode),
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

class CoupleNotifier extends StateNotifier<CoupleState> {
  final CoupleRepository _repository;

  CoupleNotifier(this._repository) : super(CoupleState.initial()) {
    initialize();
  }

  Future<void> initialize() async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final couple = await _repository.getCoupleInfo();
      if (couple == null) {
        state = state.copyWith(
          isLoading: false,
          clearCouple: true,
          clearPartnerStatus: true,
          clearShareSettings: true,
          clearPartnerCalendar: true,
          clearUpcomingEvents: true,
          clearCalendarMonth: true,
        );
        return;
      }

      final now = DateTime.now();
      final monthCursor = DateTime(now.year, now.month);
      final results = await Future.wait([
        _repository.getPartnerStatus(),
        _repository.getShareSettings(),
        _repository.getPartnerCalendar(year: now.year, month: now.month),
        _repository.getUpcomingEvents(),
      ]);

      state = state.copyWith(
        isLoading: false,
        couple: couple,
        partnerStatus: results[0] as PartnerStatusModel,
        shareSettings: results[1] as ShareSettingsModel,
        partnerCalendar: results[2] as PartnerCalendarDataModel,
        upcomingEvents: results[3] as UpcomingEventsModel,
        calendarMonth: monthCursor,
      );
    } on CoupleException catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.message);
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load partner information.',
      );
    }
  }

  Future<void> _reloadPartnerData({DateTime? month}) async {
    if (state.couple == null) return;
    final target = month ?? state.calendarMonth ?? DateTime.now();
    final monthCursor = DateTime(target.year, target.month);

    final results = await Future.wait([
      _repository.getPartnerStatus(),
      _repository.getPartnerCalendar(
        year: monthCursor.year,
        month: monthCursor.month,
      ),
      _repository.getUpcomingEvents(),
    ]);

    state = state.copyWith(
      partnerStatus: results[0] as PartnerStatusModel,
      partnerCalendar: results[1] as PartnerCalendarDataModel,
      upcomingEvents: results[2] as UpcomingEventsModel,
      calendarMonth: monthCursor,
    );
  }

  Future<void> loadPartnerCalendar(DateTime month) async {
    if (state.couple == null) return;
    final monthCursor = DateTime(month.year, month.month);
    state = state.copyWith(isSubmitting: true, clearError: true);
    try {
      final calendar = await _repository.getPartnerCalendar(
        year: monthCursor.year,
        month: monthCursor.month,
      );
      state = state.copyWith(
        isSubmitting: false,
        partnerCalendar: calendar,
        calendarMonth: monthCursor,
      );
    } on CoupleException catch (e) {
      state = state.copyWith(isSubmitting: false, errorMessage: e.message);
    } catch (_) {
      state = state.copyWith(
        isSubmitting: false,
        errorMessage: 'Failed to load partner calendar.',
      );
    }
  }

  Future<bool> createInviteCode() async {
    state = state.copyWith(isSubmitting: true, clearError: true);
    try {
      final invite = await _repository.createInviteCode();
      state = state.copyWith(isSubmitting: false, inviteCode: invite.code);
      return true;
    } on CoupleException catch (e) {
      state = state.copyWith(isSubmitting: false, errorMessage: e.message);
      return false;
    } catch (_) {
      state = state.copyWith(
        isSubmitting: false,
        errorMessage: 'Failed to create invite code.',
      );
      return false;
    }
  }

  Future<bool> connectByCode(String code) async {
    state = state.copyWith(isSubmitting: true, clearError: true);
    try {
      await _repository.connectByCode(code.trim().toUpperCase());
      await initialize();
      state = state.copyWith(isSubmitting: false);
      return true;
    } on CoupleException catch (e) {
      state = state.copyWith(isSubmitting: false, errorMessage: e.message);
      return false;
    } catch (_) {
      state = state.copyWith(
        isSubmitting: false,
        errorMessage: 'Failed to connect partner.',
      );
      return false;
    }
  }

  Future<bool> disconnect() async {
    state = state.copyWith(isSubmitting: true, clearError: true);
    try {
      await _repository.disconnect();
      state = state.copyWith(
        isSubmitting: false,
        clearCouple: true,
        clearPartnerStatus: true,
        clearShareSettings: true,
        clearPartnerCalendar: true,
        clearUpcomingEvents: true,
        clearCalendarMonth: true,
        clearInviteCode: true,
      );
      return true;
    } on CoupleException catch (e) {
      state = state.copyWith(isSubmitting: false, errorMessage: e.message);
      return false;
    } catch (_) {
      state = state.copyWith(
        isSubmitting: false,
        errorMessage: 'Failed to disconnect partner.',
      );
      return false;
    }
  }

  Future<bool> toggleShareSetting({
    required String key,
    required bool value,
  }) async {
    final settings = state.shareSettings;
    if (settings == null) return false;

    ShareSettingsModel next = settings;
    switch (key) {
      case 'periodExpected':
        next = settings.copyWith(sharePeriodExpected: value);
        break;
      case 'periodCurrent':
        next = settings.copyWith(sharePeriodCurrent: value);
        break;
      case 'periodProgress':
        next = settings.copyWith(sharePeriodProgress: value);
        break;
      case 'pms':
        next = settings.copyWith(sharePms: value);
        break;
      case 'fertile':
        next = settings.copyWith(shareFertile: value);
        break;
      case 'condition':
        next = settings.copyWith(shareCondition: value);
        break;
      case 'anniversary':
        next = settings.copyWith(shareAnniversary: value);
        break;
      default:
        return false;
    }

    state = state.copyWith(isSubmitting: true, clearError: true);
    try {
      final saved = await _repository.updateShareSettings(next);
      state = state.copyWith(shareSettings: saved);
      await _reloadPartnerData();
      state = state.copyWith(isSubmitting: false);
      return true;
    } on CoupleException catch (e) {
      state = state.copyWith(isSubmitting: false, errorMessage: e.message);
      return false;
    } catch (_) {
      state = state.copyWith(
        isSubmitting: false,
        errorMessage: 'Failed to update share settings.',
      );
      return false;
    }
  }
}

final coupleProvider = StateNotifierProvider<CoupleNotifier, CoupleState>((ref) {
  return CoupleNotifier(ref.watch(coupleRepositoryProvider));
});
