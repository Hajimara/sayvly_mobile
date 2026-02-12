import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/theme/theme.dart';
import '../../providers/onboarding_provider.dart';
import '../../providers/user_provider.dart';
import 'gender_step_screen.dart';
import 'birthdate_step_screen.dart';
import 'cycle_setup_screen.dart';

/// 온보딩 메인 화면
/// PageView로 스텝별 화면 관리
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    // 온보딩 시작
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(onboardingProvider.notifier).startOnboarding();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNextStep() {
    final state = ref.read(onboardingProvider);
    if (state is! OnboardingInProgress) return;

    if (state.isLastStep) {
      _completeOnboarding();
    } else {
      ref.read(onboardingProvider.notifier).nextStep();
      // nextStep() 호출 후 새로운 state를 읽어서 페이지 이동
      final newState = ref.read(onboardingProvider);
      if (newState is OnboardingInProgress) {
        _animateToPage(newState.currentStepIndex - 1); // 0-based index
      }
    }
  }

  void _onPreviousStep() {
    final state = ref.read(onboardingProvider);
    if (state is! OnboardingInProgress) return;

    if (state.previousStep != null) {
      ref.read(onboardingProvider.notifier).previousStep();
      _animateToPage(state.currentStepIndex - 2); // 이전 페이지로
    }
  }

  void _animateToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _completeOnboarding() async {
    final success = await ref
        .read(onboardingProvider.notifier)
        .completeOnboarding();

    if (!success || !mounted) return;

    // 프로필이 리프레시될 때까지 대기
    await ref.read(userProfileProvider.future);

    if (!mounted) return;
    context.go('/home');
  }

  Future<void> _skipOnboarding() async {
    await ref.read(onboardingProvider.notifier).skipOnboarding();

    if (!mounted) return;

    // 프로필이 리프레시될 때까지 대기
    await ref.read(userProfileProvider.future);

    if (!mounted) return;
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final state = ref.watch(onboardingProvider);

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      body: SafeArea(child: _buildBody(state, isDark)),
    );
  }

  Widget _buildBody(OnboardingState state, bool isDark) {
    if (state is OnboardingLoading) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      );
    }

    if (state is OnboardingError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: AppColors.error),
            const SizedBox(height: AppSpacing.base),
            Text(
              state.message,
              style: AppTypography.body3(color: AppColors.error),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.lg),
            ElevatedButton(
              onPressed: () {
                ref.read(onboardingProvider.notifier).startOnboarding();
              },
              child: const Text('다시 시도'),
            ),
          ],
        ),
      );
    }

    if (state is OnboardingCompleted) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, size: 64, color: AppColors.success),
            SizedBox(height: AppSpacing.base),
            Text('온보딩 완료!'),
          ],
        ),
      );
    }

    if (state is! OnboardingInProgress) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        // 상단 바 (뒤로가기 + 프로그레스)
        _buildHeader(state, isDark),

        // 페이지 컨텐츠
        Expanded(
          child: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              GenderStepScreen(onNext: _onNextStep),
              BirthdateStepScreen(onNext: _onNextStep, onBack: _onPreviousStep),
              if (state.data.isFemale)
                CycleSetupScreen(
                  onComplete: _onNextStep,
                  onBack: _onPreviousStep,
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(OnboardingInProgress state, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          // 뒤로가기 버튼 (첫 스텝에서는 숨김)
          if (state.previousStep != null)
            IconButton(
              onPressed: _onPreviousStep,
              icon: Icon(
                Icons.arrow_back_ios,
                color: isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
              ),
            )
          else
            const SizedBox(width: 48),

          // 프로그레스 인디케이터
          Expanded(
            child: _OnboardingProgress(
              currentStep: state.currentStepIndex,
              totalSteps: state.totalSteps,
            ),
          ),

          // 건너뛰기 (마지막 단계에서는 숨김)
          if (!state.isLastStep)
            TextButton(
              onPressed: _skipOnboarding,
              child: Text(
                '건너뛰기',
                style: AppTypography.body5(
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
                ),
              ),
            )
          else
            const SizedBox(width: 48),
        ],
      ),
    );
  }
}

class _OnboardingProgress extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const _OnboardingProgress({
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalSteps, (index) {
        final isActive = index < currentStep;
        final isCurrent = index == currentStep - 1;

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: AppSpacing.xxs),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: isCurrent ? 24 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: isActive || isCurrent
                  ? AppColors.primary
                  : AppColors.gray200,
              borderRadius: AppSpacing.borderRadiusCircle,
            ),
          ),
        );
      }),
    );
  }
}
