import 'package:backlog_roulette/di/api_providers.dart';
import 'package:backlog_roulette/features/auth/models/services/auth_service.dart';
import 'package:backlog_roulette/features/games/models/repositories/game_repository.dart';
import 'package:backlog_roulette/features/games/models/services/igdb_service.dart';
import 'package:backlog_roulette/features/games/models/services/steam_game_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final steamGameServiceProvider = Provider(
  (ref) => SteamGameService(steamKey: ref.read(steamKeyProvider)),
);
final igdbServiceProvider = Provider(
  (ref) => IGDBService(
    clientId: ref.read(igdbClientIdProvider),
    clientSecret: ref.read(igdbClientSecretProvider),
  ),
);
final gameRepositoryProvider = Provider((ref) => GameRepository(steamService: ref.watch(steamGameServiceProvider), igdbService: ref.watch(igdbServiceProvider), firestore: FirebaseFirestore.instance),);

final authServiceProvider = Provider((ref) => AuthService(firebaseAuth: FirebaseAuth.instance),);