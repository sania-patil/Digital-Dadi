import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  // Anonymous sign in
  static Future<UserCredential> signInAnonymously() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      return result;
    } on FirebaseAuthException catch (e) {
      throw Exception('Anonymous sign in error: ${e.message}');
    }
  }

  // Sign in with email
  static Future<UserCredential> signInWithEmail(
    String email,
    String password,
  ) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result;
    } on FirebaseAuthException catch (e) {
      throw Exception('Sign in error: ${e.message}');
    }
  }

  // Sign up with email
  static Future<UserCredential> signUpWithEmail(
    String email,
    String password,
  ) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result;
    } on FirebaseAuthException catch (e) {
      throw Exception('Sign up error: ${e.message}');
    }
  }

  // Get current user
  static User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Sign out
  static Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception('Sign out error: ${e.toString()}');
    }
  }

  // Check if user is signed in
  static bool isSignedIn() {
    return _auth.currentUser != null;
  }

  // Get user ID
  static String? getUserId() {
    return _auth.currentUser?.uid;
  }

  // Get user email
  static String? getUserEmail() {
    return _auth.currentUser?.email;
  }

  // Reset password
  static Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw Exception('Password reset error: ${e.toString()}');
    }
  }

  // Update user email
  static Future<void> updateEmail(String newEmail) async {
    try {
      await _auth.currentUser?.updateEmail(newEmail);
    } catch (e) {
      throw Exception('Email update error: ${e.toString()}');
    }
  }

  // Update user password
  static Future<void> updatePassword(String newPassword) async {
    try {
      await _auth.currentUser?.updatePassword(newPassword);
    } catch (e) {
      throw Exception('Password update error: ${e.toString()}');
    }
  }

  // Delete user account
  static Future<void> deleteAccount() async {
    try {
      await _auth.currentUser?.delete();
    } catch (e) {
      throw Exception('Delete account error: ${e.toString()}');
    }
  }
}
