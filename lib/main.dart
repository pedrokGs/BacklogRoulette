import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async{
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

