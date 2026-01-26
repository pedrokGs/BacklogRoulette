import 'package:backlog_roulette/features/games/models/enums/game_mood_enum.dart' show GameMood;

final Map<GameMood, Set<String>> moodToGenres = {
  // TRANQUILO: Foco em relaxar, sem pressão de tempo ou punição severa
  GameMood.tranquilo: {
    'Casual', 'Simulation', 'Farming Sim', 'Relaxing', 'Cozy',
    'Walking Simulator', 'Hidden Object', 'City Builder', 'Building',
    'Life Sim', 'Point & Click', 'Puzzle', 'Visual Novel',
    'Sandbox', 'Adventure', 'Exploration', 'Coloring', 'Education',
    'Card Game', 'Board Game', 'Fishing', 'Management'
  },

  // ELETRIZANTE: Adrenalina, reflexos rápidos, caos e movimento
  GameMood.eletrizante: {
    'Action', 'FPS', 'Third-Person Shooter', 'Racing', 'Fighting',
    'Hack and Slash', 'Fast-Paced', 'Shoot \'em up', 'Bullet Hell',
    'Spectacle fighter', 'Arcade', 'Beat \'em up', 'Runner',
    'Platformer', 'Parkour', 'Battle Royale', 'Roguelike', 'Roguelite',
    'Open World', 'Sports', 'Cyberpunk', 'Shooter'
  },

  // CEREBRAL: Exige planejamento, raciocínio lógico e paciência
  GameMood.cerebral: {
    'Strategy', 'Turn-Based Strategy', 'RTS', 'Card Battler', 'Card Game',
    'Grand Strategy', 'Tower Defense', 'Tactical RPG', 'Management',
    'Board Game', 'Chess', 'Economy', 'Turn-Based Tactics', '4X',
    'Puzzle', 'Puzzle-Platformer', 'Detective', 'Mystery',
    'Simulation', 'Programming', 'Logic', 'City Builder'
  },

  // IMERSIVO: Foco em "entrar" no mundo, história profunda ou atmosfera
  GameMood.imersivo: {
    'RPG', 'JRPG', 'CRPG', 'Open World', 'Story Rich', 'Atmospheric',
    'Adventure', 'Visual Novel', 'Choices Matter', 'Exploration',
    'Lore-Rich', 'Medieval', 'Sci-fi', 'Fantasy', 'Cyberpunk',
    'First-Person', 'Third-Person', 'Walking Simulator', 'Noir',
    'Narrative', 'Drama', 'Horror' // Horror é extremamente imersivo
  },

  // TENSO: Medo, dificuldade punitiva, escassez de recursos ou pressão
  GameMood.tenso: {
    'Horror', 'Survival Horror', 'Psychological Horror', 'Survival',
    'Difficult', 'Souls-like', 'Zombies', 'Stealth', 'Post-apocalyptic',
    'Dystopian', 'Dark', 'Mystery', 'Perma Death', 'Roguelike',
    'Thriller', 'Tactical', 'FPS', 'Battle Royale'
  },

  // COMPETITIVO: Foco em vencer outros jogadores ou rankings
  GameMood.competitivo: {
    'Multiplayer', 'eSports', 'PvP', 'Online Co-Op', 'Sports',
    'MOBA', 'Battle Royale', 'Team-Based', 'Competitive', 'Ranked',
    'FPS', 'Fighting', 'RTS', 'Racing', 'Shooter', 'Card Battler',
    'Tactical', 'Wargame'
  }
};

GameMood? getMoodFromString(String input) {
  return GameMood.values.firstWhere(
        (e) => e.name == input.toLowerCase().trim(),
    orElse: () => GameMood.tranquilo, // Fallback padrão
  );
}