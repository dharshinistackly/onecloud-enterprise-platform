import 'package:flutter/foundation.dart';

class AuthProvider extends ChangeNotifier {
  // Controls whether the login screen or 2-step verification is shown.
  bool _showTwoFactor = false;

  // Controls whether the user has completed authentication.
  bool _isAuthenticated = false;

  bool get showTwoFactor => _showTwoFactor;
  bool get isAuthenticated => _isAuthenticated;

  // Move from Login to 2-Step Verification.
  void goToTwoFactor() {
    _showTwoFactor = true;
    notifyListeners();
  }

  // Move back from 2-Step Verification to Login.
  void backToLogin() {
    _showTwoFactor = false;
    notifyListeners();
  }

  // Complete the authentication process.
  void completeAuthentication() {
    _isAuthenticated = true;
    notifyListeners();
  }

  // Reset authentication state.
  void logout() {
    _showTwoFactor = false;
    _isAuthenticated = false;
    notifyListeners();
  }
}