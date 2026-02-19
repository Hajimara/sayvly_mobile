import 'package:dio/dio.dart';

import '../../../../core/error/error_code.dart';
import '../../../../core/error/error_handler.dart';
import '../../../../core/network/dio_client.dart';
import '../models/couple_models.dart';

class CoupleRepository {
  final Dio _dio;

  CoupleRepository({Dio? dio}) : _dio = dio ?? DioClient.instance;

  Future<CoupleInfoModel?> getCoupleInfo() async {
    try {
      final response = await _dio.get('/couple');
      final data = response.data['data'];
      if (data == null) return null;
      return CoupleInfoModel.fromJson(data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<InviteResponseModel> createInviteCode() async {
    try {
      final response = await _dio.post('/couple/invite');
      return InviteResponseModel.fromJson(
        response.data['data'] as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<CoupleInfoModel> connectByCode(String code) async {
    try {
      final response = await _dio.post('/couple/connect', data: {'code': code});
      return CoupleInfoModel.fromJson(
        response.data['data'] as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> disconnect() async {
    try {
      await _dio.delete('/couple');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<ShareSettingsModel> getShareSettings() async {
    try {
      final response = await _dio.get('/couple/share-settings');
      return ShareSettingsModel.fromJson(
        response.data['data'] as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<ShareSettingsModel> updateShareSettings(ShareSettingsModel settings) async {
    try {
      final response = await _dio.patch(
        '/couple/share-settings',
        data: settings.toPatchJson(),
      );
      return ShareSettingsModel.fromJson(
        response.data['data'] as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<PartnerStatusModel> getPartnerStatus() async {
    try {
      final response = await _dio.get('/partner/status');
      return PartnerStatusModel.fromJson(
        response.data['data'] as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<PartnerCalendarDataModel> getPartnerCalendar({
    required int year,
    required int month,
  }) async {
    try {
      final response = await _dio.get(
        '/partner/calendar',
        queryParameters: {'year': year, 'month': month},
      );
      return PartnerCalendarDataModel.fromJson(
        response.data['data'] as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<UpcomingEventsModel> getUpcomingEvents() async {
    try {
      final response = await _dio.get('/partner/upcoming');
      return UpcomingEventsModel.fromJson(
        response.data['data'] as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    final appException = ErrorHandler.handle(e);

    if (appException is ServerException) {
      return CoupleException(
        appException.userMessage,
        errorCode: appException.errorCode,
      );
    }

    return CoupleException(appException.userMessage);
  }
}

class CoupleException implements Exception {
  final String message;
  final ErrorCode? errorCode;

  CoupleException(this.message, {this.errorCode});

  @override
  String toString() => message;
}
