import 'package:flutter/material.dart';
import 'package:flutter_dowith/view/splash/model/custom_extension_button.dart';

class LoginSignUpScreen extends StatefulWidget {
  const LoginSignUpScreen({super.key});

  @override
  State<LoginSignUpScreen> createState() => _LoginSignUpScreenState();
}

class _LoginSignUpScreenState extends State<LoginSignUpScreen>
    with TickerProviderStateMixin {
  late AnimationController _signUpAnimationController;
  late AnimationController _signInAnimationController;
  late Animation<double> _signUpAnimation;
  late Animation<double> _signInAnimation;
  bool _isSignUp = false;
  bool _isSignIn = false;

  @override
  void initState() {
    super.initState();
    _signUpAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    _signInAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    _signUpAnimation =
        Tween<double>(begin: 0, end: 1).animate(_signUpAnimationController);
    _signInAnimation =
        Tween<double>(begin: 0, end: 1).animate(_signUpAnimationController);
  }

  @override
  void dispose() {
    _signUpAnimationController.dispose();
    _signInAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.65),
            Center(
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                overlayColor: null,
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomExtensionButton(
                        callback: () {
                          setState(() {
                            _isSignUp = !_isSignUp;
                          });
                        },
                        splashColor: Colors.white,
                        highLightColor: Colors.white,
                        controller: _signUpAnimationController,
                        animation: _signUpAnimation,
                        content: "Sign Up",
                        color: const Color(0xff3964c3)),
                    CustomExtensionButton(
                        callback: () {
                          setState(() {
                            _isSignIn = !_isSignIn;
                          });
                        },
                        splashColor: const Color(0xff3964c3),
                        highLightColor: const Color(0xff3964c3),
                        controller: _signInAnimationController,
                        animation: _signInAnimation,
                        content: "Sign In",
                        color: const Color(0xfffbfbff))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
