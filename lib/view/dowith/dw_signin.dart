import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dowith/firebase/auth.dart';
import 'package:flutter_dowith/view/dowith/dw_navi_home.dart';
import 'package:flutter_dowith/view/splash/login_signup_screen.dart';

class DwSignIn extends StatelessWidget {
  const DwSignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User? user = snapshot.data;
          if (user != null) {
            return const DwNaviHome();
          } else {
            return const LoginSignUpScreen();
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
