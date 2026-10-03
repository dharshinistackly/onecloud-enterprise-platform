import 'package:flutter/material.dart';

import 'login_page.dart';
import 'mobile_welcome_page.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;

    if (width < 700) {
      return const MobileWelcomePage();
    }

    return const LoginPage();
  }
}