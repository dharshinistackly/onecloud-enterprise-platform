import 'package:flutter/foundation.dart';

class AuthProvider extends ChangeNotifier {
  bool _showTwoFactor = false;

  bool _isAuthenticated = false;

  bool get showTwoFactor => _showTwoFactor;
  bool get isAuthenticated => _isAuthenticated;

  void goToTwoFactor() {
    _showTwoFactor = true;
    notifyListeners();
  }

  void backToLogin() {
    _showTwoFactor = false;
    notifyListeners();
  }

  void completeAuthentication() {
    _isAuthenticated = true;
    notifyListeners();
  }

  void logout() {
    _showTwoFactor = false;
    _isAuthenticated = false;
    notifyListeners();
  }
}