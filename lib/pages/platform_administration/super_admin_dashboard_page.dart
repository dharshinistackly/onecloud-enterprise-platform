import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';
import '../../theme/app_theme.dart';
import '../../widgets/dashboard_dialogs.dart';

/// Super Admin Dashboard (KPIs, system status, alerts, login activity).
///
/// It is a normal page now: it opens from
///   * the "Super Admin Dashboard" card on the Platform Administration landing page
///   * the "Super Admin Dashboard" item in the sidebar
/// and is registered as `AppRoutes.superAdminDashboard`.
///
/// The page content lives in [_SuperAdminContent] so its `BuildContext` is
/// inside the shell's content navigator (pushNamed keeps header + sidebar).
class SuperAdminDashboardPage extends StatelessWidget {
  const SuperAdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      body: _SuperAdminContent(),
    );
  }
}

// ---------------------------------------------------------------------------
// Local aliases of the shared tokens (lib/theme/app_theme.dart)
// ---------------------------------------------------------------------------
const _ink = AppColors.ink;
const _muted = AppColors.muted;
const _hint = AppColors.hint;
const _border = AppColors.border;
const _blue = AppColors.blue;
const _mono = AppFonts.mono;

class _SuperAdminContent extends StatefulWidget {
  const _SuperAdminContent();

  @override
  State<_SuperAdminContent> createState() => _SuperAdminContentState();
}

class _SuperAdminContentState extends State<_SuperAdminContent> {
  // ----------------------------- data ------------------------------------
  static const _stats = <_Stat>[
    _Stat(
      'TOTAL USERS',
      '96,412',
      '↑ 1.8% this month',
      Icons.person_outline,
      Color(0xFFE5F6EE),
      Color(0xFF1FA67A),
    ),
    _Stat(
      'ACTIVE USERS',
      '78,930',
      '4,215 online now',
      Icons.check_circle_outline,
      Color(0xFFE8EEFF),
      Color(0xFF3B5BDB),
    ),
    _Stat(
      'ORGANIZATIONS',
      '1,842',
      '↑ 4.2% this month',
      Icons.apartment_outlined,
      Color(0xFFFFF1D6),
      Color(0xFFD98A12),
    ),
    _Stat(
      'LICENSES ACTIVE',
      '2,140',
      '27 expiring < 30 days',
      Icons.description_outlined,
      Colors.white,
      Color(0xFF1B2160),
      highlighted: true,
    ),
  ];

  static const _status = <_StatusItem>[
    _StatusItem('SERVER STATUS', 'Healthy', Color(0xFF16A870)),
    _StatusItem('DATABASE', 'Connected', Color(0xFF16A870)),
    _StatusItem('API GATEWAY', 'Running', Color(0xFF16A870)),
    _StatusItem('STORAGE', '68% used', Color(0xFFE59A1E)),
  ];

  static const _resources = <_Resource>[
    _Resource('CPU usage', 42, Color(0xFF2B5C84)),
    _Resource('Memory usage', 57, Color(0xFF2B5C84)),
    _Resource('Storage', 68, Color(0xFF5CBF9A)),
  ];

  static const _nav = <_NavItem>[
    _NavItem('User Management', 'Accounts & roles', Icons.person_outline,
        AppRoutes.userManagement),
    _NavItem('Platform Settings', 'Global config', Icons.settings_outlined,
        AppRoutes.globalSettings),
    _NavItem('License Mgmt', 'Renewals & seats', Icons.description_outlined,
        AppRoutes.licenseManagement),
    _NavItem('Audit Logs', 'Admin actions', Icons.fact_check_outlined,
        AppRoutes.auditLogs),
    _NavItem('Notifications', 'Notification centre',
        Icons.notifications_none_rounded, AppRoutes.inAppNotifications),
    _NavItem('Backup', 'Snapshots', Icons.inventory_2_outlined, null),
    _NavItem('Reports', 'Analytics', Icons.show_chart_rounded,
        AppRoutes.standardReports),
    _NavItem('Security', 'Threats & policies', Icons.shield_outlined,
        AppRoutes.securityAlerts),
  ];

  static const _alerts = <_AlertItem>[
    _AlertItem(
      '27 licenses expiring within 30 days',
      'Review renewals before Sep 22.',
      Icons.warning_amber_rounded,
      _AlertTone.warning,
    ),
    _AlertItem(
      '3 organizations awaiting approval',
      'Submitted via self-signup.',
      Icons.info_outline,
      _AlertTone.info,
    ),
    _AlertItem(
      'Unusual login pattern detected',
      'Delta Retail Group — 3 new locations.',
      Icons.lock_outline,
      _AlertTone.warning,
    ),
  ];

  static const _logins = <_Login>[
    _Login('Ana Ferreira', ' signed in from Lisbon, PT', '14 minutes ago',
        _LoginTone.ok),
    _Login('Unrecognized device', ' signed in to Delta Retail Group',
        '52 minutes ago', _LoginTone.warn),
    _Login('5 failed attempts', ' on j.mehta@acmecorp.com — locked',
        'Yesterday, 18:15', _LoginTone.bad),
  ];

  // ----------------------------- actions ---------------------------------
  void _toast(String message) {
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

  void _open(String? route, String title) {
    if (route != null && AppRoutes.routes.containsKey(route)) {
      Navigator.of(context).pushNamed(route);
    } else {
      _toast('$title page will be connected soon.');
    }
  }

  Future<void> _export() async {
    final options = await showExportReportDialog(context);
    if (options != null && mounted) {
      _toast('Report export started');
    }
  }

  void _refresh() {
    setState(() {});
    _toast('Dashboard refreshed');
  }

  // ----------------------------- build -----------------------------------
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final mobile = c.maxWidth < 700;

        return Container(
          color: AppColors.background,
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              mobile ? 16 : 24,
              mobile ? 16 : 20,
              mobile ? 16 : 24,
              28,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _breadcrumb(),
                const SizedBox(height: 8),
                _heading(mobile),
                SizedBox(height: mobile ? 18 : 22),
                _caption('PLATFORM OVERVIEW'),
                const SizedBox(height: 10),
                _statCards(mobile),
                const SizedBox(height: 22),
                _caption('SYSTEM STATUS'),
                const SizedBox(height: 10),
                _statusCards(mobile),
                const SizedBox(height: 10),
                _resourceCard(mobile),
                const SizedBox(height: 22),
                _caption('QUICK NAVIGATION'),
                const SizedBox(height: 10),
                _navCards(mobile),
                const SizedBox(height: 22),
                _bottomPanels(mobile),
                if (mobile) ...[
                  const SizedBox(height: 22),
                  _mobileExport(),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  // ----------------------------- heading ---------------------------------
  /// Back to the Platform Administration landing page (home).
  void _goHub() {
    Navigator.of(context).popUntil(
      (route) => route.settings.name == AppRoutes.home || route.isFirst,
    );
  }

  Widget _breadcrumb() {
    return Row(
      children: [
        InkWell(
          onTap: _goHub,
          child: const Text(
            'Platform Administration',
            style: TextStyle(fontSize: AppType.breadcrumb, color: _muted),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 6),
          child: Text(
            '/',
            style: TextStyle(fontSize: AppType.breadcrumb, color: _muted),
          ),
        ),
        const Text(
          'Dashboard',
          style: TextStyle(
            fontSize: AppType.breadcrumb,
            color: _ink,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _heading(bool mobile) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Super Admin Dashboard',
                style: TextStyle(
                  fontSize: mobile ? AppType.pageTitleM : AppType.pageTitleD,
                  fontWeight: FontWeight.w700,
                  color: _ink,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Welcome back, Super Admin',
                style: TextStyle(
                  fontSize: AppType.pageSubtitle,
                  color: _muted,
                ),
              ),
            ],
          ),
        ),
        if (mobile)
          IconButton(
            onPressed: _refresh,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
            icon: const Icon(
              Icons.sync,
              size: 24,
              color: Color(0xFF52616F),
            ),
          )
        else ...[
          _topButton('Refresh', Icons.refresh, _refresh),
          const SizedBox(width: 10),
          _topButton('Export report', Icons.download_outlined, _export,
              primary: true),
        ],
      ],
    );
  }

  Widget _topButton(
    String label,
    IconData icon,
    VoidCallback onTap, {
    bool primary = false,
  }) {
    final shape =
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(6));
    final text = Text(
      label,
      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
    );

    return SizedBox(
      height: 34,
      child: primary
          ? ElevatedButton.icon(
              onPressed: onTap,
              icon: Icon(icon, size: 16),
              label: text,
              style: ElevatedButton.styleFrom(
                backgroundColor: _blue,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: shape,
              ),
            )
          : OutlinedButton.icon(
              onPressed: onTap,
              icon: Icon(icon, size: 16),
              label: text,
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF253341),
                backgroundColor: Colors.white,
                side: const BorderSide(color: Color(0xFFD8E0E8)),
                shape: shape,
              ),
            ),
    );
  }

  Widget _caption(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: _mono,
        fontSize: AppType.sectionLabel,
        letterSpacing: 1.2,
        color: Color(0xFF7C8DA3),
      ),
    );
  }

  // ----------------------------- layout helpers --------------------------
  BoxDecoration _box() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _border),
      );

  /// Lays [children] out in rows of [cols] with fixed gaps.
  Widget _grid(List<Widget> children, int cols, {double gap = 12}) {
    final rows = <Widget>[];
    for (var i = 0; i < children.length; i += cols) {
      rows.add(
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var j = 0; j < cols; j++) ...[
                if (j > 0) SizedBox(width: gap),
                Expanded(
                  child: i + j < children.length
                      ? children[i + j]
                      : const SizedBox.shrink(),
                ),
              ],
            ],
          ),
        ),
      );
      if (i + cols < children.length) rows.add(SizedBox(height: gap));
    }
    return Column(children: rows);
  }

  // ----------------------------- stat cards ------------------------------
  Widget _statCards(bool mobile) {
    final cards = _stats.map((s) => _statCard(s, mobile)).toList();

    if (mobile) {
      // single column, as in the design
      return Column(
        children: [
          for (var i = 0; i < cards.length; i++) ...[
            if (i > 0) const SizedBox(height: 12),
            cards[i],
          ],
        ],
      );
    }
    return _grid(cards, 4, gap: 16);
  }

  Widget _statCard(_Stat s, bool mobile) {
    final on = s.highlighted;

    return Container(
      constraints: BoxConstraints(minHeight: mobile ? 132 : 136),
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
      decoration: on
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF3A4FE6), Color(0xFF181D5C)],
              ),
            )
          : _box(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  s.label,
                  style: TextStyle(
                    fontFamily: _mono,
                    fontSize: AppType.cardLabel,
                    letterSpacing: 1,
                    color: on ? Colors.white70 : const Color(0xFF7C8DA3),
                  ),
                ),
              ),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: s.chipBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(s.icon, size: 17, color: s.chipFg),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            s.value,
            style: TextStyle(
              fontSize: mobile ? AppType.statValueM : AppType.statValueD,
              fontWeight: FontWeight.w700,
              color: on ? Colors.white : _ink,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            s.delta,
            style: TextStyle(
              fontSize: AppType.delta,
              fontWeight: FontWeight.w500,
              color: on ? Colors.white : AppColors.green,
            ),
          ),
        ],
      ),
    );
  }

  // ----------------------------- system status ---------------------------
  Widget _statusCards(bool mobile) {
    return _grid(
      _status.map((s) => _statusCard(s)).toList(),
      mobile ? 2 : 4,
      gap: mobile ? 12 : 16,
    );
  }

  Widget _statusCard(_StatusItem s) {
    return Container(
      constraints: const BoxConstraints(minHeight: 84),
      padding: const EdgeInsets.fromLTRB(16, 14, 12, 14),
      decoration: _box(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            s.label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontFamily: _mono,
              fontSize: 9.5,
              letterSpacing: 1,
              color: Color(0xFF7C8DA3),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(color: s.color, shape: BoxShape.circle),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  s.value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: _ink,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ----------------------------- resources -------------------------------
  Widget _resourceCard(bool mobile) {
    final rows = _resources.map(_resourceRow).toList();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
      decoration: _box(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'RESOURCE UTILIZATION',
            style: TextStyle(
              fontFamily: _mono,
              fontSize: AppType.cardLabel,
              letterSpacing: 1,
              color: Color(0xFF7C8DA3),
            ),
          ),
          const SizedBox(height: 12),
          if (mobile)
            for (var i = 0; i < rows.length; i++) ...[
              if (i > 0) const SizedBox(height: 14),
              rows[i],
            ]
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var i = 0; i < rows.length; i++) ...[
                  if (i > 0) const SizedBox(width: 28),
                  Expanded(child: rows[i]),
                ],
              ],
            ),
        ],
      ),
    );
  }

  Widget _resourceRow(_Resource r) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                r.label,
                style: const TextStyle(fontSize: AppType.body, color: _ink),
              ),
            ),
            Text(
              '${r.percent}%',
              style: const TextStyle(
                fontSize: AppType.body,
                fontWeight: FontWeight.w600,
                color: _ink,
              ),
            ),
          ],
        ),
        const SizedBox(height: 7),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Stack(
            children: [
              Container(height: 6, color: const Color(0xFFEEF1F5)),
              FractionallySizedBox(
                widthFactor: r.percent / 100,
                child: Container(height: 6, color: r.color),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ----------------------------- quick navigation ------------------------
  Widget _navCards(bool mobile) {
    return _grid(
      _nav.map((n) => _navCard(n)).toList(),
      mobile ? 2 : 4,
      gap: mobile ? 12 : 16,
    );
  }

  Widget _navCard(_NavItem n) {
    return InkWell(
      onTap: () => _open(n.route, n.title),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        constraints: const BoxConstraints(minHeight: 106),
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(16, 14, 12, 14),
        decoration: _box(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: const Color(0xFFE5F6EE),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(n.icon, size: 17, color: const Color(0xFF1FA67A)),
            ),
            const SizedBox(height: 12),
            Text(
              n.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: AppType.body,
                fontWeight: FontWeight.w700,
                color: _ink,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              n.subtitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: AppType.bodySmall, color: _muted),
            ),
          ],
        ),
      ),
    );
  }

  // ----------------------------- alerts + logins -------------------------
  Widget _bottomPanels(bool mobile) {
    final alerts = _alertsPanel();
    final logins = _loginsPanel();

    if (mobile) {
      return Column(
        children: [
          alerts,
          const SizedBox(height: 14),
          logins,
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: alerts),
        const SizedBox(width: 16),
        Expanded(child: logins),
      ],
    );
  }

  Widget _alertsPanel() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 6),
      decoration: _box(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 2, bottom: 12),
            child: Text(
              'Security alerts',
              style: TextStyle(
                fontSize: AppType.panelTitle,
                fontWeight: FontWeight.w700,
                color: _ink,
              ),
            ),
          ),
          for (final a in _alerts) _alertTile(a),
        ],
      ),
    );
  }

  Widget _alertTile(_AlertItem a) {
    final warn = a.tone == _AlertTone.warning;
    final bg = warn ? const Color(0xFFFAEFD6) : const Color(0xFFE8F0FE);
    final title = warn ? const Color(0xFF8A5A00) : const Color(0xFF1D4ED8);
    final body = warn ? const Color(0xFFB7791F) : const Color(0xFF3F5FA8);

    return InkWell(
      onTap: () => showSecurityAlertsDialog(context),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(a.icon, size: 18, color: title),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    a.title,
                    style: TextStyle(
                      fontSize: AppType.body,
                      fontWeight: FontWeight.w700,
                      color: title,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    a.message,
                    style: TextStyle(fontSize: AppType.bodySmall, color: body),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _loginsPanel() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      decoration: _box(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 2),
                  child: Text(
                    'Recent login activities',
                    style: TextStyle(
                      fontSize: AppType.panelTitle,
                      fontWeight: FontWeight.w700,
                      color: _ink,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () => showRecentActivitiesDialog(context),
                child: const Text(
                  '24h',
                  style: TextStyle(fontSize: AppType.bodySmall, color: _hint),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          for (var i = 0; i < _logins.length; i++) ...[
            _loginRow(_logins[i]),
            if (i != _logins.length - 1)
              const Divider(height: 1, color: Color(0xFFEDF1F6)),
          ],
        ],
      ),
    );
  }

  Widget _loginRow(_Login l) {
    late final Color bg, fg;
    late final IconData icon;

    switch (l.tone) {
      case _LoginTone.ok:
        bg = const Color(0xFFE5F6EE);
        fg = const Color(0xFF16A870);
        icon = Icons.check;
        break;
      case _LoginTone.warn:
        bg = const Color(0xFFFFF1D6);
        fg = const Color(0xFFD98A12);
        icon = Icons.circle;
        break;
      case _LoginTone.bad:
        bg = const Color(0xFFFFE8EC);
        fg = const Color(0xFFE74760);
        icon = Icons.close;
        break;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
            child: Icon(icon, size: l.tone == _LoginTone.warn ? 6 : 15, color: fg),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: l.who,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      TextSpan(text: l.what),
                    ],
                  ),
                  style: const TextStyle(
                    fontSize: AppType.body,
                    height: 1.35,
                    color: _ink,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  l.time,
                  style: const TextStyle(
                    fontSize: AppType.bodySmall,
                    color: _muted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ----------------------------- export (mobile) -------------------------
  Widget _mobileExport() {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton.icon(
        onPressed: _export,
        icon: const Icon(Icons.download_outlined, size: 18),
        label: const Text(
          'Export',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1B3FE0),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Models
// ---------------------------------------------------------------------------
class _Stat {
  final String label, value, delta;
  final IconData icon;
  final Color chipBg, chipFg;
  final bool highlighted;

  const _Stat(
    this.label,
    this.value,
    this.delta,
    this.icon,
    this.chipBg,
    this.chipFg, {
    this.highlighted = false,
  });
}

class _StatusItem {
  final String label, value;
  final Color color;
  const _StatusItem(this.label, this.value, this.color);
}

class _Resource {
  final String label;
  final int percent;
  final Color color;
  const _Resource(this.label, this.percent, this.color);
}

class _NavItem {
  final String title, subtitle;
  final IconData icon;
  final String? route;
  const _NavItem(this.title, this.subtitle, this.icon, this.route);
}

enum _AlertTone { warning, info }

class _AlertItem {
  final String title, message;
  final IconData icon;
  final _AlertTone tone;
  const _AlertItem(this.title, this.message, this.icon, this.tone);
}

enum _LoginTone { ok, warn, bad }

class _Login {
  final String who, what, time;
  final _LoginTone tone;
  const _Login(this.who, this.what, this.time, this.tone);
}