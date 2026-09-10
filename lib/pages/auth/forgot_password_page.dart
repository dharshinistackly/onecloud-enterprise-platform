import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF0A1E3F),
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 28,
          ),
        ),
        title: Row(
          children: [
            Image.asset(
              'assets/onecloud_logo.jpg',
              width: 140,
              height: 45,
              fit: BoxFit.contain,
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.3),
                  width: 2,
                ),
              ),
              child: const CircleAvatar(
                radius: 19,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.lock_outline,
                  color: Color(0xFF1677C8),
                  size: 22,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Container(
          width: 450,
          padding: const EdgeInsets.all(35),
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                Colors.blue.shade50,
              ],
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: const Color(0xFFE2E8F0),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.shade200.withValues(alpha: 0.3),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF0F3D66), Color(0xFF1677C8)],
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF1677C8).withValues(alpha: 0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.lock_reset_outlined,
                  size: 50,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 25),
              const Text(
                'Reset Your Password',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F3D66),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Enter your registered email address to receive a password reset link.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF64748B),
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  labelStyle: const TextStyle(
                    color: Color(0xFF64748B),
                  ),
                  prefixIcon: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE0F2FE),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.email_outlined,
                      color: Color(0xFF1677C8),
                      size: 22,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(
                      color: Color(0xFFE2E8F0),
                      width: 1.5,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(
                      color: Color(0xFFE2E8F0),
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(
                      color: Color(0xFF1677C8),
                      width: 2,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 5,
                  ),
                ),
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Password reset link sent successfully!',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        backgroundColor: Color(0xFF0F3D66),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                    );
                    Future.delayed(const Duration(seconds: 2), () {
                      Navigator.pop(context);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1677C8),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 5,
                    shadowColor: const Color(0xFF1677C8).withValues(alpha: 0.4),
                  ),
                  child: const Text(
                    'SEND RESET LINK',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Remember your password?',
                    style: TextStyle(
                      color: Color(0xFF64748B),
                      fontSize: 13,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFF1677C8),
                    ),
                    child: const Text(
                      'Sign In',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}