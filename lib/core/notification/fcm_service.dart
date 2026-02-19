import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

import '../network/dio_client.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp();
  }
}

class FcmService {
  FcmService._();

  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final Dio _dio = DioClient.instance;
  static StreamSubscription<String>? _tokenRefreshSubscription;
  static bool _initialized = false;

  static Future<void> initialize() async {
    if (_initialized || kIsWeb) return;

    try {
      if (Firebase.apps.isEmpty) {
        await Firebase.initializeApp();
      }

      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
      await _requestPermission();
      await registerCurrentToken();

      _tokenRefreshSubscription ??= _messaging.onTokenRefresh.listen((token) {
        unawaited(_registerToken(token));
      });

      _initialized = true;
    } catch (e) {
      debugPrint('[FCM] initialize failed: $e');
    }
  }

  static Future<void> registerCurrentToken() async {
    if (kIsWeb) return;

    try {
      final token = await _messaging.getToken();
      if (token == null || token.isEmpty) {
        debugPrint('[FCM] token is empty');
        return;
      }

      await _registerToken(token);
    } catch (e) {
      debugPrint('[FCM] registerCurrentToken failed: $e');
    }
  }

  static Future<void> _requestPermission() async {
    await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );
  }

  static Future<void> _registerToken(String token) async {
    final platform = Platform.isIOS ? 'IOS' : 'ANDROID';
    final deviceInfo = 'Flutter ${Platform.operatingSystem} ${Platform.operatingSystemVersion}';

    await _dio.post(
      '/devices/token',
      data: {
        'token': token,
        'platform': platform,
        'deviceInfo': deviceInfo,
      },
    );
    debugPrint('[FCM] token registered');
  }
}
