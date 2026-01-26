import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Providers que carregam dados únicos e necessários para funcionamento do app, como chaves de APIs,
// Instâncias Singleton, etc

final steamKeyProvider = Provider<String>((ref) => dotenv.env['STEAM_API_KEY']  ?? '',); // Steam Api Key
final igdbClientIdProvider = Provider<String>((ref) => dotenv.env['IGDB_CLIENT_ID'] ?? ''); // IGDB Client Id
final igdbClientSecretProvider = Provider<String>((ref) => dotenv.env['IGDB_CLIENT_SECRET'] ?? ''); // IGDB Client Secret
final firebaseAuthProvider = Provider<FirebaseAuth>((ref) => FirebaseAuth.instance); // Firebase Auth
final firestoreProvider = Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance); // Firebase Firestore