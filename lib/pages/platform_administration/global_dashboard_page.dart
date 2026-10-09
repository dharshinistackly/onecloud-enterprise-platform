import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:one_cloud_enterprise/widgets/dashboard_dialogs.dart';

class GlobalDashboardPage extends StatefulWidget {
  const GlobalDashboardPage({super.key});

  @override
  State<GlobalDashboardPage> createState() => _GlobalDashboardPageState();
}

// ---------------------------------------------------------------------------
// DESIGN TOKENS
// ---------------------------------------------------------------------------

const _ink = Color(0xFF172536);
const _muted = Color(0xFF61758A);
const _hint = Color(0xFF8A9AB0);
const _border = Color(0xFFE1E7EF);
const _bg = Color(0xFFF7F9FC);

const _blue = Color(0xFF283BEA);
const _indigo = Color(0xFF4F46E5);

const _iconBg = Color(0xFFEAEDFF);
const _iconFg = Color(0xFF5B5BD6);

const _positive = Color(0xFF16A34A);

const _mono = 'monospace';

// ---------------------------------------------------------------------------
// PAGE STATE
// ---------------------------------------------------------------------------

class _GlobalDashboardPageState extends State<GlobalDashboardPage> {
  String _healthRange = 'Last 7 Days';
  String _chartRange = 'Last 7 Days';

  // -------------------------------------------------------------------------
  // DATA
  // -------------------------------------------------------------------------

  static const _stats = [
    _Stat(
      'Total Tenants',
      '132',
      '8%',
      Icons.groups_2_outlined,
    ),
    _Stat(
      'Total Users',
      '48,920',
      '13%',
      Icons.check_circle_outline,
    ),
    _Stat(
      'Active Subscriptions',
      '1,233',
      '10%',
      Icons.visibility_outlined,
    ),
    _Stat(
      'Active Sessions',
      '789',
      '6%',
      Icons.trending_up,
    ),
  ];

  static const _nav = [
    _Nav(
      'Manage Tenants',
      'Manage accounts & roles',
      Icons.groups_2_outlined,
    ),
    _Nav(
      'Platform Settings',
      'Global configuration',
      Icons.settings_outlined,
    ),
    _Nav(
      'Generate Report',
      'Renewals & seat usage',
      Icons.description_outlined,
    ),
    _Nav(
      'System Monitoring',
      'Track admin actions',
      Icons.insights_outlined,
    ),
  ];

  static const _health = [
    _Metric('CPU Usage', 67),
    _Metric('Memory Utilization', 54),
    _Metric('Disk I/O', 32),
    _Metric('Network Bandwidth', 78),
  ];

  static const _alerts = [
    _Alert(
      'High CPU Usage',
      'Database server CPU usage is high',
      '1 hour ago',
      _AlertKind.warning,
    ),
    _Alert(
      'Storage Threshold',
      'Storage utilization reached 80%',
      '2 hour ago',
      _AlertKind.info,
    ),
    _Alert(
      'New Tenant Registration',
      'Techcorp solutions registered',
      '2 hour ago',
      _AlertKind.notice,
    ),
  ];

  static const _activities = [
    _Activity(
      'New Tenant Created',
      'by Admin users',
      '10 min ago',
      _ActKind.warning,
    ),
    _Activity(
      'License Updated',
      'by Admin users.',
      '1 hour ago',
      _ActKind.notice,
    ),
    _Activity(
      'User Added',
      'Superadmin granted access to monitoring module.',
      '3 hours ago',
      _ActKind.info,
    ),
    _Activity(
      'Backup Completed',
      'Daily snapshot of primary database cluster successful.',
      'Yesterday',
      _ActKind.success,
    ),
  ];

  static const _labels = [
    'May 12',
    'May 13',
    'May 14',
    'May 15',
    'May 16',
    'May 17',
    'May 18',
  ];

  static const _series = [
    [
      15.2,
      17.0,
      16.5,
      19.0,
      19.0,
      17.8,
      19.3,
    ],
    [
      10.0,
      11.8,
      12.2,
      13.8,
      12.6,
      12.2,
      14.2,
    ],
    [
      5.0,
      6.0,
      5.9,
      7.2,
      7.2,
      7.2,
      7.8,
    ],
  ];

  static const _seriesColors = [
    Color(0xFF9B51E0),
    Color(0xFF3B82F6),
    Color(0xFF10B981),
  ];

  static const _seriesNames = [
    'Operational',
    'Degraded',
    'Down',
  ];

  // -------------------------------------------------------------------------
  // BUILD
  // -------------------------------------------------------------------------

  Future<void> _openExportDialog() async {
    final ExportOptions? options = await showExportReportDialog(context);
    if (options == null) return;
    // TODO: run your real export here using
    // options.format / options.range / options.includeCharts / options.includeTables
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Export started')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final mobile = constraints.maxWidth < 700;

            return SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                mobile ? 16 : 24,
                mobile ? 16 : 24,
                mobile ? 16 : 24,
                28,
              ),
              child: mobile ? _mobile() : _desktop(),
            );
          },
        ),
      ),
    );
  }

  // =========================================================================
  // MOBILE
  // =========================================================================

  Widget _mobile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Platform Administration / Global Dashboard',
          style: TextStyle(
            fontSize: 10,
            color: _hint,
          ),
        ),

        const SizedBox(height: 8),

        Row(
          children: [
            const Expanded(
              child: Text(
                'Global Dashboard',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: _ink,
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(
                minWidth: 30,
                minHeight: 30,
              ),
              icon: const Icon(
                Icons.sync,
                size: 22,
                color: Color(0xFF52616F),
              ),
            ),
          ],
        ),

        const SizedBox(height: 14),

        _eyebrow('PLATFORM OVERVIEW'),

        const SizedBox(height: 10),

        _grid2(
          _stats
              .map(
                (s) => _statCard(s, true),
              )
              .toList(),
        ),

        const SizedBox(height: 20),

        _eyebrow('QUICK NAVIGATION'),

        const SizedBox(height: 10),

        _grid2(
          _nav
              .map(
                (n) => _navTile(n, true),
              )
              .toList(),
        ),

        const SizedBox(height: 14),

        _healthCard(true),

        const SizedBox(height: 14),

        _chartCard(true),

        const SizedBox(height: 22),

        _sectionHeader(
          'Security alerts',
          'View all alerts',
          true,
        ),

        const SizedBox(height: 10),

        ..._alerts.map(
          (a) => _alertCard(a, true),
        ),

        const SizedBox(height: 12),

        _sectionHeader(
          'Recent activities',
          'View All',
          true,
        ),

        const SizedBox(height: 10),

        _activitiesCard(true),

        const SizedBox(height: 24),

        SizedBox(
          width: double.infinity,
          height: 44,
          child: ElevatedButton.icon(
            onPressed: _openExportDialog,
            icon: const Icon(
              Icons.download_outlined,
              size: 17,
            ),
            label: const Text(
              'Export Report',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: _blue,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _grid2(List<Widget> children) {
    final rows = <Widget>[];

    for (var i = 0; i < children.length; i += 2) {
      rows.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: children[i],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: i + 1 < children.length
                  ? children[i + 1]
                  : const SizedBox(),
            ),
          ],
        ),
      );

      if (i + 2 < children.length) {
        rows.add(
          const SizedBox(height: 12),
        );
      }
    }

    return Column(
      children: rows,
    );
  }

  // =========================================================================
  // DESKTOP
  // =========================================================================

  Widget _desktop() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Breadcrumb
        Row(
          children: const [
            Text(
              'Platform Administration',
              style: TextStyle(
                fontSize: 12,
                color: _muted,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6),
              child: Text(
                '/',
                style: TextStyle(
                  fontSize: 12,
                  color: _muted,
                ),
              ),
            ),
            Text(
              'Global Dashboard',
              style: TextStyle(
                fontSize: 12,
                color: _ink,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),

        // Page title + buttons
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Global Dashboard',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: _ink,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Track performance, engagement, and growth across all your social platforms in one place.',
                    style: TextStyle(
                      fontSize: 13,
                      color: _muted,
                    ),
                  ),
                ],
              ),
            ),

            _topButton(
              'Refresh',
              Icons.refresh,
            ),

            const SizedBox(width: 10),

            _topButton(
              'Export report',
              Icons.download_outlined,
              primary: true,
            ),
          ],
        ),

        const SizedBox(height: 18),

        _eyebrow(
          'PLATFORM OVERVIEW',
          big: true,
        ),

        const SizedBox(height: 10),

        _row4(
          _stats
              .map(
                (s) => _statCard(s, false),
              )
              .toList(),
        ),

        const SizedBox(height: 18),

        _eyebrow(
          'QUICK NAVIGATION',
          big: true,
        ),

        const SizedBox(height: 10),

        _row4(
          _nav
              .map(
                (n) => _navTile(n, false),
              )
              .toList(),
        ),

        const SizedBox(height: 16),

        // Health + Chart
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _healthCard(false),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _chartCard(false),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // Alerts + Activities
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _alertsCardDesktop(),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _activitiesCard(false),
            ),
          ],
        ),
      ],
    );
  }

  Widget _row4(List<Widget> children) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < children.length; i++) ...[
          if (i > 0) const SizedBox(width: 16),
          Expanded(
            child: children[i],
          ),
        ],
      ],
    );
  }

  // =========================================================================
  // COMMON UI
  // =========================================================================

  Widget _eyebrow(
    String text, {
    bool big = false,
  }) {
    return Text(
      text,
      style: TextStyle(
        fontSize: big ? 14 : 11,
        fontWeight: big ? FontWeight.w500 : FontWeight.w700,
        color: big ? const Color(0xFF5A6B80) : _hint,
        letterSpacing: big ? .5 : .8,
      ),
    );
  }

  BoxDecoration _box(double radius) {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(
        color: _border,
      ),
    );
  }

  Widget _topButton(
    String label,
    IconData icon, {
    bool primary = false,
  }) {
    final text = Text(
      label,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
    );

    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6),
    );

    if (primary) {
      return SizedBox(
        height: 34,
        child: ElevatedButton.icon(
          onPressed: _openExportDialog,
          icon: Icon(
            icon,
            size: 16,
          ),
          label: text,
          style: ElevatedButton.styleFrom(
            backgroundColor: _blue,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: shape,
          ),
        ),
      );
    }

    return SizedBox(
      height: 34,
      child: OutlinedButton.icon(
        onPressed: () {},
        icon: Icon(
          icon,
          size: 16,
        ),
        label: text,
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF253341),
          backgroundColor: Colors.white,
          side: const BorderSide(
            color: Color(0xFFD8E0E8),
          ),
          shape: shape,
        ),
      ),
    );
  }

  Widget _iconChip(
    IconData icon, {
    double size = 32,
    double iconSize = 16,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: _iconBg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        icon,
        size: iconSize,
        color: _iconFg,
      ),
    );
  }

  // =========================================================================
  // STAT CARDS
  // =========================================================================

  Widget _statCard(
    _Stat stat,
    bool mobile,
  ) {
    return Container(
      height: mobile ? 116 : 132,
      padding: EdgeInsets.fromLTRB(
        mobile ? 16 : 20,
        mobile ? 14 : 16,
        mobile ? 14 : 20,
        mobile ? 12 : 16,
      ),
      decoration: _box(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  mobile
                      ? stat.title.toUpperCase()
                      : stat.title,
                  style: mobile
                      ? const TextStyle(
                          fontFamily: _mono,
                          fontSize: 10,
                          letterSpacing: .6,
                          color: Color(0xFF7C8DA3),
                        )
                      : const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF444B55),
                        ),
                ),
              ),
              _iconChip(
                stat.icon,
                size: mobile ? 28 : 34,
                iconSize: mobile ? 15 : 17,
              ),
            ],
          ),

          const Spacer(),

          Text(
            stat.value,
            style: TextStyle(
              fontSize: mobile ? 22 : 28,
              fontWeight: FontWeight.w700,
              color: _ink,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            '↑ ${stat.delta} this month',
            style: const TextStyle(
              fontSize: 11,
              color: _positive,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================================
  // QUICK NAVIGATION
  // =========================================================================

  Widget _navTile(
    _Nav nav,
    bool mobile,
  ) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: mobile ? 114 : 124,
        padding: EdgeInsets.all(
          mobile ? 16 : 20,
        ),
        decoration: _box(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _iconChip(
              nav.icon,
              size: 36,
              iconSize: 18,
            ),

            const Spacer(),

            Text(
              nav.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: _ink,
              ),
            ),

            const SizedBox(height: 3),

            Text(
              nav.subtitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 11,
                color: _muted,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================================
  // DROPDOWN
  // =========================================================================

  Widget _rangeDropdown(
    String value,
    ValueChanged<String> onChanged, {
    required bool mobile,
  }) {
    if (mobile) {
      return Text(
        value,
        style: const TextStyle(
          fontSize: 11,
          color: _hint,
        ),
      );
    }

    return PopupMenuButton<String>(
      onSelected: onChanged,
      itemBuilder: (_) => const [
        PopupMenuItem(
          value: 'Last 7 Days',
          child: Text('Last 7 Days'),
        ),
        PopupMenuItem(
          value: 'Last 30 Days',
          child: Text('Last 30 Days'),
        ),
        PopupMenuItem(
          value: 'Last 90 Days',
          child: Text('Last 90 Days'),
        ),
      ],
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: const Color(0xFFD8E0E8),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 11,
                color: _muted,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.keyboard_arrow_down,
              size: 14,
              color: _muted,
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================================
  // PANEL
  // =========================================================================

  Widget _panel({
    required String title,
    required Widget trailing,
    required Widget child,
    required bool mobile,
  }) {
    return Container(
      width: double.infinity,
      decoration: _box(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
              mobile ? 16 : 20,
              mobile ? 14 : 18,
              mobile ? 16 : 20,
              12,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: mobile ? 15 : 16,
                      fontWeight:
                          mobile ? FontWeight.w700 : FontWeight.w600,
                      color: _ink,
                    ),
                  ),
                ),
                trailing,
              ],
            ),
          ),

          if (mobile)
            const Divider(
              height: 1,
              color: Color(0xFFEDF1F6),
            ),

          Padding(
            padding: EdgeInsets.fromLTRB(
              mobile ? 16 : 20,
              mobile ? 16 : 4,
              mobile ? 16 : 20,
              18,
            ),
            child: child,
          ),
        ],
      ),
    );
  }

  // =========================================================================
  // PLATFORM HEALTH
  // =========================================================================

  Widget _healthCard(bool mobile) {
    return _panel(
      title: 'Platform Health Status',
      mobile: mobile,
      trailing: _rangeDropdown(
        _healthRange,
        (value) {
          setState(() {
            _healthRange = value;
          });
        },
        mobile: mobile,
      ),
      child: Column(
        children: [
          for (var i = 0; i < _health.length; i++) ...[
            _metricRow(
              _health[i],
              mobile,
            ),
            if (i != _health.length - 1)
              const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }

  Widget _metricRow(
    _Metric metric,
    bool mobile,
  ) {
    final high = metric.percent >= 60;

    final barColor = high
        ? const Color(0xFFF59E0B)
        : const Color(0xFF1B7F4B);

    final textColor = high
        ? const Color(0xFFD97706)
        : const Color(0xFF15803D);

    final pillBackground = high
        ? const Color(0xFFFFF1D6)
        : const Color(0xFFE3F5EA);

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                metric.label,
                style: const TextStyle(
                  fontSize: 14,
                  color: _ink,
                ),
              ),
            ),
            Container(
              padding: mobile
                  ? EdgeInsets.zero
                  : const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
              decoration: mobile
                  ? null
                  : BoxDecoration(
                      color: pillBackground,
                      borderRadius: BorderRadius.circular(4),
                    ),
              child: Text(
                '${metric.percent}%',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 8),

        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: SizedBox(
            width: double.infinity,
            height: 8,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 8,
                  color: const Color(0xFFEBEEF3),
                ),
                FractionallySizedBox(
                  widthFactor: metric.percent / 100,
                  child: Container(
                    height: 8,
                    color: barColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // =========================================================================
  // SYSTEM HEALTH CHART
  // =========================================================================

  Widget _chartCard(bool mobile) {
    return _panel(
      title: 'System Health',
      mobile: mobile,
      trailing: _rangeDropdown(
        _chartRange,
        (value) {
          setState(() {
            _chartRange = value;
          });
        },
        mobile: mobile,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 16,
            runSpacing: 6,
            children: [
              for (var i = 0; i < 3; i++)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _seriesColors[i],
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      _seriesNames[i],
                      style: const TextStyle(
                        fontSize: 12,
                        color: _muted,
                      ),
                    ),
                  ],
                ),
            ],
          ),

          const SizedBox(height: 8),

          SizedBox(
            width: double.infinity,
            height: mobile ? 150 : 210,
            child: CustomPaint(
              painter: _ChartPainter(
                series: _series,
                colors: _seriesColors,
                labels: _labels,
                yLabels: !mobile,
                dots: !mobile,
                labelStep: mobile ? 2 : 1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================================
  // ALERTS
  // =========================================================================

  Widget _sectionHeader(
    String title,
    String action,
    bool mobile,
  ) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: _ink,
            ),
          ),
        ),
        InkWell(
          onTap: () {
            if (title == 'Security alerts') {
              showSecurityAlertsDialog(context);
            } else {
              showRecentActivitiesDialog(context);
            }
          },
          child: Text(
            action,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: mobile
                  ? _indigo
                  : const Color(0xFF2563EB),
            ),
          ),
        ),
      ],
    );
  }

  Widget _alertsCardDesktop() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: _box(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader(
            'Security alerts',
            'View all alerts',
            false,
          ),

          const SizedBox(height: 14),

          ..._alerts.map(
            (alert) => _alertCard(
              alert,
              false,
            ),
          ),
        ],
      ),
    );
  }

  Widget _alertCard(
    _Alert alert,
    bool mobile,
  ) {
    late Color background;
    late Color titleColor;
    late Color bodyColor;
    late IconData icon;

    switch (alert.kind) {
      case _AlertKind.warning:
        background = mobile
            ? const Color(0xFFFFF4D6)
            : const Color(0xFFFAEFD6);
        titleColor = const Color(0xFF8A5A00);
        bodyColor = const Color(0xFFB7791F);
        icon = Icons.warning_amber_outlined;
        break;

      case _AlertKind.info:
        background = const Color(0xFFE8F0FE);
        titleColor = const Color(0xFF1D4ED8);
        bodyColor = const Color(0xFF3F5FA8);
        icon = mobile
            ? Icons.info_outline
            : Icons.warning_amber_outlined;
        break;

      case _AlertKind.notice:
        background = const Color(0xFFFFF7DB);
        titleColor = const Color(0xFFE59A00);
        bodyColor = const Color(0xFFB7791F);
        icon = mobile
            ? Icons.warning_amber_outlined
            : Icons.info_outline;
        break;
    }

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.fromLTRB(
        14,
        12,
        14,
        12,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 18,
            color: titleColor,
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        alert.title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: titleColor,
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    Text(
                      alert.time,
                      style: TextStyle(
                        fontSize: 11,
                        color: bodyColor,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 2),

                Text(
                  alert.message,
                  style: TextStyle(
                    fontSize: 12,
                    color: bodyColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================================
  // ACTIVITIES
  // =========================================================================

  Widget _activitiesCard(bool mobile) {
    final list = Column(
      children: [
        for (var i = 0; i < _activities.length; i++)
          Padding(
            padding: const EdgeInsets.only(
              bottom: 14,
            ),
            child: _activityRow(
              _activities[i],
            ),
          ),
      ],
    );

    if (mobile) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(
          16,
          16,
          16,
          4,
        ),
        decoration: _box(12),
        child: list,
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: _box(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader(
            'Recent activities',
            'View All',
            false,
          ),

          const SizedBox(height: 16),

          list,
        ],
      ),
    );
  }

  Widget _activityRow(
    _Activity activity,
  ) {
    late Color background;
    late Color foreground;
    late IconData icon;

    switch (activity.kind) {
      case _ActKind.warning:
        background = const Color(0xFFFFF1D6);
        foreground = const Color(0xFFD98A12);
        icon = Icons.warning_amber_outlined;
        break;

      case _ActKind.notice:
        background = const Color(0xFFFFF7DB);
        foreground = const Color(0xFFE5A400);
        icon = Icons.warning_amber_outlined;
        break;

      case _ActKind.info:
        background = const Color(0xFFE8F0FE);
        foreground = const Color(0xFF2563EB);
        icon = Icons.info_outline;
        break;

      case _ActKind.success:
        background = const Color(0xFFE3F5EA);
        foreground = const Color(0xFF16A34A);
        icon = Icons.check_circle_outline;
        break;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: background,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 18,
            color: foreground,
          ),
        ),

        const SizedBox(width: 14),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                activity.title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: _ink,
                ),
              ),

              const SizedBox(height: 3),

              Text(
                activity.subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  color: _muted,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(width: 8),

        Text(
          activity.time,
          style: const TextStyle(
            fontSize: 11,
            color: _hint,
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// MODELS
// =============================================================================

class _Stat {
  final String title;
  final String value;
  final String delta;
  final IconData icon;

  const _Stat(
    this.title,
    this.value,
    this.delta,
    this.icon,
  );
}

class _Nav {
  final String title;
  final String subtitle;
  final IconData icon;

  const _Nav(
    this.title,
    this.subtitle,
    this.icon,
  );
}

class _Metric {
  final String label;
  final int percent;

  const _Metric(
    this.label,
    this.percent,
  );
}

enum _AlertKind {
  warning,
  info,
  notice,
}

class _Alert {
  final String title;
  final String message;
  final String time;
  final _AlertKind kind;

  const _Alert(
    this.title,
    this.message,
    this.time,
    this.kind,
  );
}

enum _ActKind {
  warning,
  notice,
  info,
  success,
}

class _Activity {
  final String title;
  final String subtitle;
  final String time;
  final _ActKind kind;

  const _Activity(
    this.title,
    this.subtitle,
    this.time,
    this.kind,
  );
}

// =============================================================================
// LINE CHART PAINTER
// =============================================================================

class _ChartPainter extends CustomPainter {
  final List<List<double>> series;
  final List<Color> colors;
  final List<String> labels;
  final bool yLabels;
  final bool dots;
  final int labelStep;

  _ChartPainter({
    required this.series,
    required this.colors,
    required this.labels,
    required this.yLabels,
    required this.dots,
    required this.labelStep,
  });

  static const double _minY = 5;
  static const double _maxY = 25;

  void _text(
    Canvas canvas,
    String text,
    Offset offset, {
    TextAlign align = TextAlign.center,
  }) {
    final painter = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          fontSize: 9,
          color: Color(0xFF7C8DA3),
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    double dx = offset.dx;

    if (align == TextAlign.center) {
      dx -= painter.width / 2;
    }

    if (align == TextAlign.right) {
      dx -= painter.width;
    }

    painter.paint(
      canvas,
      Offset(
        dx,
        offset.dy - painter.height / 2,
      ),
    );
  }

  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    if (size.width <= 0 || size.height <= 0) {
      return;
    }

    if (series.isEmpty || labels.isEmpty) {
      return;
    }

    final pointCount = series.first.length;

    if (pointCount < 2) {
      return;
    }

    const right = 10.0;
    const top = 8.0;
    const bottom = 22.0;

    final left = yLabels ? 36.0 : 10.0;

    final width = math.max(
      1.0,
      size.width - left - right,
    );

    final height = math.max(
      1.0,
      size.height - top - bottom,
    );

    double xAt(int index) {
      return left +
          width * index / (pointCount - 1);
    }

    double yAt(double value) {
      final normalized =
          (value - _minY) / (_maxY - _minY);

      return top +
          height * (1 - normalized);
    }

    // Grid
    if (yLabels) {
      final gridPaint = Paint()
        ..color = const Color(0xFFEEF1F5)
        ..strokeWidth = 1;

      for (var value = 5; value <= 25; value += 5) {
        final y = yAt(
          value.toDouble(),
        );

        canvas.drawLine(
          Offset(left, y),
          Offset(left + width, y),
          gridPaint,
        );

        _text(
          canvas,
          '${value}K',
          Offset(left - 8, y),
          align: TextAlign.right,
        );
      }
    }

    // X labels
    for (var i = 0; i < labels.length; i++) {
      if (i % labelStep != 0) {
        continue;
      }

      _text(
        canvas,
        labels[i],
        Offset(
          xAt(i),
          size.height - 8,
        ),
      );
    }

    // Lines
    for (var s = 0; s < series.length; s++) {
      if (series[s].length != pointCount) {
        continue;
      }

      final linePaint = Paint()
        ..color = colors[s]
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke
        ..strokeJoin = StrokeJoin.round
        ..strokeCap = StrokeCap.round;

      final path = Path();

      for (var i = 0; i < series[s].length; i++) {
        final point = Offset(
          xAt(i),
          yAt(series[s][i]),
        );

        if (i == 0) {
          path.moveTo(
            point.dx,
            point.dy,
          );
        } else {
          path.lineTo(
            point.dx,
            point.dy,
          );
        }
      }

      canvas.drawPath(
        path,
        linePaint,
      );

      // Dots
      if (dots) {
        final dotPaint = Paint()
          ..color = colors[s]
          ..style = PaintingStyle.fill;

        for (var i = 0; i < series[s].length; i++) {
          canvas.drawCircle(
            Offset(
              xAt(i),
              yAt(series[s][i]),
            ),
            3.5,
            dotPaint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(
    covariant _ChartPainter oldDelegate,
  ) {
    return oldDelegate.series != series ||
        oldDelegate.colors != colors ||
        oldDelegate.labels != labels ||
        oldDelegate.yLabels != yLabels ||
        oldDelegate.dots != dots ||
        oldDelegate.labelStep != labelStep;
  }
}