import 'package:flutter/material.dart';
import 'package:flutter_dowith/view/splash/model/circle_button.dart';
import 'package:flutter_dowith/view/splash/model/custom_text_form_field.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  final FocusNode _nameNode = FocusNode();
  final FocusNode _emailNode = FocusNode();
  final FocusNode _passwordNode = FocusNode();
  final FocusNode _passwordConfirmNode = FocusNode();

  final _formKey = GlobalKey<FormState>();
  bool _isSignUpLoad = false;
  bool _isSignUpLoadGoogle = false;
  bool _isSignUpLoadApple = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      overlayColor: null,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            withPublisher(),
            const SizedBox(height: 5),
            Card(
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 12, 15, 12),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTextFormField(
                          icon: const Icon(Icons.person_rounded),
                          focusNode: _nameNode,
                          label: "별명",
                          hintText: "별명을 입력하세요.",
                          controller: _nameController,
                          validator: validateName),
                      const SizedBox(height: 8),
                      CustomTextFormField(
                          icon: const Icon(Icons.email_outlined),
                          focusNode: _emailNode,
                          label: "계정",
                          hintText: "이메일 주소를 입력하세요.",
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: validateEmail),
                      const SizedBox(height: 8),
                      CustomTextFormField(
                          icon: const Icon(Icons.password_rounded),
                          focusNode: _passwordNode,
                          label: "비밀번호",
                          hintText: "비밀번호를 입력하세요.",
                          controller: _passwordController,
                          switchVisible: true,
                          validator: validatePassword
                          ),
                      const SizedBox(height: 8),
                      CustomTextFormField(
                        icon: const Icon(Icons.password_rounded),
                        focusNode: _passwordConfirmNode,
                        label: "비밀번호 확인",
                        hintText: "비밀번호를 한 번 더 입력하세요.",
                        controller: _passwordConfirmController,
                        switchVisible: true,
                        validator: validatePasswordConfirmation,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      _isSignUpLoad = !_isSignUpLoad;
                    });
                  }
                  // will add a focusNode
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(18, 8, 18, 8),
                child: _isSignUpLoad
                    ? const CircularProgressIndicator()
                    : const Text(
                        "Sign Up",
                        style: TextStyle(fontSize: 25),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget withPublisher() {
    return Center(
      child: Column(
        children: [
          const Text("간편 회원가입"),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [CircleButton(assetPath: "assets/icons/google_logo.png", callback: () {})],
          ),
          const SizedBox(height: 15),
          const Text("또는 개인 이메일주소로 가입하세요."),
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

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return '닉네임을 입력해주세요.';
    }
    if (value.length < 3 || value.length >= 12) {
      return '닉네임은 3글자 이상, 13글자 미만이어야 합니다.';
    }
    if (value.contains(' ') || value.contains(RegExp(r'[!@#%^&*(),.?":{}|<>]'))) {
      return '닉네임에는 특수문자와 빈칸을 입력할 수 없습니다.';
    }
    if (value.contains(RegExp(r'[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]')) && value.contains(RegExp(r'[a-zA-Z]'))) {
      return '닉네임에는 한글과 영문이 혼용될 수 없습니다.';
    }
    if (value.contains(RegExp(r'[ㄱ-ㅎ|ㅏ-ㅣ]'))) {
      return '닉네임은 완성형 한글이어야 합니다.';
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

  String? validatePasswordConfirmation(String? value) {
    if (value == null || value.isEmpty) {
      return '비밀번호를 다시 입력해주세요.';
    }
    if (value != _passwordController.text) {
      return '비밀번호가 일치하지 않습니다.';
    }
    return null;
  }
}
