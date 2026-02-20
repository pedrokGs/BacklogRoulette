import 'package:backlog_roulette/features/games/models/enums/game_mood_enum.dart'
    show GameMood;

final Map<GameMood, Set<String>> moodToGenres = {
  // TRANQUILO: Foco em relaxar, sem pressão de tempo ou punição severa
  GameMood.calm: {
    'Casual',
    'Simulator',
    'Farming Sim',
    'Relaxing',
    'Cozy',
    'Walking Simulator',
    'Hidden Object',
    'City Builder',
    'Building',
    'Life Sim',
    'Point & Click',
    'Visual Novel',
    'Sandbox',
    'Adventure',
    'Exploration',
    'Coloring',
    'Education',
    'Card Game',
    'Board Game',
    'Fishing',
    'Management',
  },

  // ELETRIZANTE: Adrenalina, reflexos rápidos, caos e movimento
  GameMood.electric: {
    'Action',
    'FPS',
    'Third-Person Shooter',
    'Racing',
    'Fighting',
    'Hack and Slash',
    'Fast-Paced',
    'Shoot \'em up',
    'Bullet Hell',
    'Spectacle fighter',
    'Arcade',
    'Beat \'em up',
    'Runner',
    'Platformer',
    'Platform',
    'Battle Royale',
    'Roguelike',
    'Roguelite',
    'Open World',
    'Sports',
    'Cyberpunk',
    'Shooter',
  },

  // CEREBRAL: Exige planejamento, raciocínio lógico e paciência
  GameMood.brainiac: {
    'Strategy',
    'Turn-Based Strategy',
    'RTS',
    'Card Battler',
    'Card Game',
    'Grand Strategy',
    'Tower Defense',
    'Tactical RPG',
    'Management',
    'Board Game',
    'Chess',
    'Economy',
    'Turn-Based Tactics',
    '4X',
    'Puzzle',
    'Puzzle-Platformer',
    'Detective',
    'Mystery',
    'Simulation',
    'Programming',
    'Logic',
    'City Builder',
  },

  // IMERSIVO: Foco em "entrar" no mundo, história profunda ou atmosfera
  GameMood.immersive: {
    'Role-Playing'
        'Role-Playing (RPG)'
        'RPG',
    'JRPG',
    'CRPG',
    'Open World',
    'Story Rich',
    'Atmospheric',
    'Adventure',
    'Visual Novel',
    'Choices Matter',
    'Exploration',
    'Lore-Rich',
    'Medieval',
    'Sci-fi',
    'Fantasy',
    'Cyberpunk',
    'First-Person',
    'Third-Person',
    'Walking Simulator',
    'Noir',
    'Narrative',
    'Drama',
    'Horror',
  },

  // TENSO: Medo, dificuldade punitiva, escassez de recursos ou pressão
  GameMood.tense: {
    'Horror',
    'Survival Horror',
    'Psychological Horror',
    'Survival',
    'Difficult',
    'Souls-like',
    'Zombies',
    'Stealth',
    'Post-apocalyptic',
    'Dystopian',
    'Dark',
    'Mystery',
    'Perma Death',
    'Roguelike',
    'Thriller',
    'Tactical',
    'Battle Royale',
  },

  // COMPETITIVO: Foco em vencer outros jogadores ou rankings
  GameMood.competitive: {
    'eSports',
    'PvP',
    'MOBA',
    'Battle Royale',
    'Team-Based',
    'Competitive',
    'Ranked',
  },
};

GameMood? getMoodFromString(String input) {
  try {
    return GameMood.values.firstWhere(
      (e) => e.name == input.toLowerCase().trim(),
    );
  } catch (_) {
    return null;
  }
}
