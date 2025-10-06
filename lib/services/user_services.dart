import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class UserServices {
  final CollectionReference usersCollection =
  FirebaseFirestore.instance.collection('users');

  Future<void> createUser(UserModel user) async {
    try {
      await usersCollection.doc(user.docId).set(user.toJson());
    } catch (e) {
      print("Error creating user: $e");
      rethrow;
    }
  }

  Future<UserModel?> getUserById(String id) async {
    try {
      final doc = await usersCollection.doc(id).get();
      if (doc.exists) {
        return UserModel.fromJson(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      print("Error fetching user: $e");
    }
    return null;
  }

  Future<void> updateUser(UserModel user) async {
    try {
      await usersCollection.doc(user.docId).update({
        "name": user.name,
        "email": user.email,
        "profileImageUrl": user.profileImageUrl,
        "degreeImageUrl": user.degreeImageUrl,
        "address": user.address,
        "contact": user.contact,
        "experience": user.experience,
        "qualification": user.qualification,
        "createdAt": user.createdAt.toIso8601String(),
      });
    } catch (e) {
      print("Error updating user: $e");
      rethrow;
    }
  }
}