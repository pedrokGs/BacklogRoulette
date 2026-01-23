class GameMetadata {
  final String? igdbId;
  final String? steamAppId;
  final String name;
  final String? coverUrl;
  final List<String> genres;

  GameMetadata({
    this.igdbId,
    this.steamAppId,
    required this.name,
    this.coverUrl,
    this.genres = const [],
  });

  factory GameMetadata.fromJson(Map<String, dynamic> json, {String? steamId}) {
    final String? extractedIgdbId = (json['id'] ?? json['igdbId'])?.toString();

    String? extractedUrl;
    if (json['cover'] is Map) {
      extractedUrl = json['cover']['url'];
    } else {
      extractedUrl = json['coverUrl'];
    }

    List<String> extractedGenres = [];
    if (json['genres'] is List) {
      extractedGenres = (json['genres'] as List)
          .map((g) => g is Map ? g['name'].toString() : g.toString())
          .toList();
    }

    return GameMetadata(
      igdbId: extractedIgdbId,
      steamAppId: steamId ?? json['steamAppId']?.toString(),
      name: json['name'] ?? 'Unknown Game',
      coverUrl: extractedUrl,
      genres: extractedGenres,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'igdbId': igdbId,
      'steamAppId': steamAppId,
      'name': name,
      'coverUrl': coverUrl,
      'genres': genres,
    };
  }
}