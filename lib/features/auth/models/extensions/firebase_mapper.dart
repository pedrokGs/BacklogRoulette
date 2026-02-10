import 'package:backlog_roulette/features/auth/models/models/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

extension FirebaseUserExtension on User {
  AppUser toDomain() {
    return AppUser(id: uid, email: email ?? "", username: displayName ?? "");
  }
}
