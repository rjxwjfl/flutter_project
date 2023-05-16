import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dowith/bloc/sqflite_bloc/personal_data/personal_todo_bloc.dart';
import 'package:flutter_dowith/bloc/sqflite_bloc/personal_data/personal_todo_repository.dart';
import 'package:flutter_dowith/main_navi_frame.dart';
import 'package:flutter_dowith/riverpod/main_route_provider.dart';
import 'package:flutter_dowith/riverpod/project_draw_up_provider.dart';
import 'package:flutter_dowith/riverpod/user_management_provider.dart';
import 'package:flutter_dowith/utils/glow_remover.dart';
import 'package:flutter_dowith/utils/theme/theme_palette.dart';
import 'package:flutter_dowith/utils/theme/theme_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_dowith/firebase_options.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';


final theme = ChangeNotifierProvider((ref) => ThemeProvider());
final pageRoute = ChangeNotifierProvider((ref) => MainRouteProvider());
final drawUp = ChangeNotifierProvider((ref) => ProjectDrawUpProvider());
final user = ChangeNotifierProvider((ref) => UserManagementProvider());
final bloc = PersonalDataBloc(PersonalRepository());
late final SharedPreferences prefs;

void loadPref() async {
  prefs = await SharedPreferences.getInstance();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initializeDateFormatting();
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
        theme: ThemeData(colorScheme: AppScheme.lightColorScheme, fontFamilyFallback: const ["QuickSand", "NotoSans"], useMaterial3: true),
        darkTheme: ThemeData(colorScheme: AppScheme.darkColorScheme, fontFamilyFallback: const ["QuickSand", "NotoSans"], useMaterial3: true),
        themeMode: ref.watch(theme).themeMode,
        scrollBehavior: ScrollGlowRemove(),
        debugShowCheckedModeBanner: false,
        home: const SafeArea(
          top: false,
          bottom: false,
          child: MainNaviFrame(),
        ));
  }
}
