import 'package:flutter/material.dart';

import '../../widgets/app_shell.dart';
import '../platform_administration/platform_administration_page.dart';

/// Home / landing page (route `/home`, opens right after login).
///
/// It is the "Platform Administration" landing page: the AppShell supplies the
/// header + sidebar and [PlatformAdministrationPage] is the page content.
///
/// The old Super Admin Dashboard content moved to
/// `pages/platform_administration/super_admin_dashboard_page.dart`
/// (route `/super-admin-dashboard`).
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppShell(
      title: 'Platform Administration',
      subtitle: 'OneCloud Enterprise',
      child: PlatformAdministrationPage(),
    );
  }
}