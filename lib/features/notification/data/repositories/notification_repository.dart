import 'package:dio/dio.dart';

import '../../../../core/error/error_code.dart';
import '../../../../core/error/error_handler.dart';
import '../../../../core/network/dio_client.dart';
import '../models/notification_models.dart';

class NotificationRepository {
  final Dio _dio;

  NotificationRepository({Dio? dio}) : _dio = dio ?? DioClient.instance;

  Future<List<NotificationItemModel>> getNotifications({
    int page = 0,
    int size = 20,
  }) async {
    try {
      final response = await _dio.get(
        '/notifications',
        queryParameters: {'page': page, 'size': size},
      );
      final raw = response.data['data'] as List<dynamic>? ?? const [];
      return raw
          .map(
            (item) => NotificationItemModel.fromJson(
              item as Map<String, dynamic>? ?? const {},
            ),
          )
          .toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<UnreadCountModel> getUnreadCount() async {
    try {
      final response = await _dio.get('/notifications/unread-count');
      return UnreadCountModel.fromJson(
        response.data['data'] as Map<String, dynamic>? ?? const {},
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> markAsRead(int id) async {
    try {
      await _dio.post('/notifications/$id/read');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> markAllAsRead() async {
    try {
      await _dio.post('/notifications/read-all');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> deleteNotification(int id) async {
    try {
      await _dio.delete('/notifications/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> sendTestPush() async {
    try {
      await _dio.post('/notifications/test-push');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    final appException = ErrorHandler.handle(e);

    if (appException is ServerException) {
      return NotificationException(
        appException.userMessage,
        errorCode: appException.errorCode,
      );
    }

    return NotificationException(appException.userMessage);
  }
}

class NotificationException implements Exception {
  final String message;
  final ErrorCode? errorCode;

  NotificationException(this.message, {this.errorCode});

  @override
  String toString() => message;
}
