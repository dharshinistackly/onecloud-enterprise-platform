import 'package:flutter/material.dart';
import 'package:one_cloud_enterprise/widgets/license_dialogs.dart';

/// ---------------------------------------------------------------------------
/// LICENSE MANAGEMENT
/// ---------------------------------------------------------------------------
/// Popups live in lib/widgets/license_dialogs.dart.
///
/// Focus:
/// Platform Administration -> License Management
///
/// Includes:
/// - License list
/// - Search
/// - Filters
/// - Create License
/// - Export Options
/// - Renew License
/// - Suspend License
/// - Activate License
/// ---------------------------------------------------------------------------

const _ink = Color(0xFF172536);
const _muted = Color(0xFF61758A);
const _hint = Color(0xFF8A9AB0);
const _border = Color(0xFFDDE4EC);
const _bg = Color(0xFFF7F9FC);
const _navy = Color(0xFF242C66);
const _blue = Color(0xFF283BEA);
const _mono = 'monospace';

class LicenseManagementPage extends StatefulWidget {
  const LicenseManagementPage({super.key});

  @override
  State<LicenseManagementPage> createState() =>
      _LicenseManagementPageState();
}

class _LicenseManagementPageState
    extends State<LicenseManagementPage> {
  final TextEditingController _searchController =
      TextEditingController();

  String? _organization;
  String? _licenseType;
  String? _status;

  int _page = 1;

  final Set<int> _selected = {};

  final List<Map<String, String>> _licenses = [
    {
      'key': 'LIC-4421-ACPR',
      'plan': 'Standard',
      'seats': '50 Seats',
      'org': '123 Inc',
      'expiry': 'Nov 02, 2024',
      'status': 'Active',
    },
    {
      'key': 'LIC-4421-ACPR',
      'plan': 'Standard',
      'seats': '50 Seats',
      'org': '123 Inc',
      'expiry': 'Nov 02, 2024',
      'status': 'Expiring',
    },
    {
      'key': 'LIC-1221-ACPR',
      'plan': 'Standard',
      'seats': '50 Seats',
      'org': '123 Inc',
      'expiry': 'Nov 02, 2024',
      'status': 'Expiring',
    },
    {
      'key': 'LIC-5321-ACPR',
      'plan': 'Enterprise',
      'seats': '100 Seats',
      'org': 'Stackly',
      'expiry': 'Dec 18, 2024',
      'status': 'Rejected',
    },
    {
      'key': 'LIC-8821-MNPR',
      'plan': 'Standard',
      'seats': '50 Seats',
      'org': '456 Inc',
      'expiry': 'Jan 15, 2025',
      'status': 'Active',
    },
  ];

  List<MapEntry<int, Map<String, String>>> get _filtered {
    final query =
        _searchController.text.trim().toLowerCase();

    final result =
        <MapEntry<int, Map<String, String>>>[];

    for (var i = 0; i < _licenses.length; i++) {
      final license = _licenses[i];

      if (query.isNotEmpty) {
        final key =
            license['key']?.toLowerCase() ?? '';

        final org =
            license['org']?.toLowerCase() ?? '';

        if (!key.contains(query) &&
            !org.contains(query)) {
          continue;
        }
      }

      if (_organization != null &&
          license['org'] != _organization) {
        continue;
      }

      if (_licenseType != null &&
          license['plan'] != _licenseType) {
        continue;
      }

      if (_status != null &&
          license['status'] != _status) {
        continue;
      }

      result.add(MapEntry(i, license));
    }

    return result;
  }

  List<Map<String, String>> get _selectedLicenses {
    return _selected
        .where(
          (index) =>
              index >= 0 &&
              index < _licenses.length,
        )
        .map((index) => _licenses[index])
        .toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // =========================================================================
  // MAIN BUILD
  // =========================================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final mobile =
                constraints.maxWidth < 700;

            return SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                mobile ? 16 : 24,
                mobile ? 16 : 24,
                mobile ? 16 : 24,
                30,
              ),
              child: mobile
                  ? _buildMobile()
                  : _buildDesktop(),
            );
          },
        ),
      ),
    );
  }

  // =========================================================================
  // DESKTOP
  // =========================================================================

  Widget _buildDesktop() {
    final items = _filtered;

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
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
              padding:
                  EdgeInsets.symmetric(horizontal: 6),
              child: Text(
                '/',
                style: TextStyle(
                  fontSize: 12,
                  color: _muted,
                ),
              ),
            ),
            Text(
              'License Management',
              style: TextStyle(
                fontSize: 12,
                color: _ink,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        Row(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            const Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    'License Management',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: _ink,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Manage platform licenses across organizations and tenants',
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
              onPressed: () {
                setState(() {});
              },
            ),

            const SizedBox(width: 10),

            _topButton(
              'Export',
              Icons.download_outlined,
              onPressed: _showExportOptionsDialog,
            ),

            const SizedBox(width: 10),

            _topButton(
              'Create License',
              Icons.add,
              primary: true,
              onPressed: _showCreateLicenseDialog,
            ),
          ],
        ),

        const SizedBox(height: 20),

        Row(
          children: [
            for (var i = 0;
                i < _summaryData.length;
                i++) ...[
              if (i > 0)
                const SizedBox(width: 14),
              Expanded(
                child: _SummaryCard(
                  data: _summaryData[i],
                  height: 140,
                ),
              ),
            ],
          ],
        ),

        const SizedBox(height: 22),

        const Text(
          'License List',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: _ink,
          ),
        ),

        const SizedBox(height: 14),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(15),
          decoration: _boxDecoration(
            radius: 14,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: _searchField(
                      radius: 6,
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(width: 12),

                  _Filter(
                    label: 'Organization',
                    value: _organization,
                    options: const [
                      '123 Inc',
                      'Stackly',
                      '456 Inc',
                    ],
                    onChanged: (value) {
                      setState(() {
                        _organization = value;
                      });
                    },
                  ),

                  const SizedBox(width: 12),

                  _Filter(
                    label: 'License Type',
                    value: _licenseType,
                    options: const [
                      'Standard',
                      'Enterprise',
                    ],
                    onChanged: (value) {
                      setState(() {
                        _licenseType = value;
                      });
                    },
                  ),

                  const SizedBox(width: 12),

                  _Filter(
                    label: 'Status',
                    value: _status,
                    options: const [
                      'Active',
                      'Expiring',
                      'Rejected',
                    ],
                    onChanged: (value) {
                      setState(() {
                        _status = value;
                      });
                    },
                  ),
                ],
              ),

              const SizedBox(height: 22),

              _buildTable(items),
            ],
          ),
        ),

        const SizedBox(height: 28),

        Row(
          children: [
            _outlinedAction(
              'Renew',
              Icons.sync,
              onPressed: _showRenewLicenseDialog,
            ),

            const SizedBox(width: 18),

            _outlinedAction(
              'Suspend',
              Icons.pause_circle_outline,
              onPressed: _showSuspendLicenseDialog,
            ),

            const SizedBox(width: 18),

            _outlinedAction(
              'Activate',
              Icons.play_circle_outline,
              onPressed: _showActivateLicenseDialog,
            ),

            const Spacer(),

            const Text(
              'Showing 1 to 5 of 2,458 entries',
              style: TextStyle(
                fontFamily: _mono,
                fontSize: 11,
                color: _muted,
              ),
            ),

            const SizedBox(width: 16),

            _pagination(),
          ],
        ),
      ],
    );
  }

  // =========================================================================
  // MOBILE
  // =========================================================================

  Widget _buildMobile() {
    final items = _filtered;

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        const Text(
          'Platform Administration / License Management',
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
                'License Management',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: _ink,
                ),
              ),
            ),

            IconButton(
              onPressed: () {
                setState(() {});
              },
              icon: const Icon(
                Icons.refresh,
                size: 21,
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        ..._summaryData.map(
          (item) => Padding(
            padding:
                const EdgeInsets.only(bottom: 10),
            child: _SummaryCard(
              data: item,
              height: 140,
            ),
          ),
        ),

        const SizedBox(height: 6),

        const Text(
          'LICENSE LIST',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: _hint,
            letterSpacing: .6,
          ),
        ),

        const SizedBox(height: 10),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration:
              _boxDecoration(radius: 12),
          child: Column(
            children: [
              _searchField(
                radius: 9,
                fontSize: 13,
              ),

              const SizedBox(height: 9),

              Row(
                children: [
                  Expanded(
                    child: _Filter(
                      label: 'Organization',
                      value: _organization,
                      options: const [
                        '123 Inc',
                        'Stackly',
                        '456 Inc',
                      ],
                      compact: true,
                      onChanged: (value) {
                        setState(() {
                          _organization = value;
                        });
                      },
                    ),
                  ),

                  const SizedBox(width: 6),

                  Expanded(
                    child: _Filter(
                      label: 'License Type',
                      value: _licenseType,
                      options: const [
                        'Standard',
                        'Enterprise',
                      ],
                      compact: true,
                      onChanged: (value) {
                        setState(() {
                          _licenseType = value;
                        });
                      },
                    ),
                  ),

                  const SizedBox(width: 6),

                  Expanded(
                    child: _Filter(
                      label: 'Status',
                      value: _status,
                      options: const [
                        'Active',
                        'Expiring',
                        'Rejected',
                      ],
                      compact: true,
                      onChanged: (value) {
                        setState(() {
                          _status = value;
                        });
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              ...items.map(
                (item) => _mobileCard(item.key, item.value),
              ),

              if (items.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(24),
                  child: Text(
                    'No licenses found',
                    style: TextStyle(
                      color: _hint,
                      fontSize: 12,
                    ),
                  ),
                ),

              const SizedBox(height: 4),

              const Text(
                'Showing 1-5 of 2,458 entries',
                style: TextStyle(
                  fontSize: 10,
                  color: _hint,
                ),
              ),

              const SizedBox(height: 10),

              _pagination(),
            ],
          ),
        ),

        const SizedBox(height: 20),

        Row(
          children: [
            Expanded(
              child: _bottomButton(
                'Export',
                Icons.download_outlined,
                onPressed:
                    _showExportOptionsDialog,
              ),
            ),

            const SizedBox(width: 8),

            Expanded(
              child: _bottomButton(
                'Create License',
                Icons.add,
                primary: true,
                onPressed:
                    _showCreateLicenseDialog,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _mobileCard(
    int index,
    Map<String, String> license,
  ) {
    return Container(
      width: double.infinity,
      margin:
          const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration:
          _boxDecoration(radius: 12),
      child: Column(
        children: [
          Row(
            children: [
              Checkbox(
                value: _selected.contains(index),
                onChanged: (value) {
                  setState(() {
                    if (value == true) {
                      _selected.add(index);
                    } else {
                      _selected.remove(index);
                    }
                  });
                },
              ),

              Expanded(
                child: Text(
                  license['key'] ?? '',
                  style: const TextStyle(
                    fontFamily: _mono,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              _StatusBadge(
                license['status'] ?? '',
              ),
            ],
          ),

          const SizedBox(height: 8),

          Align(
            alignment:
                Alignment.centerLeft,
            child: Text(
              '${license['plan']} · ${license['seats']}',
              style: const TextStyle(
                fontSize: 11,
                color: _muted,
              ),
            ),
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: _kv(
                  'Org: ',
                  license['org'] ?? '',
                ),
              ),
              Expanded(
                child: _kv(
                  'Expires: ',
                  license['expiry'] ?? '',
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: _ActionButton(
                  icon: Icons.sync,
                  label: 'Renew',
                  color: const Color(
                    0xFF243142,
                  ),
                  onPressed:
                      _showRenewLicenseDialog,
                ),
              ),

              const SizedBox(width: 7),

              Expanded(
                child: _ActionButton(
                  icon:
                      Icons.pause_circle_outline,
                  label: 'Suspend',
                  color:
                      const Color(0xFFF1A000),
                  onPressed:
                      _showSuspendLicenseDialog,
                ),
              ),

              const SizedBox(width: 7),

              Expanded(
                child: _ActionButton(
                  icon:
                      Icons.play_circle_outline,
                  label: 'Activate',
                  color:
                      const Color(0xFF00A875),
                  fill:
                      const Color(0xFFF1FBF7),
                  onPressed:
                      _showActivateLicenseDialog,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _kv(String title, String value) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
              color: _muted,
            ),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(
              color: _ink,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      style: const TextStyle(
        fontSize: 11,
      ),
    );
  }

  // =========================================================================
  // TABLE
  // =========================================================================

  Widget _buildTable(
    List<MapEntry<int, Map<String, String>>> items,
  ) {
    return ClipRRect(
      borderRadius:
          BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: _border,
          ),
          borderRadius:
              BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Container(
              height: 66,
              color: _navy,
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: const Row(
                children: [
                  SizedBox(width: 30),
                  Expanded(
                    flex: 16,
                    child: Text(
                      'LICENSE KEY',
                      style: _tableHeader,
                    ),
                  ),
                  Expanded(
                    flex: 20,
                    child: Text(
                      'ORGANIZATION PLAN',
                      textAlign: TextAlign.center,
                      style: _tableHeader,
                    ),
                  ),
                  Expanded(
                    flex: 17,
                    child: Text(
                      'ORGANIZATION',
                      textAlign: TextAlign.center,
                      style: _tableHeader,
                    ),
                  ),
                  Expanded(
                    flex: 17,
                    child: Text(
                      'EXPIRY DATE',
                      textAlign: TextAlign.center,
                      style: _tableHeader,
                    ),
                  ),
                  Expanded(
                    flex: 15,
                    child: Text(
                      'LICENSE STATUS',
                      textAlign: TextAlign.right,
                      style: _tableHeader,
                    ),
                  ),
                ],
              ),
            ),

            if (items.isEmpty)
              const Padding(
                padding: EdgeInsets.all(32),
                child: Text(
                  'No licenses found',
                  style: TextStyle(
                    color: _hint,
                    fontSize: 13,
                  ),
                ),
              ),

            ...items.map(
              (item) => _tableRow(
                item.key,
                item.value,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static const _tableHeader = TextStyle(
    color: Colors.white,
    fontSize: 12,
    fontWeight: FontWeight.w700,
    letterSpacing: .4,
  );

  Widget _tableRow(
    int index,
    Map<String, String> license,
  ) {
    return Container(
      height: 73,
      padding:
          const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom:
              BorderSide(color: _border),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 30,
            child: Checkbox(
              value:
                  _selected.contains(index),
              onChanged: (value) {
                setState(() {
                  if (value == true) {
                    _selected.add(index);
                  } else {
                    _selected.remove(index);
                  }
                });
              },
            ),
          ),

          Expanded(
            flex: 16,
            child: Text(
              license['key'] ?? '',
              style: const TextStyle(
                fontFamily: _mono,
                fontSize: 13,
                color: _ink,
              ),
            ),
          ),

          Expanded(
            flex: 20,
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              children: [
                Text(
                  license['plan'] ?? '',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight:
                        FontWeight.w600,
                  ),
                ),
                Text(
                  license['seats'] ?? '',
                  style: const TextStyle(
                    fontSize: 11,
                    color: _muted,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            flex: 17,
            child: Text(
              license['org'] ?? '',
              textAlign:
                  TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                color: _ink,
              ),
            ),
          ),

          Expanded(
            flex: 17,
            child: Text(
              license['expiry'] ?? '',
              textAlign:
                  TextAlign.center,
              style: const TextStyle(
                fontFamily: _mono,
                fontSize: 13,
                color: _ink,
              ),
            ),
          ),

          Expanded(
            flex: 15,
            child: Align(
              alignment:
                  Alignment.centerRight,
              child: _StatusBadge(
                license['status'] ?? '',
                mono: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================================
  // ACTIONS
  // =========================================================================

  Future<void> _showCreateLicenseDialog() async {
    final r = await showCreateLicenseDialog(context);
    if (r == null || !mounted) return;
    // TODO: save r -> organization, plan, type, seats, status,
    //       startDate, expiryDate, autoRenew
    _toast('License created');
  }

  Future<void> _showExportOptionsDialog() async {
    final r = await showExportLicenseDialog(context);
    if (r == null || !mounted) return;
    // TODO: r -> columns, startDate, endDate, format (CSV / PDF / XLSX)
    _toast('Export started');
  }

  Future<void> _showRenewLicenseDialog() async {
    if (_selectedLicenses.isEmpty) return _showSelectLicenseMessage();
    final r =
        await showRenewLicenseDialog(context, licenses: _selectedLicenses);
    if (r == null || !mounted) return;
    // TODO: r -> licenses (keys), period, newExpiry, reason
    _toast('Licenses renewed');
  }

  Future<void> _showSuspendLicenseDialog() async {
    if (_selectedLicenses.isEmpty) return _showSelectLicenseMessage();
    final r =
        await showSuspendLicenseDialog(context, licenses: _selectedLicenses);
    if (r == null || !mounted) return;
    // TODO: r -> licenses (keys), reason
    _toast('Licenses suspended');
  }

  Future<void> _showActivateLicenseDialog() async {
    if (_selectedLicenses.isEmpty) return _showSelectLicenseMessage();
    final r =
        await showActivateLicenseDialog(context, licenses: _selectedLicenses);
    if (r == null || !mounted) return;
    // TODO: r -> licenses (keys), activationDate, reason
    _toast('Licenses activated');
  }

  void _toast(String m) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(m)),
    );
  }

  void _showSelectLicenseMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Please select at least one license first.',
        ),
      ),
    );
  }

  // =========================================================================
  // COMMON UI
  // =========================================================================

  BoxDecoration _boxDecoration({
    required double radius,
  }) {
    return BoxDecoration(
      color: Colors.white,
      borderRadius:
          BorderRadius.circular(radius),
      border: Border.all(
        color: _border,
      ),
    );
  }

  Widget _searchField({
    required double radius,
    required double fontSize,
  }) {
    return SizedBox(
      height: 40,
      child: TextField(
        controller: _searchController,
        onChanged: (_) {
          setState(() {});
        },
        style: TextStyle(
          fontSize: fontSize,
        ),
        decoration:
            InputDecoration(
          hintText: 'Search',
          hintStyle: TextStyle(
            fontSize: fontSize,
            color: const Color(
              0xFF8D9BAD,
            ),
          ),
          prefixIcon:
              const Icon(
            Icons.search,
            size: 19,
            color: _muted,
          ),
          contentPadding:
              EdgeInsets.zero,
          enabledBorder:
              OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(
              radius,
            ),
            borderSide:
                const BorderSide(
              color: Color(
                0xFFD8E0E8,
              ),
            ),
          ),
          focusedBorder:
              OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(
              radius,
            ),
            borderSide:
                const BorderSide(
              color: _blue,
            ),
          ),
        ),
      ),
    );
  }

  Widget _topButton(
    String label,
    IconData icon, {
    bool primary = false,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      height: 34,
      child: primary
          ? ElevatedButton.icon(
              onPressed: onPressed,
              icon: Icon(
                icon,
                size: 16,
              ),
              label: Text(
                label,
                style:
                    const TextStyle(
                  fontSize: 12,
                  fontWeight:
                      FontWeight.w600,
                ),
              ),
              style:
                  ElevatedButton.styleFrom(
                backgroundColor:
                    _blue,
                foregroundColor:
                    Colors.white,
                elevation: 0,
                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(
                    6,
                  ),
                ),
              ),
            )
          : OutlinedButton.icon(
              onPressed: onPressed,
              icon: Icon(
                icon,
                size: 16,
              ),
              label: Text(
                label,
                style:
                    const TextStyle(
                  fontSize: 12,
                  fontWeight:
                      FontWeight.w600,
                ),
              ),
              style:
                  OutlinedButton.styleFrom(
                foregroundColor:
                    const Color(
                  0xFF253341,
                ),
                backgroundColor:
                    Colors.white,
                side:
                    const BorderSide(
                  color: Color(
                    0xFFD8E0E8,
                  ),
                ),
                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(
                    6,
                  ),
                ),
              ),
            ),
    );
  }

  Widget _bottomButton(
    String label,
    IconData icon, {
    bool primary = false,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      height: 44,
      child: primary
          ? ElevatedButton.icon(
              onPressed: onPressed,
              icon: Icon(
                icon,
                size: 18,
              ),
              label: Text(
                label,
                style:
                    const TextStyle(
                  fontSize: 13,
                  fontWeight:
                      FontWeight.w600,
                ),
              ),
              style:
                  ElevatedButton.styleFrom(
                backgroundColor:
                    _blue,
                foregroundColor:
                    Colors.white,
                elevation: 0,
              ),
            )
          : OutlinedButton.icon(
              onPressed: onPressed,
              icon: Icon(
                icon,
                size: 17,
              ),
              label: Text(
                label,
                style:
                    const TextStyle(
                  fontSize: 13,
                  fontWeight:
                      FontWeight.w600,
                ),
              ),
            ),
    );
  }

  Widget _outlinedAction(
    String label,
    IconData icon, {
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      height: 32,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: 15,
        ),
        label: Text(
          label,
          style:
              const TextStyle(
            fontSize: 11,
            fontWeight:
                FontWeight.w600,
          ),
        ),
        style:
            OutlinedButton.styleFrom(
          foregroundColor: _blue,
          side:
              const BorderSide(
            color: _blue,
          ),
          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(6),
          ),
        ),
      ),
    );
  }

  Widget _pagination() {
    return Row(
      mainAxisSize:
          MainAxisSize.min,
      children: [
        _PageBtn(
          icon:
              Icons.chevron_left,
          enabled: _page > 1,
          onTap: () {
            setState(() {
              _page--;
            });
          },
        ),
        _PageBtn(
          text: '1',
          selected: _page == 1,
          onTap: () {
            setState(() {
              _page = 1;
            });
          },
        ),
        _PageBtn(
          text: '2',
          selected: _page == 2,
          onTap: () {
            setState(() {
              _page = 2;
            });
          },
        ),
        _PageBtn(
          text: '3',
          selected: _page == 3,
          onTap: () {
            setState(() {
              _page = 3;
            });
          },
        ),
        _PageBtn(
          icon:
              Icons.chevron_right,
          enabled: _page < 3,
          onTap: () {
            setState(() {
              _page++;
            });
          },
        ),
      ],
    );
  }
}

// =============================================================================
// SUMMARY DATA
// =============================================================================

class _SummaryData {
  final String title;
  final String value;
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String? trend;
  final String caption;

  const _SummaryData({
    required this.title,
    required this.value,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.caption,
    this.trend,
  });
}

const _summaryData = [
  _SummaryData(
    title: 'Total Licenses',
    value: '2,458',
    icon: Icons.key_outlined,
    iconBg: Color(0xFFEAF1FF),
    iconColor: Color(0xFF3974E8),
    trend: '↑ 12%',
    caption: ' vs last month',
  ),
  _SummaryData(
    title: 'Active Licenses',
    value: '2,104',
    icon: Icons.check_circle_outline,
    iconBg: Color(0xFFDDF8EC),
    iconColor: Color(0xFF16B77A),
    caption: '85.6% utilization rate',
  ),
  _SummaryData(
    title: 'Expired licenses',
    value: '142',
    icon: Icons.warning_amber_outlined,
    iconBg: Color(0xFFFFF2C8),
    iconColor: Color(0xFFF1A900),
    caption: 'Within next 30 days',
  ),
  _SummaryData(
    title: 'Suspended licenses',
    value: '36',
    icon: Icons.block_outlined,
    iconBg: Color(0xFFFFE7E8),
    iconColor: Color(0xFFE44D55),
    caption: 'Requires admin review',
  ),
];

class _SummaryCard extends StatelessWidget {
  final _SummaryData data;
  final double height;

  const _SummaryCard({
    required this.data,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding:
          const EdgeInsets.fromLTRB(
        20,
        18,
        20,
        16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(11),
        border: Border.all(
          color: _border,
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  data.title,
                  style:
                      const TextStyle(
                    fontFamily: _mono,
                    fontSize: 14,
                    color:
                        Color(0xFF444444),
                  ),
                ),
              ),
              Container(
                width: 34,
                height: 34,
                decoration:
                    BoxDecoration(
                  color:
                      data.iconBg,
                  shape:
                      BoxShape.circle,
                ),
                child: Icon(
                  data.icon,
                  size: 17,
                  color:
                      data.iconColor,
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            data.value,
            style:
                const TextStyle(
              fontSize: 29,
              fontWeight:
                  FontWeight.w700,
              color:
                  Color(0xFF202020),
            ),
          ),
          const SizedBox(height: 2),
          Text.rich(
            TextSpan(
              children: [
                if (data.trend != null)
                  TextSpan(
                    text: data.trend,
                    style:
                        const TextStyle(
                      color:
                          Color(0xFF16A56A),
                      fontWeight:
                          FontWeight.w600,
                    ),
                  ),
                TextSpan(
                  text:
                      data.caption,
                ),
              ],
            ),
            style:
                const TextStyle(
              fontSize: 12,
              color:
                  Color(0xFF666666),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// STATUS BADGE
// =============================================================================

class _StatusBadge
    extends StatelessWidget {
  final String status;
  final bool mono;

  const _StatusBadge(
    this.status, {
    this.mono = false,
  });

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;

    switch (status) {
      case 'Active':
        bg = const Color(0xFFE5F8EF);
        fg = const Color(0xFF00A96B);
        break;

      case 'Expiring':
        bg = const Color(0xFFFFF3D5);
        fg = const Color(0xFFE99500);
        break;

      default:
        bg = const Color(0xFFFFE8EC);
        fg = const Color(0xFFE74760);
    }

    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: bg,
        borderRadius:
            BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize:
            MainAxisSize.min,
        children: [
          Icon(
            Icons.circle,
            size: 6,
            color: fg,
          ),
          const SizedBox(width: 5),
          Text(
            status,
            style: TextStyle(
              fontFamily:
                  mono ? _mono : null,
              fontSize: 11,
              color: fg,
              fontWeight:
                  FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// FILTER
// =============================================================================

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
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      tooltip: label,
      offset: const Offset(0, 42),
      onSelected: (selectedValue) {
        onChanged(
          selectedValue == '__all__' ? null : selectedValue,
        );
      },
      itemBuilder: (_) => [
        const PopupMenuItem<String>(
          value: '__all__',
          child: Text('All'),
        ),
        ...options.map(
          (option) => PopupMenuItem<String>(
            value: option,
            child: Text(option),
          ),
        ),
      ],
      child: Container(
        height: compact ? 36 : 40,
        width: compact ? double.infinity : 150,
        padding: EdgeInsets.symmetric(
          horizontal: compact ? 8 : 12,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            compact ? 7 : 6,
          ),
          border: Border.all(
            color: const Color(0xFFD8E0E8),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                value ?? label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: compact ? 11 : 13,
                  color: value == null
                      ? const Color(0xFF5E6873)
                      : _ink,
                ),
              ),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.keyboard_arrow_down,
              size: 16,
              color: Color(0xFF5E6E80),
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// ACTION BUTTON
// =============================================================================

class _ActionButton
    extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Color? fill;
  final VoidCallback onPressed;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onPressed,
    this.fill,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: 14,
          color: color,
        ),
        label: Text(
          label,
          maxLines: 1,
          style: TextStyle(
            fontSize: 11,
            fontWeight:
                FontWeight.w600,
            color: color,
          ),
        ),
        style:
            OutlinedButton.styleFrom(
          padding:
              EdgeInsets.zero,
          backgroundColor:
              fill,
          side: BorderSide(
            color:
                color.withValues(
              alpha: .35,
            ),
          ),
          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(
              7,
            ),
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// PAGINATION
// =============================================================================

class _PageBtn
    extends StatelessWidget {
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
    return SizedBox(
      width: 32,
      height: 32,
      child: OutlinedButton(
        onPressed:
            enabled ? onTap : null,
        style:
            OutlinedButton.styleFrom(
          padding:
              EdgeInsets.zero,
          backgroundColor:
              selected
                  ? _navy
                  : Colors.white,
          foregroundColor:
              selected
                  ? Colors.white
                  : const Color(
                      0xFF4F5D6B,
                    ),
          side: BorderSide(
            color: selected
                ? _navy
                : const Color(
                    0xFFDDE3E9,
                  ),
          ),
          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(5),
          ),
        ),
        child: icon != null
            ? Icon(
                icon,
                size: 16,
              )
            : Text(
                text ?? '',
                style:
                    const TextStyle(
                  fontSize: 12,
                ),
              ),
      ),
    );
  }
}