import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';
import '../../widgets/sidebar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSidebarOpen = true;

  void _handleLogout() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.login,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      body: SafeArea(
        child: Row(
          children: [
            // Sidebar
            if (isSidebarOpen)
              Sidebar(
                onLogout: _handleLogout,
              ),

            // Main Content
            Expanded(
              child: Column(
                children: [
                  // Fixed Header
                  _buildHeader(),

                  // Scrollable Dashboard Content
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(24),
                      child: _buildDashboardContent(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // HEADER
  // ============================================================

  Widget _buildHeader() {
    return Container(
      height: 76,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Menu Button
          IconButton(
            onPressed: () {
              setState(() {
                isSidebarOpen = !isSidebarOpen;
              });
            },
            icon: Icon(
              isSidebarOpen ? Icons.menu_open : Icons.menu,
              color: const Color(0xFF0F3D66),
              size: 27,
            ),
            tooltip: 'Toggle Sidebar',
          ),

          const SizedBox(width: 12),

          // Page Title
          const Text(
            'Dashboard',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0F3D66),
            ),
          ),

          const Spacer(),

          // Notification
          IconButton(
            onPressed: () {
              _showMessage('No new notifications');
            },
            icon: const Icon(
              Icons.notifications_none_rounded,
              color: Color(0xFF475569),
            ),
            tooltip: 'Notifications',
          ),

          const SizedBox(width: 8),

          // Profile
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'profile') {
                _showMessage('Profile selected');
              } else if (value == 'settings') {
                _showMessage('Settings selected');
              } else if (value == 'logout') {
                _handleLogout();
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: 'profile',
                child: Row(
                  children: [
                    Icon(Icons.person_outline),
                    SizedBox(width: 10),
                    Text('Profile'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'settings',
                child: Row(
                  children: [
                    Icon(Icons.settings_outlined),
                    SizedBox(width: 10),
                    Text('Settings'),
                  ],
                ),
              ),
              PopupMenuDivider(),
              PopupMenuItem(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout),
                    SizedBox(width: 10),
                    Text('Logout'),
                  ],
                ),
              ),
            ],
            child: Container(
              padding: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                color: const Color(0xFFEAF4FC),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.person_outline,
                color: Color(0xFF1677C8),
                size: 23,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // DASHBOARD CONTENT
  // ============================================================

  Widget _buildDashboardContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Welcome Section
        const Text(
          'Welcome to OneCloud',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: Color(0xFF0F3D66),
          ),
        ),

        const SizedBox(height: 6),

        const Text(
          'Manage your enterprise services from one centralized platform.',
          style: TextStyle(
            fontSize: 15,
            color: Color(0xFF64748B),
          ),
        ),

        const SizedBox(height: 24),

        // Statistics
        _buildStatistics(),

        const SizedBox(height: 28),

        // Platform Overview
        _buildSectionTitle(
          'Platform Overview',
          'Monitor your enterprise services and platform activity.',
        ),

        const SizedBox(height: 16),

        _buildPlatformOverview(),

        const SizedBox(height: 28),

        // Quick Actions
        _buildSectionTitle(
          'Quick Actions',
          'Frequently used platform operations.',
        ),

        const SizedBox(height: 16),

        _buildQuickActions(),

        const SizedBox(height: 28),

        // System Status
        _buildSectionTitle(
          'System Status',
          'Current status of your OneCloud platform.',
        ),

        const SizedBox(height: 16),

        _buildSystemStatus(),

        const SizedBox(height: 30),

        // Footer
        _buildFooter(),
      ],
    );
  }

  // ============================================================
  // STATISTICS
  // ============================================================

  Widget _buildStatistics() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        int columns;

        if (width >= 1100) {
          columns = 4;
        } else if (width >= 700) {
          columns = 2;
        } else {
          columns = 1;
        }

        return GridView.count(
          crossAxisCount: columns,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 2.7,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _buildStatCard(
              title: 'Total Users',
              value: '1,248',
              icon: Icons.people_alt_outlined,
              iconColor: const Color(0xFF1677C8),
            ),
            _buildStatCard(
              title: 'Active Tenants',
              value: '48',
              icon: Icons.business_outlined,
              iconColor: const Color(0xFF16A085),
            ),
            _buildStatCard(
              title: 'Active Services',
              value: '16',
              icon: Icons.apps_outlined,
              iconColor: const Color(0xFF8B5CF6),
            ),
            _buildStatCard(
              title: 'System Health',
              value: '99.9%',
              icon: Icons.health_and_safety_outlined,
              iconColor: const Color(0xFF10B981),
            ),
          ],
        );
      },
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 26,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F3D66),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SECTION TITLE
  // ============================================================

  Widget _buildSectionTitle(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xFF0F3D66),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 13,
            color: Color(0xFF64748B),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // PLATFORM OVERVIEW
  // ============================================================

  Widget _buildPlatformOverview() {
    final services = [
      {
        'title': 'HRMS',
        'subtitle': 'Human Resource Management',
        'icon': Icons.people_alt_outlined,
        'color': const Color(0xFF1677C8),
      },
      {
        'title': 'CRM',
        'subtitle': 'Customer Relationship',
        'icon': Icons.handshake_outlined,
        'color': const Color(0xFF16A085),
      },
      {
        'title': 'ERP',
        'subtitle': 'Enterprise Resources',
        'icon': Icons.inventory_2_outlined,
        'color': const Color(0xFF8B5CF6),
      },
      {
        'title': 'Finance',
        'subtitle': 'Accounting & Finance',
        'icon': Icons.account_balance_outlined,
        'color': const Color(0xFFF59E0B),
      },
      {
        'title': 'AI',
        'subtitle': 'Enterprise Intelligence',
        'icon': Icons.auto_awesome_outlined,
        'color': const Color(0xFFEC4899),
      },
      {
        'title': 'Workflow',
        'subtitle': 'Automation & Processes',
        'icon': Icons.account_tree_outlined,
        'color': const Color(0xFF0EA5E9),
      },
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        int columns;

        if (constraints.maxWidth >= 1100) {
          columns = 3;
        } else if (constraints.maxWidth >= 650) {
          columns = 2;
        } else {
          columns = 1;
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: services.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 2.5,
          ),
          itemBuilder: (context, index) {
            final service = services[index];

            return _buildServiceCard(
              title: service['title'] as String,
              subtitle: service['subtitle'] as String,
              icon: service['icon'] as IconData,
              color: service['color'] as Color,
            );
          },
        );
      },
    );
  }

  Widget _buildServiceCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () {
        _showMessage('$title service selected');
      },
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: const Color(0xFFE2E8F0),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: color,
                size: 25,
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0F3D66),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 15,
              color: Color(0xFF94A3B8),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // QUICK ACTIONS
  // ============================================================

  Widget _buildQuickActions() {
    return Wrap(
      spacing: 14,
      runSpacing: 14,
      children: [
        _buildActionButton(
          'Add User',
          Icons.person_add_alt_1_outlined,
          const Color(0xFF1677C8),
          () {
            _showMessage('Add User selected');
          },
        ),
        _buildActionButton(
          'Manage Tenants',
          Icons.business_outlined,
          const Color(0xFF16A085),
          () {
            _showMessage('Manage Tenants selected');
          },
        ),
        _buildActionButton(
          'View Reports',
          Icons.bar_chart_outlined,
          const Color(0xFF8B5CF6),
          () {
            _showMessage('View Reports selected');
          },
        ),
        _buildActionButton(
          'System Health',
          Icons.monitor_heart_outlined,
          const Color(0xFF10B981),
          () {
            _showMessage('System Health selected');
          },
        ),
      ],
    );
  }

  Widget _buildActionButton(
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 13,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color(0xFFE2E8F0),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: color,
              size: 20,
            ),
            const SizedBox(width: 9),
            Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF334155),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SYSTEM STATUS
  // ============================================================

  Widget _buildSystemStatus() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
      ),
      child: Column(
        children: [
          _buildStatusRow(
            'Platform Services',
            'All services operational',
            Icons.check_circle_outline,
            const Color(0xFF10B981),
          ),
          const Divider(height: 24),
          _buildStatusRow(
            'Database',
            'Connected',
            Icons.storage_outlined,
            const Color(0xFF1677C8),
          ),
          const Divider(height: 24),
          _buildStatusRow(
            'API Gateway',
            'Operational',
            Icons.api_outlined,
            const Color(0xFF8B5CF6),
          ),
          const Divider(height: 24),
          _buildStatusRow(
            'Security',
            'Protected',
            Icons.security_outlined,
            const Color(0xFF16A085),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusRow(
    String title,
    String status,
    IconData icon,
    Color color,
  ) {
    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: color,
            size: 22,
          ),
        ),

        const SizedBox(width: 14),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF334155),
                ),
              ),
              const SizedBox(height: 3),
              Text(
                status,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF64748B),
                ),
              ),
            ],
          ),
        ),

        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFDCFCE7),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'Healthy',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Color(0xFF15803D),
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // FOOTER
  // ============================================================

  Widget _buildFooter() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(
          '© 2026 OneCloud Enterprise Platform',
          style: TextStyle(
            fontSize: 12,
            color: Colors.blueGrey.shade400,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // MESSAGE
  // ============================================================

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}