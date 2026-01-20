import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final steamKeyProvider = Provider<String>((ref) => dotenv.env['STEAM_API_KEY']  ?? '',);
final igdbClientIdProvider = Provider<String>((ref) => dotenv.env['IGDB_CLIENT_ID'] ?? '');
final igdbClientSecretProvider = Provider<String>((ref) => dotenv.env['IGDB_CLIENT_SECRET'] ?? '');