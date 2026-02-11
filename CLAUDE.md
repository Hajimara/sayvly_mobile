# Sayvly Mobile - Claude 작업 가이드

## 프로젝트 개요

Sayvly는 여성 건강 관리 및 커플 공유 앱입니다.

- **프레임워크**: Flutter (iOS/Android)
- **언어**: Dart
- **타겟**: 20-35세 여성 및 파트너

## 브랜드 키워드

- 따뜻함 (Warm)
- 신뢰 (Trust)
- 연결 (Connection)
- 배려 (Care)

## 디자인 시스템

### 필수 참고 문서

- [디자인 시스템 문서](./docs/DESIGN_SYSTEM.md) - 컬러, 타이포그래피, 스페이싱 등
- [디자인 컨셉](../sayvly-docs/docs/desi/ㄹ///gn-concept.md) - 브랜드 아이덴티티, 무드보드

### 디자인 시스템 파일 위치

```
lib/core/theme/
├── theme.dart           # Export (이 파일만 import)
├── app_colors.dart      # 컬러
├── app_typography.dart  # 타이포그래피
├── app_spacing.dart     # 스페이싱
├── app_shadows.dart     # 쉐도우
└── app_theme.dart       # ThemeData
```

### 사용 방법

```dart
import 'package:sayvly_mobile/core/theme/theme.dart';

// 컬러
AppColors.primary        // #FF6B6B (Coral Red)
AppColors.secondary      // #4ECDC4 (Mint Teal)
AppColors.accent         // #9B59B6 (Soft Purple)

// 캘린더 시맨틱 컬러
AppColors.menstruation   // 생리
AppColors.ovulation      // 배란
AppColors.fertile        // 가임기
AppColors.safe           // 안전기
AppColors.pms            // PMS

// 타이포그래피
AppTypography.title1()
AppTypography.body1()
AppTypography.label1()

// 스페이싱
AppSpacing.md            // 12px
AppSpacing.base          // 16px
AppSpacing.borderRadiusXl // 카드용 BorderRadius

// 쉐도우
AppShadows.softCard      // 카드용
AppShadows.softButton    // 버튼용

// 테마
AppTheme.light
AppTheme.dark
```

## 코드 컨벤션

### 파일 구조

```
lib/
├── core/               # 핵심 유틸리티
│   ├── theme/          # 디자인 시스템
│   ├── constants/      # 상수
│   └── utils/          # 유틸리티
├── features/           # 기능별 모듈
│   ├── home/
│   ├── calendar/
│   ├── record/
│   └── partner/
├── shared/             # 공유 위젯
│   ├── widgets/
│   └── components/
└── main.dart
```

### 네이밍 컨벤션

- 파일명: `snake_case.dart`
- 클래스명: `PascalCase`
- 변수/함수: `camelCase`
- 상수: `camelCase` 또는 `SCREAMING_SNAKE_CASE`

## UI 가이드라인

### Do's
- 둥근 모서리 사용 (borderRadiusLg, borderRadiusXl)
- 충분한 여백 (AppSpacing.base 이상)
- 따뜻한 톤 유지
- 원탭 액션 우선

### Don'ts
- 날카로운 모서리
- 빽빽한 레이아웃
- 의료적/임상적 느낌
- 과도한 핑크 (유아적)

## 참고 앱

- Flo: 캘린더 UI, 주기 시각화
- Clue: 미니멀 디자인, 데이터 표현
- Between: 커플 앱 UX
- Calm: 온보딩 플로우
- Headspace: 일러스트 스타일

## 관련 프로젝트

- `ddoga-design-system`: 기존 디자인 시스템 (웹용, 참고용)
- `sayvly-docs`: 프로젝트 문서
