# 에러 처리 가이드

## 개요

Sayvly 모바일 앱은 Repository 레벨에서 통합된 에러 처리 시스템을 사용합니다. 백엔드 ErrorCode를 기반으로 하되, 모바일에서 정의한 사용자 친화적인 메시지를 우선적으로 사용합니다.

## 아키텍처

### 에러 처리 흐름

```
DioException → ErrorHandler → AppException → 도메인별 Exception → Provider → UI
```

1. **DioException**: 네트워크 요청 실패 시 발생
2. **ErrorHandler**: DioException을 AppException으로 변환
3. **도메인별 Exception**: AuthException, UserException 등으로 변환
4. **Provider**: 예외를 상태로 변환
5. **UI**: 사용자에게 에러 메시지 표시

## 핵심 컴포넌트

### 1. ErrorCode Enum

백엔드 ErrorCode를 Dart enum으로 변환한 타입입니다.

**위치**: `lib/core/error/error_code.dart`

**특징**:
- 각 에러 코드는 `code` (int)와 `userFriendlyMessage` (String) 포함
- 모바일에서 정의한 사용자 친화적인 메시지 사용
- 타입 안전성 보장

**사용 예시**:
```dart
// 에러 코드로 ErrorCode 찾기
final errorCode = ErrorCode.fromCode(3004); // nicknameAlreadyExists

// 에러 코드 확인
if (errorCode == ErrorCode.nicknameAlreadyExists) {
  // 닉네임 중복 처리
}
```

### 2. ErrorMessageService

에러 메시지 매핑 서비스입니다.

**위치**: `lib/core/error/error_message_service.dart`

**메시지 우선순위**:
1. **모바일 userFriendlyMessage** (최우선)
2. 백엔드 errorMessage (fallback)
3. 기본 메시지

**사용 예시**:
```dart
final message = ErrorMessageService.getMessage(
  errorCode: ErrorCode.nicknameAlreadyExists,
  backendMessage: '닉네임이 중복되었습니다',
);
// 결과: "이미 사용 중인 닉네임입니다" (모바일 메시지 우선)
```

### 3. ErrorHandler

DioException을 AppException으로 변환하는 공통 유틸리티입니다.

**위치**: `lib/core/error/error_handler.dart`

**기능**:
- 네트워크 에러 처리 (타임아웃, 연결 오류 등)
- 백엔드 응답 파싱 (errorCode, errorMessage)
- ErrorCode enum 변환
- 사용자 친화적인 메시지 매핑

**사용 예시**:
```dart
try {
  await _dio.get('/api/endpoint');
} on DioException catch (e) {
  final appException = ErrorHandler.handle(e);
  // appException은 NetworkException 또는 ServerException
}
```

### 4. AppException

모든 도메인 예외의 기본 클래스입니다.

**위치**: `lib/core/error/app_exception.dart`

**구조**:
```dart
abstract class AppException implements Exception {
  final ErrorCode? errorCode;
  final String userMessage;
}
```

**하위 클래스**:
- `NetworkException`: 네트워크 관련 에러
- `ServerException`: 서버 응답 에러 (HTTP 상태 코드 포함)

### 5. 도메인별 예외 클래스

각 Repository에서 사용하는 도메인별 예외 클래스입니다.

**예외 클래스**:
- `AuthException`: 인증 관련 예외
- `UserException`: 사용자/프로필 관련 예외
- `AccountException`: 계정 관리 관련 예외
- `SettingsException`: 설정 관련 예외

**특징**:
- ErrorCode enum 사용
- 도메인별 편의 메서드 제공 (예: `isNicknameDuplicate`)

**예시**:
```dart
class UserException implements Exception {
  final String message;
  final ErrorCode? errorCode;

  bool get isNicknameDuplicate => 
    errorCode == ErrorCode.nicknameAlreadyExists;
}
```

## 사용 방법

### Repository에서 에러 처리

모든 Repository는 `ErrorHandler`를 사용하여 에러를 처리합니다.

```dart
class UserRepository {
  Future<ProfileResponse> getMyProfile() async {
    try {
      final response = await _dio.get('/profile/me');
      return ProfileResponse.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    final appException = ErrorHandler.handle(e);
    
    // ServerException을 UserException으로 변환
    if (appException is ServerException) {
      return UserException(
        appException.userMessage,
        errorCode: appException.errorCode,
      );
    }
    
    // NetworkException을 UserException으로 변환
    return UserException(appException.userMessage);
  }
}
```

### Provider에서 에러 처리

Provider는 도메인별 예외를 받아 상태로 변환합니다.

```dart
class UserProfileNotifier extends StateNotifier<UserProfileState> {
  Future<void> loadProfile() async {
    state = const UserProfileLoading();
    try {
      final profile = await _repository.getMyProfile();
      state = UserProfileLoaded(profile);
    } on UserException catch (e) {
      state = UserProfileError(e.message, errorCode: e.errorCode);
    } catch (e) {
      state = UserProfileError(e.toString());
    }
  }
}
```

### UI에서 에러 처리

UI는 Provider의 에러 상태를 확인하여 사용자에게 메시지를 표시합니다.

```dart
final state = ref.watch(userProfileProvider);
if (state is UserProfileError) {
  if (state.errorCode == ErrorCode.nicknameAlreadyExists) {
    // 닉네임 중복 특수 처리
    setState(() {
      _nicknameError = '이미 사용 중인 닉네임입니다.';
    });
  } else {
    // 일반 에러 메시지 표시
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(state.message)),
    );
  }
}
```

## 에러 코드 목록

### Common (1xxx)
- `requestParamCannotBeEmpty` (1000): 필수 정보를 입력해주세요
- `invalidInputValue` (1001): 입력한 내용을 확인해주세요

### Auth (2xxx)
- `unauthorized` (2000): 다시 로그인해주세요
- `invalidToken` (2001): 로그인 세션이 만료되었습니다
- `expiredToken` (2002): 로그인 세션이 만료되었습니다
- `socialLoginRequired` (2009): 소셜 로그인으로 가입된 계정입니다

### User (3xxx)
- `nicknameAlreadyExists` (3004): 이미 사용 중인 닉네임입니다
- `invalidNicknameFormat` (3005): 닉네임은 2-12자로 입력해주세요
- `nicknameChangeCooldown` (3008): 닉네임 변경은 30일에 한 번만 가능합니다
- `invalidCurrentPassword` (3009): 현재 비밀번호가 일치하지 않습니다

전체 에러 코드 목록은 `lib/core/error/error_code.dart`를 참조하세요.

## 모범 사례

### 1. 에러 메시지 우선순위 준수

모바일에서 정의한 사용자 친화적인 메시지가 항상 우선적으로 사용됩니다.

```dart
// ✅ 좋은 예: 모바일 메시지 사용
final message = ErrorMessageService.getMessage(
  errorCode: ErrorCode.nicknameAlreadyExists,
  backendMessage: '닉네임이 중복되었습니다',
);

// ❌ 나쁜 예: 백엔드 메시지를 직접 사용
final message = backendMessage; // 사용자 친화적이지 않을 수 있음
```

### 2. ErrorCode enum 사용

문자열 비교 대신 ErrorCode enum을 사용하여 타입 안전성을 보장합니다.

```dart
// ✅ 좋은 예: ErrorCode enum 사용
if (errorCode == ErrorCode.nicknameAlreadyExists) {
  // 처리
}

// ❌ 나쁜 예: 문자열 비교
if (errorCode == '3004') {
  // 처리
}
```

### 3. 도메인별 예외 클래스 활용

도메인별 예외 클래스의 편의 메서드를 활용합니다.

```dart
// ✅ 좋은 예: 편의 메서드 사용
if (exception.isNicknameDuplicate) {
  // 처리
}

// ❌ 나쁜 예: 직접 비교
if (exception.errorCode == ErrorCode.nicknameAlreadyExists) {
  // 처리
}
```

### 4. 네트워크 에러 처리

네트워크 에러는 사용자에게 명확한 메시지를 제공합니다.

```dart
try {
  await _repository.getData();
} on UserException catch (e) {
  // 서버 에러 처리
} catch (e) {
  // 예상치 못한 에러 처리
  state = UserProfileError('알 수 없는 오류가 발생했습니다.');
}
```

## 파일 구조

```
lib/core/error/
├── error_code.dart          # ErrorCode enum 정의
├── error_message_service.dart  # 에러 메시지 매핑 서비스
├── app_exception.dart       # 통합 예외 클래스
└── error_handler.dart       # 공통 에러 처리 유틸리티
```

## 참고 자료

- 백엔드 ErrorCode: `sayvly-backend/src/main/kotlin/com/sayvly/infrastructure/error/ErrorCode.kt`
- 도메인별 예외 클래스: 각 Repository 파일 내부
- Provider 에러 처리: `lib/features/*/presentation/providers/`

## Riverpod 개선 사항

### ProviderObserver를 통한 전역 에러 처리

`ErrorObserver`는 모든 Provider의 에러를 감지하고 자동으로 처리합니다.

**주요 기능**:
- 모든 AsyncValue 에러 자동 감지
- 인증 만료 시 자동 로그아웃
- 에러 로깅 및 모니터링

**등록 방법** (`main.dart`):
```dart
final container = ProviderContainer();
final observer = ErrorObserver(container);

runApp(
  ProviderScope(
    parent: container,
    observers: [observer],
    child: const SayvlyApp(),
  ),
);
```

### AsyncNotifierProvider 활용

기존 `StateNotifier<SealedState>` 패턴을 `AsyncNotifier<T>`로 변경하여 에러 처리를 간소화했습니다.

**Before**:
```dart
class UserProfileNotifier extends StateNotifier<UserProfileState> {
  Future<void> loadProfile() async {
    state = const UserProfileLoading();
    try {
      final profile = await _repository.getMyProfile();
      state = UserProfileLoaded(profile);
    } on UserException catch (e) {
      state = UserProfileError(e.message, errorCode: e.errorCode);
    } catch (e) {
      state = UserProfileError(e.toString());
    }
  }
}
```

**After**:
```dart
class UserProfileNotifier extends AsyncNotifier<ProfileResponse> {
  @override
  Future<ProfileResponse> build() async {
    return await ref.read(userRepositoryProvider).getMyProfile();
  }

  Future<void> loadProfile() async {
    state = const AsyncValue.loading();
    state = await AsyncErrorHandler.safeAsyncOperation(
      () => ref.read(userRepositoryProvider).getMyProfile(),
      context: 'Load Profile',
      ref: ref,
    );
  }
}
```

**장점**:
- 에러 처리 코드 중복 제거
- 로딩/에러 상태 자동 관리
- 타입 안전성 향상

### 전역 에러 상태 관리

`GlobalErrorProvider`를 통해 앱 전체에서 에러 상태를 공유할 수 있습니다.

**사용 예시**:
```dart
// 에러 추가
ref.read(globalErrorProvider.notifier).addException(
  exception,
  context: 'User Action',
);

// 현재 에러 확인
final currentError = ref.watch(currentErrorProvider);

// 최근 에러 목록
final recentErrors = ref.watch(recentErrorsProvider);
```

### 에러 리커버리

`ErrorRecoveryProvider`를 통해 자동 재시도 기능을 제공합니다.

**사용 예시**:
```dart
final recoveryNotifier = ref.read(errorRecoveryProvider.notifier);

// 자동 재시도 (네트워크 에러만)
final result = await recoveryNotifier.retry(
  () => repository.getData(),
);

// 수동 재시도
final result = await recoveryNotifier.manualRetry(
  () => repository.getData(),
);
```

### AsyncValue 확장 함수

`AsyncValue`에 편의 메서드를 추가하여 에러 처리를 간소화했습니다.

**사용 예시**:
```dart
final state = ref.watch(userProfileProvider);

// 에러 메시지 가져오기
if (state.hasError) {
  final message = state.errorMessage;
  final errorCode = state.errorCode;
  final appException = state.appException;
}
```

## 문제 해결

### 새로운 에러 코드 추가

1. 백엔드 `ErrorCode.kt`에 에러 코드 추가
2. 모바일 `error_code.dart`에 해당 enum 추가 (사용자 친화적인 메시지 포함)
3. 필요시 도메인별 예외 클래스에 편의 메서드 추가

### 에러 메시지 수정

모바일에서 정의한 메시지를 수정하려면 `error_code.dart`의 `userFriendlyMessage`를 수정하세요.

```dart
enum ErrorCode {
  nicknameAlreadyExists(3004, '수정된 메시지'), // 여기서 수정
  // ...
}
```

### 네트워크 에러 메시지 수정

네트워크 에러 메시지를 수정하려면 `error_message_service.dart`의 `getNetworkErrorMessage` 메서드를 수정하세요.

### ProviderObserver가 작동하지 않는 경우

`main.dart`에서 `ProviderScope`에 `observers` 파라미터가 올바르게 등록되었는지 확인하세요.

```dart
ProviderScope(
  observers: [ErrorObserver(container)],
  child: const SayvlyApp(),
)
```
