import 'package:flutter/material.dart';

import '../routes/app_routes.dart';
import '../widgets/auth_brand_panel.dart';

class MobileWelcomePage extends StatelessWidget {
  const MobileWelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF02040B),
      body: SafeArea(
        child: AuthBrandPanel(
          isMobile: true,
          showGraphic: true,
          showHeadline: true,
          openRing: true,
          showSignInButton: true,
          onSignIn: () {
            Navigator.pushReplacementNamed(
              context,
              AppRoutes.login,
            );
          },
        ),
      ),
    );
  }
}