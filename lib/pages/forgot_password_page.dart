import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F8FC),
      appBar: AppBar(
        title: const Text('Forgot Password'),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF0F3D66),
        elevation: 0,
      ),
      body: Center(
        child: Container(
          width: 450,
          padding: const EdgeInsets.all(30),
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 20,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.lock_reset_outlined,
                size: 65,
                color: Color(0xFF1677C8),
              ),
              const SizedBox(height: 20),
              const Text(
                'Reset Your Password',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F3D66),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Enter your registered email address.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF64748B),
                ),
              ),
              const SizedBox(height: 25),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  prefixIcon:
                      Icon(Icons.email_outlined),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Password reset link sent',
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFF1677C8),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text(
                    'SEND RESET LINK',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}