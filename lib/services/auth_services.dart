import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Register User
  Future<UserModel?> registerUser({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCred.user;
      if (user != null) {
        return UserModel(
          docId: user.uid, // 🔹 use docId instead of userId
          name: "",
          email: email,
          profileImageUrl: "",
          degreeImageUrl: "",
          address: "",
          contact: "",
          experience: "",
          qualification: "",
          createdAt: DateTime.now(),
        );
      }
      return null;
    } catch (e) {
      throw e.toString();
    }
  }

  /// Login User
  Future<UserModel?> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCred.user;
      if (user != null) {
        return UserModel(
          docId: user.uid, // 🔹 again docId
          name: "",
          email: email,
          profileImageUrl: "",
          degreeImageUrl: "",
          address: "",
          contact: "",
          experience: "",
          qualification: "",
          createdAt: DateTime.now(),
        );
      }
      return null;
    } catch (e) {
      throw e.toString();
    }
  }

  /// Reset Password
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw e.toString();
    }
  }
}