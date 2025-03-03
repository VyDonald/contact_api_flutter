import 'package:flutter/material.dart';
import '../Api_Service/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  Future<bool> login(String email, String password) async {
    bool success = await _authService.login(email, password);
    if (success) {
      _isAuthenticated = true;
      notifyListeners();
    }
    return success;
  }
  Future<bool> register(String name, String email, String password) async {
    return await _authService.register(name, email, password);
  }

  Future<void> logout() async {
    await _authService.logout();
    _isAuthenticated = false;
    notifyListeners();
  }
}
