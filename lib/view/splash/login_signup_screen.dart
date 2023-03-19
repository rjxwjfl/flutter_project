import 'package:flutter/material.dart';
import 'package:flutter_dowith/view/splash/login_view.dart';
import 'package:flutter_dowith/view/splash/signup_view.dart';

class LoginSignUpScreen extends StatefulWidget {
  const LoginSignUpScreen({super.key});

  @override
  State<LoginSignUpScreen> createState() => _LoginSignUpScreenState();
}

class _LoginSignUpScreenState extends State<LoginSignUpScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isSignup = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                children: [
                  Placeholder(
                    fallbackHeight: 200,
                  ),
                  TextButton(onPressed: (){
                    setState(() {
                      _isSignup = !_isSignup;
                    });
                  }, child: const Text("Switch")),
                  _isSignup? const SignUpView(): const LoginView() ,
                  SizedBox(height: kToolbarHeight)
                ],
              )),
        ),
      ),
    );
  }
}
