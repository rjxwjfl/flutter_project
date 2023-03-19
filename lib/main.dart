import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dowith/firebase/auth.dart';
import 'package:flutter_dowith/view/splash/login_signup_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_dowith/bloc/sql_bloc.dart';
import 'package:flutter_dowith/bloc/sql_dao.dart';
import 'package:flutter_dowith/firebase_options.dart';
import 'package:flutter_dowith/theme/theme_provider.dart';

final themeProv = ChangeNotifierProvider((ref) => ThemeProvider());
final bloc = SqlBloc(SqlDao());

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SystemChrome.setPreferredOrientations(
    <DeviceOrientation>[
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  ).then((value) => runApp(const ProviderScope(child: AppInit())));
}

class AppInit extends ConsumerWidget {
  const AppInit({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: "Do With!",
      theme: ThemeData(
          useMaterial3: true, colorScheme: ref.watch(themeProv).colorScheme),
      home: StreamBuilder(
        stream: Auth().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active){
            final User? user = snapshot.data;
            if (user != null){
              // navihome route
            } else {
              // signin session
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
          return const LoginSignUpScreen();
        }
      ),
    );
  }
}
