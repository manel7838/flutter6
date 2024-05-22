import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:pfe/features/profile/models/admin_model.dart';

//a verif
abstract class BaseAuthRepository {
  Stream<auth.User?> get admin;
  Future<auth.User?> signUp({
    required String password,
    required Admin admin,
  });
  // Future<void> logInWithGoogle();
  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<void> signOut();
}
