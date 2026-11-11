import 'package:flutter/material.dart';

import 'tenant_ui.dart';
import '../../widgets/tenant_management_dialogs.dart';

class TenantIsolationPage extends StatefulWidget {
  const TenantIsolationPage({super.key});

  @override
  State<TenantIsolationPage> createState() => _TenantIsolationPageState();
}

class _TenantIsolationPageState extends State<TenantIsolationPage> {
  final List<String> tenants = [
    'ABX Technologies Pvt. Ltd.',
    'ABC Technologies Pvt. Ltd.',
    'Java Enterprise Suite',
    'ABZ TECH',
  ];

  String selectedTenant = 'ABX Technologies Pvt. Ltd.';

  bool databaseIsolation = true;
  bool storageIsolation = true;
  bool apiAccess = true;
  bool crossTenantAccess = false;
  bool privateNetwork = true;
  bool ipWhitelisting = true;

  final TextEditingController ipController = TextEditingController();

  late final Map<String, Map<String, dynamic>> savedSettings = {
    selectedTenant: _currentSettings(),
  };

  Map<String, dynamic> _currentSettings() => {
        'databaseIsolation': databaseIsolation,
        'storageIsolation': storageIsolation,
        'apiAccess': apiAccess,
        'crossTenantAccess': crossTenantAccess,
        'privateNetwork': privateNetwork,
        'ipWhitelisting': ipWhitelisting,
        'ipAddress': ipController.text,
      };

  void _applySettings(Map<String, dynamic> settings) {
    databaseIsolation = settings['databaseIsolation'] as bool;
    storageIsolation = settings['storageIsolation'] as bool;
    apiAccess = settings['apiAccess'] as bool;
    crossTenantAccess = settings['crossTenantAccess'] as bool;
    privateNetwork = settings['privateNetwork'] as bool;
    ipWhitelisting = settings['ipWhitelisting'] as bool;
    ipController.text = settings['ipAddress'] as String;
  }

  void _selectTenant(String? tenant) {
    if (tenant == null) return;

    setState(() {
      savedSettings[selectedTenant] = _currentSettings();
      selectedTenant = tenant;

      final settings = savedSettings[tenant];
      if (settings != null) {
        _applySettings(settings);
      } else {
        databaseIsolation = true;
        storageIsolation = true;
        apiAccess = true;
        crossTenantAccess = false;
        privateNetwork = true;
        ipWhitelisting = true;
        ipController.clear();
      }
    });
  }

  void _save() {
    setState(() {
      savedSettings[selectedTenant] = _currentSettings();
    });
    _message('Isolation settings saved for this session.');
  }

  Future<void> _reset() async {
    if (!await showResetChangesDialog(context)) return;
    if (!mounted) return;
    setState(() {
      databaseIsolation = true;
      storageIsolation = true;
      apiAccess = true;
      crossTenantAccess = false;
      privateNetwork = true;
      ipWhitelisting = true;
      ipController.clear();
    });
    _message('Settings reset to their default values.');
  }

  void _refresh() {
    setState(() {});
    _message('Isolation status refreshed.');
  }

  void _message(String message) {
    if (!mounted) return;
    showTenantMessageToast(context, message);
  }

  @override
  void dispose() {
    ipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final mobile = TUi.isMobile(constraints.maxWidth);

        final compliant = databaseIsolation &&
            storageIsolation &&
            apiAccess &&
            !crossTenantAccess &&
            privateNetwork &&
            (!ipWhitelisting || ipController.text.trim().isNotEmpty);

        return Container(
          color: TUi.bg,
          child: SingleChildScrollView(
            padding: TUi.pagePadding(mobile),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TBreadcrumb(['Tenant Management', 'Tenant Isolation']),
                const SizedBox(height: 8),
                _header(mobile),
                SizedBox(height: mobile ? 18 : 22),
                _tenantSelector(mobile),
                const SizedBox(height: 16),
                TCard(
                  title: 'Isolation Configuration',
                  icon: Icons.settings_outlined,
                  padding: EdgeInsets.zero,
                  child: _divided([
                    _settingRow(
                      'Database Isolation',
                      'Dedicated database for the tenant',
                      databaseIsolation,
                      (v) => setState(() => databaseIsolation = v),
                      mobile,
                    ),
                    _settingRow(
                      'Storage Isolation',
                      'Dedicated storage for tenant data',
                      storageIsolation,
                      (v) => setState(() => storageIsolation = v),
                      mobile,
                    ),
                    _settingRow(
                      'API Access',
                      'Restrict API access to the selected tenant',
                      apiAccess,
                      (v) => setState(() => apiAccess = v),
                      mobile,
                    ),
                    _settingRow(
                      'Cross - Tenant Access',
                      'Prevent data access between tenants',
                      crossTenantAccess,
                      (v) => setState(() => crossTenantAccess = v),
                      mobile,
                    ),
                  ]),
                ),
                const SizedBox(height: 16),
                TCard(
                  title: 'Network Security',
                  icon: Icons.shield_outlined,
                  padding: EdgeInsets.zero,
                  child: _divided([
                    _settingRow(
                      'Private Network',
                      'Isolate tenant within private network',
                      privateNetwork,
                      (v) => setState(() => privateNetwork = v),
                      mobile,
                    ),
                    _settingRow(
                      'IP whitelisting',
                      'Allow only specified IP addresses',
                      ipWhitelisting,
                      (v) => setState(() => ipWhitelisting = v),
                      mobile,
                    ),
                    _ipAddressRow(mobile),
                  ]),
                ),
                const SizedBox(height: 16),
                TCard(
                  title: 'Isolation Status',
                  icon: Icons.hub_outlined,
                  padding: EdgeInsets.zero,
                  child: _divided([
                    _statusRow('Database Isolation', databaseIsolation, mobile),
                    _statusRow('Storage Isolation', storageIsolation, mobile),
                    _statusRow('API Security', apiAccess, mobile),
                    _statusRow(
                      'Compliance Status',
                      compliant,
                      mobile,
                      enabledText: 'Compliant',
                      disabledText: 'Non-compliant',
                      disabledTone: TTone.warning,
                    ),
                  ]),
                ),
                if (mobile) ...[
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TButton(
                          'Refresh',
                          icon: Icons.refresh,
                          height: 46,
                          expand: true,
                          onPressed: _refresh,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TButton(
                          'Reset',
                          icon: Icons.restart_alt,
                          height: 46,
                          expand: true,
                          onPressed: _reset,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  TButton(
                    'Save',
                    icon: Icons.save_outlined,
                    kind: TButtonKind.primary,
                    height: 46,
                    expand: true,
                    onPressed: _save,
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
    return TPageHeader(
      title: 'Tenant Isolation',
      subtitle: 'Configure and monitor isolation policies per tenant.',
      mobile: mobile,
      actions: [
        TButton('Refresh', icon: Icons.refresh, onPressed: _refresh),
        TButton('Reset', icon: Icons.restart_alt, onPressed: _reset),
        TButton(
          'Save',
          icon: Icons.save_outlined,
          kind: TButtonKind.primary,
          onPressed: _save,
        ),
      ],
    );
  }

  Widget _tenantSelector(bool mobile) {
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
      onChanged: _selectTenant,
    );
  }

  // ---------------------------------------------------------------------------
  // ROWS
  // ---------------------------------------------------------------------------
  /// Puts a thin divider between rows (none after the last one).
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

  Widget _settingRow(
    String title,
    String description,
    bool value,
    ValueChanged<bool> onChanged,
    bool mobile,
  ) {
    return Container(
      constraints: const BoxConstraints(minHeight: 64),
      padding: EdgeInsets.symmetric(
        horizontal: mobile ? 16 : 20,
        vertical: 10,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  description,
                  style: const TextStyle(fontSize: 12, color: TUi.muted),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          TUi.toggle(value: value, onChanged: onChanged),
        ],
      ),
    );
  }

  Widget _ipAddressRow(bool mobile) {
    const label = Text(
      'Allowed IP Address',
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: TUi.ink,
      ),
    );

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: mobile ? 16 : 20,
        vertical: 14,
      ),
      child: mobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                label,
                const SizedBox(height: 10),
                _ipField(),
              ],
            )
          : Row(
              children: [
                const Expanded(child: label),
                const SizedBox(width: 20),
                SizedBox(width: 340, child: _ipField()),
              ],
            ),
    );
  }

  Widget _ipField() {
    return TextField(
      controller: ipController,
      keyboardType: TextInputType.text,
      onChanged: (_) => setState(() {}),
      decoration: TUi.input(hint: 'e.g. 192.168.1.0/24, 10.0.0.1'),
      style: TUi.fieldText,
    );
  }

  Widget _statusRow(
    String title,
    bool enabled,
    bool mobile, {
    String enabledText = 'Enabled',
    String disabledText = 'Disabled',
    TTone disabledTone = TTone.neutral,
  }) {
    return Container(
      constraints: const BoxConstraints(minHeight: 56),
      padding: EdgeInsets.symmetric(
        horizontal: mobile ? 16 : 20,
        vertical: 10,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: TUi.ink,
              ),
            ),
          ),
          TStatusBadge(
            enabled ? enabledText : disabledText,
            tone: enabled ? TTone.success : disabledTone,
          ),
        ],
      ),
    );
  }
}