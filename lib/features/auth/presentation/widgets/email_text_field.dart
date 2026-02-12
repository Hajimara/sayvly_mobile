import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';

/// 이메일 입력 필드
class EmailTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? errorText;
  final bool enabled;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;

  const EmailTextField({
    super.key,
    required this.controller,
    this.errorText,
    this.enabled = true,
    this.onChanged,
    this.onEditingComplete,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      enabled: enabled,
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      textInputAction: TextInputAction.next,
      style: AppTypography.body4(),
      decoration: InputDecoration(
        labelText: '이메일',
        hintText: 'example@email.com',
        errorText: errorText,
        prefixIcon: const Icon(Icons.email_outlined),
      ),
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
    );
  }

  /// 이메일 형식 검증
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  /// 이메일 에러 메시지
  static String? getErrorText(String email) {
    if (email.isEmpty) {
      return null;
    }
    if (!isValidEmail(email)) {
      return '올바른 이메일 형식이 아닙니다';
    }
    return null;
  }
}

/// 비밀번호 입력 필드
class PasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? labelText;
  final String? hintText;
  final String? errorText;
  final bool enabled;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final TextInputAction textInputAction;

  const PasswordTextField({
    super.key,
    required this.controller,
    this.labelText = '비밀번호',
    this.hintText,
    this.errorText,
    this.enabled = true,
    this.onChanged,
    this.onEditingComplete,
    this.textInputAction = TextInputAction.done,
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      enabled: widget.enabled,
      obscureText: _obscureText,
      keyboardType: TextInputType.visiblePassword,
      autocorrect: false,
      textInputAction: widget.textInputAction,
      style: AppTypography.body4(),
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        errorText: widget.errorText,
        prefixIcon: const Icon(Icons.lock_outlined),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined,
          ),
          onPressed: () => setState(() => _obscureText = !_obscureText),
        ),
      ),
      onChanged: widget.onChanged,
      onEditingComplete: widget.onEditingComplete,
    );
  }
}

/// 닉네임 입력 필드
class NicknameTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? errorText;
  final bool enabled;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;

  const NicknameTextField({
    super.key,
    required this.controller,
    this.errorText,
    this.enabled = true,
    this.onChanged,
    this.onEditingComplete,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      enabled: enabled,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      maxLength: 12,
      style: AppTypography.body4(),
      decoration: InputDecoration(
        labelText: '닉네임',
        hintText: '2-12자',
        errorText: errorText,
        prefixIcon: const Icon(Icons.person_outlined),
        counterText: '',
      ),
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
    );
  }

  /// 닉네임 검증
  static bool isValid(String nickname) {
    return nickname.length >= 2 && nickname.length <= 12;
  }

  /// 닉네임 에러 메시지
  static String? getErrorText(String nickname) {
    if (nickname.isEmpty) {
      return null;
    }
    if (nickname.length < 2) {
      return '닉네임은 2자 이상이어야 합니다';
    }
    if (nickname.length > 12) {
      return '닉네임은 12자 이하여야 합니다';
    }
    return null;
  }
}
