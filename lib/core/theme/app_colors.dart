import 'package:flutter/material.dart';

/// Sayvly 앱 컬러 시스템
/// 디자인 컨셉: 따뜻함 + 신뢰 + 연결
class AppColors {
  AppColors._();

  // ============================================
  // Brand Colors
  // ============================================

  /// Primary: Coral Red - 생리, 여성성, 따뜻함
  static const Color primary = Color(0xFFFF6B6B);
  static const MaterialColor primarySwatch = MaterialColor(0xFFFF6B6B, {
    50: Color(0xFFFFF9F9),
    100: Color(0xFFFFF0F0),
    200: Color(0xFFFFE5E5),
    300: Color(0xFFFFD4D4),
    400: Color(0xFFFFBDBD),
    500: Color(0xFFFF6B6B),
    600: Color(0xFFE85555),
    700: Color(0xFFD14040),
    800: Color(0xFFB82D2D),
    900: Color(0xFF9A1F1F),
  });

  /// Secondary: Mint Teal - 파트너, 연결, 신선함
  static const Color secondary = Color(0xFF4ECDC4);
  static const MaterialColor secondarySwatch = MaterialColor(0xFF4ECDC4, {
    50: Color(0xFFF0FDFB),
    100: Color(0xFFE0FAF7),
    200: Color(0xFFCCF5F1),
    300: Color(0xFFB3EFE9),
    400: Color(0xFF4ECDC4),
    500: Color(0xFF3EBDB4),
    600: Color(0xFF2FA8A0),
    700: Color(0xFF238E87),
    800: Color(0xFF18736D),
    900: Color(0xFF0F5954),
  });

  /// Accent: Soft Purple - 배란, 프리미엄
  static const Color accent = Color(0xFF9B59B6);
  static const MaterialColor accentSwatch = MaterialColor(0xFF9B59B6, {
    50: Color(0xFFF9F5FB),
    100: Color(0xFFF3EBF7),
    200: Color(0xFFEBDFF2),
    300: Color(0xFFDFD0EA),
    400: Color(0xFFB085CF),
    500: Color(0xFF9B59B6),
    600: Color(0xFF8A4AA3),
    700: Color(0xFF763D8D),
    800: Color(0xFF613075),
    900: Color(0xFF4B255B),
  });

  // ============================================
  // Semantic Colors (캘린더)
  // ============================================

  /// 생리 기간
  static const Color menstruation = Color(0xFFFF6B6B);
  static const Color menstruationDark = Color(0xFFFF8E8E);

  /// 배란일
  static const Color ovulation = Color(0xFF9B59B6);
  static const Color ovulationDark = Color(0xFFB085CF);

  /// 가임기
  static const Color fertile = Color(0xFF3498DB);
  static const Color fertileDark = Color(0xFF5DADE2);

  /// 안전기
  static const Color safe = Color(0xFF2ECC71);
  static const Color safeDark = Color(0xFF58D68D);

  /// PMS 기간
  static const Color pms = Color(0xFFF39C12);
  static const Color pmsDark = Color(0xFFF5B041);

  // ============================================
  // Neutral Colors
  // ============================================

  /// Light Mode
  static const Color backgroundLight = Color(0xFFFFF9F9);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color textPrimaryLight = Color(0xFF2D3436);
  static const Color textSecondaryLight = Color(0xFF636E72);
  static const Color borderLight = Color(0xFFE0E0E0);

  /// Dark Mode
  static const Color backgroundDark = Color(0xFF1A1A1A);
  static const Color surfaceDark = Color(0xFF2D2D2D);
  static const Color textPrimaryDark = Color(0xFFF5F5F5);
  static const Color textSecondaryDark = Color(0xFFB0B0B0);
  static const Color borderDark = Color(0xFF404040);

  // ============================================
  // Gray Scale
  // ============================================

  static const Color gray10 = Color(0xFFF6F6F6);
  static const Color gray30 = Color(0xFFF3F3F3);
  static const Color gray60 = Color(0xFFEEEEEE);
  static const Color gray100 = Color(0xFFD9D9D9);
  static const Color gray200 = Color(0xFFC5C5C5);
  static const Color gray300 = Color(0xFFABABAB);
  static const Color gray400 = Color(0xFF969696);
  static const Color gray500 = Color(0xFF878787);
  static const Color gray600 = Color(0xFF717171);
  static const Color gray700 = Color(0xFF5A5A5A);
  static const Color gray800 = Color(0xFF4A4A4A);
  static const Color gray900 = Color(0xFF3A3A3A);
  static const Color gray950 = Color(0xFF272727);

  // ============================================
  // Warm Gray (Sayvly 톤에 맞춘 따뜻한 그레이)
  // ============================================

  static const Color warmGray10 = Color(0xFFFFF9F9);
  static const Color warmGray30 = Color(0xFFF5F0F0);
  static const Color warmGray60 = Color(0xFFEDE7E7);
  static const Color warmGray100 = Color(0xFFDED6D6);
  static const Color warmGray200 = Color(0xFFCCC2C2);
  static const Color warmGray300 = Color(0xFFB5A8A8);
  static const Color warmGray400 = Color(0xFF9B8E8E);
  static const Color warmGray500 = Color(0xFF8A7E7E);
  static const Color warmGray600 = Color(0xFF746969);
  static const Color warmGray700 = Color(0xFF5C5252);
  static const Color warmGray800 = Color(0xFF4A4242);
  static const Color warmGray900 = Color(0xFF3A3333);
  static const Color warmGray950 = Color(0xFF2D2626);

  // ============================================
  // Status Colors
  // ============================================

  static const Color success = Color(0xFF2ECC71);
  static const Color warning = Color(0xFFF39C12);
  static const Color error = Color(0xFFE74C3C);
  static const Color info = Color(0xFF3498DB);

  // ============================================
  // Utility Colors
  // ============================================

  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color transparent = Colors.transparent;

  // ============================================
  // Overlay Colors
  // ============================================

  static Color overlay05 = Colors.black.withValues(alpha: 0.05);
  static Color overlay10 = Colors.black.withValues(alpha: 0.10);
  static Color overlay20 = Colors.black.withValues(alpha: 0.20);
  static Color overlay40 = Colors.black.withValues(alpha: 0.40);
  static Color overlay60 = Colors.black.withValues(alpha: 0.60);
  static Color overlay80 = Colors.black.withValues(alpha: 0.80);

  // ============================================
  // Button Shadow Color
  // ============================================

  static Color primaryShadow = primary.withValues(alpha: 0.30);
  static Color secondaryShadow = secondary.withValues(alpha: 0.30);
}
