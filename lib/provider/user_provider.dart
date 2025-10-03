import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/auth_services.dart';

class UserProvider with ChangeNotifier {
  final AuthServices _authServices = AuthServices();

  UserModel? _user;
  UserModel? get user => _user;

  /// Set user
  void setUser(UserModel user) {
    _user = user;
    notifyListeners();
  }

  /// Register User
  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    final userModel =
    await _authServices.registerUser(email: email, password: password);
    if (userModel != null) {
      setUser(userModel);
    }
  }

  /// Login User
  Future<void> login({
    required String email,
    required String password,
  }) async {
    final userModel =
    await _authServices.loginUser(email: email, password: password);
    if (userModel != null) {
      setUser(userModel);
    }
  }

  /// Reset password
  Future<void> resetPassword(String email) async {
    await _authServices.resetPassword(email);
  }
}