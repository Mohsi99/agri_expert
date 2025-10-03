import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class UserServices {
  final CollectionReference usersCollection =
  FirebaseFirestore.instance.collection('users');

  Future<void> createUser(UserModel user) async {
    await usersCollection.doc(user.docId).set(user.toJson());
  }

  Future<UserModel?> getUserById(String id) async {
    final doc = await usersCollection.doc(id).get();
    if (doc.exists) {
      return UserModel.fromJson(doc.data() as Map<String, dynamic>);
    }
    return null;
  }

  Future<void> updateUser(UserModel user) async {
    await usersCollection.doc(user.docId).update(user.toJson());
  }
}