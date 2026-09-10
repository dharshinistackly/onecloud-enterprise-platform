import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../routes/app_routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  void _login() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_otpController.text.trim() != '123456') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid OTP. Please enter 123456 for demo.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    context.read<AuthProvider>().completeAuthentication();

    Future.delayed(const Duration(milliseconds: 500), () {
      if (!mounted) return;

      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.home,
        (route) => false,
      );
    });
  }

  void _resendOtp() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('A new OTP has been sent. Demo OTP: 123456'),
        backgroundColor: Color(0xFF1677C8),
      ),
    );
  }

  void _openSocialLogin(String provider) {
    Navigator.pushNamed(
      context,
      AppRoutes.socialLogin,
      arguments: provider,
    );
  }

  InputDecoration _inputDecoration({
    required String hintText,
    required IconData icon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      prefixIcon: Icon(
        icon,
        color: const Color(0xFF1677C8),
      ),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: const Color(0xFFF8FAFC),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 17,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: Color(0xFFE2E8F0),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: Color(0xFFE2E8F0),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: Color(0xFF1677C8),
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: Colors.red,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 2,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 30,
            ),
            child: Container(
              width: 480,
              padding: const EdgeInsets.all(38),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white,
                    Colors.blue.shade50,
                  ],
                ),
                borderRadius: BorderRadius.circular(26),
                border: Border.all(
                  color: const Color(0xFFE2E8F0),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.shade200.withValues(alpha: 0.30),
                    blurRadius: 35,
                    offset: const Offset(0, 15),
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Logo
                    Center(
                      child: Image.asset(
                        'assets/onecloud_logo.jpg',
                        width: 190,
                        height: 70,
                        fit: BoxFit.contain,
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Center(
                      child: Text(
                        'Welcome Back',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F3D66),
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Center(
                      child: Text(
                        'Sign in to your OneCloud Enterprise account',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Email
                    const Text(
                      'Email Address',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF334155),
                      ),
                    ),

                    const SizedBox(height: 8),

                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: _inputDecoration(
                        hintText: 'Enter your email',
                        icon: Icons.email_outlined,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your email';
                        }

                        if (!value.contains('@')) {
                          return 'Please enter a valid email';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    // Password
                    const Text(
                      'Password',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF334155),
                      ),
                    ),

                    const SizedBox(height: 8),

                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: _inputDecoration(
                        hintText: 'Enter your password',
                        icon: Icons.lock_outline,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }

                        if (value.length < 6) {
                          return 'Password must contain at least 6 characters';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    // OTP
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'OTP Verification',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF334155),
                          ),
                        ),
                        TextButton(
                          onPressed: _resendOtp,
                          child: const Text(
                            'Resend OTP',
                            style: TextStyle(
                              color: Color(0xFF1677C8),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    TextFormField(
                      controller: _otpController,
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                      decoration: _inputDecoration(
                        hintText: 'Enter 6-digit OTP',
                        icon: Icons.verified_user_outlined,
                      ).copyWith(
                        counterText: '',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter the OTP';
                        }

                        if (value.length != 6) {
                          return 'OTP must contain 6 digits';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      'Demo OTP: 123456',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF64748B),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Forgot Password
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.forgotPassword,
                          );
                        },
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Color(0xFF1677C8),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Login Button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1677C8),
                          foregroundColor: Colors.white,
                          disabledBackgroundColor:
                              const Color(0xFF94A3B8),
                          elevation: 5,
                          shadowColor: const Color(0xFF1677C8)
                              .withValues(alpha: 0.35),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  color: Colors.white,
                                ),
                              )
                            : const Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    // Divider
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Colors.grey.shade300,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            'OR',
                            style: TextStyle(
                              color: Color(0xFF94A3B8),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: Colors.grey.shade300,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 22),

                    // Social Login
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              _openSocialLogin('Google');
                            },
                            icon: const Icon(
                              Icons.g_mobiledata,
                              size: 26,
                              color: Color(0xFF1677C8),
                            ),
                            label: const Text(
                              'Google',
                              style: TextStyle(
                                color: Color(0xFF334155),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              minimumSize: const Size(0, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              side: const BorderSide(
                                color: Color(0xFFE2E8F0),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              _openSocialLogin('Facebook');
                            },
                            icon: const Icon(
                              Icons.facebook,
                              size: 22,
                              color: Color(0xFF1677C8),
                            ),
                            label: const Text(
                              'Facebook',
                              style: TextStyle(
                                color: Color(0xFF334155),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              minimumSize: const Size(0, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              side: const BorderSide(
                                color: Color(0xFFE2E8F0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 25),

                    // Sign Up
                    Center(
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account? ",
                            style: TextStyle(
                              color: Color(0xFF64748B),
                              fontSize: 14,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.signup,
                              );
                            },
                            child: const Text(
                              'Create Account',
                              style: TextStyle(
                                color: Color(0xFF1677C8),
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}