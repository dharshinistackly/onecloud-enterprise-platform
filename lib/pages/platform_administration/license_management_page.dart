import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:one_cloud_enterprise/widgets/license_dialogs.dart';
import '../../utils/chart_csv_export.dart';

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

  // Starts empty. Licenses appear here when you press "Create License".
  final List<Map<String, String>> _licenses = [];

  static const _knownOrgs = [
    '123 Inc',
    'Stackly',
    '456 Inc',
    'Acme Corp',
    'Globex Ltd',
  ];

  String get _emptyText => _licenses.isEmpty
      ? 'No licenses yet - click Create License to add one'
      : 'No licenses found';

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

  static const int _pageSize = 5;

  static const _statusOptions = ['Active', 'Expiring', 'Suspended', 'Rejected'];
  static const _planOptions = ['Standard', 'Professional', 'Enterprise'];

  List<String> get _orgOptions =>
      (_licenses.map((l) => l['org'] ?? '').where((o) => o.isNotEmpty).toSet()
            .toList()
        ..sort());

  List<String> get _creatableOrgs =>
      ({..._knownOrgs, ..._orgOptions}.toList()..sort());

  int get _totalPages {
    final n = (_filtered.length / _pageSize).ceil();
    return n < 1 ? 1 : n;
  }

  int get _safePage => _page.clamp(1, _totalPages).toInt();

  List<MapEntry<int, Map<String, String>>> get _pageItems {
    final start = (_safePage - 1) * _pageSize;
    return _filtered.skip(start).take(_pageSize).toList();
  }

  String get _showingText {
    final total = _filtered.length;
    if (total == 0) return 'No entries';
    final start = (_safePage - 1) * _pageSize;
    final end = math.min(start + _pageSize, total);
    return 'Showing ${start + 1} to $end of $total entries';
  }

  List<_SummaryData> get _summary {
    int count(String status) =>
        _licenses.where((l) => l['status'] == status).length;
    final total = _licenses.length;
    final active = count('Active');
    final rate = total == 0 ? 0 : active * 100 / total;
    return [
      _SummaryData(
        title: 'Total Licenses',
        value: '$total',
        icon: Icons.key_outlined,
        iconBg: const Color(0xFFEAF1FF),
        iconColor: const Color(0xFF3974E8),
        caption: 'Across all organizations',
      ),
      _SummaryData(
        title: 'Active Licenses',
        value: '$active',
        icon: Icons.check_circle_outline,
        iconBg: const Color(0xFFDDF8EC),
        iconColor: const Color(0xFF16B77A),
        caption: '${rate.toStringAsFixed(1)}% utilization rate',
      ),
      _SummaryData(
        title: 'Expiring licenses',
        value: '${count('Expiring')}',
        icon: Icons.warning_amber_outlined,
        iconBg: const Color(0xFFFFF2C8),
        iconColor: const Color(0xFFF1A900),
        caption: 'Renew soon',
      ),
      _SummaryData(
        title: 'Suspended licenses',
        value: '${count('Suspended')}',
        icon: Icons.block_outlined,
        iconBg: const Color(0xFFFFE7E8),
        iconColor: const Color(0xFFE44D55),
        caption: 'Requires admin review',
      ),
    ];
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
    final items = _pageItems;

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
              onPressed: _refresh,
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
                i < _summary.length;
                i++) ...[
              if (i > 0)
                const SizedBox(width: 14),
              Expanded(
                child: _SummaryCard(
                  data: _summary[i],
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
                    options: _creatableOrgs,
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
                    options: _planOptions,
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
                    options: _statusOptions,
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

            Text(
              _showingText,
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
    final items = _pageItems;

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
              onPressed: _refresh,
              icon: const Icon(
                Icons.refresh,
                size: 21,
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        ..._summary.map(
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
                      options: _creatableOrgs,
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
                      options: _planOptions,
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
                      options: _statusOptions,
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
                Padding(padding: const EdgeInsets.all(24), child: Text(_emptyText,
                    style: TextStyle(
                      color: _hint,
                      fontSize: 12,
                    ),
                  ),
                ),

              const SizedBox(height: 4),

              Text(
                _showingText,
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
                  onPressed: () => _showRenewLicenseDialog([index]),
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
                  onPressed: () => _showSuspendLicenseDialog([index]),
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
                  onPressed: () => _showActivateLicenseDialog([index]),
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
              child: Row(
                children: [
                  SizedBox(
                    width: 30,
                    child: Checkbox(
                      tristate: true,
                      value: items.isNotEmpty &&
                              items.every((e) => _selected.contains(e.key))
                          ? true
                          : (items.any((e) => _selected.contains(e.key))
                              ? null
                              : false),
                      activeColor: Colors.white,
                      checkColor: _navy,
                      side: const BorderSide(color: Colors.white, width: 1.5),
                      onChanged: (_) {
                        setState(() {
                          final all = items.isNotEmpty &&
                              items.every((e) => _selected.contains(e.key));
                          for (final e in items) {
                            all ? _selected.remove(e.key) : _selected.add(e.key);
                          }
                        });
                      },
                    ),
                  ),
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
              Padding(padding: const EdgeInsets.all(32), child: Text(_emptyText,
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

  static const _periodMonths = {
    '6 Months': 6,
    '1 Year': 12,
    '2 Years': 24,
    '3 Years': 36,
  };

  static const _monthNames = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];

  String _fmtDate(DateTime d) =>
      '${_monthNames[d.month - 1]} ${d.day.toString().padLeft(2, '0')}, ${d.year}';

  DateTime? _parseDate(String s) {
    final p = s.replaceAll(',', ' ').trim().split(RegExp(r'\s+'));
    if (p.length < 3) return null;
    final m = _monthNames.indexOf(p[0]);
    final d = int.tryParse(p[1]);
    final y = int.tryParse(p[2]);
    if (m < 0 || d == null || y == null) return null;
    return DateTime(y, m + 1, d);
  }

  DateTime _addMonths(DateTime d, int months) {
    final last = DateTime(d.year, d.month + months + 1, 0).day;
    return DateTime(d.year, d.month + months, d.day > last ? last : d.day);
  }

  String _generateKey(String org) {
    final letters = org
        .replaceAll(RegExp(r'[^A-Za-z]'), '')
        .toUpperCase()
        .padRight(4, 'X')
        .substring(0, 4);
    final rnd = math.Random();
    String key;
    do {
      key = 'LIC-${1000 + rnd.nextInt(9000)}-$letters';
    } while (_licenses.any((l) => l['key'] == key));
    return key;
  }

  void _applyToKeys(
    Iterable<dynamic> keys,
    void Function(Map<String, String> license) change,
  ) {
    final wanted = keys.map((k) => k.toString()).toSet();
    for (final license in _licenses) {
      if (wanted.contains(license['key'])) change(license);
    }
  }

  /// Rows the action should work on: the given rows, or the ticked rows.
  List<int> _targets(List<int>? indices) {
    if (indices != null) return indices;
    return _selected.toList()..sort();
  }

  String _plural(int n, String word) => '$n $word${n == 1 ? '' : 's'}';

  void _refresh() {
    setState(() {
      _searchController.clear();
      _organization = null;
      _licenseType = null;
      _status = null;
      _selected.clear();
      _page = 1;
    });
    _toast('Filters cleared');
  }

  // ---- CREATE --------------------------------------------------------------

  Future<void> _showCreateLicenseDialog() async {
    final r = await showCreateLicenseDialog(
      context,
      organizations: _creatableOrgs,
    );
    if (r == null || !mounted) return;

    final org = r['organization'] as String?;
    final seats = r['seats'] as int? ?? 0;
    if (org == null || org.isEmpty) {
      return _toast('Please choose an organization.');
    }
    if (seats <= 0) {
      return _toast('Number of seats must be greater than 0.');
    }

    final plan = (r['plan'] as String?) ?? 'Standard';
    final ok = await showConfirmActionDialog(
      context,
      title: 'Create this license?',
      message:
          'A new $plan license with $seats seats will be created for $org.',
      confirmText: 'Yes, create',
      icon: Icons.add_circle_outline,
    );
    if (!ok || !mounted) return;

    final key = _generateKey(org);
    setState(() {
      // New license goes to the top of the list.
      _licenses.insert(0, {
        'key': key,
        'plan': plan,
        'type': (r['type'] as String?) ?? plan,
        'seats': '$seats Seats',
        'org': org,
        'expiry': _fmtDate(r['expiryDate'] as DateTime),
        'status': (r['status'] as String?) ?? 'Active',
      });
      // Row numbers shifted, so reset selection and show the new row.
      _selected.clear();
      _searchController.clear();
      _organization = null;
      _licenseType = null;
      _status = null;
      _page = 1;
    });
    _toast('License $key created for $org');
  }

  // ---- EXPORT --------------------------------------------------------------


Future<void> _showExportOptionsDialog() async {
  final r = await showExportLicenseDialog(context);
  if (r == null || !mounted) return;

  final columns = List<String>.from(r['columns'] as List);
  final format = ((r['format'] as String?) ?? 'CSV').toUpperCase();

  // Export the licenses matching the current search and filters.
  final licenses = _filtered.map((entry) => entry.value).toList();

  if (licenses.isEmpty) {
    _toast('Nothing to export - no licenses match the current filters.');
    return;
  }

  String valueFor(Map<String, String> license, String column) {
    switch (column) {
      case 'License Key':
        return license['key'] ?? '';

      case 'Organization Plan':
        return '${license['plan'] ?? ''} (${license['seats'] ?? ''})';

      case 'License Type':
        return license['type'] ?? license['plan'] ?? '';

      case 'Expiry Date':
        return license['expiry'] ?? '';

      case 'License Status':
        return license['status'] ?? '';

      default:
        return '';
    }
  }

  final rows = <List<Object?>>[
    for (final license in licenses)
      [for (final column in columns) valueFor(license, column)],
  ];

  try {
    switch (format) {
      case 'CSV':
        await exportChartCsv(
          fileName: 'license_management_report',
          headers: columns,
          rows: rows,
        );
        break;

      case 'XLSX':
      case 'EXCEL':
        await exportChartExcel(
          fileName: 'license_management_report',
          headers: columns,
          rows: rows,
        );
        break;

      case 'PDF':
        await exportChartPdf(
          fileName: 'license_management_report',
          headers: columns,
          rows: rows,
        );
        break;

      default:
        _toast('Unsupported export format: $format');
        return;
    }

    if (!mounted) return;
    _toast('${licenses.length} licenses exported successfully.');
  } catch (e) {
    if (!mounted) return;
    _toast('Export failed: $e');
  }
}

  // ---- RENEW ---------------------------------------------------------------

  Future<void> _showRenewLicenseDialog([List<int>? indices]) async {
    final targets = _targets(indices);
    if (targets.isEmpty) return _showSelectLicenseMessage();

    final r = await showRenewLicenseDialog(
      context,
      licenses: [for (final i in targets) _licenses[i]],
    );
    if (r == null || !mounted) return;

    final keys = List<dynamic>.from(r['licenses'] as List);
    final period = (r['period'] as String?) ?? '1 Year';
    final months = _periodMonths[period] ?? 12;
    if (keys.isEmpty) return;

    final ok = await showConfirmActionDialog(
      context,
      title: 'Renew ${_plural(keys.length, 'license')}?',
      message:
          'The validity of ${_plural(keys.length, 'license')} will be extended by $period.',
      confirmText: 'Yes, renew',
      icon: Icons.sync,
    );
    if (!ok || !mounted) return;

    final now = DateTime.now();
    final reason = (r['reason'] as String?) ?? '';
    setState(() {
      _applyToKeys(keys, (l) {
        final current = _parseDate(l['expiry'] ?? '');
        final base = (current != null && current.isAfter(now)) ? current : now;
        l['expiry'] = _fmtDate(_addMonths(base, months));
        if (l['status'] == 'Expiring') l['status'] = 'Active';
        if (reason.isNotEmpty) l['renewReason'] = reason;
      });
      _selected.removeAll(targets);
    });
    _toast('${_plural(keys.length, 'license')} renewed for $period');
  }

  // ---- SUSPEND -------------------------------------------------------------

  Future<void> _showSuspendLicenseDialog([List<int>? indices]) async {
    final targets = _targets(indices);
    if (targets.isEmpty) return _showSelectLicenseMessage();

    // Only Active / Expiring licenses can be suspended.
    final eligible = targets
        .where((i) =>
            _licenses[i]['status'] == 'Active' ||
            _licenses[i]['status'] == 'Expiring')
        .toList();
    if (eligible.isEmpty) {
      return _toast('Only Active or Expiring licenses can be suspended.');
    }

    final r = await showSuspendLicenseDialog(
      context,
      licenses: [for (final i in eligible) _licenses[i]],
    );
    if (r == null || !mounted) return;

    final keys = List<dynamic>.from(r['licenses'] as List);
    final reason = (r['reason'] as String?) ?? '';
    if (keys.isEmpty) return;

    final ok = await showConfirmActionDialog(
      context,
      title: 'Are you sure?',
      message:
          '${_plural(keys.length, 'license')} will be suspended and the organization '
          'will lose access until it is activated again.\n\nReason: $reason',
      confirmText: 'Yes, suspend',
      icon: Icons.pause_circle_outline,
      color: const Color(0xFFE44D55),
    );
    if (!ok || !mounted) return;

    setState(() {
      _applyToKeys(keys, (l) {
        l['status'] = 'Suspended';
        l['suspendReason'] = reason;
      });
      _selected.removeAll(targets);
    });

    final skipped = targets.length - eligible.length;
    _toast(
      '${_plural(keys.length, 'license')} suspended'
      '${skipped > 0 ? ' ($skipped skipped - not Active/Expiring)' : ''}',
    );
  }

  // ---- ACTIVATE ------------------------------------------------------------

  Future<void> _showActivateLicenseDialog([List<int>? indices]) async {
    final targets = _targets(indices);
    if (targets.isEmpty) return _showSelectLicenseMessage();

    // Only Suspended / Rejected licenses need activating.
    final eligible = targets
        .where((i) =>
            _licenses[i]['status'] == 'Suspended' ||
            _licenses[i]['status'] == 'Rejected')
        .toList();
    if (eligible.isEmpty) {
      return _toast('Only Suspended or Rejected licenses can be activated.');
    }

    final r = await showActivateLicenseDialog(
      context,
      licenses: [for (final i in eligible) _licenses[i]],
    );
    if (r == null || !mounted) return;

    final keys = List<dynamic>.from(r['licenses'] as List);
    if (keys.isEmpty) return;

    final ok = await showConfirmActionDialog(
      context,
      title: 'Activate ${_plural(keys.length, 'license')}?',
      message:
          '${_plural(keys.length, 'license')} will become available for the organization again.',
      confirmText: 'Yes, activate',
      icon: Icons.play_circle_outline,
      color: const Color(0xFF00A875),
    );
    if (!ok || !mounted) return;

    final activateReason = (r['reason'] as String?) ?? '';
    setState(() {
      _applyToKeys(keys, (l) {
        l['status'] = 'Active';
        l.remove('suspendReason');
        if (activateReason.isNotEmpty) l['activateReason'] = activateReason;
      });
      _selected.removeAll(targets);
    });

    final skipped = targets.length - eligible.length;
    _toast(
      '${_plural(keys.length, 'license')} activated'
      '${skipped > 0 ? ' ($skipped skipped - already Active/Expiring)' : ''}',
    );
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
    final pages = _totalPages;
    final current = _safePage;
    var start = math.max(1, current - 2);
    final end = math.min(pages, start + 4);
    start = math.max(1, end - 4);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _PageBtn(
          icon: Icons.chevron_left,
          enabled: current > 1,
          onTap: () => setState(() => _page = current - 1),
        ),
        for (var p = start; p <= end; p++)
          _PageBtn(
            text: '$p',
            selected: p == current,
            onTap: () => setState(() => _page = p),
          ),
        _PageBtn(
          icon: Icons.chevron_right,
          enabled: current < pages,
          onTap: () => setState(() => _page = current + 1),
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

      case 'Suspended':
        bg = const Color(0xFFE5E7EB);
        fg = const Color(0xFF4B5563);
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