import 'package:dio/dio.dart';

import '../../../../core/error/error_code.dart';
import '../../../../core/error/error_handler.dart';
import '../../../../core/network/dio_client.dart';
import '../models/cycle_calendar_models.dart';

class CycleRepository {
  final Dio _dio;

  CycleRepository({Dio? dio}) : _dio = dio ?? DioClient.instance;

  Future<MonthlyCalendarResponse> getMonthlyCalendar({
    required int year,
    required int month,
  }) async {
    try {
      final response = await _dio.get(
        '/calendar/monthly',
        queryParameters: {'year': year, 'month': month},
      );
      return MonthlyCalendarResponse.fromJson(
        response.data['data'] as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<DayDetailResponse> getDayDetail(DateTime date) async {
    try {
      final response = await _dio.get(
        '/calendar/day',
        queryParameters: {'date': _toDate(date)},
      );
      return DayDetailResponse.fromJson(
        response.data['data'] as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<CurrentCycleResponse> getCurrentCycle() async {
    try {
      final response = await _dio.get('/cycles/current');
      return CurrentCycleResponse.fromJson(
        response.data['data'] as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> startCycle({required DateTime startDate}) async {
    try {
      await _dio.post(
        '/cycles/start',
        data: {'startDate': _toDate(startDate), 'source': 'MANUAL'},
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<List<SymptomTypeItem>> getSymptomTypes() async {
    try {
      final response = await _dio.get('/symptoms/types');
      return (response.data['data'] as List<dynamic>? ?? const [])
          .map((e) => SymptomTypeItem.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> recordSymptom({
    required DateTime date,
    required String symptomType,
    required int intensity,
    String? timeOfDay,
    String? memo,
  }) async {
    try {
      await _dio.post(
        '/symptoms',
        data: {
          'recordDate': _toDate(date),
          'symptomType': symptomType,
          'intensity': intensity,
          if (timeOfDay != null) 'timeOfDay': timeOfDay,
          if (memo != null && memo.trim().isNotEmpty) 'memo': memo.trim(),
        },
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> endCycle({required DateTime endDate}) async {
    try {
      await _dio.post('/cycles/end', data: {'endDate': _toDate(endDate)});
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> updateCycleStartDate({
    required int cycleId,
    required DateTime startDate,
  }) async {
    try {
      await _dio.patch(
        '/cycles/$cycleId',
        data: {'startDate': _toDate(startDate)},
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> deleteCycle({required int cycleId}) async {
    try {
      await _dio.delete('/cycles/$cycleId');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<PredictedSymptomHistoryResponse> getPredictedSymptomHistory({
    required String symptomType,
    required String phase,
  }) async {
    try {
      final response = await _dio.get(
        '/symptoms/predictions/$symptomType/history',
        queryParameters: {'phase': phase},
      );
      return PredictedSymptomHistoryResponse.fromJson(
        response.data['data'] as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> recordPredictedSymptomNonOccurrence({
    required String symptomType,
    required DateTime date,
  }) async {
    try {
      await _dio.post(
        '/symptoms/predictions/not-occurred',
        data: {'symptomType': symptomType, 'date': _toDate(date)},
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    final appException = ErrorHandler.handle(e);

    if (appException is ServerException) {
      return CycleException(
        appException.userMessage,
        errorCode: appException.errorCode,
      );
    }

    return CycleException(appException.userMessage);
  }

  String _toDate(DateTime date) {
    final y = date.year.toString().padLeft(4, '0');
    final m = date.month.toString().padLeft(2, '0');
    final d = date.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }
}

class CycleException implements Exception {
  final String message;
  final ErrorCode? errorCode;

  CycleException(this.message, {this.errorCode});

  bool get isFutureDateNotAllowed =>
      errorCode == ErrorCode.futureDateNotAllowed;

  bool get isAlreadyRecordedForPhase =>
      errorCode == ErrorCode.alreadyRecordedForPhase;

  @override
  String toString() => message;
}
