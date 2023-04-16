import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dowith/utils/theme/app_theme.dart';
import 'package:flutter_dowith/bloc/sqflite_bloc/sql_bloc.dart';
import 'package:flutter_dowith/bloc/sqflite_bloc/sql_repository.dart';
import 'package:flutter_dowith/navi_home.dart';
import 'package:flutter_dowith/utils/glow_remover.dart';
import 'package:flutter_dowith/utils/riverpod/page_route_provider.dart';
import 'package:flutter_dowith/utils/theme/theme_provider.dart';
import 'package:flutter_dowith/view/splash/login_signup_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter_dowith/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';


final themeProv = ChangeNotifierProvider((ref) => ThemeProvider());
final routeProv = ChangeNotifierProvider((ref) => PageRouteProvider());
final bloc = SqlBloc(SqlRepository());
late final SharedPreferences prefs;

void loadPref() async {
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
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.grey,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
        title: "Do With!",
        theme: ThemeData(colorScheme: ref.watch(themeProv).lightColorScheme, fontFamilyFallback: ["QuickSand", "NotoSans"], useMaterial3: true),
        darkTheme: ThemeData(colorScheme: ref.watch(themeProv).darkColorScheme, fontFamilyFallback: ["QuickSand", "NotoSans"], useMaterial3: true),
        themeMode: ref.watch(themeProv).themeMode,
        scrollBehavior: ScrollGlowRemove(),
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          top: false,
          bottom: false,
          child: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const LoginSignUpScreen();
                }
                return const NaviHome();
              }),
        ));
  }
}
