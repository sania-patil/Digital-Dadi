import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign up with email and password
  static Future<UserCredential> signUpWithEmail(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception('Sign up error: ${e.message}');
    }
  }

  // Save user registration data to Firestore
  static Future<void> saveUserRegistrationData({
    required String userId,
    required String motherName,
    required String careStage,
    int? pregnancyMonth,
    int? babyAgeWeeks,
    String? deliveryType,
    required String languagePreference,
    required Map<String, Map<String, String>> emergencyContacts,
  }) async {
    try {
      await _firestore.collection('users').doc(userId).set({
        'motherName': motherName,
        'careStage': careStage,
        'pregnancyMonth': pregnancyMonth,
        'babyAgeWeeks': babyAgeWeeks,
        'deliveryType': deliveryType,
        'languagePreference': languagePreference,
        'emergencyContacts': {
          'primary': {
            'name': emergencyContacts['primary']?['name'] ?? '',
            'phone': emergencyContacts['primary']?['phone'] ?? '',
          },
          'secondary': {
            'name': emergencyContacts['secondary']?['name'] ?? '',
            'phone': emergencyContacts['secondary']?['phone'] ?? '',
          },
          'tertiary': {
            'name': emergencyContacts['tertiary']?['name'] ?? '',
            'phone': emergencyContacts['tertiary']?['phone'] ?? '',
          },
        },
        'registrationDate': FieldValue.serverTimestamp(),
        'lastUpdated': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Error saving user data: ${e.toString()}');
    }
  }

  // Update user registration data
  static Future<void> updateUserRegistrationData({
    required String userId,
    required String motherName,
    required String careStage,
    int? pregnancyMonth,
    int? babyAgeWeeks,
    String? deliveryType,
    required String languagePreference,
    required Map<String, Map<String, String>> emergencyContacts,
  }) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'motherName': motherName,
        'careStage': careStage,
        'pregnancyMonth': pregnancyMonth,
        'babyAgeWeeks': babyAgeWeeks,
        'deliveryType': deliveryType,
        'languagePreference': languagePreference,
        'emergencyContacts': {
          'primary': {
            'name': emergencyContacts['primary']?['name'] ?? '',
            'phone': emergencyContacts['primary']?['phone'] ?? '',
          },
          'secondary': {
            'name': emergencyContacts['secondary']?['name'] ?? '',
            'phone': emergencyContacts['secondary']?['phone'] ?? '',
          },
          'tertiary': {
            'name': emergencyContacts['tertiary']?['name'] ?? '',
            'phone': emergencyContacts['tertiary']?['phone'] ?? '',
          },
        },
        'lastUpdated': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Error updating user data: ${e.toString()}');
    }
  }

  // Get current user
  static User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Get user data from Firestore
  static Future<DocumentSnapshot> getUserData(String userId) async {
    try {
      return await _firestore.collection('users').doc(userId).get();
    } catch (e) {
      throw Exception('Error fetching user data: ${e.toString()}');
    }
  }

  // Sign out
  static Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception('Error signing out: ${e.toString()}');
    }
  }

  // Delete user account and data
  static Future<void> deleteUserAccount(String userId) async {
    try {
      // Delete user data from Firestore
      await _firestore.collection('users').doc(userId).delete();
      // Delete user from Firebase Auth
      await _auth.currentUser?.delete();
    } catch (e) {
      throw Exception('Error deleting account: ${e.toString()}');
    }
  }

  // Check if user exists in Firestore
  static Future<bool> userExists(String userId) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('users').doc(userId).get();
      return doc.exists;
    } catch (e) {
      throw Exception('Error checking user existence: ${e.toString()}');
    }
  }

  // Reset password
  static Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw Exception('Error resetting password: ${e.toString()}');
    }
  }
}
