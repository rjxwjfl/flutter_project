import 'package:flutter/material.dart';
import 'package:flutter_dowith/view/splash/model/custom_text_form_field.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final FocusNode _nameNode = FocusNode();
  final FocusNode _emailNode = FocusNode();
  final FocusNode _passwordNode = FocusNode();
  final FocusNode _passwordConfirmNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextFormField(
                  icon: const Icon(Icons.person_rounded),
                  focusNode: _nameNode,
                  label: "NICKNAME",
                  hintText: "닉네임을 입력하세요.",
                  controller: _nameController,
                  validator: validateName),
              const SizedBox(height: 20),
              CustomTextFormField(
                  icon: const Icon(Icons.email_outlined),
                  focusNode: _emailNode,
                  label: "ACCOUNT",
                  hintText: "이메일 주소를 입력하세요.",
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: validateEmail),
              const SizedBox(height: 20),
              CustomTextFormField(
                  icon: const Icon(Icons.password_rounded),
                  focusNode: _passwordNode,
                  label: "PASSWORD",
                  hintText: "비밀번호를 입력하세요.",
                  controller: _passwordController,
                  obscureText: true,
                  validator: validatePassword),
              const SizedBox(height: 20),
              CustomTextFormField(
                icon: const Icon(Icons.password_rounded),
                focusNode: _passwordConfirmNode,
                label: "CONFIRM PASSWORD",
                hintText: "비밀번호를 한 번 더 입력하세요.",
                controller: _passwordConfirmController,
                obscureText: true,
                validator: validatePasswordConfirmation,
              ),
              const SizedBox(height: 70),
              ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(),
                child: const Text("Sign Up"),
              ),
            ],
          ),
        ),
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

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return '닉네임을 입력해주세요.';
    }
    if (value.length < 3 || value.length >= 7) {
      return '닉네임은 3글자 이상, 7글자 미만이어야 합니다.';
    }
    if (value.contains(' ') ||
        value.contains(RegExp(r'[!@#%^&*(),.?":{}|<>]'))) {
      return '닉네임에는 특수문자와 빈칸을 입력할 수 없습니다.';
    }
    if (value.contains(RegExp(r'[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]')) &&
        value.contains(RegExp(r'[a-zA-Z]'))) {
      return '닉네임에는 한글과 영문이 혼용될 수 없습니다.';
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
    if (value.length < 12) {
      return '비밀번호는 12자 이상이어야 합니다.';
    }
    if (!value.contains(RegExp(r'[!@#%^&*(),.?":{}|<>]'))) {
      return '비밀번호에는 최소 하나의 특수문자가 포함되어야 합니다.';
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return '비밀번호에는 최소 하나의 숫자가 포함되어야 합니다.';
    }
    if (_passwordConfirmController.text != value) {
      return '비밀번호와 확인이 일치하지 않습니다.';
    }
    return null;
  }

  String? validatePasswordConfirmation(String? value) {
    if (value == null || value.isEmpty) {
      return '비밀번호를 다시 입력해주세요.';
    }
    if (value != _passwordController.text) {
      return '비밀번호와 확인이 일치하지 않습니다.';
    }
    return null;
  }
}
