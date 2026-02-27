import 'package:backlog_roulette/features/auth/domain/entities/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Mapper para transformar um [User] do firebaseauth em [AppUser]
extension FirebaseUserExtension on User {
  AppUser toDomain() {
    return AppUser(id: uid, email: email ?? "", username: displayName ?? "");
  }
}
