import 'package:flutter/material.dart';
import 'package:flutter_dowith/bloc/database_bloc/userCtrl/auth.dart';
import 'package:flutter_dowith/utils/glow_remover.dart';
import 'package:flutter_dowith/view/login/login_view.dart';
import 'package:flutter_dowith/view/login/model/circle_button.dart';
import 'package:flutter_dowith/view/login/model/custom_extension_button.dart';

class LoginSignUpScreen extends StatefulWidget {
  const LoginSignUpScreen({this.callback, super.key});

  final VoidCallback? callback;

  @override
  State<LoginSignUpScreen> createState() => _LoginSignUpScreenState();
}

class _LoginSignUpScreenState extends State<LoginSignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isSignUpLoad = false;
  bool _isSignInLoad = false;
  bool _isGoogleLoad = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: ScrollConfiguration(
          behavior: ScrollGlowRemove(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Placeholder(fallbackHeight: _size.height > 800 ? 240 : _size.height * 0.3),
                const SizedBox(height: 10),
                LoginView(
                  formKey: _formKey,
                  emailController: _emailController,
                  passwordController: _passwordController,
                ),
                const SizedBox(height: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomExtensionButton(
                      callback: () {
                        FocusScope.of(context).unfocus();
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _isSignInLoad = !_isSignInLoad;
                          });
                          Auth().signInWithEmail(context, _emailController.text, _passwordController.text);
                        }
                      },
                      splashColor: const Color(0xff3964c3),
                      highLightColor: const Color(0xff3964c3),
                      content: "로그인",
                      color: const Color(0xfffbfbff),
                      isLoading: _isSignInLoad,
                    ),
                    CustomExtensionButton(
                      callback: () {
                        setState(() {
                          _isSignUpLoad = !_isSignUpLoad;
                        });
                      },
                      splashColor: Colors.white,
                      highLightColor: Colors.white,
                      content: "회원 가입",
                      color: const Color(0xff3964c3),
                      isLoading: _isSignUpLoad,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Divider(color: Theme.of(context).colorScheme.onBackground),
                      Container(
                          width: _size.width * 0.15,
                          color: Theme.of(context).colorScheme.background,
                          child: const Text("OR", textAlign: TextAlign.center))
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                withPublisher(),
                SizedBox(height: _size.height * 0.25)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget withPublisher() {
    return Center(
      child: Column(
        children: [
          const Text("간편 회원가입"),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleButton(
                assetPath: "assets/icons/google_logo.png",
                isLoad: _isGoogleLoad,
                callback: () {
                  if (mounted) {
                    setState(() {
                      _isGoogleLoad = !_isGoogleLoad;
                    });
                    Auth().signInUpWithGoogle().then((value) {
                      if (widget.callback != null) {
                        widget.callback;
                      }
                    });
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
