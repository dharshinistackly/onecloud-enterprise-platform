import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';

class SocialLoginPage extends StatelessWidget {
  const SocialLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String provider =
        ModalRoute.of(context)?.settings.arguments as String? ??
            'Google';

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
              child: CircleAvatar(
                radius: 19,
                backgroundColor: Colors.white,
                child: Icon(
                  provider == 'Google'
                      ? Icons.g_mobiledata
                      : provider == 'Facebook'
                          ? Icons.facebook
                          : Icons.apple,
                  color: const Color(0xFF1677C8),
                  size: 24,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Container(
            width: 450,
            padding: const EdgeInsets.all(40),
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
              children: [
                Container(
                  padding: const EdgeInsets.all(22),
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
                  child: Icon(
                    provider == 'Google'
                        ? Icons.g_mobiledata
                        : provider == 'Facebook'
                            ? Icons.facebook
                            : Icons.apple,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 25),
                Text(
                  '$provider Sign-In',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F3D66),
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  'Continue with your $provider account to access OneCloud Enterprise Platform.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Color(0xFF64748B),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 35),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton.icon(
                    onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            AppRoutes.home,
                            (route) => false,
                          );
                        },
                                          
                    icon: Icon(
                      provider == 'Google'
                          ? Icons.g_mobiledata
                          : provider == 'Facebook'
                              ? Icons.facebook
                              : Icons.apple,
                      color: Colors.white,
                      size: 28,
                    ),
                    label: Text(
                      'Continue with $provider',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1677C8),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 5,
                      shadowColor: const Color(0xFF1677C8).withValues(alpha: 0.4),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Want to use a different method?',
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
                        'Back to Login',
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
      ),
    );
  }
}