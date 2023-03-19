import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(
//     MultiProvider(
//       child: const AppMain(),
//       providers: [
//         Provider<Auth>(create: (_) => Auth(FirebaseAuth.instance)),
//         StreamProvider(
//             create: (context) => context.read<Auth>().authState,
//             initialData: null),
//         ChangeNotifierProvider(create: (context) => LocationProvider()),
//       ],
//     ),
//   );
// }
//
// class AppMain extends StatelessWidget {
//   const AppMain({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
//       statusBarColor: Colors.transparent,
//       statusBarIconBrightness: Brightness.dark,
//       statusBarBrightness: Brightness.dark,
//     ));
//     return MaterialApp(
//         title: 'title',
//         home: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(),
//           builder: (context, snapshot){
//             if (!snapshot.hasData){
//               return const LoginScreen();
//             }
//             return const AppOutline();
//           },
//         )
//     );
//   }
// }
//
// class AuthWrapper extends StatelessWidget {
//   const AuthWrapper({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final firebaseUser = context.watch<User?>();
//     if (firebaseUser!=null){
//       return const AppOutline();
//     }
//     return const LoginScreen();
//   }
// }


// class Auth {
//   final FirebaseAuth _auth;
//
//   Auth(this._auth);
//
//   Stream<User?> get authState => FirebaseAuth.instance.authStateChanges();
//
//   /// Log In with E-mail Session
//   Future<void> loginWithEmail({
//     required String email,
//     required String password,
//     required BuildContext context,
//   }) async {
//     try {
//       await _auth.signInWithEmailAndPassword(email: email, password: password);
//       if (!_auth.currentUser!.emailVerified) {
//         await sendEmailVerification(context);
//       } else {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => const AppOutline(),
//           ),
//         );
//       }
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'too-many-requests') {
//         showSnackBar(context, '요청이 너무 많습니다. 잠시 후 다시 시도해주세요.');
//       }
//       if (e.code == 'wrong-password') {
//         showSnackBar(context, '비밀번호를 다시 확인해주세요.');
//       }
//       if (e.code == 'user-not-found') {
//         showSnackBar(context, '이메일 주소를 확인해주세요.');
//       }
//     }
//   }
//
//   /// Sign Up with E-mail Session
//   Future<void> signUpWithEmail({
//     required String email,
//     required String password,
//     required BuildContext context,
//     required DateTime signUpDate,
//   }) async {
//     try {
//       await _auth.createUserWithEmailAndPassword(
//           email: email, password: password);
//       await sendEmailVerification(context);
//       signOut(context);
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'email-already-in-use') {
//         showSnackBar(context, '이미 존재하는 메일 주소입니다.');
//       }
//       showSnackBar(context, e.message!);
//       print(e.code);
//     }
//   }
//
//   ///Sign in with Google
//   Future<void> signInWithGoogle(BuildContext context) async {
//     try {
//       final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//       final GoogleSignInAuthentication? googleAuth =
//       await googleUser?.authentication;
//       if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
//         final credential = GoogleAuthProvider.credential(
//           accessToken: googleAuth?.accessToken,
//           idToken: googleAuth?.idToken,
//         );
//         UserCredential userCredential =
//         await _auth.signInWithCredential(credential);
//         if (userCredential.user !=null){
//           if(userCredential.additionalUserInfo!.isNewUser){
//             /// 초기 실행 시 파이어스토어 문서 && 프로필 작성 위치
//             final FirebaseFirestore firestore = FirebaseFirestore.instance;
//             final DateTime dateTime = DateTime.now();
//             firestore.collection('user_data').doc(googleUser?.email).set({
//               'UserEmail':googleUser?.email,
//               'UserName':googleUser?.displayName,
//               'SignupDate':dateTime,
//             });
//           }
//         }
//       }
//     } on FirebaseAuthException catch (e) {
//       showSnackBar(context, e.message!);
//     }
//   }
//
//   /// Log Out Session
//   Future<void> signOut(BuildContext context) async {
//     try {
//       await _auth.signOut();
//     } on FirebaseAuthException catch (e) {
//       showSnackBar(context, e.message!);
//     }
//   }
//
//   /// E-mail verification
//   Future<void> sendEmailVerification(BuildContext context) async {
//     try {
//       _auth.currentUser!.sendEmailVerification();
//       showSnackBar(context, '이메일 인증이 발송되었습니다. \n 인증을 완료해주세요.');
//     } on FirebaseAuthException catch (e) {
//       showSnackBar(context, e.message!);
//     }
//   }
// }
//
// void showSnackBar(BuildContext context, String text) {
//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       content: Text(text),
//       behavior: SnackBarBehavior.floating,
//       margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
//       elevation: 30,
//       shape: const StadiumBorder(),
//       backgroundColor: AppTheme.themeOrange,
//     ),
//   );
// }