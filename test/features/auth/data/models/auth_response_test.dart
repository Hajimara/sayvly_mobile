import 'package:flutter_test/flutter_test.dart';
import 'package:sayvly_mobile/features/auth/data/models/auth_response.dart';

void main() {
  group('AuthResponse', () {
    test('fromJson 백엔드 응답 파싱', () {
      // 백엔드 AuthResponse와 동일한 구조
      final json = {
        'userId': 123,
        'accessToken': 'access_token_value',
        'refreshToken': 'refresh_token_value',
        'expiresIn': 3600000,
        'isNewUser': false,
      };

      final response = AuthResponse.fromJson(json);

      expect(response.userId, 123);
      expect(response.accessToken, 'access_token_value');
      expect(response.refreshToken, 'refresh_token_value');
      expect(response.expiresIn, 3600000);
      expect(response.isNewUser, false);
    });

    test('fromJson isNewUser 기본값 false', () {
      final json = {
        'userId': 1,
        'accessToken': 'token',
        'refreshToken': 'refresh',
        'expiresIn': 3600,
        // isNewUser 없음
      };

      final response = AuthResponse.fromJson(json);

      expect(response.isNewUser, false);
    });

    test('fromJson 신규 사용자', () {
      final json = {
        'userId': 1,
        'accessToken': 'token',
        'refreshToken': 'refresh',
        'expiresIn': 3600,
        'isNewUser': true,
      };

      final response = AuthResponse.fromJson(json);

      expect(response.isNewUser, true);
    });

    test('toJson 직렬화', () {
      const response = AuthResponse(
        userId: 456,
        accessToken: 'access',
        refreshToken: 'refresh',
        expiresIn: 7200,
        isNewUser: true,
      );

      final json = response.toJson();

      expect(json['userId'], 456);
      expect(json['accessToken'], 'access');
      expect(json['refreshToken'], 'refresh');
      expect(json['expiresIn'], 7200);
      expect(json['isNewUser'], true);
    });

    test('copyWith', () {
      const original = AuthResponse(
        userId: 1,
        accessToken: 'old_access',
        refreshToken: 'old_refresh',
        expiresIn: 3600,
      );

      final copied = original.copyWith(
        accessToken: 'new_access',
        refreshToken: 'new_refresh',
      );

      expect(copied.userId, 1); // 변경 안됨
      expect(copied.accessToken, 'new_access'); // 변경됨
      expect(copied.refreshToken, 'new_refresh'); // 변경됨
      expect(copied.expiresIn, 3600); // 변경 안됨
    });

    test('equality', () {
      const response1 = AuthResponse(
        userId: 1,
        accessToken: 'token',
        refreshToken: 'refresh',
        expiresIn: 3600,
      );

      const response2 = AuthResponse(
        userId: 1,
        accessToken: 'token',
        refreshToken: 'refresh',
        expiresIn: 3600,
      );

      expect(response1, response2);
      expect(response1.hashCode, response2.hashCode);
    });
  });
}
