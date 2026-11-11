import 'dart:convert';
import 'dart:html' as html;

import 'package:flutter/material.dart';

import 'tenant_ui.dart';
import '../../widgets/tenant_management_dialogs.dart';

class TenantBackupPage extends StatefulWidget {
  const TenantBackupPage({super.key});

  @override
  State<TenantBackupPage> createState() => _TenantBackupPageState();
}

class _TenantBackupPageState extends State<TenantBackupPage> {

  final List<String> tenants = [
    'ABX Technologies Pvt. Ltd.',
    'ABC Technologies Pvt. Ltd.',
    'Java Enterprise Suite',
    'ABZ TECH',
  ];

  String selectedTenant = 'ABX Technologies Pvt. Ltd.';
  bool automaticBackups = true;
  String frequency = 'Daily';
  String backupWindow = '02:00 AM';
  int retentionDays = 30;
  String storageLocation = 'Primary vault-ap-south-1';

  int currentPage = 1;
  final int rowsPerPage = 4;
  int totalBackups = 2458;
  bool backupRunning = false;

  final Set<int> selectedRows = {};
  late final List<Map<String, String>> backupHistory = [
    {
      'date': '17-SEP-2026  02:00 AM',
      'type': 'Scheduled',
      'size': '4.2 GB',
      'duration': '6m 12s',
      'status': 'Completed',
    },
    {
      'date': '16-SEP-2026  02:20 AM',
      'type': 'Scheduled',
      'size': '4.1 GB',
      'duration': '5m 18s',
      'status': 'Completed',
    },
    {
      'date': '15-SEP-2026  02:20 AM',
      'type': 'Manual',
      'size': '-',
      'duration': '1m 12s',
      'status': 'Failed',
    },
    {
      'date': '14-SEP-2026  02:20 AM',
      'type': 'Scheduled',
      'size': '4.2 GB',
      'duration': '7m 12s',
      'status': 'Completed',
    },
    {
      'date': '13-SEP-2026  02:00 AM',
      'type': 'Scheduled',
      'size': '4.0 GB',
      'duration': '5m 48s',
      'status': 'Completed',
    },
    {
      'date': '12-SEP-2026  02:00 AM',
      'type': 'Manual',
      'size': '4.1 GB',
      'duration': '6m 02s',
      'status': 'Completed',
    },
    {
      'date': '11-SEP-2026  02:00 AM',
      'type': 'Scheduled',
      'size': '4.0 GB',
      'duration': '5m 35s',
      'status': 'Completed',
    },
    {
      'date': '10-SEP-2026  02:00 AM',
      'type': 'Scheduled',
      'size': '4.2 GB',
      'duration': '6m 10s',
      'status': 'Completed',
    },
    {
      'date': '09-SEP-2026  02:00 AM',
      'type': 'Scheduled',
      'size': '4.1 GB',
      'duration': '5m 55s',
      'status': 'Completed',
    },
    {
      'date': '08-SEP-2026  02:00 AM',
      'type': 'Scheduled',
      'size': '3.9 GB',
      'duration': '5m 40s',
      'status': 'Completed',
    },
    {
      'date': '07-SEP-2026  02:00 AM',
      'type': 'Scheduled',
      'size': '4.0 GB',
      'duration': '5m 50s',
      'status': 'Completed',
    },
    {
      'date': '06-SEP-2026  02:00 AM',
      'type': 'Manual',
      'size': '4.1 GB',
      'duration': '6m 20s',
      'status': 'Completed',
    },
  ];

  final Map<String, Map<String, dynamic>> savedSettings = {};

  Map<String, dynamic> _settingsSnapshot() => {
        'automaticBackups': automaticBackups,
        'frequency': frequency,
        'backupWindow': backupWindow,
        'retentionDays': retentionDays,
        'storageLocation': storageLocation,
      };

  void _loadTenant(String tenant) {
    final settings = savedSettings[tenant];
    selectedTenant = tenant;

    automaticBackups = settings?['automaticBackups'] as bool? ?? true;
    frequency = settings?['frequency'] as String? ?? 'Daily';
    backupWindow = settings?['backupWindow'] as String? ?? '02:00 AM';
    retentionDays = settings?['retentionDays'] as int? ?? 30;
    storageLocation = settings?['storageLocation'] as String? ??
        'Primary vault-ap-south-1';

    selectedRows.clear();
    currentPage = 1;
  }

  void _saveSettings() {
    setState(() {
      savedSettings[selectedTenant] = _settingsSnapshot();
    });
    _message('Backup settings saved for $selectedTenant.');
  }

  void _resetSettings() {
    setState(() {
      automaticBackups = true;
      frequency = 'Daily';
      backupWindow = '02:00 AM';
      retentionDays = 30;
      storageLocation = 'Primary vault-ap-south-1';
    });
    _message('Backup settings reset to defaults.');
  }

  void _refresh() {
    setState(() {});
    _message('Backup information refreshed.');
  }

  void _message(String message) {
    if (!mounted) return;
    showTenantMessageToast(context, message);
  }

  Future<void> _runBackup() async {
    if (backupRunning) return;

    setState(() => backupRunning = true);
    _message('Starting a simulated backup...');

    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    setState(() {
      backupRunning = false;
      totalBackups++;
      backupHistory.insert(0, {
        'date': 'NOW  ${backupWindow}',
        'type': 'Manual',
        'size': '4.2 GB',
        'duration': '1m 00s',
        'status': 'Completed',
      });
      selectedRows.clear();
      currentPage = 1;
    });

    _message('Demo backup completed successfully.');
  }

  List<Map<String, String>> get _visibleRows {
    final start = (currentPage - 1) * rowsPerPage;
    if (start >= backupHistory.length) return [];
    return backupHistory.skip(start).take(rowsPerPage).toList();
  }

  int get _pageCount => (backupHistory.length / rowsPerPage).ceil();

  void _changePage(int page) {
    setState(() {
      currentPage = page.clamp(1, _pageCount);
      selectedRows.clear();
    });
  }

  void _toggleRow(int index, bool? value) {
    setState(() {
      if (value == true) {
        selectedRows.add(index);
      } else {
        selectedRows.remove(index);
      }
    });
  }

  Future<void> _restoreSelected() async {
    if (selectedRows.isEmpty) {
      _message('Select a backup record to restore.');
      return;
    }

    final confirmed = await showTenantConfirmDialog(
      context: context,
      icon: Icons.restore,
      title: 'Restore Backup',
      subtitle:
          'Restore ${selectedRows.length} selected backup record(s) for $selectedTenant?',
      note: 'This is a frontend demo and will not change any database.',
      confirmLabel: 'Restore',
      confirmIcon: Icons.restore,
    );

    if (confirmed == true && mounted) {
      _message('Restore demo completed. No real data was changed.');
    }
  }

  void _downloadCsv() {
    if (selectedRows.isEmpty) {
      _message('Select one or more backup records to download.');
      return;
    }

    final rows = selectedRows
        .where((i) => i >= 0 && i < backupHistory.length)
        .map((i) => backupHistory[i])
        .toList();

    final csv = StringBuffer(
      'Tenant,Time and Date,Type,Size,Duration,Backup Status\n',
    );

    for (final row in rows) {
      csv.writeln([
        _csvValue(selectedTenant),
        _csvValue(row['date'] ?? ''),
        _csvValue(row['type'] ?? ''),
        _csvValue(row['size'] ?? ''),
        _csvValue(row['duration'] ?? ''),
        _csvValue(row['status'] ?? ''),
      ].join(','));
    }

    final bytes = utf8.encode('\uFEFF${csv.toString()}');
    final blob = html.Blob([bytes], 'text/csv;charset=utf-8');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute('download', 'tenant_backup_history.csv')
      ..click();
    anchor.remove();
    html.Url.revokeObjectUrl(url);

    _message('Backup history CSV downloaded.');
  }

  String _csvValue(String value) =>
      '"${value.replaceAll('"', '""')}"';

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
                const TBreadcrumb(['Tenant Management', 'Tenant Backup']),
                const SizedBox(height: 8),
                _pageHeader(mobile),
                SizedBox(height: mobile ? 18 : 22),
                _tenantPicker(mobile),
                const SizedBox(height: 16),
                if (mobile) ...[
                  _configurationCard(true),
                  const SizedBox(height: 16),
                  _statusCard(),
                ] else
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _configurationCard(false)),
                      const SizedBox(width: 16),
                      Expanded(child: _statusCard()),
                    ],
                  ),
                const SizedBox(height: 16),
                _historyCard(mobile),
              ],
            ),
          ),
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // HEADER / TENANT PICKER
  // ---------------------------------------------------------------------------
  Widget _pageHeader(bool mobile) {
    final header = TPageHeader(
      title: 'Tenant Backup',
      subtitle: 'Schedule, monitor and restore backups for each tenant.',
      mobile: mobile,
      actions: [
        TButton('Refresh', icon: Icons.refresh, onPressed: _refresh),
        TButton(
          'Save',
          icon: Icons.save_outlined,
          kind: TButtonKind.primary,
          onPressed: _saveSettings,
        ),
      ],
    );

    if (!mobile) return header;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: header),
        IconButton(
          tooltip: 'Refresh',
          onPressed: _refresh,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          icon: const Icon(Icons.sync, size: 24, color: Color(0xFF52616F)),
        ),
      ],
    );
  }

  Widget _tenantPicker(bool mobile) {
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
                _tenantDropdown(),
              ],
            )
          : Row(
              children: [
                const Icon(Icons.apartment_outlined, size: 18, color: TUi.accent),
                const SizedBox(width: 10),
                const TLabel('Select Tenant'),
                const SizedBox(width: 20),
                SizedBox(width: 300, child: _tenantDropdown()),
              ],
            ),
    );
  }

  Widget _tenantDropdown() {
    return DropdownButtonFormField<String>(
      value: selectedTenant,
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
            (tenant) => DropdownMenuItem(
              value: tenant,
              child: Text(tenant, overflow: TextOverflow.ellipsis),
            ),
          )
          .toList(),
      onChanged: (value) {
        if (value == null) return;
        setState(() => _loadTenant(value));
      },
    );
  }

  // ---------------------------------------------------------------------------
  // CONFIGURATION + STATUS
  // ---------------------------------------------------------------------------
  Widget _divided(List<Widget> rows) {
    return Column(
      children: [
        for (int i = 0; i < rows.length; i++) ...[
          if (i > 0) const Divider(height: 1, color: TUi.divider),
          rows[i],
        ],
      ],
    );
  }

  Widget _configurationCard(bool mobile) {
    return TCard(
      title: 'Backup Configuration',
      subtitle: 'Automatic schedule, frequency, and how long copies are kept',
      icon: Icons.settings_backup_restore_outlined,
      padding: EdgeInsets.zero,
      child: _divided([
        _configurationRow(
          'Automatic backups',
          'Run backups on the schedule below without manual action',
          mobile,
          inline: true,
          trailing: TUi.toggle(
            value: automaticBackups,
            onChanged: (v) => setState(() => automaticBackups = v),
          ),
        ),
        _configurationRow(
          'Frequency',
          'How often a full backup is taken',
          mobile,
          trailing: _frequencyPicker(),
        ),
        _configurationRow(
          'Backup window',
          'Preferred time to run, in the tenant’s local timezone',
          mobile,
          trailing: _dropdown(
            backupWindow,
            const ['01:00 AM', '02:00 AM', '03:00 AM', '04:00 AM'],
            (v) => setState(() => backupWindow = v),
          ),
        ),
        _configurationRow(
          'Retention period',
          'Backups older than this are automatically removed',
          mobile,
          trailing: _retentionControl(),
        ),
        _configurationRow(
          'Storage location',
          'Where encrypted backup files are written',
          mobile,
          trailing: _dropdown(
            storageLocation,
            const [
              'Primary vault-ap-south-1',
              'Secondary vault-ap-south-2',
              'Regional vault-in-1',
            ],
            (v) => setState(() => storageLocation = v),
          ),
        ),
      ]),
    );
  }

  Widget _statusCard() {
    return TCard(
      title: 'Backup Status',
      subtitle: 'Live backup health for this tenant',
      icon: Icons.monitor_heart_outlined,
      padding: EdgeInsets.zero,
      child: _divided([
        _statusLine('Last backup', '17-SEP-2026  02:00 AM'),
        _statusLine(
          'Next scheduled run',
          automaticBackups ? '18-SEP-2026  02:00 AM' : 'Paused',
        ),
        _statusLine(
          'Current status',
          '',
          badge: TStatusBadge(
            automaticBackups ? 'Successful' : 'Paused',
            tone: automaticBackups ? TTone.success : TTone.neutral,
          ),
        ),
        _statusLine('Retained copies', '$retentionDays of $retentionDays days'),
        _statusLine('Vault usage', '62.4 GB / 200 GB'),
      ]),
    );
  }

  Widget _configurationRow(
    String title,
    String subtitle,
    bool mobile, {
    required Widget trailing,
    bool inline = false,
  }) {
    final text = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: TUi.ink,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          subtitle,
          style: const TextStyle(fontSize: 12, height: 1.35, color: TUi.muted),
        ),
      ],
    );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      constraints: const BoxConstraints(minHeight: 64),
      child: inline
          ? Row(
              children: [
                Expanded(child: text),
                const SizedBox(width: 12),
                trailing,
              ],
            )
          : mobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    text,
                    const SizedBox(height: 10),
                    trailing,
                  ],
                )
              : Row(
                  children: [
                    Expanded(child: text),
                    const SizedBox(width: 16),
                    SizedBox(width: 210, child: trailing),
                  ],
                ),
    );
  }

  Widget _frequencyPicker() {
    return Container(
      height: 40,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F4F8),
        border: Border.all(color: TUi.controlBorder),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: ['Daily', 'Weekly', 'Monthly'].map((option) {
          final active = frequency == option;
          return Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(4),
              onTap: () => setState(() => frequency = option),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: active ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(4),
                  border: active ? Border.all(color: TUi.border) : null,
                ),
                child: Text(
                  option,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                    color: active ? TUi.blue : TUi.muted,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _retentionControl() {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: TUi.fieldFill,
        border: Border.all(color: TUi.controlBorder),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: retentionDays > 1
                ? () => setState(() => retentionDays--)
                : null,
            icon: const Icon(Icons.remove, size: 16),
            visualDensity: VisualDensity.compact,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
            padding: EdgeInsets.zero,
          ),
          Text(
            '$retentionDays days',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: TUi.ink,
            ),
          ),
          IconButton(
            onPressed: retentionDays < 365
                ? () => setState(() => retentionDays++)
                : null,
            icon: const Icon(Icons.add, size: 16),
            visualDensity: VisualDensity.compact,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }

  Widget _dropdown(
    String value,
    List<String> options,
    ValueChanged<String> onChanged,
  ) {
    return DropdownButtonFormField<String>(
      value: value,
      isExpanded: true,
      icon: const Icon(
        Icons.keyboard_arrow_down_rounded,
        size: 18,
        color: TUi.muted,
      ),
      decoration: TUi.input(minHeight: 40),
      style: TUi.fieldText,
      items: options
          .map(
            (option) => DropdownMenuItem(
              value: option,
              child: Text(option, overflow: TextOverflow.ellipsis),
            ),
          )
          .toList(),
      onChanged: (v) {
        if (v != null) onChanged(v);
      },
    );
  }

  Widget _statusLine(String label, String value, {Widget? badge}) {
    return Container(
      constraints: const BoxConstraints(minHeight: 56),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: TUi.muted,
              ),
            ),
          ),
          const SizedBox(width: 8),
          if (badge != null)
            badge
          else
            Flexible(
              child: Text(
                value,
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
    );
  }

  // ---------------------------------------------------------------------------
  // HISTORY
  // ---------------------------------------------------------------------------
  Widget _historyCard(bool mobile) {
    final from = (currentPage - 1) * rowsPerPage + 1;
    final to = (currentPage - 1) * rowsPerPage + _visibleRows.length;

    final showing = Text(
      'Showing $from to $to of $totalBackups backups',
      style: const TextStyle(fontSize: 12, color: TUi.muted),
    );

    final pagination = Wrap(
      spacing: 6,
      runSpacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        TPageButton(
          icon: Icons.chevron_left,
          enabled: currentPage > 1,
          onTap: () => _changePage(currentPage - 1),
        ),
        for (int i = 1; i <= _pageCount; i++)
          if (i <= 3 || i == currentPage)
            TPageButton(
              text: '$i',
              selected: i == currentPage,
              onTap: () => _changePage(i),
            ),
        TPageButton(
          icon: Icons.chevron_right,
          enabled: currentPage < _pageCount,
          onTap: () => _changePage(currentPage + 1),
        ),
      ],
    );

    return TCard(
      title: 'Backup History',
      subtitle: 'Most recent runs - restore or download logs for any entry',
      icon: Icons.history,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (mobile)
            ..._visibleRows.asMap().entries.map((entry) {
              final rowIndex = (currentPage - 1) * rowsPerPage + entry.key;
              return _mobileHistoryItem(rowIndex, entry.value);
            })
          else
            _desktopHistoryTable(),
          const Divider(height: 1, color: TUi.divider),
          Padding(
            padding: const EdgeInsets.all(16),
            child: mobile
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      showing,
                      const SizedBox(height: 12),
                      pagination,
                      const SizedBox(height: 16),
                      TButton(
                        'Restore',
                        icon: Icons.restore,
                        height: 44,
                        expand: true,
                        onPressed: _restoreSelected,
                      ),
                      const SizedBox(height: 8),
                      TButton(
                        backupRunning ? 'Backing up...' : 'Back up',
                        icon: Icons.backup_outlined,
                        height: 44,
                        expand: true,
                        loading: backupRunning,
                        onPressed: _runBackup,
                      ),
                      const SizedBox(height: 8),
                      TButton(
                        'Download CSV',
                        icon: Icons.download_outlined,
                        kind: TButtonKind.primary,
                        height: 44,
                        expand: true,
                        onPressed: _downloadCsv,
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          showing,
                          const Spacer(),
                          pagination,
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TButton(
                            'Restore',
                            icon: Icons.restore,
                            onPressed: _restoreSelected,
                          ),
                          const SizedBox(width: 10),
                          TButton(
                            backupRunning ? 'Backing up...' : 'Back up',
                            icon: Icons.backup_outlined,
                            loading: backupRunning,
                            onPressed: _runBackup,
                          ),
                          const SizedBox(width: 10),
                          TButton(
                            'Download CSV',
                            icon: Icons.download_outlined,
                            kind: TButtonKind.primary,
                            onPressed: _downloadCsv,
                          ),
                        ],
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _desktopHistoryTable() {
    final rows = _visibleRows.asMap().entries.toList();

    final table = Column(
      children: [
        Container(
          height: 48,
          color: TUi.navy,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: const Row(
            children: [
              SizedBox(width: 36),
              Expanded(
                flex: 3,
                child: Text('TIME AND DATE', style: TUi.tableHeader),
              ),
              Expanded(flex: 2, child: Text('TYPE', style: TUi.tableHeader)),
              Expanded(flex: 2, child: Text('SIZE', style: TUi.tableHeader)),
              Expanded(
                flex: 2,
                child: Text('DURATION', style: TUi.tableHeader),
              ),
              Expanded(
                flex: 2,
                child: Text('BACKUP STATUS', style: TUi.tableHeader),
              ),
            ],
          ),
        ),
        for (int i = 0; i < rows.length; i++)
          _historyRow(
            (currentPage - 1) * rowsPerPage + rows[i].key,
            rows[i].value,
            i == rows.length - 1,
          ),
      ],
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 720) return table;
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(width: 720, child: table),
        );
      },
    );
  }

  Widget _historyRow(int rowIndex, Map<String, String> row, bool last) {
    final selected = selectedRows.contains(rowIndex);

    return Container(
      constraints: const BoxConstraints(minHeight: 56),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: selected ? const Color(0xFFF5F8FF) : Colors.white,
        border: last
            ? null
            : const Border(bottom: BorderSide(color: TUi.divider)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 36,
            child: Checkbox(
              value: selected,
              activeColor: TUi.blue,
              side: const BorderSide(color: Color(0xFFB6C2D1), width: 1.5),
              onChanged: (v) => _toggleRow(rowIndex, v),
              visualDensity: VisualDensity.compact,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              row['date']!,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: TUi.ink,
              ),
            ),
          ),
          Expanded(flex: 2, child: Text(row['type']!, style: TUi.tableCell)),
          Expanded(flex: 2, child: Text(row['size']!, style: TUi.tableCell)),
          Expanded(
            flex: 2,
            child: Text(row['duration']!, style: TUi.tableCell),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: _statusBadge(row['status']!),
            ),
          ),
        ],
      ),
    );
  }

  Widget _mobileHistoryItem(int index, Map<String, String> row) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 10, 16, 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: TUi.divider)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Checkbox(
                value: selectedRows.contains(index),
                activeColor: TUi.blue,
                onChanged: (v) => _toggleRow(index, v),
                visualDensity: VisualDensity.compact,
              ),
              Expanded(
                child: Text(
                  row['date']!,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: TUi.ink,
                  ),
                ),
              ),
              _statusBadge(row['status']!),
            ],
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Column(
              children: [
                _detailLine('Type', row['type']!),
                _detailLine('Size', row['size']!),
                _detailLine('Duration', row['duration']!),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailLine(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 12, color: TUi.muted),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: TUi.ink,
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusBadge(String status) {
    return TStatusBadge(
      status,
      tone: status == 'Completed' ? TTone.success : TTone.danger,
    );
  }
}