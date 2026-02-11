import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Sayvly 앱 타이포그래피 시스템
/// 폰트: Pretendard (한글), SF Pro / Roboto (시스템 폴백)
class AppTypography {
  AppTypography._();

  /// 기본 폰트 패밀리
  static const String fontFamily = 'Pretendard';

  // ============================================
  // Font Weights
  // ============================================

  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;

  // ============================================
  // Font Sizes (px 기준)
  // ============================================

  static const double fontSize2xs = 12.0;
  static const double fontSizeXs = 14.0;
  static const double fontSizeSm = 16.0;
  static const double fontSizeMd = 18.0;
  static const double fontSizeLg = 20.0;
  static const double fontSizeXl = 22.0;
  static const double fontSize2xl = 24.0;
  static const double fontSize3xl = 26.0;
  static const double fontSize4xl = 28.0;
  static const double fontSize5xl = 30.0;

  // ============================================
  // Display Styles
  // ============================================

  static TextStyle display1({Color? color}) => TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize5xl,
        fontWeight: bold,
        height: 1.4,
        letterSpacing: -0.3,
        color: color ?? AppColors.textPrimaryLight,
      );

  // ============================================
  // Title Styles
  // ============================================

  static TextStyle title1({Color? color}) => TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize3xl,
        fontWeight: bold,
        height: 1.46,
        letterSpacing: -0.26,
        color: color ?? AppColors.textPrimaryLight,
      );

  static TextStyle title2({Color? color}) => TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize2xl,
        fontWeight: bold,
        height: 1.43,
        letterSpacing: -0.24,
        color: color ?? AppColors.textPrimaryLight,
      );

  static TextStyle title3({Color? color}) => TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSizeXl,
        fontWeight: bold,
        height: 1.38,
        letterSpacing: -0.22,
        color: color ?? AppColors.textPrimaryLight,
      );

  // ============================================
  // Body Styles
  // ============================================

  static TextStyle body1({Color? color}) => TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSizeXl,
        fontWeight: medium,
        height: 1.56,
        letterSpacing: -0.22,
        color: color ?? AppColors.textPrimaryLight,
      );

  static TextStyle body1Bold({Color? color}) => TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSizeXl,
        fontWeight: bold,
        height: 1.56,
        letterSpacing: -0.33,
        color: color ?? AppColors.textPrimaryLight,
      );

  static TextStyle body2({Color? color}) => TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSizeLg,
        fontWeight: medium,
        height: 1.48,
        letterSpacing: -0.2,
        color: color ?? AppColors.textPrimaryLight,
      );

  static TextStyle body2Bold({Color? color}) => TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSizeLg,
        fontWeight: bold,
        height: 1.48,
        letterSpacing: -0.3,
        color: color ?? AppColors.textPrimaryLight,
      );

  static TextStyle body3({Color? color}) => TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSizeMd,
        fontWeight: medium,
        height: 1.47,
        letterSpacing: -0.18,
        color: color ?? AppColors.textPrimaryLight,
      );

  static TextStyle body3Bold({Color? color}) => TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSizeMd,
        fontWeight: bold,
        height: 1.47,
        letterSpacing: -0.27,
        color: color ?? AppColors.textPrimaryLight,
      );

  static TextStyle body4({Color? color}) => TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSizeSm,
        fontWeight: medium,
        height: 1.47,
        letterSpacing: -0.16,
        color: color ?? AppColors.textPrimaryLight,
      );

  static TextStyle body4Bold({Color? color}) => TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSizeSm,
        fontWeight: bold,
        height: 1.47,
        letterSpacing: -0.24,
        color: color ?? AppColors.textPrimaryLight,
      );

  static TextStyle body5({Color? color}) => TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSizeXs,
        fontWeight: medium,
        height: 1.46,
        letterSpacing: -0.14,
        color: color ?? AppColors.textPrimaryLight,
      );

  static TextStyle body5Bold({Color? color}) => TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSizeXs,
        fontWeight: bold,
        height: 1.46,
        letterSpacing: -0.21,
        color: color ?? AppColors.textPrimaryLight,
      );

  static TextStyle body6({Color? color}) => TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize2xs,
        fontWeight: medium,
        height: 1.4,
        letterSpacing: -0.14,
        color: color ?? AppColors.textPrimaryLight,
      );

  static TextStyle body6Bold({Color? color}) => TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize2xs,
        fontWeight: bold,
        height: 1.4,
        letterSpacing: -0.18,
        color: color ?? AppColors.textPrimaryLight,
      );

  // ============================================
  // Label Styles
  // ============================================

  static TextStyle label1({Color? color}) => TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSizeSm,
        fontWeight: medium,
        height: 1.0,
        letterSpacing: -0.16,
        color: color ?? AppColors.textPrimaryLight,
      );

  static TextStyle label1Bold({Color? color}) => TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSizeSm,
        fontWeight: bold,
        height: 1.0,
        letterSpacing: -0.24,
        color: color ?? AppColors.textPrimaryLight,
      );

  static TextStyle label2({Color? color}) => TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSizeXs,
        fontWeight: medium,
        height: 1.0,
        letterSpacing: -0.14,
        color: color ?? AppColors.textPrimaryLight,
      );

  static TextStyle label2Bold({Color? color}) => TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSizeXs,
        fontWeight: bold,
        height: 1.0,
        letterSpacing: -0.21,
        color: color ?? AppColors.textPrimaryLight,
      );

  static TextStyle label3({Color? color}) => TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize2xs,
        fontWeight: medium,
        height: 1.0,
        letterSpacing: -0.14,
        color: color ?? AppColors.textPrimaryLight,
      );

  static TextStyle label3Bold({Color? color}) => TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize2xs,
        fontWeight: bold,
        height: 1.0,
        letterSpacing: -0.18,
        color: color ?? AppColors.textPrimaryLight,
      );

  // ============================================
  // Caption & Small Styles
  // ============================================

  static TextStyle caption({Color? color}) => TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSizeXs,
        fontWeight: regular,
        height: 1.43,
        letterSpacing: -0.14,
        color: color ?? AppColors.textSecondaryLight,
      );

  static TextStyle small({Color? color}) => TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize2xs,
        fontWeight: regular,
        height: 1.33,
        letterSpacing: -0.12,
        color: color ?? AppColors.textSecondaryLight,
      );
}
