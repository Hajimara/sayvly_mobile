import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/error/error_code.dart';
import '../../../../core/error/error_handler_extension.dart';
import '../../../../core/theme/theme.dart';
import '../../domain/validators/password_validator.dart';
import '../../data/models/auth_response.dart';
import '../providers/auth_provider.dart';
import '../../../user/presentation/providers/user_provider.dart';
import '../widgets/email_text_field.dart';
import '../widgets/password_strength_indicator.dart';

/// 회원가입 화면
class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _emailController = TextEditingController();
  final _nicknameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String? _emailError;
  String? _nicknameError;
  String? _passwordError;
  String? _confirmPasswordError;

  @override
  void dispose() {
    _emailController.dispose();
    _nicknameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final isLoading = authState.isLoading;

    // 회원가입 성공 시 프로필 로드 후 온보딩 또는 홈으로 이동
    ref.listen<AsyncValue<AuthResponse?>>(authProvider, (prev, next) async {
      if (next.hasValue && next.value != null) {
        // 프로필이 로드될 때까지 대기
        await ref.read(userProfileProvider.future);
        
        // 온보딩 표시 여부 확인
        final shouldShowOnboarding = ref.read(shouldShowOnboardingProvider);
        if (shouldShowOnboarding) {
          context.go('/onboarding');
        } else {
          context.go('/home');
        }
      } else if (next.hasError) {
        final appException = next.appException;
        if (appException != null && appException.errorCode != null) {
          _handleErrorCode(appException.errorCode!);
        } else {
          _showErrorSnackBar(next.errorMessage);
        }
      }
    });

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/login'),
        ),
        title: const Text('회원가입'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.pagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 안내 텍스트
              Text('계정을 만들어주세요', style: AppTypography.title2()),
              const SizedBox(height: AppSpacing.xs),
              Text(
                '이메일과 비밀번호로 회원가입합니다',
                style: AppTypography.body5(color: AppColors.textSecondaryLight),
              ),
              const SizedBox(height: AppSpacing.xl),

              // 이메일 입력
              EmailTextField(
                controller: _emailController,
                errorText: _emailError,
                enabled: !isLoading,
                onChanged: (_) => _clearEmailError(),
              ),
              const SizedBox(height: AppSpacing.base),

              // 닉네임 입력
              NicknameTextField(
                controller: _nicknameController,
                errorText: _nicknameError,
                enabled: !isLoading,
                onChanged: (_) => _clearNicknameError(),
              ),
              const SizedBox(height: AppSpacing.base),

              // 비밀번호 입력
              PasswordTextField(
                controller: _passwordController,
                errorText: _passwordError,
                enabled: !isLoading,
                textInputAction: TextInputAction.next,
                onChanged: (_) {
                  _clearPasswordError();
                  setState(() {}); // 강도 표시기 업데이트
                },
              ),
              const SizedBox(height: AppSpacing.sm),

              // 비밀번호 강도 표시기
              PasswordStrengthIndicator(password: _passwordController.text),
              const SizedBox(height: AppSpacing.base),

              // 비밀번호 확인 입력
              PasswordTextField(
                controller: _confirmPasswordController,
                labelText: '비밀번호 확인',
                errorText: _confirmPasswordError,
                enabled: !isLoading,
                onChanged: (_) => _clearConfirmPasswordError(),
                onEditingComplete: _handleSignup,
              ),
              const SizedBox(height: AppSpacing.xxl),

              // 회원가입 버튼
              _buildSignupButton(isLoading),
              const SizedBox(height: AppSpacing.base),

              // 로그인 링크
              _buildLoginLink(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSignupButton(bool isLoading) {
    return SizedBox(
      height: AppSpacing.buttonHeightBase,
      child: ElevatedButton(
        onPressed: isLoading ? null : _handleSignup,
        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation(AppColors.white),
                ),
              )
            : Text(
                '회원가입',
                style: AppTypography.body3Bold(color: AppColors.white),
              ),
      ),
    );
  }

  Widget _buildLoginLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '이미 계정이 있으신가요?',
          style: AppTypography.body5(color: AppColors.textSecondaryLight),
        ),
        TextButton(
          onPressed: () => context.go('/login'),
          child: Text(
            '로그인',
            style: AppTypography.body5Bold(color: AppColors.primary),
          ),
        ),
      ],
    );
  }

  void _handleSignup() {
    final email = _emailController.text.trim();
    final nickname = _nicknameController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    bool hasError = false;

    // 이메일 검증
    if (email.isEmpty) {
      setState(() => _emailError = '이메일을 입력해주세요');
      hasError = true;
    } else if (!EmailTextField.isValidEmail(email)) {
      setState(() => _emailError = '올바른 이메일 형식이 아닙니다');
      hasError = true;
    }

    // 닉네임 검증
    if (nickname.isEmpty) {
      setState(() => _nicknameError = '닉네임을 입력해주세요');
      hasError = true;
    } else if (!NicknameTextField.isValid(nickname)) {
      setState(() => _nicknameError = '닉네임은 2-12자여야 합니다');
      hasError = true;
    }

    // 비밀번호 검증
    if (password.isEmpty) {
      setState(() => _passwordError = '비밀번호를 입력해주세요');
      hasError = true;
    } else if (!PasswordValidator.isValid(password)) {
      setState(() => _passwordError = '비밀번호 조건을 모두 충족해주세요');
      hasError = true;
    }

    // 비밀번호 확인 검증
    if (confirmPassword.isEmpty) {
      setState(() => _confirmPasswordError = '비밀번호 확인을 입력해주세요');
      hasError = true;
    } else if (password != confirmPassword) {
      setState(() => _confirmPasswordError = '비밀번호가 일치하지 않습니다');
      hasError = true;
    }

    if (hasError) return;

    // 회원가입 요청
    ref
        .read(authProvider.notifier)
        .signup(email: email, password: password, nickname: nickname);
  }

  void _handleErrorCode(ErrorCode errorCode) {
    // 에러 코드에 따른 처리
    switch (errorCode) {
      case ErrorCode.userAlreadyExists: // 이메일 중복
        _showDuplicateEmailDialog();
        break;
      case ErrorCode.invalidPasswordFormat: // 비밀번호 형식 오류
        final authState = ref.read(authProvider);
        setState(() => _passwordError = authState.errorMessage);
        break;
      default:
        final authState = ref.read(authProvider);
        _showErrorSnackBar(authState.errorMessage);
    }
  }

  void _showDuplicateEmailDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('이미 가입된 이메일'),
        content: const Text('이미 가입된 이메일입니다.\n로그인하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.go('/login');
            },
            child: const Text('로그인'),
          ),
        ],
      ),
    );
  }

  void _clearEmailError() {
    if (_emailError != null) setState(() => _emailError = null);
  }

  void _clearNicknameError() {
    if (_nicknameError != null) setState(() => _nicknameError = null);
  }

  void _clearPasswordError() {
    if (_passwordError != null) setState(() => _passwordError = null);
  }

  void _clearConfirmPasswordError() {
    if (_confirmPasswordError != null)
      setState(() => _confirmPasswordError = null);
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: AppColors.error),
    );
  }
}
