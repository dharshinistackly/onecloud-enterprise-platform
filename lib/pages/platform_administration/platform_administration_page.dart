import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';
import '../../theme/app_theme.dart';


class PlatformAdministrationPage extends StatefulWidget {
  const PlatformAdministrationPage({super.key});

  @override
  State<PlatformAdministrationPage> createState() =>
      _PlatformAdministrationPageState();
}

const _ink = AppColors.ink;
const _muted = AppColors.muted;
const _border = AppColors.border;
const _mono = AppFonts.mono;

class _PlatformAdministrationPageState
    extends State<PlatformAdministrationPage> {
  // ----------------------------- data ------------------------------------

  static const _a = _Card(
    'Super Admin Dashboard',
    'Platform status, KPIs, system health, and recent admin activity at a glance.',
    Icons.grid_view_rounded,
    AppRoutes.superAdminDashboard,
    showArrow: true,
  );
  static const _b = _Card(
    'Global Dashboard',
    'Platform-wide KPIs across every organization — tenants by plan, onboarding trends.',
    Icons.language,
    AppRoutes.globalDashboard,
  );
  static const _c = _Card(
    'Platform Configuration',
    'Platform name, timezone, session limits, upload size, and environment defaults.',
    Icons.settings_outlined,
    AppRoutes.platformConfig,
  );
  static const _d = _Card(
    'Settings',
    'Platform behavior toggles, regional defaults, security policy, and notifications.',
    Icons.tune,
    AppRoutes.globalSettings,
  );
  static const _e = _Card(
    'Platform Branding',
    'Logo, brand colors, login background, and custom domain for the platform shell.',
    Icons.draw_outlined,
    AppRoutes.platformBranding,
  );
  static const _f = _Card(
    'Feature Management',
    'Roll features out by plan tier, and track rollout percentage across tenants.',
    Icons.layers_outlined,
    AppRoutes.featureManagement,
  );
  static const _g = _Card(
    'License Management',
    'Seat usage, renewal dates, and license status across every organization.',
    Icons.description_outlined,
    AppRoutes.licenseManagement,
  );
  static const _h = _Card(
    'Platform Health Overview',
    'Live status per service — auth, API gateway, database, queue, storage, AI engine.',
    Icons.monitor_heart_outlined,
    AppRoutes.systemHealth,
  );

  // Order differs between the desktop and the phone design.
  static const _adminDesktop = [_a, _b, _c, _d, _e, _f, _g, _h];
  static const _adminPhone = [_a, _b, _c, _e, _f, _h, _g, _d];

  static const _organization = [
    _Card(
      'Company Setup',
      'Business units, departments, branches, and legal entity details.',
      Icons.apartment_outlined,
      null,
    ),
    _Card(
      'User Management',
      'Invite, deactivate, and manage roles for every user across the organization.',
      Icons.group_outlined,
      AppRoutes.userManagement,
    ),
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

  /// Opens [route] inside the shell. Pages that are not registered yet show
  /// a short message instead of failing.
  void _open(_Card card) {
    final route = card.route;

    if (route != null && AppRoutes.routes.containsKey(route)) {
      Navigator.of(context).pushNamed(route);
    } else {
      _toast('${card.title} page will be connected soon.');
    }
  }

  void _refresh() {
    setState(() {});
    _toast('Platform data refreshed');
  }

  // ----------------------------- build -----------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: LayoutBuilder(
        builder: (context, c) {
          final mobile = c.maxWidth < 700;
          final cols = mobile ? 2 : (c.maxWidth < 1000 ? 2 : 3);

          return SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              mobile ? 16 : 24,
              mobile ? 16 : 20,
              mobile ? 16 : 24,
              32,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _heading(mobile),
                SizedBox(height: mobile ? 16 : 20),
                _stats(mobile),
                SizedBox(height: mobile ? 20 : 26),
                _caption('SUPER ADMIN MANAGEMENT', mobile),
                const SizedBox(height: 12),
                _cardGrid(
                  mobile ? _adminPhone : _adminDesktop,
                  cols: cols,
                  mobile: mobile,
                  withDescription: !mobile,
                ),
                SizedBox(height: mobile ? 20 : 26),
                _caption('ORGANIZATION', mobile),
                const SizedBox(height: 12),
                _cardGrid(
                  _organization,
                  // phone: one full-width column with descriptions
                  cols: mobile ? 1 : cols,
                  mobile: mobile,
                  withDescription: true,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ----------------------------- heading ---------------------------------
  Widget _heading(bool mobile) {
    if (mobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Platform Administration  /',
            style: TextStyle(fontSize: AppType.breadcrumb, color: _muted),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Platform Administration',
                  style: TextStyle(
                    fontSize: AppType.pageTitleM,
                    fontWeight: FontWeight.w700,
                    color: _ink,
                  ),
                ),
              ),
              IconButton(
                onPressed: _refresh,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                icon: const Icon(
                  Icons.sync,
                  size: 24,
                  color: Color(0xFF52616F),
                ),
              ),
            ],
          ),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Platform Administration',
                style: TextStyle(fontSize: AppType.breadcrumb, color: _ink),
              ),
              SizedBox(height: 8),
              Text(
                'Platform Administration',
                style: TextStyle(
                  fontSize: AppType.pageTitleD,
                  fontWeight: FontWeight.w700,
                  color: _ink,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 34,
          child: OutlinedButton.icon(
            onPressed: _refresh,
            icon: const Icon(Icons.refresh, size: 16),
            label: const Text(
              'Refresh',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF253341),
              backgroundColor: Colors.white,
              side: const BorderSide(color: Color(0xFFD8E0E8)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _caption(String text, bool mobile) {
    return Text(
      text,
      style: mobile
          ? const TextStyle(
              fontFamily: _mono,
              fontSize: AppType.sectionLabel,
              letterSpacing: 1.2,
              color: Color(0xFF7C8DA3),
            )
          : const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              letterSpacing: .6,
              color: Color(0xFF5A6B80),
            ),
    );
  }

  // ----------------------------- stat cards ------------------------------
  Widget _stats(bool mobile) {
    final cards = <Widget>[
      _statCard(
        label: 'ORGANIZATIONS',
        value: '1,842',
        note: '↑ 4.2% this month',
        noteColor: AppColors.green,
        icon: Icons.apartment_outlined,
        chipBg: const Color(0xFFE5F6EE),
        chipFg: const Color(0xFF1FA67A),
        mobile: mobile,
      ),
      _statCard(
        label: 'TOTAL USERS',
        value: '96,412',
        note: '↑ 1.8% this month',
        noteColor: AppColors.green,
        icon: Icons.group_outlined,
        chipBg: const Color(0xFFE8EEFF),
        chipFg: const Color(0xFF3B5BDB),
        mobile: mobile,
      ),
      _statCard(
        label: 'LICENSES ACTIVE',
        value: '2,140',
        note: '27 expiring < 30 days',
        noteColor: _muted,
        icon: Icons.description_outlined,
        chipBg: const Color(0xFFFFE8EC),
        chipFg: const Color(0xFFE74760),
        mobile: mobile,
      ),
      _statCard(
        label: 'PLATFORM UPTIME',
        value: '99.98%',
        note: 'Healthy — all regions',
        noteColor: Colors.white,
        icon: Icons.monitor_heart_outlined,
        chipBg: Colors.white,
        chipFg: const Color(0xFF1B2160),
        mobile: mobile,
        highlighted: true,
      ),
    ];

    if (mobile) {
      return Column(
        children: [
          for (var i = 0; i < cards.length; i++) ...[
            if (i > 0) const SizedBox(height: 12),
            cards[i],
          ],
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < cards.length; i++) ...[
          if (i > 0) const SizedBox(width: 16),
          Expanded(child: cards[i]),
        ],
      ],
    );
  }

  Widget _statCard({
    required String label,
    required String value,
    required String note,
    required Color noteColor,
    required IconData icon,
    required Color chipBg,
    required Color chipFg,
    required bool mobile,
    bool highlighted = false,
  }) {
    return Container(
      height: mobile ? 140 : 140,
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
      decoration: highlighted
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF2F46F0), Color(0xFF151A55)],
              ),
            )
          : BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _border),
            ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontFamily: _mono,
                    fontSize: AppType.cardLabel,
                    letterSpacing: 1,
                    color: highlighted
                        ? Colors.white70
                        : const Color(0xFF7C8DA3),
                  ),
                ),
              ),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: chipBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, size: 17, color: chipFg),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
  value,
            style: TextStyle(
              fontSize: mobile ? AppType.statValueM : AppType.statValueD,
              fontWeight: FontWeight.w700,
              color: highlighted ? Colors.white : _ink,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            note,
            style: TextStyle(
              fontSize: AppType.bodySmall + 1,
              fontWeight: FontWeight.w500,
              color: noteColor,
            ),
          ),
        ],
      ),
    );
  }

  // ----------------------------- management cards ------------------------
  Widget _cardGrid(
    List<_Card> items, {
    required int cols,
    required bool mobile,
    required bool withDescription,
  }) {
    final rows = <Widget>[];
    final gap = mobile ? 12.0 : 16.0;

    for (var i = 0; i < items.length; i += cols) {
      rows.add(
        // IntrinsicHeight keeps every card in a row the same height without
        // a fixed pixel height (no overflow if a description wraps).
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var j = 0; j < cols; j++) ...[
                if (j > 0) SizedBox(width: gap),
                Expanded(
                  child: i + j < items.length
                      ? _cardTile(
                          items[i + j],
                          mobile: mobile,
                          withDescription: withDescription,
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ],
          ),
        ),
      );

      if (i + cols < items.length) rows.add(SizedBox(height: gap));
    }

    return Column(children: rows);
  }

  Widget _cardTile(
    _Card card, {
    required bool mobile,
    required bool withDescription,
  }) {
    return InkWell(
      onTap: () => _open(card),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        constraints: BoxConstraints(minHeight: mobile ? 134 : 160),
        padding: EdgeInsets.all(mobile ? 16 : 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEF0FF),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Icon(card.icon, size: 19, color: AppColors.blue),
                ),
                const Spacer(),
                if (card.showArrow && !mobile)
                  const Icon(Icons.north_east, size: 14, color: _muted),
              ],
            ),
            SizedBox(height: mobile ? 22 : 18),
            Text(
              card.title,
              style: TextStyle(
                fontSize: mobile ? AppType.body : 15,
                fontWeight: mobile ? FontWeight.w600 : FontWeight.w700,
                color: _ink,
                height: 1.3,
              ),
            ),
            if (withDescription) ...[
              const SizedBox(height: 6),
              Text(
                card.description,
                style: const TextStyle(
                  fontSize: AppType.bodySmall + .5,
                  height: 1.5,
                  color: _muted,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _Card {
  final String title, description;
  final IconData icon;
  final String? route;
  final bool showArrow;

  const _Card(
    this.title,
    this.description,
    this.icon,
    this.route, {
    this.showArrow = false,
  });
}