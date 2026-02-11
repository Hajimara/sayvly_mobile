# Sayvly Mobile Design System

Sayvly 모바일 앱의 디자인 시스템 문서입니다.

## 브랜드 아이덴티티

### 키워드
| 키워드 | 의미 |
|--------|------|
| **따뜻함** | 여성의 건강을 따뜻하게 돌보는 느낌 |
| **신뢰** | 민감한 건강 정보를 안전하게 관리 |
| **연결** | 커플 간의 이해와 소통 |
| **배려** | 파트너를 위한 섬세한 가이드 |

### 톤앤매너
- **Warm & Soft**: 차갑지 않고 부드러운 느낌
- **Clean & Minimal**: 복잡하지 않은 깔끔한 UI
- **Friendly & Approachable**: 민감한 주제를 편안하게 다룸
- **Trustworthy**: 의료/건강 앱으로서의 신뢰감

---

## 컬러 시스템

### Brand Colors

| 용도 | 컬러명 | HEX | 의미 |
|------|--------|-----|------|
| **Primary** | Coral Red | `#FF6B6B` | 생리, 여성성, 따뜻함 |
| **Secondary** | Mint Teal | `#4ECDC4` | 파트너, 연결, 신선함 |
| **Accent** | Soft Purple | `#9B59B6` | 배란, 프리미엄 |

### 사용 방법

```dart
import 'package:sayvly_mobile/core/theme/theme.dart';

// 컬러 사용
Container(
  color: AppColors.primary, // #FF6B6B
)

// Primary Swatch 사용 (50~900)
Container(
  color: AppColors.primarySwatch[100], // Light coral
)
```

### Semantic Colors (캘린더)

| 상태 | Light Mode | Dark Mode | 클래스명 |
|------|------------|-----------|----------|
| 생리 기간 | `#FF6B6B` | `#FF8E8E` | `AppColors.menstruation` |
| 배란일 | `#9B59B6` | `#B085CF` | `AppColors.ovulation` |
| 가임기 | `#3498DB` | `#5DADE2` | `AppColors.fertile` |
| 안전기 | `#2ECC71` | `#58D68D` | `AppColors.safe` |
| PMS 기간 | `#F39C12` | `#F5B041` | `AppColors.pms` |

### Neutral Colors

| 용도 | Light Mode | Dark Mode |
|------|------------|-----------|
| Background | `#FFF9F9` | `#1A1A1A` |
| Surface | `#FFFFFF` | `#2D2D2D` |
| Text Primary | `#2D3436` | `#F5F5F5` |
| Text Secondary | `#636E72` | `#B0B0B0` |
| Border | `#E0E0E0` | `#404040` |

---

## 타이포그래피

### 폰트
- **Primary**: Pretendard (한글)
- **Fallback**: SF Pro (iOS) / Roboto (Android)

### Font Weights
| Weight | Value | 클래스명 |
|--------|-------|----------|
| Regular | 400 | `AppTypography.regular` |
| Medium | 500 | `AppTypography.medium` |
| SemiBold | 600 | `AppTypography.semiBold` |
| Bold | 700 | `AppTypography.bold` |

### Text Styles

#### Display
```dart
Text('제목', style: AppTypography.display1())
```
| Style | Size | Weight | Line Height |
|-------|------|--------|-------------|
| display1 | 30px | Bold | 1.4 |

#### Title
```dart
Text('제목', style: AppTypography.title1())
Text('제목', style: AppTypography.title2())
Text('제목', style: AppTypography.title3())
```
| Style | Size | Weight | Line Height |
|-------|------|--------|-------------|
| title1 | 26px | Bold | 1.46 |
| title2 | 24px | Bold | 1.43 |
| title3 | 22px | Bold | 1.38 |

#### Body
```dart
Text('본문', style: AppTypography.body1())
Text('본문', style: AppTypography.body1Bold())
// ... body2, body3, body4, body5, body6
```
| Style | Size | Weight | Line Height |
|-------|------|--------|-------------|
| body1 | 22px | Medium | 1.56 |
| body2 | 20px | Medium | 1.48 |
| body3 | 18px | Medium | 1.47 |
| body4 | 16px | Medium | 1.47 |
| body5 | 14px | Medium | 1.46 |
| body6 | 12px | Medium | 1.4 |

#### Label
```dart
Text('라벨', style: AppTypography.label1())
Text('라벨', style: AppTypography.label1Bold())
// ... label2, label3
```
| Style | Size | Weight | Line Height |
|-------|------|--------|-------------|
| label1 | 16px | Medium | 1.0 |
| label2 | 14px | Medium | 1.0 |
| label3 | 12px | Medium | 1.0 |

### 컬러 적용
```dart
Text(
  '커스텀 컬러 텍스트',
  style: AppTypography.body1(color: AppColors.primary),
)
```

---

## 스페이싱

### Scale (4px 기반)
```dart
// 직접 사용
SizedBox(height: AppSpacing.scale16) // 16px

// Semantic 사용
SizedBox(height: AppSpacing.md) // 12px
```

| Name | Value |
|------|-------|
| xxs | 2px |
| xs | 4px |
| sm | 8px |
| md | 12px |
| base | 16px |
| lg | 20px |
| xl | 24px |
| xxl | 32px |
| section | 48px |

### Page Padding
```dart
Padding(
  padding: AppSpacing.pagePadding,
  child: ...
)

// 또는 개별 사용
Padding(
  padding: EdgeInsets.symmetric(horizontal: AppSpacing.pageHorizontal),
  child: ...
)
```

### Border Radius
```dart
Container(
  decoration: BoxDecoration(
    borderRadius: AppSpacing.borderRadiusXl, // 16px - 카드용
  ),
)
```

| Name | Value | 용도 |
|------|-------|------|
| radiusXs | 4px | 아주 작은 |
| radiusSm | 6px | 작은 |
| radiusMd | 8px | 입력 필드 |
| radiusLg | 12px | 버튼 |
| radiusXl | 16px | 카드 |
| radiusBottomSheet | 24px | 바텀시트 (상단) |
| radiusCircle | 9999px | 원형 |

---

## 쉐도우

### Box Shadows
```dart
Container(
  decoration: BoxDecoration(
    boxShadow: AppShadows.md, // 카드용
  ),
)
```

| Name | 용도 |
|------|------|
| xs | Extra small |
| sm | Small |
| md | 카드, 바텀시트 |
| lg | Large |
| xl | Extra large |
| softCard | 카드 (Sayvly 스타일) |
| softButton | Primary 버튼 |
| bottomNav | 하단 네비게이션 |
| fab | FAB 버튼 |

### 버튼 쉐도우
```dart
// Primary 버튼 쉐도우
Container(
  decoration: BoxDecoration(
    boxShadow: AppShadows.softButton,
  ),
)

// Secondary 버튼 쉐도우
Container(
  decoration: BoxDecoration(
    boxShadow: AppShadows.softButtonSecondary,
  ),
)
```

---

## 테마 사용

### 기본 설정 (main.dart)
```dart
import 'package:sayvly_mobile/core/theme/theme.dart';

MaterialApp(
  theme: AppTheme.light,
  darkTheme: AppTheme.dark,
  themeMode: ThemeMode.system,
)
```

### Theme 접근
```dart
// ColorScheme 접근
Theme.of(context).colorScheme.primary

// TextTheme 접근
Theme.of(context).textTheme.headlineMedium

// Custom 스타일 (권장)
AppColors.primary
AppTypography.body1()
AppSpacing.md
AppShadows.softCard
```

---

## UI 스타일 가이드

### Do's
- 둥근 모서리로 부드러운 인상 (`borderRadiusLg`, `borderRadiusXl`)
- 충분한 여백으로 가독성 확보 (`AppSpacing.base` 이상)
- 민감한 정보는 절제된 표현
- 이모지로 친근함 표현
- 원탭 액션 우선

### Don'ts
- 날카로운 모서리, 차가운 느낌
- 빽빽한 정보 나열
- 의료적/임상적인 느낌
- 과도한 핑크 (유아적 느낌)
- 복잡한 다단계 입력

---

## 파일 구조

```
lib/
└── core/
    └── theme/
        ├── theme.dart           # Export 파일
        ├── app_colors.dart      # 컬러 시스템
        ├── app_typography.dart  # 타이포그래피
        ├── app_spacing.dart     # 스페이싱 & 라운드
        ├── app_shadows.dart     # 쉐도우
        └── app_theme.dart       # ThemeData
```

---

## 관련 문서

- [Sayvly 디자인 컨셉](../../sayvly-docs/docs/design-concept.md)
- [ddoga-design-system](../../../ddoga-design-system/packages/foundation/styles/)
