import 'package:flutter/material.dart';
import 'package:flutter_dowith/view/splash/model/custom_text_form_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({required this.formKey, required this.emailController, required this.passwordController, super.key});

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  final FocusNode _emailNode = FocusNode();
  final FocusNode _passwordNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40),
      child: Column(
        children: [
          Form(
            key: widget.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextFormField(
                    icon: const Icon(Icons.email_outlined),
                    focusNode: _emailNode,
                    label: "계정",
                    hintText: "이메일 주소를 입력하세요.",
                    controller: widget.emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: validateEmail),
                const SizedBox(height: 8),
                CustomTextFormField(
                    icon: const Icon(Icons.password_rounded),
                    focusNode: _passwordNode,
                    label: "비밀번호",
                    hintText: "비밀번호를 입력하세요.",
                    controller: widget.passwordController,
                    switchVisible: true,
                    validator: validatePassword
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return '이메일을 입력하세요.';
    }
    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
      return '유효한 이메일 주소를 입력하세요.';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return '비밀번호를 입력해주세요.';
    }
    if (value.contains(' ')) {
      return '비밀번호에는 스페이스를 사용할 수 없습니다.';
    }
    if (value.length < 10) {
      return '비밀번호는 10자 이상이어야 합니다.';
    }
    if (!value.contains(RegExp(r'[!@#%^&*(),.?":{}|<>]'))) {
      return '비밀번호에는 최소 하나의 특수문자가 포함되어야 합니다.';
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return '비밀번호에는 최소 하나의 숫자가 포함되어야 합니다.';
    }
    return null;
  }
}