import 'dart:async';

import 'package:flutter/material.dart';

import '../routes/app_routes.dart';
import '../widgets/auth_brand_panel.dart';

class AuthSuccessPage extends StatefulWidget {
  const AuthSuccessPage({super.key});

  @override
  State<AuthSuccessPage> createState() => _AuthSuccessPageState();
}

class _AuthSuccessPageState extends State<AuthSuccessPage> {
  Timer? _redirectTimer;

  @override
  void initState() {
    super.initState();

    _redirectTimer = Timer(
      const Duration(milliseconds: 1800),
      _goToHome,
    );
  }

  void _goToHome() {
    if (!mounted) return;

    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.home,
      (route) => false,
    );
  }

  @override
  void dispose() {
    _redirectTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F9),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final bool isDesktop = constraints.maxWidth >= 900;

            if (isDesktop) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 51,
                    child: AuthBrandPanel(
                      isMobile: false,
                      showGraphic: true,
                    ),
                  ),
                  Expanded(
                    flex: 49,
                    child: _buildSuccessPanel(
                      isMobile: false,
                    ),
                  ),
                ],
              );
            }

            return SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AuthBrandPanel(
                    isMobile: true,
                    showGraphic: false,
                  ),
                  _buildSuccessPanel(
                    isMobile: true,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSuccessPanel({
    required bool isMobile,
  }) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: isMobile ? 300 : 0,
      ),
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 40,
        vertical: isMobile ? 50 : 40,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 360,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: isMobile ? 54 : 48,
                height: isMobile ? 54 : 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFE7F7EF),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_rounded,
                  color: Color(0xFF20A464),
                  size: 25,
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "You're in",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF111827),
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Redirecting to your dashboard...',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF98A2B3),
                  fontSize: 10,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: const Color(0xFF2F6BFF),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}