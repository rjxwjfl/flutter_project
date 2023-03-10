import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_dowith/navi_home.dart';
import 'package:flutter_dowith/theme/theme_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final themeProv = ChangeNotifierProvider((ref) => ThemeProvider());


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
