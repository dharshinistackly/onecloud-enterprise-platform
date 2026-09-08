import 'package:flutter/material.dart';

import '../pages/login_page.dart';
import '../pages/two_factor_page.dart';
import '../pages/home_page.dart';
import '../pages/forgot_password_page.dart';
import '../pages/signup_page.dart';
import '../pages/social_login_page.dart';

class AppRoutes {
  static const String login = '/login';
  static const String verify = '/verify';
  static const String home = '/home';
  static const String forgotPassword = '/forgot-password';
  static const String signup = '/signup';
  static const String socialLogin = '/social-login';

  static final Map<String, WidgetBuilder> routes = {
    login: (context) => const LoginPage(),
    verify: (context) => const TwoFactorPage(),
    home: (context) => const HomePage(),
    forgotPassword: (context) => const ForgotPasswordPage(),
    signup: (context) => const SignupPage(),
    socialLogin: (context) => const SocialLoginPage(),
  };
}