import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dowith/firebase/firestore_user.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class Auth {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  String baseUrl = "";

  get auth => _auth;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<void> signUpWithEmail(context, String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      // 서버로 데이터 전송 => username : email, password : password, name: name, fb_uid : _auth.currentUser!.uid, device_token: _messaging.getToken()
      // name 설정하는 페이지 추가해야함.
      await sendEmailVerification(context); // 이메일 인증은 그냥 빼버리는게 나을지도?
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showSnackBar(context, '이미 사용중인 이메일입니다.');
      }
    }
  }

  Future<User?> signInWithEmail(context, String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (!_auth.currentUser!.emailVerified) {
        await sendEmailVerification(context);
      } else {
        // 응답에 따라 처리 혹은 반려
        showSnackBar(context, "${_auth.currentUser!.displayName}님 환영합니다.");
        return _auth.currentUser;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackBar(context, '이메일 주소를 확인해주세요.');
      }
      if (e.code == 'wrong-password') {
        showSnackBar(context, '비밀번호를 다시 확인해주세요.');
      }
    }
    return null;
  }

  Future<void> signInUpWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      // username : userCredential.user!.email, name : userCredential.user!.displayName, fb_uid : _auth.currentUser.uid;

      // FireStoreUser fireStoreUser = FireStoreUser();
      // if (!await fireStoreUser.userExistCheck(userCredential.user!.uid)) {
      //   fireStoreUser.createUserData();
      // }
    } catch (e) {
      print(e);
    }
  }

  Future<void> signOutSession() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
    } catch (e) {
      print(e);
    }
  }

  Future<void> sendEmailVerification(context) async {
    try {
      _auth.currentUser!.sendEmailVerification();
      showSnackBar(context, '이메일 인증이 발송되었습니다. \n 인증을 완료해주세요.');
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  void showSnackBar(context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text, textAlign: TextAlign.center),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 50),
        elevation: 30,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
      ),
    );
  }
}
