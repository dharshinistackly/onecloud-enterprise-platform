import 'package:flutter/material.dart';


class FeatureManagementPage extends StatefulWidget {
  const FeatureManagementPage({super.key});

  @override
  State<FeatureManagementPage> createState() => _FeatureManagementPageState();
}

// ---------------------------------------------------------------------------
// Design tokens
// ---------------------------------------------------------------------------
const _ink = Color(0xFF172536);
const _muted = Color(0xFF61758A);
const _hint = Color(0xFF8A9AB0);
const _border = Color(0xFFDDE4EC);
const _bg = Color(0xFFF7F9FC);
const _navy = Color(0xFF242C66);
const _blue = Color(0xFF283BEA);
const _green = Color(0xFF00A96B);
const _red = Color(0xFFE74760);

class _FeatureManagementPageState extends State<FeatureManagementPage> {
  final _searchController = TextEditingController();

  String? _module;
  String? _plan;
  String? _status;
  int _page = 1;

  final List<Map<String, dynamic>> _features = [
    {
      'name': 'User Management',
      'module': 'Identity',
      'plan': 'Enterprise',
      'enabled': true,
    },
    {
      'name': 'Workflow Engine',
      'module': 'Workflow',
      'plan': 'Enterprise',
      'enabled': true,
    },
    {
      'name': 'AI Assistant',
      'module': 'AI Services',
      'plan': 'Premium',
      'enabled': false,
    },
    {
      'name': 'Reports',
      'module': 'Analytics',
      'plan': 'Standard',
      'enabled': true,
    },
    {
      'name': 'API Access',
      'module': 'Integration',
      'plan': 'Enterprise',
      'enabled': true,
    },
  ];

  List<Map<String, dynamic>> get _filtered {
    final q = _searchController.text.trim().toLowerCase();
    return _features.where((f) {
      if (q.isNotEmpty && !(f['name'] as String).toLowerCase().contains(q)) {
        return false;
      }
      if (_module != null && f['module'] != _module) return false;
      if (_plan != null && f['plan'] != _plan) return false;
      if (_status != null) {
        final enabled = f['enabled'] as bool;
        if (_status == 'Enabled' && !enabled) return false;
        if (_status == 'Disabled' && enabled) return false;
      }
      return true;
    }).toList();
  }

  void _clearFilters() => setState(() {
        _searchController.clear();
        _module = null;
        _plan = null;
        _status = null;
      });

  void _toggle(Map<String, dynamic> f) =>
      setState(() => f['enabled'] = !(f['enabled'] as bool));

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // -------------------------------------------------------------------------
  // Build
  // -------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, c) {
            final mobile = c.maxWidth < 700;
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

  // -------------------------------------------------------------------------
  // MOBILE
  // -------------------------------------------------------------------------
  Widget _mobile() {
    final items = _filtered;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Platform Administration / Feature Management',
          style: TextStyle(fontSize: 10, color: _hint),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Expanded(
              child: Text(
                'Feature Management',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: _ink,
                ),
              ),
            ),
            IconButton(
              onPressed: _refresh,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 30, minHeight: 30),
              icon: const Icon(Icons.sync, size: 22, color: Color(0xFF52616F)),
            ),
          ],
        ),
        const SizedBox(height: 14),
        ..._stats.map(
          (s) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _StatCard(data: s, height: 136),
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 14),
          decoration: _box(radius: 12),
          child: Column(
            children: [
              _searchField(radius: 12, fontSize: 13),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _filters(compact: true),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              ...items.map(_mobileCard),
              if (items.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(24),
                  child: Text('No features found',
                      style: TextStyle(color: _hint, fontSize: 12)),
                ),
              const SizedBox(height: 4),
              const Text(
                'Showing 1-5 of 65 features',
                style: TextStyle(fontSize: 10, color: _hint),
              ),
              const SizedBox(height: 10),
              _pagination(),
            ],
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          height: 44,
          child: ElevatedButton.icon(
            onPressed: _showExportDialog,
            icon: const Icon(Icons.download_outlined, size: 17),
            label: const Text('Export Report',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
            style: ElevatedButton.styleFrom(
              backgroundColor: _blue,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _mobileCard(Map<String, dynamic> f) {
    final enabled = f['enabled'] as bool;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
      decoration: _box(radius: 12),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      f['name'],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: _ink,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '${f['module']} · ${f['plan']}',
                      style: const TextStyle(fontSize: 11, color: _muted),
                    ),
                  ],
                ),
              ),
              _StatusBadge(enabled: enabled),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _OutBtn(
                  label: 'Configure',
                  icon: Icons.tune,
                  color: _ink,
                  onPressed: () => _showOrgAccessDialog(f),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _OutBtn(
                  label: 'Usage',
                  color: _ink,
                  onPressed: () => _showHistoryDialog(f),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _OutBtn(
                  label: enabled ? 'Disable' : 'Enable',
                  color: enabled ? _red : _green,
                  fill: enabled ? null : const Color(0xFFF1FBF7),
                  onPressed: () => _requestToggle(f),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // DESKTOP
  // -------------------------------------------------------------------------
  Widget _desktop() {
    final items = _filtered;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Text('Platform Administration',
                style: TextStyle(fontSize: 12, color: _muted)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6),
              child: Text('/', style: TextStyle(fontSize: 12, color: _muted)),
            ),
            Text(
              'Feature Management',
              style: TextStyle(
                  fontSize: 12, color: _ink, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Feature Management',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: _ink,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Control platform feature availability, configuration, and access across the enterprise.',
                    style: TextStyle(fontSize: 13, color: _muted),
                  ),
                ],
              ),
            ),
            _topButton('Refresh', Icons.refresh, onPressed: _refresh),
            const SizedBox(width: 10),
            _topButton(
              'Export report',
              Icons.download_outlined,
              primary: true,
              onPressed: _showExportDialog,
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            for (var i = 0; i < _stats.length; i++) ...[
              if (i > 0) const SizedBox(width: 14),
              Expanded(child: _StatCard(data: _stats[i], height: 138)),
            ],
          ],
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          decoration: _box(radius: 12),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 14),
                child: Row(
                  children: [
                    Expanded(child: _searchField(radius: 8, fontSize: 15, borderless: true)),
                    const SizedBox(width: 12),
                    _filters(compact: false),
                    const SizedBox(width: 14),
                    InkWell(
                      onTap: _clearFilters,
                      child: const Text(
                        'Clear Filters',
                        style: TextStyle(
                          fontSize: 13,
                          color: _blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              _table(items),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: _border)),
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Showing 1-5 of 65 features',
                        style: TextStyle(fontSize: 13, color: _muted),
                      ),
                    ),
                    _pagination(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _table(List<Map<String, dynamic>> items) {
    const head = TextStyle(
      color: Colors.white,
      fontSize: 12,
      fontWeight: FontWeight.w700,
      letterSpacing: .4,
    );

    Widget h(String t, int flex, {TextAlign a = TextAlign.left}) =>
        Expanded(flex: flex, child: Text(t, textAlign: a, style: head));

    return Column(
      children: [
        Container(
          height: 55,
          color: _navy,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              h('FEATURE NAME', 20),
              h('MODULE', 14),
              h('LICENSE PLAN', 14),
              h('STATUS', 12, a: TextAlign.center),
              h('CONFIGURE', 14, a: TextAlign.center),
              h('USAGE', 12, a: TextAlign.center),
              h('ACTION', 12, a: TextAlign.center),
              const SizedBox(width: 36),
            ],
          ),
        ),
        if (items.isEmpty)
          const Padding(
            padding: EdgeInsets.all(32),
            child: Text('No features found',
                style: TextStyle(color: _hint, fontSize: 13)),
          ),
        ...items.map(_tableRow),
      ],
    );
  }

  Widget _tableRow(Map<String, dynamic> f) {
    final enabled = f['enabled'] as bool;
    const cell = TextStyle(fontSize: 14, color: _ink);
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            flex: 20,
            child: Text(f['name'],
                style: cell.copyWith(fontWeight: FontWeight.w500)),
          ),
          Expanded(flex: 14, child: Text(f['module'], style: cell)),
          Expanded(flex: 14, child: Text(f['plan'], style: cell)),
          Expanded(
            flex: 12,
            child: Center(child: _StatusBadge(enabled: enabled, small: true)),
          ),
          Expanded(
            flex: 14,
            child: Center(
              child: SizedBox(
                height: 28,
                child: OutlinedButton.icon(
                  onPressed: () => _showOrgAccessDialog(f),
                  icon: const Icon(Icons.tune, size: 13),
                  label: const Text('Configure',
                      style: TextStyle(fontSize: 12)),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: _ink,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    side: const BorderSide(color: Color(0xFFD8E0E8)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 12,
            child: Center(
              child: InkWell(
                onTap: () => _showHistoryDialog(f),
                child: const Text(
                  'View Usage',
                  style: TextStyle(
                    fontSize: 12,
                    color: _ink,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 12,
            child: Center(
              child: SizedBox(
                height: 26,
                child: OutlinedButton(
                  onPressed: () => _requestToggle(f),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: enabled ? _red : _green,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    side: BorderSide(color: enabled ? _red : _green),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                  ),
                  child: Text(enabled ? 'Disable' : 'Enable',
                      style: const TextStyle(fontSize: 12)),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 36,
            child: PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert, size: 20, color: _ink),
              padding: EdgeInsets.zero,
              onSelected: (v) {
                if (v == 'access') _showOrgAccessDialog(f);
                if (v == 'history') _showHistoryDialog(f);
                if (v == 'toggle') _requestToggle(f);
              },
              itemBuilder: (_) => [
                const PopupMenuItem(
                  value: 'access',
                  child: Text('Organization access'),
                ),
                const PopupMenuItem(
                  value: 'history',
                  child: Text('Change history'),
                ),
                PopupMenuItem(
                  value: 'toggle',
                  child: Text(enabled ? 'Disable feature' : 'Enable feature'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // Shared pieces
  // -------------------------------------------------------------------------
  BoxDecoration _box({required double radius}) => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: _border),
      );

  Widget _filters({required bool compact}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _Filter(
          label: 'All Modules',
          value: _module,
          options: const ['Identity', 'Workflow', 'AI Services', 'Analytics', 'Integration'],
          compact: compact,
          onChanged: (v) => setState(() => _module = v),
        ),
        SizedBox(width: compact ? 8 : 12),
        _Filter(
          label: 'All License Plans',
          value: _plan,
          options: const ['Standard', 'Premium', 'Enterprise'],
          compact: compact,
          onChanged: (v) => setState(() => _plan = v),
        ),
        SizedBox(width: compact ? 8 : 12),
        _Filter(
          label: 'All Status',
          value: _status,
          options: const ['Enabled', 'Disabled'],
          compact: compact,
          onChanged: (v) => setState(() => _status = v),
        ),
      ],
    );
  }

  Widget _searchField({
    required double radius,
    required double fontSize,
    bool borderless = false,
  }) {
    final side = borderless
        ? BorderSide.none
        : const BorderSide(color: Color(0xFFD8E0E8));
    return SizedBox(
      height: 42,
      child: TextField(
        controller: _searchController,
        onChanged: (_) => setState(() {}),
        style: TextStyle(fontSize: fontSize),
        decoration: InputDecoration(
          hintText: 'Search features...',
          hintStyle:
              TextStyle(fontSize: fontSize, color: const Color(0xFF8D9BAD)),
          prefixIcon: const Icon(Icons.search, size: 20, color: _muted),
          contentPadding: EdgeInsets.zero,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: side,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: const BorderSide(color: _blue),
          ),
        ),
      ),
    );
  }

  Widget _topButton(
    String label,
    IconData icon, {
    bool primary = false,
    VoidCallback? onPressed,
  }) {
    final text = Text(label,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600));
    final shape =
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(6));
    return SizedBox(
      height: 34,
      child: primary
          ? ElevatedButton.icon(
              onPressed: onPressed ?? () {},
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
              onPressed: onPressed ?? () {},
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

  Widget _pagination() {
    Widget dots() => const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text('...', style: TextStyle(fontSize: 11, color: _muted)),
        );
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _PageBtn(
          icon: Icons.chevron_left,
          enabled: _page > 1,
          onTap: () => setState(() => _page--),
        ),
        for (final p in [1, 2, 3])
          _PageBtn(
            text: '$p',
            selected: _page == p,
            onTap: () => setState(() => _page = p),
          ),
        dots(),
        _PageBtn(
          text: '13',
          selected: _page == 13,
          onTap: () => setState(() => _page = 13),
        ),
        _PageBtn(
          icon: Icons.chevron_right,
          enabled: _page < 13,
          onTap: () => setState(() => _page++),
        ),
      ],
    );
  }

  // =========================================================================
  // POP-UPS
  //   Export report / Export Report -> _showExportDialog()
  //   Configure                     -> _showOrgAccessDialog(feature)
  //   View Usage / Usage            -> _showHistoryDialog(feature)
  //   Enable / Disable              -> _requestToggle(feature)
  //   ⋮ menu                        -> org access / history
  //   Refresh                       -> _refresh()
  // =========================================================================

  static const _orgs = [
    ['Infotech Innovations', 'Enterprise'],
    ['Nexus Labs', 'Premium'],
    ['Orbit Systems', 'Standard'],
    ['Zenith Corp', 'Enterprise'],
    ['Bright Ventures', 'Premium'],
  ];

  /// feature name -> selected org names. A missing key means "All Organizations".
  final Map<String, Set<String>> _orgAccess = {};

  static const _history = [
    ['Status Updated', 'Disabled', 'Enabled', 'Hemanshu', '14 Aug 2025, 02:41 AM'],
    ['Status Updated', 'Enabled', 'Disabled', 'Hemanshu', '10 Aug 2025, 11:12 AM'],
    ['Status Updated', 'Disabled', 'Enabled', 'Hemanshu', '02 Aug 2025, 09:30 AM'],
    ['Status Updated', 'Enabled', 'Disabled', 'Hemanshu', '28 Jul 2025, 04:05 PM'],
    ['License Plan Updated', 'Standard', 'Enterprise', 'Hemanshu', '20 Jul 2025, 10:15 AM'],
  ];

  void _refresh() {
    setState(() {});
    _toast('Data refreshed', 'Feature list is up to date.');
  }

  void _toast(String title, [String? subtitle]) {
    final messenger = ScaffoldMessenger.of(context);
    final screen = MediaQuery.of(context).size.width;
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.white,
        elevation: 6,
        width: screen < 360 ? screen - 32 : 320,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: _border),
        ),
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: _green, size: 22),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: _ink,
                    ),
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle,
                      style: const TextStyle(fontSize: 11, color: _muted),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---- shared frame --------------------------------------------------------

  Widget _dialogShell({
    required String title,
    required String subtitle,
    required Widget body,
    Widget? footer,
    Widget? leading,
    double maxWidth = 520,
  }) {
    return Dialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 14, 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (leading != null) ...[
                    leading,
                    const SizedBox(width: 12),
                  ],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: _ink,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          subtitle,
                          style: const TextStyle(fontSize: 11, color: _muted),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Builder(
                    builder: (ctx) => InkWell(
                      onTap: () => Navigator.of(ctx).pop(),
                      customBorder: const CircleBorder(),
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFFD0D7E2)),
                        ),
                        child: const Icon(Icons.close, size: 14, color: _muted),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(child: body),
            if (footer != null) footer,
          ],
        ),
      ),
    );
  }

  Widget _dialogFooter(
    BuildContext ctx, {
    required String confirmLabel,
    required VoidCallback onConfirm,
    Color confirmColor = _blue,
    IconData? confirmIcon,
  }) {
    final shape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(8));
    const txt = TextStyle(fontSize: 13, fontWeight: FontWeight.w600);
    final pad = const EdgeInsets.symmetric(horizontal: 20, vertical: 13);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          OutlinedButton(
            onPressed: () => Navigator.of(ctx).pop(),
            style: OutlinedButton.styleFrom(
              foregroundColor: _ink,
              side: const BorderSide(color: Color(0xFFD8E0E8)),
              padding: pad,
              shape: shape,
            ),
            child: const Text('Cancel', style: txt),
          ),
          const SizedBox(width: 10),
          ElevatedButton.icon(
            onPressed: onConfirm,
            icon: confirmIcon == null
                ? const SizedBox.shrink()
                : Icon(confirmIcon, size: 17),
            label: Text(confirmLabel, style: txt),
            style: ElevatedButton.styleFrom(
              backgroundColor: confirmColor,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: pad,
              shape: shape,
            ),
          ),
        ],
      ),
    );
  }

  Widget _label(String t) => Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Text(
          t,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: _ink,
          ),
        ),
      );

  // ---- confirm (enable / disable / rollback) --------------------------------

  Future<bool> _confirm({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required String message,
    required String confirmLabel,
    String? warning,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => _dialogShell(
        maxWidth: 400,
        title: title,
        subtitle: subtitle,
        leading: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: color.withValues(alpha: .12),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 20, color: color),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message,
                style: const TextStyle(
                  fontSize: 12,
                  height: 1.5,
                  color: Color(0xFF4A5A6E),
                ),
              ),
              if (warning != null) ...[
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFEEF0),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: const Color(0xFFF8C9D0)),
                  ),
                  child: Text(
                    warning,
                    style: const TextStyle(
                      fontSize: 11,
                      height: 1.4,
                      color: Color(0xFFC23048),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        footer: _dialogFooter(
          ctx,
          confirmLabel: confirmLabel,
          confirmColor: color,
          onConfirm: () => Navigator.of(ctx).pop(true),
        ),
      ),
    );
    return result ?? false;
  }

  /// Enable / Disable buttons call this instead of toggling directly.
  Future<void> _requestToggle(Map<String, dynamic> f) async {
    final enabled = f['enabled'] as bool;
    final name = f['name'] as String;

    final ok = enabled
        ? await _confirm(
            icon: Icons.block,
            color: _red,
            title: 'Disable Feature',
            subtitle: name,
            message:
                'Are you sure you want to disable the "$name" feature? This will immediately revoke access for all tenant organizations using it.',
            confirmLabel: 'Disable Feature',
          )
        : await _confirm(
            icon: Icons.check_circle_outline,
            color: _green,
            title: 'Enable Feature',
            subtitle: name,
            message:
                'Are you sure you want to enable the "$name" feature? This will immediately make it accessible to all tenant organizations on the ${f['plan']} plan.',
            confirmLabel: 'Enable Feature',
          );

    if (!ok || !mounted) return;
    _toggle(f);
    _toast(enabled ? 'Feature Disabled' : 'Feature Enabled', name);
  }

  // ---- Export Feature Management Report -------------------------------------

  void _showExportDialog() {
    final now = DateTime.now();
    String two(int n) => n.toString().padLeft(2, '0');
    final nameCtrl = TextEditingController(
      text: 'Feature_Management_Report_${now.year}-${two(now.month)}-${two(now.day)}',
    );

    var scope = 'All Features (65 records)';
    var format = 'CSV (Comma Separated)';
    var interval = '30d';
    final sections = <bool>[true, false, false];

    showDialog<void>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (ctx, setLocal) {
          Widget dropdown(
            String value,
            List<String> options,
            ValueChanged<String> onChanged,
          ) {
            return Container(
              height: 38,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: const Color(0xFFD8E0E8)),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: value,
                  isExpanded: true,
                  icon: const Icon(Icons.unfold_more, size: 16, color: _muted),
                  style: const TextStyle(fontSize: 12, color: _ink),
                  items: [
                    for (final o in options)
                      DropdownMenuItem(value: o, child: Text(o)),
                  ],
                  onChanged: (v) {
                    if (v != null) setLocal(() => onChanged(v));
                  },
                ),
              ),
            );
          }

          Widget chip(String id, String label) {
            final selected = interval == id;
            return InkWell(
              onTap: () => setLocal(() => interval = id),
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                decoration: BoxDecoration(
                  color: selected
                      ? const Color(0xFF1E2A5E)
                      : const Color(0xFFF1F4F8),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: selected ? Colors.white : const Color(0xFF41536B),
                  ),
                ),
              ),
            );
          }

          Widget check(int i, String label) => InkWell(
                onTap: () => setLocal(() => sections[i] = !sections[i]),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: Checkbox(
                          value: sections[i],
                          activeColor: _green,
                          visualDensity: VisualDensity.compact,
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          onChanged: (v) =>
                              setLocal(() => sections[i] = v ?? false),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          label,
                          style: const TextStyle(fontSize: 11, color: _ink),
                        ),
                      ),
                    ],
                  ),
                ),
              );

          return _dialogShell(
            title: 'Export Feature Management Report',
            subtitle:
                'Download comprehensive feature configuration, license tier and usage metrics.',
            maxWidth: 480,
            body: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(height: 1, color: Color(0xFFEDF1F6)),
                  const SizedBox(height: 12),
                  _label('Export Report Name'),
                  TextField(
                    controller: nameCtrl,
                    style: const TextStyle(fontSize: 12, color: _ink),
                    decoration: InputDecoration(
                      isDense: true,
                      suffixIcon: const Icon(Icons.edit_outlined,
                          size: 15, color: _muted),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 11),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(color: Color(0xFFD8E0E8)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(color: _blue),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _label('Export Scope'),
                            dropdown(
                              scope,
                              const [
                                'All Features (65 records)',
                                'Enabled Features (52 records)',
                                'Disabled Features (13 records)',
                              ],
                              (v) => scope = v,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _label('Document Format'),
                            dropdown(
                              format,
                              const [
                                'CSV (Comma Separated)',
                                'Excel (.xlsx)',
                                'PDF Document',
                              ],
                              (v) => format = v,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  _label('Telemetry & Usage Interval'),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      chip('today', 'Today'),
                      chip('7d', 'Last 7 Days'),
                      chip('30d', 'Last 30 Days'),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(12, 10, 12, 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF6F8FB),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Include Data Sections',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: _ink,
                          ),
                        ),
                        const SizedBox(height: 4),
                        check(0, 'Include tenant adoption, daily calls & latency stats'),
                        check(1, 'Include rate limits, concurrency & governance flags'),
                        check(2, 'Include license tier requirements and feature notes'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            footer: _dialogFooter(
              dialogContext,
              confirmLabel: 'Download Export',
              confirmIcon: Icons.download_outlined,
              onConfirm: () {
                Navigator.of(dialogContext).pop();
                // TODO: call your real export here using
                //   nameCtrl.text, scope, format, interval, sections
                _toast('Export started', '${nameCtrl.text} · $format');
              },
            ),
          );
        },
      ),
    ).whenComplete(nameCtrl.dispose);
  }

  // ---- Organization Access (Configure) --------------------------------------

  void _showOrgAccessDialog(Map<String, dynamic> f) {
    final name = f['name'] as String;
    final saved = _orgAccess[name];
    var mode = saved == null ? 'all' : 'selected';
    final selected = <String>{...(saved ?? <String>{_orgs[0][0], _orgs[1][0]})};
    var query = '';

    showDialog<void>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (ctx, setLocal) {
          Widget radio(String id, String title, String sub) {
            final on = mode == id;
            return InkWell(
              onTap: () => setLocal(() => mode = id),
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: on ? const Color(0xFFF5F7FF) : Colors.white,
                  border: Border.all(color: on ? _blue : const Color(0xFFD8E0E8)),
                ),
                child: Row(
                  children: [
                    Icon(
                      on ? Icons.radio_button_checked : Icons.radio_button_off,
                      size: 18,
                      color: on ? _blue : _muted,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title,
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: _ink)),
                          const SizedBox(height: 2),
                          Text(sub,
                              style: const TextStyle(
                                  fontSize: 10, color: _muted)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          final visible = _orgs
              .where((o) => o[0].toLowerCase().contains(query.toLowerCase()))
              .toList();
          final allChecked = selected.length == _orgs.length;

          Widget summaryCell(String k, String v) => Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(k,
                        style: const TextStyle(
                            fontSize: 9, color: _hint, letterSpacing: .4)),
                    const SizedBox(height: 3),
                    Text(v,
                        style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: _ink)),
                  ],
                ),
              );

          return _dialogShell(
            title: 'Organization Access',
            subtitle: 'Control which organizations can access this feature.',
            maxWidth: 520,
            body: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('ORGANIZATION ACCESS',
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: _muted,
                          letterSpacing: .6)),
                  const SizedBox(height: 8),
                  radio('all', 'All Organizations',
                      'Enable this feature for all organizations'),
                  radio('selected', 'Selected Organizations',
                      'Enable the feature only for selected organizations'),
                  if (mode == 'selected') ...[
                    const SizedBox(height: 4),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFD8E0E8)),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 8, 10, 4),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    onChanged: (v) =>
                                        setLocal(() => query = v),
                                    style: const TextStyle(fontSize: 12),
                                    decoration: const InputDecoration(
                                      isDense: true,
                                      border: InputBorder.none,
                                      hintText: 'Search organizations',
                                      prefixIcon: Icon(Icons.search, size: 16),
                                      prefixIconConstraints:
                                          BoxConstraints(minWidth: 26),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () => setLocal(() {
                                    allChecked
                                        ? selected.clear()
                                        : selected.addAll(
                                            _orgs.map((o) => o[0]));
                                  }),
                                  child: Text(
                                    allChecked ? 'Clear all' : 'Select all',
                                    style: const TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: _blue),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Divider(height: 1, color: Color(0xFFEDF1F6)),
                          for (final o in visible)
                            CheckboxListTile(
                              dense: true,
                              visualDensity: VisualDensity.compact,
                              controlAffinity: ListTileControlAffinity.leading,
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              activeColor: _blue,
                              value: selected.contains(o[0]),
                              onChanged: (v) => setLocal(() {
                                v == true
                                    ? selected.add(o[0])
                                    : selected.remove(o[0]);
                              }),
                              title: Text(o[0],
                                  style: const TextStyle(
                                      fontSize: 12, color: _ink)),
                              secondary: Text(o[1],
                                  style: const TextStyle(
                                      fontSize: 10, color: _muted)),
                            ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              '${selected.length} of ${_orgs.length} organizations selected',
                              style: const TextStyle(
                                  fontSize: 10, color: _hint),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  const SizedBox(height: 14),
                  const Text('FEATURE SUMMARY',
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: _muted,
                          letterSpacing: .6)),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF6F8FB),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        summaryCell('FEATURE', name),
                        summaryCell('LICENSE PLAN', f['plan'] as String),
                        summaryCell(
                          'SELECTED ORGS',
                          mode == 'all' ? 'All' : '${selected.length}',
                        ),
                        summaryCell('LAST UPDATED', '14 Aug 2025'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F4F8),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      mode == 'all'
                          ? 'Every organization on the ${f['plan']} plan will have access to this feature.'
                          : 'Only selected organizations will have access to this feature.',
                      style: const TextStyle(fontSize: 10, color: _muted),
                    ),
                  ),
                ],
              ),
            ),
            footer: _dialogFooter(
              dialogContext,
              confirmLabel: 'Save Changes',
              onConfirm: () {
                setState(() {
                  if (mode == 'all') {
                    _orgAccess.remove(name);
                  } else {
                    _orgAccess[name] = {...selected};
                  }
                });
                Navigator.of(dialogContext).pop();
                _toast('Access updated', name);
              },
            ),
          );
        },
      ),
    );
  }

  // ---- History (View Usage) -------------------------------------------------

  void _showHistoryDialog(Map<String, dynamic> f) {
    final name = f['name'] as String;
    final enabled = f['enabled'] as bool;

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        const headStyle = TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.w700,
          letterSpacing: .4,
        );
        const cell = TextStyle(fontSize: 11, color: _ink);

        Widget col(String t, int flex) =>
            Expanded(flex: flex, child: Text(t, style: headStyle));

        Widget summary(String k, String v) => Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(k,
                      style: const TextStyle(
                          fontSize: 9, color: _hint, letterSpacing: .4)),
                  const SizedBox(height: 3),
                  Text(v,
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: _ink)),
                ],
              ),
            );

        return _dialogShell(
          title: 'History',
          subtitle: 'View previous feature changes and restore an earlier configuration.',
          maxWidth: 720,
          body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: _border),
                  ),
                  child: Row(
                    children: [
                      summary('FEATURE', name),
                      summary('MODULE', f['module'] as String),
                      summary('CURRENT STATUS', enabled ? 'Enabled' : 'Disabled'),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: 660,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Column(
                        children: [
                          Container(
                            height: 36,
                            color: _navy,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              children: [
                                col('CHANGE', 18),
                                col('PREVIOUS VALUE', 15),
                                col('NEW VALUE', 14),
                                col('CHANGED BY', 14),
                                col('CHANGED ON', 22),
                                col('ACTION', 12),
                              ],
                            ),
                          ),
                          for (final h in _history)
                            Container(
                              height: 44,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: _border),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Expanded(flex: 18, child: Text(h[0], style: cell)),
                                  Expanded(flex: 15, child: Text(h[1], style: cell)),
                                  Expanded(flex: 14, child: Text(h[2], style: cell)),
                                  Expanded(flex: 14, child: Text(h[3], style: cell)),
                                  Expanded(flex: 22, child: Text(h[4], style: cell)),
                                  Expanded(
                                    flex: 12,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: SizedBox(
                                        height: 24,
                                        child: OutlinedButton(
                                          onPressed: () async {
                                            final ok = await _confirm(
                                              icon: Icons.warning_amber_rounded,
                                              color: const Color(0xFFD93A3A),
                                              title: 'Rollback Feature Change',
                                              subtitle: name,
                                              message:
                                                  'Are you sure you want to rollback this feature to its previous configuration?',
                                              warning:
                                                  'Warning: This will restore "${h[1]}" and may immediately change tenant access to this feature.',
                                              confirmLabel: 'Rollback Change',
                                            );
                                            if (ok && mounted) {
                                              _toast('Change rolled back', name);
                                            }
                                          },
                                          style: OutlinedButton.styleFrom(
                                            foregroundColor: _red,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8),
                                            side: const BorderSide(color: _red),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                          ),
                                          child: const Text('Rollback',
                                              style: TextStyle(fontSize: 10)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Changes are retained for 90 days.',
                  style: TextStyle(fontSize: 10, color: _hint),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}

// ---------------------------------------------------------------------------
// Stat cards
// ---------------------------------------------------------------------------
class _StatData {
  final String title, value, delta;
  final IconData icon;
  final Color iconColor;
  final bool up;

  const _StatData({
    required this.title,
    required this.value,
    required this.delta,
    required this.icon,
    required this.iconColor,
    required this.up,
  });
}

const _stats = [
  _StatData(
    title: 'Total Features',
    value: '65',
    delta: '+4.2%',
    icon: Icons.tune,
    iconColor: Color(0xFF1B2A4A),
    up: true,
  ),
  _StatData(
    title: 'Enabled',
    value: '52',
    delta: '+3.6%',
    icon: Icons.check_circle_outline,
    iconColor: Color(0xFF16A56A),
    up: true,
  ),
  _StatData(
    title: 'Disabled',
    value: '13',
    delta: '-7.1%',
    icon: Icons.error_outline,
    iconColor: Color(0xFFD93A3A),
    up: false,
  ),
];

class _StatCard extends StatelessWidget {
  final _StatData data;
  final double height;
  const _StatCard({required this.data, required this.height});

  @override
  Widget build(BuildContext context) {
    final color = data.up ? const Color(0xFF16A56A) : const Color(0xFFD93A3A);
    return Container(
      height: height,
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(22, 18, 22, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  data.title,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Color(0xFF444B55),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Icon(data.icon, size: 22, color: data.iconColor),
            ],
          ),
          const Spacer(),
          Text(
            data.value,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: Color(0xFF111827),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(
                data.up ? Icons.arrow_upward : Icons.arrow_downward,
                size: 12,
                color: color,
              ),
              const SizedBox(width: 2),
              Text(
                data.delta,
                style: TextStyle(
                    fontSize: 11, color: color, fontWeight: FontWeight.w600),
              ),
              const SizedBox(width: 10),
              const Text('this month',
                  style: TextStyle(fontSize: 11, color: _hint)),
            ],
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Small reusable widgets
// ---------------------------------------------------------------------------
class _StatusBadge extends StatelessWidget {
  final bool enabled;
  final bool small;
  const _StatusBadge({required this.enabled, this.small = false});

  @override
  Widget build(BuildContext context) {
    final bg = enabled ? const Color(0xFFE5F8EF) : const Color(0xFFFFE8EC);
    final fg = enabled ? _green : _red;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: small ? 8 : 10, vertical: 5),
      decoration:
          BoxDecoration(color: bg, borderRadius: BorderRadius.circular(6)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.circle, size: 6, color: fg),
          const SizedBox(width: 5),
          Text(
            enabled ? 'Enabled' : 'Disabled',
            style: TextStyle(
              fontSize: small ? 11 : 12,
              color: fg,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _OutBtn extends StatelessWidget {
  final String label;
  final IconData? icon;
  final Color color;
  final Color? fill;
  final VoidCallback onPressed;

  const _OutBtn({
    required this.label,
    required this.color,
    required this.onPressed,
    this.icon,
    this.fill,
  });

  @override
  Widget build(BuildContext context) {
    final isNeutral = color == _ink;
    final text = Text(
      label,
      maxLines: 1,
      style: TextStyle(
          fontSize: 12, fontWeight: FontWeight.w600, color: color),
    );
    final style = OutlinedButton.styleFrom(
      padding: EdgeInsets.zero,
      backgroundColor: fill,
      side: BorderSide(
        color: isNeutral ? const Color(0xFFD8E0E8) : color.withValues(alpha: .4),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
    );
    return SizedBox(
      height: 36,
      child: icon == null
          ? OutlinedButton(onPressed: onPressed, style: style, child: text)
          : OutlinedButton.icon(
              onPressed: onPressed,
              icon: Icon(icon, size: 15, color: color),
              label: text,
              style: style,
            ),
    );
  }
}

class _Filter extends StatelessWidget {
  final String label;
  final String? value;
  final List<String> options;
  final ValueChanged<String?> onChanged;
  final bool compact;

  const _Filter({
    required this.label,
    required this.value,
    required this.options,
    required this.onChanged,
    required this.compact,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      tooltip: label,
      offset: const Offset(0, 42),
      onSelected: (v) => onChanged(v == '__all__' ? null : v),
      itemBuilder: (_) => [
        PopupMenuItem(value: '__all__', child: Text(label)),
        ...options.map((o) => PopupMenuItem(value: o, child: Text(o))),
      ],
      child: Container(
        height: compact ? 36 : 38,
        padding: EdgeInsets.symmetric(horizontal: compact ? 10 : 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(compact ? 8 : 5),
          border: Border.all(color: const Color(0xFFD8E0E8)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              value ?? label,
              style: TextStyle(
                fontSize: compact ? 12 : 13,
                color: _ink,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.keyboard_arrow_down, size: 16, color: _ink),
          ],
        ),
      ),
    );
  }
}

class _PageBtn extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final bool selected;
  final bool enabled;
  final VoidCallback onTap;

  const _PageBtn({
    this.text,
    this.icon,
    this.selected = false,
    this.enabled = true,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      margin: const EdgeInsets.only(left: 4),
      child: OutlinedButton(
        onPressed: enabled ? onTap : null,
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: selected ? const Color(0xFF202A68) : Colors.white,
          foregroundColor: selected ? Colors.white : const Color(0xFF4F5D6B),
          side: BorderSide(
            color: selected
                ? const Color(0xFF202A68)
                : (icon != null ? const Color(0xFFDDE3E9) : Colors.transparent),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
        child: icon != null
            ? Icon(icon, size: 16)
            : Text(text!,
                style: const TextStyle(
                    fontSize: 12, fontWeight: FontWeight.w500)),
      ),
    );
  }
}