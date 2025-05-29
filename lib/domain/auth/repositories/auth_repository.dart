import 'package:swiss_travel_platform/domain/auth/entities/user.dart';

abstract class AuthRepository {
  Future<User> signInWithGoogle();
  Future<User> signInWithKakao();
  Future<User> signInWithNaver();
  Future<void> signOut();
  Stream<User?> get authStateChanges;
} 