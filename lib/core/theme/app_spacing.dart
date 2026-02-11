import 'package:flutter/material.dart';

/// Sayvly 앱 스페이싱 시스템
/// 4px 기반 스케일
class AppSpacing {
  AppSpacing._();

  // ============================================
  // Base Scale (4px unit)
  // ============================================

  static const double scale0 = 0.0;
  static const double scale1 = 1.0;
  static const double scale2 = 2.0;
  static const double scale3 = 3.0;
  static const double scale4 = 4.0;
  static const double scale5 = 5.0;
  static const double scale6 = 6.0;
  static const double scale7 = 7.0;
  static const double scale8 = 8.0;
  static const double scale10 = 10.0;
  static const double scale12 = 12.0;
  static const double scale14 = 14.0;
  static const double scale16 = 16.0;
  static const double scale18 = 18.0;
  static const double scale20 = 20.0;
  static const double scale24 = 24.0;
  static const double scale28 = 28.0;
  static const double scale32 = 32.0;
  static const double scale36 = 36.0;
  static const double scale40 = 40.0;
  static const double scale44 = 44.0;
  static const double scale48 = 48.0;
  static const double scale56 = 56.0;
  static const double scale64 = 64.0;
  static const double scale72 = 72.0;
  static const double scale80 = 80.0;
  static const double scale96 = 96.0;
  static const double scale128 = 128.0;

  // ============================================
  // Semantic Spacing
  // ============================================

  /// 아이템 간 아주 작은 간격 (2px)
  static const double xxs = scale2;

  /// 아이템 간 작은 간격 (4px)
  static const double xs = scale4;

  /// 아이템 간 작은-중간 간격 (8px)
  static const double sm = scale8;

  /// 아이템 간 중간 간격 (12px)
  static const double md = scale12;

  /// 아이템 간 기본 간격 (16px)
  static const double base = scale16;

  /// 아이템 간 큰 간격 (20px)
  static const double lg = scale20;

  /// 아이템 간 아주 큰 간격 (24px)
  static const double xl = scale24;

  /// 아이템 간 매우 큰 간격 (32px)
  static const double xxl = scale32;

  /// 섹션 간 간격 (48px)
  static const double section = scale48;

  // ============================================
  // Page Padding
  // ============================================

  /// 페이지 좌우 패딩 (16px)
  static const double pageHorizontal = scale16;

  /// 페이지 상단 패딩 (24px)
  static const double pageTop = scale24;

  /// 페이지 하단 패딩 (32px)
  static const double pageBottom = scale32;

  /// 페이지 기본 패딩
  static const EdgeInsets pagePadding = EdgeInsets.fromLTRB(
    pageHorizontal,
    pageTop,
    pageHorizontal,
    pageBottom,
  );

  /// 페이지 수평 패딩만
  static const EdgeInsets pageHorizontalPadding = EdgeInsets.symmetric(
    horizontal: pageHorizontal,
  );

  // ============================================
  // Card Padding
  // ============================================

  /// 카드 내부 패딩 (16px)
  static const double cardPadding = scale16;

  /// 카드 내부 패딩 EdgeInsets
  static const EdgeInsets cardInsets = EdgeInsets.all(cardPadding);

  // ============================================
  // Border Radius
  // ============================================

  /// 아주 작은 라운드 (4px)
  static const double radiusXs = scale4;

  /// 작은 라운드 (6px)
  static const double radiusSm = scale6;

  /// 중간 라운드 (8px) - 입력 필드
  static const double radiusMd = scale8;

  /// 기본 라운드 (10px)
  static const double radiusBase = scale10;

  /// 큰 라운드 (12px) - 버튼
  static const double radiusLg = scale12;

  /// 아주 큰 라운드 (16px) - 카드
  static const double radiusXl = scale16;

  /// 매우 큰 라운드 (20px)
  static const double radius2xl = scale20;

  /// 바텀시트 라운드 (24px) - 상단만
  static const double radiusBottomSheet = scale24;

  /// 원형
  static const double radiusCircle = 9999.0;

  // ============================================
  // Border Radius - BorderRadius 객체
  // ============================================

  static const BorderRadius borderRadiusXs = BorderRadius.all(Radius.circular(radiusXs));
  static const BorderRadius borderRadiusSm = BorderRadius.all(Radius.circular(radiusSm));
  static const BorderRadius borderRadiusMd = BorderRadius.all(Radius.circular(radiusMd));
  static const BorderRadius borderRadiusBase = BorderRadius.all(Radius.circular(radiusBase));
  static const BorderRadius borderRadiusLg = BorderRadius.all(Radius.circular(radiusLg));
  static const BorderRadius borderRadiusXl = BorderRadius.all(Radius.circular(radiusXl));
  static const BorderRadius borderRadius2xl = BorderRadius.all(Radius.circular(radius2xl));
  static const BorderRadius borderRadiusCircle = BorderRadius.all(Radius.circular(radiusCircle));

  /// 바텀시트용 (상단만 라운드)
  static const BorderRadius borderRadiusBottomSheet = BorderRadius.only(
    topLeft: Radius.circular(radiusBottomSheet),
    topRight: Radius.circular(radiusBottomSheet),
  );

  // ============================================
  // Border Width
  // ============================================

  static const double borderWidth2xs = 0.5;
  static const double borderWidthXs = 1.0;
  static const double borderWidthSm = 2.0;
  static const double borderWidthMd = 3.0;
  static const double borderWidthLg = 4.0;
  static const double borderWidthXl = 6.0;

  // ============================================
  // Icon Sizes
  // ============================================

  static const double iconXs = 12.0;
  static const double iconSm = 16.0;
  static const double iconMd = 20.0;
  static const double iconBase = 24.0;
  static const double iconLg = 28.0;
  static const double iconXl = 32.0;
  static const double icon2xl = 40.0;
  static const double icon3xl = 48.0;

  // ============================================
  // Button Heights
  // ============================================

  static const double buttonHeightSm = 32.0;
  static const double buttonHeightMd = 40.0;
  static const double buttonHeightBase = 48.0;
  static const double buttonHeightLg = 56.0;

  // ============================================
  // Input Heights
  // ============================================

  static const double inputHeightSm = 36.0;
  static const double inputHeightMd = 44.0;
  static const double inputHeightBase = 52.0;
  static const double inputHeightLg = 60.0;

  // ============================================
  // Avatar Sizes
  // ============================================

  static const double avatarXs = 24.0;
  static const double avatarSm = 32.0;
  static const double avatarMd = 40.0;
  static const double avatarBase = 48.0;
  static const double avatarLg = 64.0;
  static const double avatarXl = 80.0;
  static const double avatar2xl = 96.0;
}
