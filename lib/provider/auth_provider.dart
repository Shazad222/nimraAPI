import 'package:flutter/material.dart';
import '../data/auth_repository.dart';

class AuthProvider with ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  Future<bool> login(String email, String password) async {
    bool success = await _authRepository.driverLogin(email, password);
    _isAuthenticated = success;
    notifyListeners();
    return success;
  }
}
