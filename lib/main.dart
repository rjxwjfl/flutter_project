import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dowith/firebase/auth.dart';
import 'package:flutter_dowith/navi_home.dart';
import 'package:flutter_dowith/riverpod/page_route_provider.dart';
import 'package:flutter_dowith/view/splash/login_signup_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_dowith/bloc/sql_bloc.dart';
import 'package:flutter_dowith/bloc/sql_dao.dart';
import 'package:flutter_dowith/firebase_options.dart';
import 'package:flutter_dowith/theme/theme_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeProv = ChangeNotifierProvider((ref) => ThemeProvider());
final routeProv = ChangeNotifierProvider((ref) => PageRouteProvider());
final bloc = SqlBloc(SqlDao());
late final SharedPreferences prefs;

void loadPref() async{
  prefs = await SharedPreferences.getInstance();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  loadPref();
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
      theme: ThemeData.from(colorScheme: ref.watch(themeProv).lightColorScheme),
      darkTheme: ThemeData.from(colorScheme: ref.watch(themeProv).darkColorScheme),
      themeMode: ref.watch(themeProv).themeMode,
      home: SafeArea(
        child: StreamBuilder(
          stream: Auth().authStateChanges,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active){
              final User? user = snapshot.data;
              if (user != null){
                return const NaviHome();
              } else {
                return const LoginSignUpScreen();
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }
        ),
      ),
    );
  }
}
