import 'package:backlog_roulette/config/firebase/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(ProviderScope(child: BacklogRoulette()));
}

class BacklogRoulette extends StatelessWidget{
  const BacklogRoulette({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(

    );
  }

}

