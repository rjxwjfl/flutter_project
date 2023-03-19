import 'package:flutter/material.dart';
import 'package:flutter_dowith/view/splash/model/custom_text_form_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailNode = FocusNode();
  final FocusNode _passwordNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  bool _isSignInLoad = false;

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
          children: [
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
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    _isSignInLoad = !_isSignInLoad;
                  });
                }
                // will add a focusNode
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                elevation: 4.0
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(18, 8, 18, 8),
                child: _isSignInLoad
                    ? const CircularProgressIndicator()
                    : const Text(
                  "Login",
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ),
          ],
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