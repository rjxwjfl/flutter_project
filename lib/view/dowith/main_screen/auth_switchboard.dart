import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dowith/bloc/database_bloc/userCtrl/auth.dart';
import 'package:flutter_dowith/view/dowith/main_screen/dowith_navi_screen.dart';
import 'package:flutter_dowith/view/login/login_signup_screen.dart';

class AuthSwitchBoard extends StatefulWidget {
  const AuthSwitchBoard({Key? key}) : super(key: key);

  @override
  State<AuthSwitchBoard> createState() => _AuthSwitchBoardState();
}

class _AuthSwitchBoardState extends State<AuthSwitchBoard> {
  @override
  Widget build(BuildContext context) {
    return  StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User? user = snapshot.data;
          if (user != null) {
            return const DoWithTabScreen();
          } else {
            return LoginSignUpScreen(
              callback: (){
              if (mounted){
                setState(() {});
              }
            },);
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
