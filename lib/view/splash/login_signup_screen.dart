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
  late Animation<double> _animation;
  bool _isSignup = false;

  @override
  void initState() {
    super.initState();
    _signUpAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    _signInAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    _animation =
        Tween<double>(begin: 0, end: 1).animate(_signUpAnimationController);
  }

  @override
  void dispose() {
    _signUpAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    ColorScheme _scheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
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
                children: [
                  CustomExtensionButton(
                      splashColor: Colors.white,
                      highLightColor: Colors.white,
                      controller: _signUpAnimationController,
                      content: "Sign Up",
                      color: const Color(0xff3964c3)),
                  CustomExtensionButton(
                      splashColor: const Color(0xff3964c3),
                      highLightColor: const Color(0xff3964c3),
                      controller: _signInAnimationController,
                      content: "Sign In",
                      color: const Color(0xfffbfbff))
                ],
              )),
        ),
      ),
    );
  }
}

// Placeholder(
//                     fallbackHeight: 200,
//                   ),
//                   TextButton(onPressed: (){
//                     setState(() {
//                       _isSignup = !_isSignup;
//                     });
//                   }, child: const Text("Switch")),
//                   _isSignup? const SignUpView(): const LoginView() ,
//                   SizedBox(height: kToolbarHeight)
