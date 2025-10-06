import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/auth_services.dart';
import '../services/user_services.dart';

class UserProvider with ChangeNotifier {
  final AuthServices _authServices = AuthServices();
  final UserServices _userServices = UserServices();

  UserModel? _user;
  UserModel? get user => _user;

  void setUser(UserModel user) {
    _user = user;
    notifyListeners();
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final userModel =
    await _authServices.registerUser(email: email, password: password);
    if (userModel != null) {
      final updatedUser = userModel.copyWith(name: name);
      await _userServices.createUser(updatedUser);
      setUser(updatedUser);
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    final userModel =
    await _authServices.loginUser(email: email, password: password);
    if (userModel != null) {
      final fetchedUser = await _userServices.getUserById(userModel.docId);
      if (fetchedUser != null) {
        setUser(fetchedUser);
      } else {
        await _userServices.createUser(userModel);
        setUser(userModel);
      }
    }
  }

  Future<void> resetPassword(String email) async {
    await _authServices.resetPassword(email);
  }

  Future<void> updateUser(UserModel updatedUser) async {
    await _userServices.updateUser(updatedUser);
    setUser(updatedUser);
  }

  Future<void> refreshUser() async {
    if (_user == null) return;
    final updatedUser = await _userServices.getUserById(_user!.docId);
    if (updatedUser != null) {
      setUser(updatedUser);
    }
  }
}