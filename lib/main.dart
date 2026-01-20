import 'package:backlog_roulette/config/app_router.dart';
import 'package:backlog_roulette/config/firebase/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'di/notifiers.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(ProviderScope(child: BacklogRoulette()));
}

class BacklogRoulette extends ConsumerWidget{
  const BacklogRoulette({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);
    final flavor = themeState.flavor;

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        pageTransitionsTheme: PageTransitionsTheme(builders: {
          TargetPlatform.android: ZoomPageTransitionsBuilder()
        }),
        useMaterial3: true,
        colorScheme: flavor.lightColors,
        appBarTheme: AppBarTheme(
          backgroundColor: flavor.lightColors.primaryContainer,
        ),
      ),

      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: flavor.darkColors,
        scaffoldBackgroundColor: flavor.darkColors.surface,
      ),

      themeMode: themeState.mode,
      routerConfig: appRouter,
    );
  }

}

