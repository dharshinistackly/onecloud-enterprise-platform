import 'package:flutter/foundation.dart';

class AuthProvider extends ChangeNotifier {
  bool _showTwoFactor = false;
  bool _isAuthenticated = false;

  String? _organizationName;
  String? _organizationCode;
  String? _registeredEmail;
  String? _registeredUsername;
  String? _registeredPassword;

  bool get showTwoFactor => _showTwoFactor;
  bool get isAuthenticated => _isAuthenticated;

  bool get hasRegisteredAccount =>
      _organizationCode != null &&
      _registeredEmail != null &&
      _registeredPassword != null;

  String get organizationName => _organizationName ?? '';

  String get organizationCode => _organizationCode ?? '';

  String get registeredEmail => _registeredEmail ?? '';

  String get registeredUsername => _registeredUsername ?? '';

  void registerAccount({
    required String organizationName,
    required String organizationCode,
    required String email,
    required String username,
    required String password,
  }) {
    _organizationName = organizationName.trim();
    _organizationCode = organizationCode.trim().toLowerCase();
    _registeredEmail = email.trim().toLowerCase();
    _registeredUsername = username.trim().toLowerCase();
    _registeredPassword = password;

    _showTwoFactor = false;
    _isAuthenticated = false;

    notifyListeners();
  }

  bool isWorkspaceValid(String workspace) {
    if (!hasRegisteredAccount) {
      return false;
    }

    return workspace.trim().toLowerCase() ==
        _organizationCode;
  }

  bool isEmailValid(String email) {
    if (!hasRegisteredAccount) {
      return false;
    }

    return email.trim().toLowerCase() ==
        _registeredEmail;
  }

  bool isIdentityValid({
    required String workspace,
    required String email,
  }) {
    if (!hasRegisteredAccount) {
      return false;
    }

    return isWorkspaceValid(workspace) &&
        isEmailValid(email);
  }

  bool isPasswordValid(String password) {
    if (!hasRegisteredAccount) {
      return false;
    }

    return password == _registeredPassword;
  }

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