import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/error/error_code.dart';
import '../../../../../core/storage/secure_storage.dart';
import '../../../../../core/utils/nickname_generator.dart';
import '../../data/models/user_models.dart';
import '../../data/models/onboarding_models.dart';
import '../../data/repositories/user_repository.dart';
import 'user_provider.dart';

/// 온보딩 단계
enum OnboardingStep {
  gender, // Step 1: 성별 선택
  birthDate, // Step 2: 생년월일 입력
  cycleSetup, // Step 3: 주기 설정 (여성만)
}

/// 온보딩 입력 데이터
class OnboardingData {
  final Gender? gender;
  final DateTime? birthDate;
  final int cycleLength;
  final int periodLength;
  final DateTime? lastPeriodStartDate;

  const OnboardingData({
    this.gender,
    this.birthDate,
    this.cycleLength = 28,
    this.periodLength = 5,
    this.lastPeriodStartDate,
  });

  OnboardingData copyWith({
    Gender? gender,
    DateTime? birthDate,
    int? cycleLength,
    int? periodLength,
    DateTime? lastPeriodStartDate,
  }) {
    return OnboardingData(
      gender: gender ?? this.gender,
      birthDate: birthDate ?? this.birthDate,
      cycleLength: cycleLength ?? this.cycleLength,
      periodLength: periodLength ?? this.periodLength,
      lastPeriodStartDate: lastPeriodStartDate ?? this.lastPeriodStartDate,
    );
  }

  /// 온보딩 요청 객체로 변환
  OnboardingRequest toRequest() {
    return OnboardingRequest(
      gender: gender!,
      birthDate: birthDate,
      cycleLength: cycleLength,
      periodLength: periodLength,
      lastPeriodStartDate: lastPeriodStartDate,
    );
  }

  /// 여성인지 확인
  bool get isFemale => gender == Gender.female;

  /// 현재 스텝에서 다음 스텝으로 이동 가능한지 확인
  bool canProceed(OnboardingStep currentStep) {
    switch (currentStep) {
      case OnboardingStep.gender:
        return gender != null;
      case OnboardingStep.birthDate:
        return true; // 생년월일은 선택사항
      case OnboardingStep.cycleSetup:
        if (isFemale) {
          return lastPeriodStartDate != null;
        }
        return true;
    }
  }
}

/// 온보딩 상태
sealed class OnboardingState {
  const OnboardingState();
}

class OnboardingInitial extends OnboardingState {
  const OnboardingInitial();
}

class OnboardingInProgress extends OnboardingState {
  final OnboardingStep currentStep;
  final OnboardingData data;

  const OnboardingInProgress({required this.currentStep, required this.data});

  /// 다음 스텝 계산
  OnboardingStep? get nextStep {
    switch (currentStep) {
      case OnboardingStep.gender:
        return OnboardingStep.birthDate;
      case OnboardingStep.birthDate:
        // 모든 성별에서 주기 설정 단계로 (남성은 반려자 주기 등록)
        return OnboardingStep.cycleSetup;
      case OnboardingStep.cycleSetup:
        return null; // 마지막 단계
    }
  }

  /// 이전 스텝 계산
  OnboardingStep? get previousStep {
    switch (currentStep) {
      case OnboardingStep.gender:
        return null; // 첫 단계
      case OnboardingStep.birthDate:
        return OnboardingStep.gender;
      case OnboardingStep.cycleSetup:
        return OnboardingStep.birthDate;
    }
  }

  /// 마지막 스텝인지 확인
  bool get isLastStep => nextStep == null;

  /// 전체 스텝 수
  /// 모든 성별에서 3단계 (gender → birthDate → cycleSetup)
  int get totalSteps => 3;

  /// 현재 스텝 인덱스 (1부터 시작)
  int get currentStepIndex {
    switch (currentStep) {
      case OnboardingStep.gender:
        return 1;
      case OnboardingStep.birthDate:
        return 2;
      case OnboardingStep.cycleSetup:
        return 3;
    }
  }
}

class OnboardingLoading extends OnboardingState {
  const OnboardingLoading();
}

class OnboardingCompleted extends OnboardingState {
  const OnboardingCompleted();
}

class OnboardingError extends OnboardingState {
  final String message;
  final ErrorCode? errorCode;
  const OnboardingError(this.message, {this.errorCode});
}

/// 온보딩 Notifier
class OnboardingNotifier extends StateNotifier<OnboardingState> {
  final UserRepository _repository;
  final SecureStorage _storage;

  OnboardingNotifier(this._repository)
    : _storage = SecureStorage(),
      super(const OnboardingInitial());

  /// 온보딩 시작
  void startOnboarding() {
    state = const OnboardingInProgress(
      currentStep: OnboardingStep.gender,
      data: OnboardingData(),
    );
  }

  /// 성별 선택
  void selectGender(Gender gender) {
    final currentState = state;
    if (currentState is! OnboardingInProgress) return;

    state = OnboardingInProgress(
      currentStep: currentState.currentStep,
      data: currentState.data.copyWith(gender: gender),
    );
  }

  /// 생년월일 선택
  void selectBirthDate(DateTime? birthDate) {
    final currentState = state;
    if (currentState is! OnboardingInProgress) return;

    state = OnboardingInProgress(
      currentStep: currentState.currentStep,
      data: currentState.data.copyWith(birthDate: birthDate),
    );
  }

  /// 주기 길이 설정
  void setCycleLength(int length) {
    final currentState = state;
    if (currentState is! OnboardingInProgress) return;

    state = OnboardingInProgress(
      currentStep: currentState.currentStep,
      data: currentState.data.copyWith(cycleLength: length),
    );
  }

  /// 생리 기간 설정
  void setPeriodLength(int length) {
    final currentState = state;
    if (currentState is! OnboardingInProgress) return;

    state = OnboardingInProgress(
      currentStep: currentState.currentStep,
      data: currentState.data.copyWith(periodLength: length),
    );
  }

  /// 마지막 생리 시작일 설정
  void setLastPeriodStartDate(DateTime? date) {
    final currentState = state;
    if (currentState is! OnboardingInProgress) return;

    state = OnboardingInProgress(
      currentStep: currentState.currentStep,
      data: currentState.data.copyWith(lastPeriodStartDate: date),
    );
  }

  /// 다음 스텝으로 이동
  void nextStep() {
    final currentState = state;
    if (currentState is! OnboardingInProgress) return;

    final nextStep = currentState.nextStep;
    if (nextStep != null) {
      state = OnboardingInProgress(
        currentStep: nextStep,
        data: currentState.data,
      );
    }
  }

  /// 이전 스텝으로 이동
  void previousStep() {
    final currentState = state;
    if (currentState is! OnboardingInProgress) return;

    final previousStep = currentState.previousStep;
    if (previousStep != null) {
      state = OnboardingInProgress(
        currentStep: previousStep,
        data: currentState.data,
      );
    }
  }

  /// 온보딩 완료 (서버에 제출)
  Future<bool> completeOnboarding() async {
    final currentState = state;
    if (currentState is! OnboardingInProgress) return false;

    state = const OnboardingLoading();
    try {
      await _repository.submitOnboarding(currentState.data.toRequest());
      state = const OnboardingCompleted();
      return true;
    } on UserException catch (e) {
      state = OnboardingError(e.message, errorCode: e.errorCode);
      return false;
    } catch (e) {
      state = OnboardingError(e.toString());
      return false;
    }
  }

  /// 온보딩 건너뛰기 (성별 OTHER, 랜덤 닉네임, 기본값 주기로 설정)
  Future<void> skipOnboarding() async {
    state = const OnboardingLoading();

    try {
      // 랜덤 닉네임 생성
      final randomNickname = NicknameGenerator.generateRandom();

      // 주기 정보 기본값 설정
      const defaultCycleLength = 28;
      const defaultPeriodLength = 5;

      // OnboardingRequest 생성
      final request = OnboardingRequest(
        gender: Gender.other,
        birthDate: null,
        cycleLength: defaultCycleLength,
        periodLength: defaultPeriodLength,
        lastPeriodStartDate: null,
      );

      // 온보딩 완료 API 호출
      await _repository.submitOnboarding(request);

      // 프로필 업데이트 API 호출하여 닉네임 설정
      await _repository.updateProfile(
        UpdateProfileRequest(nickname: randomNickname),
      );

      // 로컬에 건너뛰기 플래그 저장
      await _storage.setOnboardingSkipped(true);

      // 상태를 완료로 설정
      state = const OnboardingCompleted();
    } on UserException catch (e) {
      state = OnboardingError(e.message, errorCode: e.errorCode);
      rethrow;
    } catch (e) {
      state = OnboardingError(e.toString());
      rethrow;
    }
  }

  /// 초기화
  void reset() {
    state = const OnboardingInitial();
  }
}

/// OnboardingNotifier Provider
final onboardingProvider =
    StateNotifierProvider<OnboardingNotifier, OnboardingState>((ref) {
      final repository = ref.watch(userRepositoryProvider);
      return OnboardingNotifier(repository);
    });

/// 현재 온보딩 데이터 Provider
final onboardingDataProvider = Provider<OnboardingData?>((ref) {
  final state = ref.watch(onboardingProvider);
  if (state is OnboardingInProgress) {
    return state.data;
  }
  return null;
});

/// 현재 온보딩 스텝 Provider
final currentOnboardingStepProvider = Provider<OnboardingStep?>((ref) {
  final state = ref.watch(onboardingProvider);
  if (state is OnboardingInProgress) {
    return state.currentStep;
  }
  return null;
});
