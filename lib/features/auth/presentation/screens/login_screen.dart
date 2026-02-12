import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/error/error_handler_extension.dart';
import '../../data/models/auth_response.dart';
import '../providers/auth_provider.dart';
import '../../../user/presentation/providers/user_provider.dart';
import '../widgets/email_text_field.dart';
import '../widgets/social_login_button.dart';
import '../widgets/social_login_section.dart';

/// 로그인 화면
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? _emailError;
  String? _passwordError;
  SocialLoginType? _loadingSocialType;

  @override
  void initState() {
    super.initState();
    _loadLastEmail();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  /// 저장된 이메일 불러오기 (화면 최초 진입 시에만)
  Future<void> _loadLastEmail() async {
    final repository = ref.read(authRepositoryProvider);
    final lastEmail = await repository.getLastEmail();
    // 사용자가 아직 아무것도 입력하지 않은 경우에만 설정
    if (lastEmail != null && mounted && _emailController.text.isEmpty) {
      _emailController.text = lastEmail;
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final isLoading = authState.isLoading;

    // 로그인 성공 시 프로필 로드 후 온보딩 또는 홈으로 이동
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
        // 에러는 글로벌 토스트로 처리됨
      }
    });

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.pagePadding,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: AppSpacing.section),

                // 로고
                _buildLogo(),
                const SizedBox(height: AppSpacing.section),

                // 이메일 입력
                EmailTextField(
                  controller: _emailController,
                  errorText: _emailError,
                  enabled: !isLoading,
                  onChanged: (_) => _clearEmailError(),
                ),
                const SizedBox(height: AppSpacing.base),

                // 비밀번호 입력
                PasswordTextField(
                  controller: _passwordController,
                  errorText: _passwordError,
                  enabled: !isLoading,
                  onChanged: (_) => _clearPasswordError(),
                  onEditingComplete: _handleLogin,
                ),
                const SizedBox(height: AppSpacing.xl),

                // 로그인 버튼
                _buildLoginButton(isLoading),
                const SizedBox(height: AppSpacing.md),

                // 비밀번호 찾기 / 회원가입 링크
                _buildLinks(),
                const SizedBox(height: AppSpacing.xl),

                // 소셜 로그인 (개발 모드 전용)
                SocialLoginSection(
                  onSocialLogin: _handleSocialLogin,
                  loadingType: _loadingSocialType,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Column(
      children: [
        // TODO: 실제 로고 이미지로 교체
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: AppSpacing.borderRadiusXl,
          ),
          child: const Icon(Icons.favorite, size: 40, color: AppColors.white),
        ),
        const SizedBox(height: AppSpacing.base),
        Text('Sayvly', style: AppTypography.title1()),
        const SizedBox(height: AppSpacing.xs),
        Text(
          '커플을 위한 생리 주기 관리',
          style: AppTypography.body5(color: AppColors.textSecondaryLight),
        ),
      ],
    );
  }

  Widget _buildLoginButton(bool isLoading) {
    return SizedBox(
      height: AppSpacing.buttonHeightBase,
      child: ElevatedButton(
        onPressed: isLoading ? null : _handleLogin,
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
                '로그인',
                style: AppTypography.body3Bold(color: AppColors.white),
              ),
      ),
    );
  }

  Widget _buildLinks() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {
            // TODO: 비밀번호 찾기 화면으로 이동
          },
          child: Text(
            '비밀번호 찾기',
            style: AppTypography.body5(color: AppColors.textSecondaryLight),
          ),
        ),
        Text('|', style: AppTypography.body5(color: AppColors.gray300)),
        TextButton(
          onPressed: () => context.go('/signup'),
          child: Text(
            '회원가입',
            style: AppTypography.body5Bold(color: AppColors.primary),
          ),
        ),
      ],
    );
  }

  void _handleLogin() {
    // 입력 검증
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    bool hasError = false;

    if (email.isEmpty) {
      setState(() => _emailError = '이메일을 입력해주세요');
      hasError = true;
    } else if (!EmailTextField.isValidEmail(email)) {
      setState(() => _emailError = '올바른 이메일 형식이 아닙니다');
      hasError = true;
    }

    if (password.isEmpty) {
      setState(() => _passwordError = '비밀번호를 입력해주세요');
      hasError = true;
    }

    if (hasError) return;

    // 로그인 요청
    ref.read(authProvider.notifier).login(email: email, password: password);
  }

  void _handleSocialLogin(SocialLoginType type) async {
    setState(() => _loadingSocialType = type);

    try {
      String? accessToken;

      // 각 소셜 로그인 SDK 호출
      switch (type) {
        case SocialLoginType.google:
          accessToken = await _signInWithGoogle();
          break;
        case SocialLoginType.kakao:
          accessToken = await _signInWithKakao();
          break;
        case SocialLoginType.naver:
          accessToken = await _signInWithNaver();
          break;
      }

      if (accessToken != null) {
        ref
            .read(authProvider.notifier)
            .socialLogin(type: type, accessToken: accessToken);
      }
    } catch (e) {
      // 에러는 글로벌 토스트로 처리됨
    } finally {
      setState(() => _loadingSocialType = null);
    }
  }

  Future<String?> _signInWithGoogle() async {
    // TODO: google_sign_in 패키지로 구현
    // final GoogleSignInAccount? account = await GoogleSignIn().signIn();
    // final GoogleSignInAuthentication? auth = await account?.authentication;
    // return auth?.accessToken;
    throw UnimplementedError('Google 로그인 구현 필요');
  }

  Future<String?> _signInWithKakao() async {
    // TODO: kakao_flutter_sdk_user 패키지로 구현
    // final OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
    // return token.accessToken;
    throw UnimplementedError('Kakao 로그인 구현 필요');
  }

  Future<String?> _signInWithNaver() async {
    // TODO: flutter_naver_login 패키지로 구현
    // final NaverLoginResult result = await FlutterNaverLogin.logIn();
    // return result.accessToken;
    throw UnimplementedError('Naver 로그인 구현 필요');
  }

  void _clearEmailError() {
    if (_emailError != null) {
      setState(() => _emailError = null);
    }
  }

  void _clearPasswordError() {
    if (_passwordError != null) {
      setState(() => _passwordError = null);
    }
  }
}
