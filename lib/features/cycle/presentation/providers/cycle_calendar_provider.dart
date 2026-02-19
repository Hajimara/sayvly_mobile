import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/cycle_calendar_models.dart';
import '../../data/repositories/cycle_repository.dart';

final cycleRepositoryProvider = Provider<CycleRepository>((ref) {
  return CycleRepository();
});

class CycleCalendarState {
  final DateTime focusedMonth;
  final DateTime selectedDate;
  final MonthlyCalendarResponse? monthly;
  final DayDetailResponse? dayDetail;
  final CurrentCycleResponse? currentCycle;
  final bool isLoadingMonth;
  final bool isLoadingDay;
  final bool isSubmitting;
  final String? errorMessage;
  final List<SymptomTypeItem> symptomTypes;

  const CycleCalendarState({
    required this.focusedMonth,
    required this.selectedDate,
    required this.monthly,
    required this.dayDetail,
    required this.currentCycle,
    required this.isLoadingMonth,
    required this.isLoadingDay,
    required this.isSubmitting,
    required this.errorMessage,
    required this.symptomTypes,
  });

  factory CycleCalendarState.initial() {
    final now = DateTime.now();
    final normalized = DateTime(now.year, now.month, now.day);
    return CycleCalendarState(
      focusedMonth: DateTime(now.year, now.month, 1),
      selectedDate: normalized,
      monthly: null,
      dayDetail: null,
      currentCycle: null,
      isLoadingMonth: true,
      isLoadingDay: true,
      isSubmitting: false,
      errorMessage: null,
      symptomTypes: const [],
    );
  }

  CycleCalendarState copyWith({
    DateTime? focusedMonth,
    DateTime? selectedDate,
    MonthlyCalendarResponse? monthly,
    bool clearMonthly = false,
    DayDetailResponse? dayDetail,
    bool clearDayDetail = false,
    CurrentCycleResponse? currentCycle,
    bool clearCurrentCycle = false,
    bool? isLoadingMonth,
    bool? isLoadingDay,
    bool? isSubmitting,
    String? errorMessage,
    bool clearError = false,
    List<SymptomTypeItem>? symptomTypes,
  }) {
    return CycleCalendarState(
      focusedMonth: focusedMonth ?? this.focusedMonth,
      selectedDate: selectedDate ?? this.selectedDate,
      monthly: clearMonthly ? null : (monthly ?? this.monthly),
      dayDetail: clearDayDetail ? null : (dayDetail ?? this.dayDetail),
      currentCycle: clearCurrentCycle
          ? null
          : (currentCycle ?? this.currentCycle),
      isLoadingMonth: isLoadingMonth ?? this.isLoadingMonth,
      isLoadingDay: isLoadingDay ?? this.isLoadingDay,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      symptomTypes: symptomTypes ?? this.symptomTypes,
    );
  }
}

class CycleCalendarNotifier extends StateNotifier<CycleCalendarState> {
  final CycleRepository _repository;

  CycleCalendarNotifier(this._repository)
    : super(CycleCalendarState.initial()) {
    initialize();
  }

  Future<void> initialize() async {
    final month = state.focusedMonth;
    final selectedDate = state.selectedDate;

    await Future.wait([
      _loadMonthly(month, clearError: true),
      _loadDayDetail(selectedDate, clearError: true),
      _loadCurrentCycle(clearError: true),
      _loadSymptomTypes(clearError: true),
    ]);
  }

  Future<void> refreshAll() async {
    await Future.wait([
      _loadMonthly(state.focusedMonth, clearError: true),
      _loadDayDetail(state.selectedDate, clearError: true),
      _loadCurrentCycle(clearError: true),
    ]);
  }

  Future<void> goToPreviousMonth() async {
    final target = DateTime(
      state.focusedMonth.year,
      state.focusedMonth.month - 1,
      1,
    );
    state = state.copyWith(
      focusedMonth: target,
      isLoadingMonth: true,
      clearError: true,
    );
    await _loadMonthly(target);
  }

  Future<void> goToNextMonth() async {
    final target = DateTime(
      state.focusedMonth.year,
      state.focusedMonth.month + 1,
      1,
    );
    state = state.copyWith(
      focusedMonth: target,
      isLoadingMonth: true,
      clearError: true,
    );
    await _loadMonthly(target);
  }

  Future<void> goToToday() async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final currentMonth = DateTime(now.year, now.month, 1);

    state = state.copyWith(
      focusedMonth: currentMonth,
      selectedDate: today,
      isLoadingMonth: true,
      isLoadingDay: true,
      clearError: true,
    );

    await Future.wait([
      _loadMonthly(currentMonth),
      _loadDayDetail(today),
    ]);
  }

  Future<void> selectDate(DateTime date) async {
    final normalized = DateTime(date.year, date.month, date.day);
    state = state.copyWith(
      selectedDate: normalized,
      isLoadingDay: true,
      clearError: true,
    );
    await _loadDayDetail(normalized);
  }

  Future<bool> startCycleToday() async {
    return startCycleOn(DateTime.now());
  }

  Future<bool> startCycleOn(DateTime date) async {
    state = state.copyWith(isSubmitting: true, clearError: true);
    try {
      await _repository.startCycle(startDate: date);
      await refreshAll();
      return true;
    } on CycleException catch (e) {
      state = state.copyWith(errorMessage: e.message, isSubmitting: false);
      return false;
    } catch (_) {
      state = state.copyWith(
        errorMessage: '생리 시작 처리 중 오류가 발생했습니다.',
        isSubmitting: false,
      );
      return false;
    }
  }

  Future<bool> endCycleToday() async {
    return endCycleOn(DateTime.now());
  }

  Future<bool> endCycleOn(DateTime date) async {
    state = state.copyWith(isSubmitting: true, clearError: true);
    try {
      await _repository.endCycle(endDate: date);
      await refreshAll();
      return true;
    } on CycleException catch (e) {
      state = state.copyWith(errorMessage: e.message, isSubmitting: false);
      return false;
    } catch (_) {
      state = state.copyWith(
        errorMessage: '생리 종료 처리 중 오류가 발생했습니다.',
        isSubmitting: false,
      );
      return false;
    }
  }

  Future<bool> updateCycleStartDate({
    required int cycleId,
    required DateTime startDate,
  }) async {
    state = state.copyWith(isSubmitting: true, clearError: true);
    try {
      await _repository.updateCycleStartDate(
        cycleId: cycleId,
        startDate: startDate,
      );
      await refreshAll();
      return true;
    } on CycleException catch (e) {
      state = state.copyWith(errorMessage: e.message, isSubmitting: false);
      return false;
    } catch (_) {
      state = state.copyWith(
        errorMessage: '생리 시작일 수정 중 오류가 발생했습니다.',
        isSubmitting: false,
      );
      return false;
    }
  }

  Future<bool> deleteCycle(int cycleId) async {
    state = state.copyWith(isSubmitting: true, clearError: true);
    try {
      await _repository.deleteCycle(cycleId: cycleId);
      await refreshAll();
      return true;
    } on CycleException catch (e) {
      state = state.copyWith(errorMessage: e.message, isSubmitting: false);
      return false;
    } catch (_) {
      state = state.copyWith(
        errorMessage: '생리 기록 삭제 중 오류가 발생했습니다.',
        isSubmitting: false,
      );
      return false;
    }
  }

  Future<PredictedSymptomHistoryResponse> getPredictedSymptomHistory({
    required String symptomType,
    required String phase,
  }) {
    return _repository.getPredictedSymptomHistory(
      symptomType: symptomType,
      phase: phase,
    );
  }

  Future<bool> recordSymptomOn({
    required DateTime date,
    required String symptomType,
    required int intensity,
    String? timeOfDay,
    String? memo,
  }) async {
    state = state.copyWith(isSubmitting: true, clearError: true);
    try {
      await _repository.recordSymptom(
        date: date,
        symptomType: symptomType,
        intensity: intensity,
        timeOfDay: timeOfDay,
        memo: memo,
      );
      await _loadDayDetail(state.selectedDate);
      await _loadMonthly(state.focusedMonth);
      state = state.copyWith(isSubmitting: false);
      return true;
    } on CycleException catch (e) {
      state = state.copyWith(isSubmitting: false, errorMessage: e.message);
      return false;
    } catch (_) {
      state = state.copyWith(
        isSubmitting: false,
        errorMessage: '증상 기록 처리 중 오류가 발생했습니다.',
      );
      return false;
    }
  }

  Future<List<SymptomTypeItem>> getSymptomTypes() async {
    if (state.symptomTypes.isNotEmpty) {
      return state.symptomTypes;
    }
    await _loadSymptomTypes(clearError: true);
    return state.symptomTypes;
  }

  Future<bool> recordNonOccurrence(String symptomType) async {
    state = state.copyWith(isSubmitting: true, clearError: true);
    try {
      await _repository.recordPredictedSymptomNonOccurrence(
        symptomType: symptomType,
        date: state.selectedDate,
      );
      await _loadDayDetail(state.selectedDate);
      await _loadMonthly(state.focusedMonth);
      state = state.copyWith(isSubmitting: false);
      return true;
    } on CycleException catch (e) {
      state = state.copyWith(isSubmitting: false, errorMessage: e.message);
      return false;
    } catch (_) {
      state = state.copyWith(
        isSubmitting: false,
        errorMessage: '예상 증상 기록 처리 중 오류가 발생했습니다.',
      );
      return false;
    }
  }

  Future<void> _loadMonthly(DateTime month, {bool clearError = false}) async {
    state = state.copyWith(isLoadingMonth: true, clearError: clearError);

    try {
      final monthly = await _repository.getMonthlyCalendar(
        year: month.year,
        month: month.month,
      );
      state = state.copyWith(monthly: monthly, isLoadingMonth: false);
    } on CycleException catch (e) {
      state = state.copyWith(isLoadingMonth: false, errorMessage: e.message);
    } catch (_) {
      state = state.copyWith(
        isLoadingMonth: false,
        errorMessage: '캘린더 데이터를 불러오지 못했습니다.',
      );
    }
  }

  Future<void> _loadDayDetail(DateTime date, {bool clearError = false}) async {
    state = state.copyWith(isLoadingDay: true, clearError: clearError);

    try {
      final detail = await _repository.getDayDetail(date);
      state = state.copyWith(dayDetail: detail, isLoadingDay: false);
    } on CycleException catch (e) {
      state = state.copyWith(isLoadingDay: false, errorMessage: e.message);
    } catch (_) {
      state = state.copyWith(
        isLoadingDay: false,
        errorMessage: '일별 상세 데이터를 불러오지 못했습니다.',
      );
    }
  }

  Future<void> _loadCurrentCycle({bool clearError = false}) async {
    try {
      final current = await _repository.getCurrentCycle();
      state = state.copyWith(
        currentCycle: current,
        isSubmitting: false,
        clearError: clearError,
      );
    } on CycleException catch (e) {
      state = state.copyWith(errorMessage: e.message, isSubmitting: false);
    } catch (_) {
      state = state.copyWith(
        errorMessage: '현재 주기 정보를 불러오지 못했습니다.',
        isSubmitting: false,
      );
    }
  }

  Future<void> _loadSymptomTypes({bool clearError = false}) async {
    try {
      final types = await _repository.getSymptomTypes();
      state = state.copyWith(symptomTypes: types, clearError: clearError);
    } on CycleException catch (e) {
      state = state.copyWith(errorMessage: e.message);
    } catch (_) {
      state = state.copyWith(errorMessage: '증상 목록을 불러오지 못했습니다.');
    }
  }
}

final cycleCalendarProvider =
    StateNotifierProvider<CycleCalendarNotifier, CycleCalendarState>((ref) {
      return CycleCalendarNotifier(ref.watch(cycleRepositoryProvider));
    });
