// ignore_for_file: uri_does_not_exist
import 'package:flutter/material.dart';
import '../../widgets/app_shell.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: 'Dashboard',
      subtitle: 'OneCloud Enterprise',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 700;

          return Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(
                  isMobile ? 14 : 26,
                  isMobile ? 14 : 18,
                  isMobile ? 14 : 26,
                  14,
                ),
                child: _buildWelcomeBanner(isMobile),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(
                    isMobile ? 14 : 26,
                    0,
                    isMobile ? 14 : 26,
                    30,
                  ),
                  child: _buildDashboardContent(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildWelcomeBanner(bool isMobile) {
    return Container(
      width: double.infinity,
      height: isMobile ? 158 : 148,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 18 : 26,
        vertical: isMobile ? 18 : 20,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0F3D66),
            Color(0xFF1677C8),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1677C8).withValues(alpha: 0.20),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 500;

          return Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    right: compact ? 8 : 16,
                  ),
                  child: _buildWelcomeText(compact),
                ),
              ),
              _cloudCircle(
                size: compact ? 64 : 78,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildWelcomeText(bool compact) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome to OneCloud',
          maxLines: compact ? 2 : 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: compact ? 22 : 27,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),

        const SizedBox(height: 6),

        Text(
          'Manage your enterprise services from one centralized platform.',
          maxLines: compact ? 2 : 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: compact ? 12 : 14,
            color: Colors.white.withValues(alpha: 0.88),
            height: 1.35,
          ),
        ),

        const SizedBox(height: 10),

        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.22),
            ),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.verified_outlined,
                color: Colors.white,
                size: 14,
              ),
              SizedBox(width: 6),
              Flexible(
                child: Text(
                  'Enterprise Control Center',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _cloudCircle({double size = 78}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.20),
          width: 2,
        ),
      ),
      child: Icon(
        Icons.cloud_outlined,
        color: Colors.white,
        size: size * 0.53,
      ),
    );
  }

  Widget _buildDashboardContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStatistics(),

        const SizedBox(height: 28),

        _buildSectionTitle(
          'Platform Overview',
          'Monitor your enterprise services and platform activity.',
        ),

        const SizedBox(height: 16),

        _buildPlatformOverview(),

        const SizedBox(height: 28),

        _buildSectionTitle(
          'Quick Actions',
          'Frequently used platform operations.',
        ),

        const SizedBox(height: 16),

        _buildQuickActions(),

        const SizedBox(height: 28),

        _buildSectionTitle(
          'System Status',
          'Current status of your OneCloud platform.',
        ),

        const SizedBox(height: 16),

        _buildSystemStatus(),

        const SizedBox(height: 28),

        _buildFooter(),
      ],
    );
  }

  Widget _buildStatistics() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        final columns = width >= 1100
            ? 4
            : width >= 650
                ? 2
                : 1;

        return GridView.count(
          crossAxisCount: columns,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: columns == 1 ? 3.0 : 2.25,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _buildStatCard(
              'Total Users',
              '1,248',
              Icons.people_alt_outlined,
              const Color(0xFF1677C8),
            ),

            _buildStatCard(
              'Active Tenants',
              '48',
              Icons.business_outlined,
              const Color(0xFF10B981),
            ),

            _buildStatCard(
              'Active Services',
              '16',
              Icons.apps_outlined,
              const Color(0xFF8B5CF6),
            ),

            _buildStatCard(
              'System Health',
              '99.9%',
              Icons.health_and_safety_outlined,
              const Color(0xFFF59E0B),
            ),
          ],
        );
      },
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withValues(alpha: 0.45),
          width: 1.4,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 5,
            height: double.infinity,
            color: color,
          ),

          const SizedBox(width: 14),

          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.09),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: color,
              size: 25,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF64748B),
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0F3D66),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(
    String title,
    String subtitle,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 4,
          height: 34,
          decoration: BoxDecoration(
            color: const Color(0xFF1677C8),
            borderRadius: BorderRadius.circular(10),
          ),
        ),

        const SizedBox(width: 11),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
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
          ),
        ),
      ],
    );
  }

  Widget _buildPlatformOverview() {
    final services = [
      (
        'HRMS',
        'Human Resource Management',
        Icons.people_alt_outlined,
        const Color(0xFF1677C8),
      ),
      (
        'CRM',
        'Customer Relationship',
        Icons.handshake_outlined,
        const Color(0xFF10B981),
      ),
      (
        'ERP',
        'Enterprise Resources',
        Icons.inventory_2_outlined,
        const Color(0xFF8B5CF6),
      ),
      (
        'Finance',
        'Accounting & Finance',
        Icons.account_balance_outlined,
        const Color(0xFFF59E0B),
      ),
      (
        'AI',
        'Enterprise Intelligence',
        Icons.auto_awesome_outlined,
        const Color(0xFFEC4899),
      ),
      (
        'Workflow',
        'Automation & Processes',
        Icons.account_tree_outlined,
        const Color(0xFF0EA5E9),
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 1100
            ? 3
            : constraints.maxWidth >= 650
                ? 2
                : 1;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: services.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio:
                columns == 1 ? 3.0 : 2.15,
          ),
          itemBuilder: (context, index) {
            final service = services[index];

            return _buildServiceCard(
              title: service.$1,
              subtitle: service.$2,
              icon: service.$3,
              color: service.$4,
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
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        _showMessage('$title service selected');
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: color.withValues(alpha: 0.38),
            width: 1.2,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 5,
              height: double.infinity,
              color: color,
            ),

            const SizedBox(width: 14),

            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.09),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: color,
                size: 25,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
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

            const SizedBox(width: 8),

            Container(
              margin: const EdgeInsets.only(right: 12),
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 13,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    final actions = [
      (
        'Add User',
        Icons.person_add_alt_1_outlined,
        const Color(0xFF1677C8),
      ),
      (
        'Manage Tenants',
        Icons.business_outlined,
        const Color(0xFF10B981),
      ),
      (
        'View Reports',
        Icons.bar_chart_outlined,
        const Color(0xFF8B5CF6),
      ),
      (
        'System Health',
        Icons.monitor_heart_outlined,
        const Color(0xFFF59E0B),
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: actions.map((action) {
            final width = constraints.maxWidth < 450
                ? constraints.maxWidth
                : null;

            return SizedBox(
              width: width,
              child: _buildActionButton(
                action.$1,
                action.$2,
                action.$3,
                () {
                  _showMessage(
                    '${action.$1} selected',
                  );
                },
              ),
            );
          }).toList(),
        );
      },
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
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 11,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: color.withValues(alpha: 0.38),
            width: 1.2,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.09),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: color,
                size: 18,
              ),
            ),

            const SizedBox(width: 9),

            Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Color(0xFF334155),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSystemStatus() {
    final items = [
      (
        'Platform Services',
        'All services operational',
        Icons.check_circle_outline,
        const Color(0xFF10B981),
      ),
      (
        'Database',
        'Connected',
        Icons.storage_outlined,
        const Color(0xFF1677C8),
      ),
      (
        'API Gateway',
        'Operational',
        Icons.api_outlined,
        const Color(0xFF8B5CF6),
      ),
      (
        'Security',
        'Protected',
        Icons.security_outlined,
        const Color(0xFFEC4899),
      ),
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFDCE6EF),
        ),
      ),
      child: Column(
        children: [
          for (int i = 0; i < items.length; i++) ...[
            _buildStatusRow(
              items[i].$1,
              items[i].$2,
              items[i].$3,
              items[i].$4,
            ),
            if (i != items.length - 1)
              const Divider(height: 24),
          ],
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
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.09),
            borderRadius: BorderRadius.circular(11),
          ),
          child: Icon(
            icon,
            color: color,
            size: 22,
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF334155),
                ),
              ),

              const SizedBox(height: 3),

              Text(
                status,
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

        const SizedBox(width: 8),

        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.09),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            'Healthy',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment:
              WrapCrossAlignment.center,
          children: [
            const Icon(
              Icons.cloud_outlined,
              size: 15,
              color: Color(0xFF94A3B8),
            ),

            const SizedBox(width: 6),

            Text(
              '© 2026 OneCloud Enterprise Platform',
              style: TextStyle(
                fontSize: 12,
                color: Colors.blueGrey.shade400,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}