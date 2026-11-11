import 'dart:math' as math;
import 'package:flutter/material.dart';

import 'tenant_ui.dart';
import '../../widgets/tenant_management_dialogs.dart';

class TenantDatabasePage extends StatefulWidget {
  const TenantDatabasePage({super.key});

  @override
  State<TenantDatabasePage> createState() => _TenantDatabasePageState();
}

class _TenantDatabasePageState extends State<TenantDatabasePage> {
  static const Color cyan = Color(0xFF20B5ED);
  static const Color cpuColor = Color(0xFF2B5C84);
  static const Color memoryColor = Color(0xFF5CBF9A);

  String tenant = 'ABX Technologies Pvt. Ltd.';
  String databaseName = 'tenant_abc_db';
  String databaseType = 'PostgreSQL';
  String serverName = 'db-server-01';
  String maintenanceWindow = 'Sunday 02:00 AM';

  bool connected = true;
  bool autoBackup = true;
  bool busy = false;

  double cpuUsage = 67;
  double memoryUsage = 54;

  final List<String> tenants = [
    'ABX Technologies Pvt. Ltd.',
    'ABC Technologies Pvt. Ltd.',
    'Java Enterprise Suite',
    'ABZ TECH',
  ];

  final List<String> maintenanceWindows = [
    'Sunday 02:00 AM',
    'Sunday 04:00 AM',
    'Saturday 02:00 AM',
    'Saturday 04:00 AM',
    'Monday 01:00 AM',
  ];

  final List<String> databaseTypes = [
    'PostgreSQL',
    'MySQL',
    'Microsoft SQL Server',
    'Oracle Database',
  ];

  final Map<String, Map<String, String>> tenantDatabaseInfo = {
    'ABX Technologies Pvt. Ltd.': {
      'name': 'tenant_abc_db',
      'type': 'PostgreSQL',
      'server': 'db-server-01',
    },
    'ABC Technologies Pvt. Ltd.': {
      'name': 'tenant_abc_02',
      'type': 'MySQL',
      'server': 'db-server-02',
    },
    'Java Enterprise Suite': {
      'name': 'java_enterprise_db',
      'type': 'Oracle Database',
      'server': 'db-server-03',
    },
    'ABZ TECH': {
      'name': 'abz_tech_db',
      'type': 'PostgreSQL',
      'server': 'db-server-01',
    },
  };

  final databaseController = TextEditingController();
  final serverController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTenantValues();
  }

  @override
  void dispose() {
    databaseController.dispose();
    serverController.dispose();
    super.dispose();
  }

  void _loadTenantValues() {
    final info = tenantDatabaseInfo[tenant]!;
    databaseName = info['name']!;
    databaseType = info['type']!;
    serverName = info['server']!;
    databaseController.text = databaseName;
    serverController.text = serverName;
  }

  void _selectTenant(String? value) {
    if (value == null) return;
    setState(() {
      tenant = value;
      _loadTenantValues();
      connected = true;
    });
  }

  Future<void> _refresh() async {
    setState(() => busy = true);
    await Future.delayed(const Duration(milliseconds: 500));

    if (!mounted) return;
    setState(() {
      cpuUsage = 40 + math.Random().nextInt(51).toDouble();
      memoryUsage = 35 + math.Random().nextInt(46).toDouble();
      busy = false;
    });
    _message('Database dashboard refreshed.');
  }

  Future<void> _testConnection() async {
    setState(() => busy = true);
    await Future.delayed(const Duration(milliseconds: 900));

    if (!mounted) return;
    setState(() {
      busy = false;
      // Frontend demonstration only. No real database connection is made.
      connected = serverController.text.trim().isNotEmpty &&
          databaseController.text.trim().isNotEmpty;
    });

    _message(
      connected
          ? 'Demo connection check passed. Connect a backend for a real test.'
          : 'Enter a database name and server name first.',
    );
  }

  void _save() {
    if (databaseController.text.trim().isEmpty ||
        serverController.text.trim().isEmpty) {
      _message('Database name and server name are required.');
      return;
    }

    setState(() {
      databaseName = databaseController.text.trim();
      serverName = serverController.text.trim();

      tenantDatabaseInfo[tenant] = {
        'name': databaseName,
        'type': databaseType,
        'server': serverName,
      };
    });

    _message('Settings updated in the current session.');
  }

  Future<void> _cancel() async {
    if (!await showResetChangesDialog(context)) return;
    if (!mounted) return;
    setState(() {
      _loadTenantValues();
      maintenanceWindow = 'Sunday 02:00 AM';
      autoBackup = true;
    });
    _message('Changes reverted to the current tenant values.');
  }

  void _message(String text) {
    if (!mounted) return;
    showTenantMessageToast(context, text);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final mobile = TUi.isMobile(constraints.maxWidth);

        return Container(
          color: TUi.bg,
          child: SingleChildScrollView(
            padding: TUi.pagePadding(mobile),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TBreadcrumb(['Tenant Management', 'Tenant Database']),
                const SizedBox(height: 8),
                _header(mobile),
                SizedBox(height: mobile ? 18 : 22),
                _tenantSelector(mobile),
                const SizedBox(height: 16),
                if (mobile) ...[
                  _databaseDetails(),
                  const SizedBox(height: 16),
                  _storageCard(),
                  const SizedBox(height: 16),
                  _healthCard(),
                  const SizedBox(height: 16),
                  _maintenanceCard(),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TButton(
                          'Cancel',
                          icon: Icons.close,
                          height: 46,
                          expand: true,
                          onPressed: _cancel,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TButton(
                          'Save',
                          icon: Icons.save_outlined,
                          kind: TButtonKind.primary,
                          height: 46,
                          expand: true,
                          onPressed: _save,
                        ),
                      ),
                    ],
                  ),
                ] else ...[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _databaseDetails()),
                      const SizedBox(width: 16),
                      Expanded(child: _storageCard()),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _healthCard()),
                      const SizedBox(width: 16),
                      Expanded(child: _maintenanceCard()),
                    ],
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // HEADER / SELECTOR
  // ---------------------------------------------------------------------------
  Widget _header(bool mobile) {
    final header = TPageHeader(
      title: 'Tenant Database',
      subtitle:
          'Manage tenant databases, monitor health, storage, and backup configurations.',
      mobile: mobile,
      actions: [
        TButton(
          'Refresh',
          icon: Icons.refresh,
          loading: busy,
          onPressed: _refresh,
        ),
        TButton('Save', icon: Icons.save_outlined, onPressed: _save),
        TButton(
          'Test Connection',
          icon: Icons.link,
          kind: TButtonKind.primary,
          loading: busy,
          onPressed: _testConnection,
        ),
      ],
    );

    if (!mobile) return header;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: header),
        IconButton(
          onPressed: busy ? null : _refresh,
          tooltip: 'Refresh',
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          icon: const Icon(Icons.sync, size: 24, color: Color(0xFF52616F)),
        ),
      ],
    );
  }

  Widget _tenantSelector(bool mobile) {
    final dropdown = DropdownButtonFormField<String>(
      value: tenant,
      isExpanded: true,
      icon: const Icon(
        Icons.keyboard_arrow_down_rounded,
        size: 18,
        color: TUi.muted,
      ),
      decoration: TUi.input(),
      style: TUi.fieldText,
      items: tenants
          .map(
            (t) => DropdownMenuItem(
              value: t,
              child: Text(t, overflow: TextOverflow.ellipsis),
            ),
          )
          .toList(),
      onChanged: _selectTenant,
    );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: TUi.cardBox(),
      child: mobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TLabel('Select Tenant'),
                const SizedBox(height: 8),
                dropdown,
              ],
            )
          : Row(
              children: [
                const Icon(Icons.apartment_outlined, size: 18, color: TUi.accent),
                const SizedBox(width: 10),
                const TLabel('Select Tenant'),
                const SizedBox(width: 20),
                SizedBox(width: 300, child: dropdown),
              ],
            ),
    );
  }

  // ---------------------------------------------------------------------------
  // CARDS
  // ---------------------------------------------------------------------------
  Widget _databaseDetails() {
    return TCard(
      title: 'Database Details',
      icon: Icons.dns_outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TLabel('Database Name'),
          const SizedBox(height: 6),
          TextFormField(
            controller: databaseController,
            onChanged: (v) => databaseName = v,
            decoration: TUi.input(),
            style: TUi.fieldText,
          ),
          const SizedBox(height: 14),
          const TLabel('Database Type'),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            value: databaseType,
            isExpanded: true,
            icon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 18,
              color: TUi.muted,
            ),
            decoration: TUi.input(),
            style: TUi.fieldText,
            items: databaseTypes
                .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                .toList(),
            onChanged: (value) {
              if (value != null) setState(() => databaseType = value);
            },
          ),
          const SizedBox(height: 14),
          const TLabel('Server Name'),
          const SizedBox(height: 6),
          TextFormField(
            controller: serverController,
            onChanged: (v) => serverName = v,
            decoration: TUi.input(),
            style: TUi.fieldText,
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: TUi.fieldFill,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: TUi.border),
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Connection Status',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: TUi.muted,
                    ),
                  ),
                ),
                TStatusBadge(
                  connected ? 'Connected' : 'Disconnected',
                  tone: connected ? TTone.success : TTone.danger,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _storageCard() {
    return TCard(
      title: 'Storage Information',
      icon: Icons.storage_outlined,
      child: Column(
        children: [
          const SizedBox(height: 4),
          SizedBox(
            height: 190,
            width: double.infinity,
            child: CustomPaint(
              painter: _StorageGaugePainter(),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 30),
                  Text('USED', style: TUi.captionStyle),
                  SizedBox(height: 3),
                  Text(
                    '45 GB',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: TUi.ink,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            runSpacing: 12,
            children: [
              _storageLegend(TUi.blue, 'Used Storage', '45 GB', '45%'),
              _storageLegend(cyan, 'Free Storage', '35 GB', '35%'),
              _storageLegend(
                const Color(0xFFE2E8F0),
                'Available Storage',
                '20 GB',
                '20%',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _storageLegend(
    Color color,
    String label,
    String amount,
    String percentage,
  ) {
    return SizedBox(
      width: 130,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 9,
                height: 9,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              const SizedBox(width: 7),
              Flexible(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12, color: TUi.muted),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 5,
            crossAxisAlignment: WrapCrossAlignment.end,
            children: [
              Text(
                amount,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: TUi.ink,
                ),
              ),
              Text(
                '($percentage)',
                style: const TextStyle(fontSize: 12, color: TUi.muted),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _healthCard() {
    return TCard(
      title: 'Database Health',
      icon: Icons.monitor_heart_outlined,
      child: Column(
        children: [
          _usageRow('CPU Usage', cpuUsage, cpuColor),
          const SizedBox(height: 20),
          _usageRow('Memory Utilization', memoryUsage, memoryColor),
          const SizedBox(height: 20),
          const Divider(height: 1, color: TUi.divider),
          const SizedBox(height: 14),
          Row(
            children: [
              const Icon(Icons.history, size: 16, color: TUi.muted),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Last Backup',
                  style: TextStyle(fontSize: 12, color: TUi.muted),
                ),
              ),
              Flexible(
                child: Text(
                  autoBackup ? '08-Sep-2026 02:00 AM' : 'Backup disabled',
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: TUi.ink,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _usageRow(String label, double value, Color color) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: TUi.ink,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                '${value.round()}%',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: value / 100,
            minHeight: 8,
            backgroundColor: const Color(0xFFE8EDF3),
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }

  Widget _maintenanceCard() {
    return TCard(
      title: 'Maintenance Settings',
      icon: Icons.build_circle_outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TLabel('Maintenance Window'),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            value: maintenanceWindow,
            isExpanded: true,
            icon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 18,
              color: TUi.muted,
            ),
            decoration: TUi.input(),
            style: TUi.fieldText,
            items: maintenanceWindows
                .map((w) => DropdownMenuItem(value: w, child: Text(w)))
                .toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() => maintenanceWindow = value);
              }
            },
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Auto Backup',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: TUi.ink,
                  ),
                ),
              ),
              TUi.toggle(
                value: autoBackup,
                onChanged: (value) => setState(() => autoBackup = value),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const TInfoNote(
            'Schedule maintenance to ensure smooth database performance and reduce downtime.',
          ),
        ],
      ),
    );
  }
}

class _StorageGaugePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final stroke = math.max(18.0, size.width * 0.045);
    final rect = Rect.fromLTWH(
      stroke / 2,
      stroke / 2,
      size.width - stroke,
      size.height * 1.65,
    );

    final startAngle = math.pi;
    final sweep = math.pi;

    final backgroundPaint = Paint()
      ..color = const Color(0xFFE2E8F0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.butt;

    canvas.drawArc(rect, startAngle, sweep, false, backgroundPaint);

    final usedPaint = Paint()
      ..color = TUi.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.butt;

    canvas.drawArc(rect, startAngle, sweep * 0.45, false, usedPaint);

    final freePaint = Paint()
      ..color = const Color(0xFF20B5ED)
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.butt;

    canvas.drawArc(
      rect,
      startAngle + sweep * 0.45,
      sweep * 0.35,
      false,
      freePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}