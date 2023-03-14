import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dowith/bloc/internal_db_bloc.dart';
import 'package:flutter_dowith/bloc/sql_dao.dart';
import 'package:flutter_dowith/firebase_options.dart';

import 'package:flutter_dowith/navi_home.dart';
import 'package:flutter_dowith/theme/theme_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



final themeProv = ChangeNotifierProvider((ref) => ThemeProvider());
final bloc = InternalDbBloc(SqlDao());

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
      home: const NaviHome(),
    );
  }
}
