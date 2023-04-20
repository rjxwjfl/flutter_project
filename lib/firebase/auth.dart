import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dowith/bloc/database_bloc/model/user/user_model.dart';
import 'package:flutter_dowith/main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class Auth {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  String baseUrl = "http://10.0.2.2:8080";

  get auth => _auth;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<void> signUpWithEmail(context, String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password).then((value) async {
        String? token = await _messaging.getToken();
        Map<String, dynamic> body = {
          "username": "Test@test.com",
          "user_pw": "TEST PW",
          "name": "Test@test.com",
          "contact": "",
          "device_token": token,
          "fb_uid": "TEST UID"
        };
        final response = await http.post(Uri.parse("$baseUrl/user/config"),
            headers: {"Content-Type": "application/json"}, body: jsonEncode(body));
        if (response.statusCode == 200) {
          Map<String, dynamic> data = jsonDecode(response.body);
          prefs.setInt("user_id", data.values as int);
        } else {
          throw Exception('Failed to join');
        }
      });
      // 서버로 데이터 전송 => username : email, password : password, name: name, fb_uid : _auth.currentUser!.uid, device_token: _messaging.getToken()
      // name 설정하는 페이지 추가해야함.
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

      await _auth.signInWithCredential(credential).then((value) async {
        if (value.additionalUserInfo!.isNewUser) {
          String? token = await _messaging.getToken();
          Map<String, dynamic> body = {
            "username": value.user!.email,
            "name": value.user!.email,
            "password": null,
            "contact": value.user!.phoneNumber,
            "device_token": token,
            "fb_uid": value.user!.uid
          };
          final response = await http.post(Uri.parse("$baseUrl/user/config"),
              headers: {"Content-Type": "application/json"}, body: jsonEncode(body));
          if (response.statusCode == 200) {
            Map<String, dynamic> data = jsonDecode(response.body);
            print(data.entries);
            print("key : ${data.entries.first.key}, value: ${data.entries.first.value}");
            prefs.setInt("user_id", data.entries.first.value);
          } else {
            throw Exception('Failed to fetch projects');
          }
        }

        final response = await http.post(
          Uri.parse("$baseUrl/user/info"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"username": value.user!.email}),
        );
        if (response.statusCode == 200) {
          List<dynamic> data = jsonDecode(response.body);
          Map<String, dynamic> userData = data[0];
          UserModel model = UserModel.fromMap(userData);
          print(model);
          prefs.setInt("user_id", model.userId!);
        }
        print("user exist. ${value.user!.phoneNumber}");
      });
      return;
    } catch (e) {
      print("Error : $e");
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
// // register user
// String? token = await _messaging.getToken();
// Map<String, dynamic> body = {
//   "username": "Test@test.com",
//   "user_pw": "TEST PW",
//   "name": "Test@test.com",
//   "contact": null,
//   "device_token": token,
//   "fb_uid": "TEST UID"
// };
// final response =
//     await http.post(Uri.parse(baseUrl), headers: {"Content-Type": "application/json"}, body: jsonEncode(body));
// if (response.statusCode == 200) {
// Map<String, dynamic> data = jsonDecode(response.body);
// prefs.setInt("user_id", data["user_id"]);
// } else {
// throw Exception('Failed to fetch projects');
// }
