// providers/auth_provider.dart
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  String? _userId;
  String? _userName;
  String? _userPhone;
  bool _isLoading = false;

  bool get isAuthenticated => _userId != null;
  String? get userId => _userId;
  String? get userName => _userName;
  String? get userPhone => _userPhone;
  bool get isLoading => _isLoading;

  Future<bool> login(String phone, String otp) async {
    _isLoading = true;
    notifyListeners();

    // Simulate API call
    await Future.delayed(Duration(seconds: 2));
    
    // Simple validation for MVP
    if (otp == '1234') {
      _userId = 'user_${DateTime.now().millisecondsSinceEpoch}';
      _userName = 'User';
      _userPhone = phone;
      _isLoading = false;
      notifyListeners();
      return true;
    }
    
    _isLoading = false;
    notifyListeners();
    return false;
  }

  void logout() {
    _userId = null;
    _userName = null;
    _userPhone = null;
    notifyListeners();
  }
}