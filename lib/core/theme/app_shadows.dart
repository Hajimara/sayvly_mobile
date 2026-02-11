import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Sayvly 앱 쉐도우 시스템
/// Soft Shadow - 부드럽고 따뜻한 느낌
class AppShadows {
  AppShadows._();

  // ============================================
  // Box Shadows - Black (기본)
  // ============================================

  /// Extra Small Shadow
  static List<BoxShadow> xs = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.10),
      offset: const Offset(0, 2),
      blurRadius: 4,
    ),
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.05),
      offset: const Offset(0, 1),
      blurRadius: 2,
    ),
  ];

  /// Small Shadow
  static List<BoxShadow> sm = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.10),
      offset: const Offset(0, 4),
      blurRadius: 8,
    ),
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.05),
      offset: const Offset(0, 1),
      blurRadius: 4,
    ),
  ];

  /// Medium Shadow - 카드, 바텀시트
  static List<BoxShadow> md = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.08),
      offset: const Offset(0, 4),
      blurRadius: 20,
    ),
  ];

  /// Large Shadow
  static List<BoxShadow> lg = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.10),
      offset: const Offset(0, 8),
      blurRadius: 20,
    ),
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.05),
      offset: const Offset(0, 3),
      blurRadius: 8,
    ),
  ];

  /// Extra Large Shadow
  static List<BoxShadow> xl = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.10),
      offset: const Offset(0, 14),
      blurRadius: 28,
    ),
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.05),
      offset: const Offset(0, 4),
      blurRadius: 10,
    ),
  ];

  // ============================================
  // Box Shadows - Soft (Sayvly 무드)
  // ============================================

  /// Soft Card Shadow - 카드에 사용
  static List<BoxShadow> softCard = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.08),
      offset: const Offset(0, 4),
      blurRadius: 20,
    ),
  ];

  /// Soft Button Shadow - Primary 버튼
  static List<BoxShadow> softButton = [
    BoxShadow(
      color: AppColors.primary.withValues(alpha: 0.30),
      offset: const Offset(0, 2),
      blurRadius: 8,
    ),
  ];

  /// Soft Button Shadow - Secondary 버튼
  static List<BoxShadow> softButtonSecondary = [
    BoxShadow(
      color: AppColors.secondary.withValues(alpha: 0.30),
      offset: const Offset(0, 2),
      blurRadius: 8,
    ),
  ];

  // ============================================
  // Bottom Navigation Shadow
  // ============================================

  static List<BoxShadow> bottomNav = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.10),
      offset: const Offset(0, -8),
      blurRadius: 20,
    ),
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.05),
      offset: const Offset(0, -8),
      blurRadius: 8,
    ),
  ];

  // ============================================
  // FAB Shadow
  // ============================================

  static List<BoxShadow> fab = [
    BoxShadow(
      color: AppColors.primary.withValues(alpha: 0.40),
      offset: const Offset(0, 4),
      blurRadius: 16,
    ),
  ];

  // ============================================
  // Input Focus Shadow
  // ============================================

  static List<BoxShadow> inputFocus = [
    BoxShadow(
      color: AppColors.primary.withValues(alpha: 0.20),
      offset: const Offset(0, 0),
      blurRadius: 0,
      spreadRadius: 3,
    ),
  ];

  // ============================================
  // Elevation Helpers (Material 스타일)
  // ============================================

  static List<BoxShadow> elevation1 = xs;
  static List<BoxShadow> elevation2 = sm;
  static List<BoxShadow> elevation4 = md;
  static List<BoxShadow> elevation8 = lg;
  static List<BoxShadow> elevation16 = xl;

  // ============================================
  // No Shadow
  // ============================================

  static List<BoxShadow> none = [];
}
