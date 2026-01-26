import 'package:backlog_roulette/core/di/global_providers.dart';
import 'package:backlog_roulette/features/games/models/models/game/game.dart';
import 'package:backlog_roulette/features/games/models/repositories/game_repository.dart';
import 'package:backlog_roulette/features/games/models/services/igdb_service.dart';
import 'package:backlog_roulette/features/games/models/services/steam_service.dart';
import 'package:backlog_roulette/features/games/viewmodels/library/library_state.dart';
import 'package:backlog_roulette/features/games/viewmodels/library/library_notifier.dart';
import 'package:backlog_roulette/features/games/viewmodels/roulette/roulette_notifier.dart';
import 'package:backlog_roulette/features/games/viewmodels/roulette/roulette_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Injeção de Dependência para jogos.

// Providers

final steamServiceProvider = Provider<SteamService>(
  (ref) => SteamService(steamKey: ref.read(steamKeyProvider)),
);

final igdbServiceProvider = Provider<IGDBService>(
  (ref) => IGDBService(
    clientId: ref.read(igdbClientIdProvider),
    clientSecret: ref.read(igdbClientSecretProvider),
  ),
);

final gameRepositoryProvider = Provider<GameRepository>(
  (ref) => GameRepository(
    steamService: ref.watch(steamServiceProvider),
    igdbService: ref.watch(igdbServiceProvider),
    firestore: ref.watch(firestoreProvider),
  ),
);

// Notifiers
final libraryNotifier = NotifierProvider<LibraryNotifier, LibraryState>(
  LibraryNotifier.new,
);
final rouletteNotifier = NotifierProvider<RouletteNotifier, RouletteState>(
  RouletteNotifier.new,
);

// Selectors
/// Pega todos os jogos atualmente selecionados na roleta
final rouletteSelectedIdsProvider = Provider<Set<String>>(
  (ref) => ref.read(rouletteNotifier.notifier).selectedIds,
);

/// Pega os jogos atualmente carregados na biblioteca do usuário
final userGamesProvider = Provider<List<Game>>(
  (ref) => ref.watch(libraryNotifier).maybeMap(loaded: (state) => state.games, orElse: () => []),
);

/// Reseta a biblioteca carregada do usuário, retornando o estado para inicial
final resetLibraryStateProvider = Provider<void>(
    (ref) => ref.read(libraryNotifier.notifier).resetState()
);