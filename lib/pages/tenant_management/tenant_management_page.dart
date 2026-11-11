import 'package:flutter/material.dart';

import 'tenant_ui.dart';
import '../../widgets/dashboard_dialogs.dart';
import '../../utils/chart_csv_export.dart';
import '../../widgets/tenant_management_dialogs.dart';

class TenantManagementPage extends StatefulWidget {
  const TenantManagementPage({super.key});

  @override
  State<TenantManagementPage> createState() =>
      _TenantManagementPageState();
}

class _TenantManagementPageState extends State<TenantManagementPage> {
  final TextEditingController searchController = TextEditingController();

  static const int pageSize = 5;

  final List<Map<String, dynamic>> tenants = [
    {
      'name': 'ABC PVT LTD',
      'id': 'TEN001',
      'plan': 'Enterprise',
      'status': 'Active',
      'date': '10-05-2026',
      'region': 'India',
      'selected': false,
    },
    {
      'name': 'XYZ Technologies',
      'id': 'TEN002',
      'plan': 'Professional',
      'status': 'Inactive',
      'date': '12-05-2026',
      'region': 'India',
      'selected': false,
    },
    {
      'name': 'Global Solutions',
      'id': 'TEN003',
      'plan': 'Enterprise',
      'status': 'Active',
      'date': '15-05-2026',
      'region': 'India',
      'selected': false,
    },
    {
      'name': 'Tech Innovations',
      'id': 'TEN004',
      'plan': 'Standard',
      'status': 'Active',
      'date': '18-05-2026',
      'region': 'India',
      'selected': false,
    },
    {
      'name': 'Smart Systems',
      'id': 'TEN005',
      'plan': 'Professional',
      'status': 'Inactive',
      'date': '20-05-2026',
      'region': 'India',
      'selected': false,
    },
  ];

  String subscriptionFilter = 'All';
  String statusFilter = 'All';
  String regionFilter = 'All';

  int currentPage = 1;

  static const List<String> planOptions = [
    'All',
    'Enterprise',
    'Professional',
    'Standard',
  ];

  static const List<String> statusOptions = [
    'All',
    'Active',
    'Inactive',
  ];

  static const List<String> regionOptions = [
    'All',
    'India',
    'United States',
    'United Kingdom',
    'Singapore',
  ];

  static const List<String> regionLabels = [
    'India (Asia South)',
    'United States (US East)',
    'United Kingdom (Europe West)',
    'Singapore (Asia Southeast)',
  ];

  List<Map<String, dynamic>> get filteredTenants {
    final query = searchController.text.toLowerCase().trim();

    return tenants.where((tenant) {
      final matchesSearch =
          tenant['name'].toString().toLowerCase().contains(query) ||
          tenant['id'].toString().toLowerCase().contains(query);

      final matchesPlan = subscriptionFilter == 'All' ||
          tenant['plan'] == subscriptionFilter;

      final matchesStatus = statusFilter == 'All' ||
          tenant['status'] == statusFilter;

      final matchesRegion = regionFilter == 'All' ||
          tenant['region'] == regionFilter;

      return matchesSearch &&
          matchesPlan &&
          matchesStatus &&
          matchesRegion;
    }).toList();
  }

  int get totalPages {
    if (filteredTenants.isEmpty) return 1;
    return (filteredTenants.length / pageSize).ceil();
  }

  List<Map<String, dynamic>> get paginatedTenants {
    final items = filteredTenants;
    final start = (currentPage - 1) * pageSize;

    if (start >= items.length) return [];

    return items.skip(start).take(pageSize).toList();
  }

  int get activeCount =>
      tenants.where((t) => t['status'] == 'Active').length;

  int get inactiveCount =>
      tenants.where((t) => t['status'] == 'Inactive').length;

  int get selectedCount =>
      tenants.where((t) => t['selected'] == true).length;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void showMessage(String message) {
    if (!mounted) return;
    showTenantMessageToast(context, message);
  }

  Future<void> refresh() async {
    await showTenantRefreshingDialog(context);
    if (!mounted) return;
    setState(() {});
  }

  void clearFilters() {
    setState(() {
      searchController.clear();
      subscriptionFilter = 'All';
      statusFilter = 'All';
      regionFilter = 'All';
      currentPage = 1;
    });
  }

  Future<void> toggleStatus(Map<String, dynamic> tenant) async {
    final enable = tenant['status'] != 'Active';

    final confirmed = await showTenantStatusDialog(
      context: context,
      tenantName: tenant['name'],
      tenantDescription: '${tenant['id']} • ${tenant['plan']} Plan',
      enable: enable,
    );

    if (confirmed != true || !mounted) return;

    setState(() {
      tenant['status'] = enable ? 'Active' : 'Inactive';
    });

    _statusToast(enable, "'${tenant['name']}'", 1);
  }

  void _statusToast(bool enable, String subject, int count) {
    final many = count > 1;

    showTenantToast(
      context,
      title: enable
          ? (many ? 'Tenants Enabled' : 'Tenant Enabled')
          : (many ? 'Tenants Disabled' : 'Tenant Disabled'),
      message: many
          ? '$count tenants have been ${enable ? 'activated' : 'deactivated'} across the platform.'
          : '$subject has been ${enable ? 'activated' : 'deactivated'} across the platform.',
      type: enable ? TenantToastType.success : TenantToastType.danger,
      icon: Icons.check_circle_outline,
    );
  }
  Future<void> configureTenant(Map<String, dynamic> tenant) async {
    final result = await showConfigureTenantDialog(
      context,
      tenantName: tenant['name'].toString(),
      plan: tenant['plan'].toString(),
      region: tenant['region'].toString(),
      storageGb: (tenant['storage'] as int?) ?? 200,
      active: tenant['status'] == 'Active',
      plans: planOptions.where((p) => p != 'All').toList(),
      regions: regionLabels,
    );

    if (result == null || !mounted) return;

    setState(() {
      tenant['plan'] = result.plan;
      tenant['region'] = result.region.split(' (').first;
      tenant['storage'] = result.storageGb;
      tenant['status'] = result.active ? 'Active' : 'Inactive';
      currentPage = 1;
    });

    showTenantToast(
      context,
      title: 'Tenant Updated',
      message: "'${tenant['name']}' settings have been saved.",
    );
  }

  Future<void> backupTenant(Map<String, dynamic> tenant) async {
    final options = await showBackupTenantDialog(
      context,
      tenantName: tenant['name'].toString(),
    );

    if (options == null || !mounted) return;

    showTenantToast(
      context,
      title: 'Backup Started',
      message:
          "${options.type} of '${tenant['name']}' to ${options.location} has been started.",
      type: TenantToastType.info,
    );
  }

  String _exportValue(Map<String, dynamic> tenant, String column) {
    switch (column) {
      case 'Tenant Name':
        return tenant['name'].toString();
      case 'Tenant ID':
        return tenant['id'].toString();
      case 'Domain':
        return (tenant['domain'] ?? '-').toString();
      case 'Subscription Plan':
        return tenant['plan'].toString();
      case 'Status':
        return tenant['status'].toString();
      case 'Region':
        return tenant['region'].toString();
      case 'Storage Used':
        return (tenant['storageUsed'] ?? '-').toString();
      case 'Created On':
        return tenant['date'].toString();
      case 'Last Backup':
        return (tenant['lastBackup'] ?? '-').toString();
      default:
        return '';
    }
  }

  Future<void> exportTenants() async {
    final options = await showExportTenantsDialog(
      context,
      totalCount: tenants.length,
      selectedCount: selectedCount,
    );

    if (options == null || !mounted) return;

    final source = options.selectedOnly
        ? tenants.where((t) => t['selected'] == true).toList()
        : tenants;

    final headers = options.columns.where((c) => c != 'Actions').toList();

    if (headers.isEmpty) {
      showTenantToast(
        context,
        title: 'Export Failed',
        message: 'Select at least one column to export.',
        type: TenantToastType.danger,
        icon: Icons.error_outline,
      );
      return;
    }

    final rows = source.map((tenant) {
      return <Object?>[
        for (final column in headers) _exportValue(tenant, column),
      ];
    }).toList();

    try {
      switch (options.format) {
        case ExportFormat.csv:
          await exportChartCsv(
            fileName: 'Tenant_Report',
            headers: headers,
            rows: rows,
          );
          break;

        case ExportFormat.excel:
          await exportChartExcel(
            fileName: 'Tenant_Report',
            headers: headers,
            rows: rows,
          );
          break;

        case ExportFormat.pdf:
          await exportChartPdf(
            fileName: 'Tenant_Report',
            headers: headers,
            rows: rows,
          );
          break;
      }

      if (mounted) {
        showTenantToast(
          context,
          title: 'Export Complete',
          message: 'Tenant report exported successfully.',
        );
      }
    } catch (e) {
      if (mounted) {
        showTenantToast(
          context,
          title: 'Export Failed',
          message: '$e',
          type: TenantToastType.danger,
          icon: Icons.error_outline,
        );
      }
    }
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
                const TBreadcrumb(['Tenant Management']),
                const SizedBox(height: 8),
                _buildHeading(mobile),
                SizedBox(height: mobile ? 18 : 22),
                _buildSummaryCards(mobile),
                SizedBox(height: mobile ? 22 : 24),
                const TCaption('TENANT LIST'),
                const SizedBox(height: 10),
                if (mobile)
                  _buildMobileTenantList()
                else
                  _buildDesktopTenantList(),
                if (mobile) ...[
                  const SizedBox(height: 18),
                  TButton(
                    'Export Report',
                    icon: Icons.download_outlined,
                    kind: TButtonKind.primary,
                    height: 46,
                    expand: true,
                    onPressed: exportTenants,
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeading(bool mobile) {
    const subtitle =
        'Create, configure, and manage multiple tenants from a centralized interface.';

    if (mobile) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Expanded(
            child: TPageHeader(
              title: 'Tenant Management',
              subtitle: subtitle,
              mobile: true,
            ),
          ),
          IconButton(
            onPressed: refresh,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(
              minWidth: 32,
              minHeight: 32,
            ),
            tooltip: 'Refresh',
            icon: const Icon(
              Icons.sync,
              size: 24,
              color: Color(0xFF52616F),
            ),
          ),
        ],
      );
    }

    return TPageHeader(
      title: 'Tenant Management',
      subtitle: subtitle,
      mobile: false,
      actions: [
        TButton(
          'Refresh',
          icon: Icons.refresh,
          onPressed: refresh,
        ),
        TButton(
          'Export',
          icon: Icons.download_outlined,
          onPressed: exportTenants,
        ),
        TButton(
          'Create Tenant',
          icon: Icons.add,
          kind: TButtonKind.primary,
          onPressed: () {
            showMessage('Create Tenant form is not connected yet.');
          },
        ),
      ],
    );
  }

  Widget _buildSummaryCards(bool mobile) {
    final cards = [
      _summaryCard(
        'Total Tenants',
        '${tenants.length}',
        Icons.apartment_outlined,
        const Color(0xFFEAF1FF),
        const Color(0xFF3974E8),
      ),
      _summaryCard(
        'Active Tenants',
        '$activeCount',
        Icons.check_circle_outline,
        const Color(0xFFE5F8EF),
        const Color(0xFF00A96B),
      ),
      _summaryCard(
        'Inactive Tenants',
        '$inactiveCount',
        Icons.error_outline,
        const Color(0xFFFFE8EC),
        TUi.red,
      ),
    ];

    if (!mobile) {
      return Row(
        children: [
          for (int i = 0; i < cards.length; i++) ...[
            if (i > 0) const SizedBox(width: 16),
            Expanded(child: cards[i]),
          ],
        ],
      );
    }

    return Column(
      children: [
        for (int i = 0; i < cards.length; i++) ...[
          if (i > 0) const SizedBox(height: 12),
          cards[i],
        ],
      ],
    );
  }

  Widget _summaryCard(
    String title,
    String value,
    IconData icon,
    Color chipBg,
    Color chipFg,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
      decoration: TUi.cardBox(),
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
                    color: TUi.muted,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 30,
                    height: 1,
                    fontWeight: FontWeight.w700,
                    color: TUi.ink,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: chipBg,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 19, color: chipFg),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileTenantList() {
    final items = paginatedTenants;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: TUi.cardBox(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _searchField(),
          const SizedBox(height: 12),

          // Filters wrap onto another line on smaller phones.
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              SizedBox(
                width: 145,
                child: TFilter(
                  label: 'Subscription',
                  value: subscriptionFilter,
                  options: planOptions,
                  compact: true,
                  onChanged: (v) {
                    setState(() {
                      subscriptionFilter = v;
                      currentPage = 1;
                    });
                  },
                ),
              ),
              SizedBox(
                width: 110,
                child: TFilter(
                  label: 'Status',
                  value: statusFilter,
                  options: statusOptions,
                  compact: true,
                  onChanged: (v) {
                    setState(() {
                      statusFilter = v;
                      currentPage = 1;
                    });
                  },
                ),
              ),
              SizedBox(
                width: 105,
                child: TFilter(
                  label: 'Region',
                  value: regionFilter,
                  options: regionOptions,
                  compact: true,
                  onChanged: (v) {
                    setState(() {
                      regionFilter = v;
                      currentPage = 1;
                    });
                  },
                ),
              ),
              TextButton(
                onPressed: clearFilters,
                child: const Text(
                  'Clear Filters',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: TUi.blue,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          if (items.isEmpty)
            _emptyState()
          else
            for (final tenant in items) _tenantMobileCard(tenant),

          const SizedBox(height: 6),
          _resultCount(),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.center,
            child: _pagination(),
          ),
        ],
      ),
    );
  }

  Widget _tenantMobileCard(Map<String, dynamic> tenant) {
    final isActive = tenant['status'] == 'Active';

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: TUi.cardBox(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  tenant['name'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: TUi.ink,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              _statusBadge(tenant['status']),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            '${tenant['id']} · ${tenant['plan']}',
            style: const TextStyle(
              fontSize: 12,
              color: TUi.muted,
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              SizedBox(
                width: 95,
                child: TButton(
                  'Configure',
                  height: 36,
                  onPressed: () => configureTenant(tenant),
                ),
              ),
              SizedBox(
                width: 80,
                child: TButton(
                  'Backup',
                  height: 36,
                  onPressed: () => backupTenant(tenant),
                ),
              ),
              SizedBox(
                width: 95,
                child: TButton(
                  isActive ? 'Disable' : 'Enable',
                  height: 36,
                  kind: isActive
                      ? TButtonKind.danger
                      : TButtonKind.success,
                  onPressed: () => toggleStatus(tenant),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopTenantList() {
    final items = paginatedTenants;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: TUi.cardBox(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 12,
            runSpacing: 12,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              SizedBox(width: 260, child: _searchField()),
              TFilter(
                label: 'Subscription',
                value: subscriptionFilter,
                options: planOptions,
                onChanged: (v) {
                  setState(() {
                    subscriptionFilter = v;
                    currentPage = 1;
                  });
                },
              ),
              TFilter(
                label: 'Status',
                value: statusFilter,
                options: statusOptions,
                onChanged: (v) {
                  setState(() {
                    statusFilter = v;
                    currentPage = 1;
                  });
                },
              ),
              TFilter(
                label: 'Region',
                value: regionFilter,
                options: regionOptions,
                onChanged: (v) {
                  setState(() {
                    regionFilter = v;
                    currentPage = 1;
                  });
                },
              ),
              TButton(
                'Clear Filters',
                icon: Icons.filter_alt_off_outlined,
                height: 40,
                onPressed: clearFilters,
              ),
            ],
          ),
          if (selectedCount > 0) ...[
            const SizedBox(height: 12),
            _bulkBar(),
          ],
          const SizedBox(height: 14),
          _buildTable(items),
          const SizedBox(height: 14),
          Row(
            children: [
              _resultCount(),
              const Spacer(),
              _pagination(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _resultCount() {
    final total = filteredTenants.length;

    if (total == 0) {
      return const Text(
        'Showing 0 tenants',
        style: TextStyle(fontSize: 12, color: TUi.muted),
      );
    }

    final start = ((currentPage - 1) * pageSize) + 1;
    final end = (start + pageSize - 1).clamp(0, total);

    return Text(
      'Showing $start-$end of $total tenants',
      style: const TextStyle(fontSize: 12, color: TUi.muted),
    );
  }

  Widget _bulkBar() {
    Future<void> setSelectedStatus(String status) async {
      final selected =
          tenants.where((tenant) => tenant['selected'] == true).toList();
      if (selected.isEmpty) return;

      final enable = status == 'Active';
      final single = selected.length == 1;

      final confirmed = await showTenantStatusDialog(
        context: context,
        tenantName: single
            ? selected.first['name'].toString()
            : '${selected.length} selected tenants',
        tenantDescription: single
            ? '${selected.first['id']} • ${selected.first['plan']} Plan'
            : 'Bulk status change',
        enable: enable,
        count: selected.length,
      );

      if (confirmed != true || !mounted) return;

      setState(() {
        for (final tenant in selected) {
          tenant['status'] = status;
        }
      });

      _statusToast(
        enable,
        single ? "'${selected.first['name']}'" : '',
        selected.length,
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5FF),
        border: Border.all(color: const Color(0xFFD8E5FF)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            selectedCount == 1
                ? '1 tenant selected'
                : '$selectedCount tenants selected',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: TUi.ink,
            ),
          ),
          TButton(
            'Enable',
            compact: true,
            kind: TButtonKind.success,
            onPressed: () => setSelectedStatus('Active'),
          ),
          TButton(
            'Disable',
            compact: true,
            kind: TButtonKind.danger,
            onPressed: () => setSelectedStatus('Inactive'),
          ),
          TButton(
            'Clear Selection',
            compact: true,
            onPressed: () {
              setState(() {
                for (final tenant in tenants) {
                  tenant['selected'] = false;
                }
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTable(List<Map<String, dynamic>> items) {
    final allSelected =
        items.isNotEmpty && items.every((t) => t['selected'] == true);

    final anySelected =
        items.any((t) => t['selected'] == true);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: TUi.border),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Container(
              height: 50,
              color: TUi.navy,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  SizedBox(
                    width: 36,
                    child: Checkbox(
                      tristate: true,
                      value: allSelected
                          ? true
                          : (anySelected ? null : false),
                      activeColor: Colors.white,
                      checkColor: TUi.navy,
                      side: const BorderSide(
                        color: Colors.white,
                        width: 1.5,
                      ),
                      visualDensity: VisualDensity.compact,
                      materialTapTargetSize:
                          MaterialTapTargetSize.shrinkWrap,
                      onChanged: (_) {
                        setState(() {
                          for (final tenant in items) {
                            tenant['selected'] = !allSelected;
                          }
                        });
                      },
                    ),
                  ),
                  const Expanded(
                    flex: 26,
                    child: Text(
                      'TENANT NAME',
                      style: TUi.tableHeader,
                    ),
                  ),
                  const Expanded(
                    flex: 16,
                    child: Text(
                      'TENANT ID',
                      style: TUi.tableHeader,
                    ),
                  ),
                  const Expanded(
                    flex: 18,
                    child: Text(
                      'LICENSE PLAN',
                      style: TUi.tableHeader,
                    ),
                  ),
                  const Expanded(
                    flex: 16,
                    child: Text(
                      'STATUS',
                      style: TUi.tableHeader,
                    ),
                  ),
                  const Expanded(
                    flex: 16,
                    child: Text(
                      'CREATED ON',
                      style: TUi.tableHeader,
                    ),
                  ),
                ],
              ),
            ),
            if (items.isEmpty)
              _emptyState()
            else
              for (int i = 0; i < items.length; i++)
                _tableRow(items[i], i == items.length - 1),
          ],
        ),
      ),
    );
  }

  Widget _tableRow(
    Map<String, dynamic> tenant,
    bool last,
  ) {
    final selected = tenant['selected'] == true;

    return InkWell(
      onTap: () {
        setState(() {
          tenant['selected'] = !selected;
        });
      },
      child: Container(
        height: 58,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFFF5F8FF)
              : Colors.white,
          border: last
              ? null
              : const Border(
                  bottom: BorderSide(color: TUi.divider),
                ),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 36,
              child: Checkbox(
                value: selected,
                activeColor: TUi.blue,
                side: const BorderSide(
                  color: Color(0xFFB6C2D1),
                  width: 1.5,
                ),
                visualDensity: VisualDensity.compact,
                materialTapTargetSize:
                    MaterialTapTargetSize.shrinkWrap,
                onChanged: (value) {
                  setState(() {
                    tenant['selected'] = value ?? false;
                  });
                },
              ),
            ),
            Expanded(
              flex: 26,
              child: Text(
                tenant['name'],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: TUi.ink,
                ),
              ),
            ),
            Expanded(
              flex: 16,
              child: Text(
                tenant['id'],
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  color: TUi.muted,
                ),
              ),
            ),
            Expanded(
              flex: 18,
              child: Text(
                tenant['plan'],
                style: TUi.tableCell,
              ),
            ),
            Expanded(
              flex: 16,
              child: Align(
                alignment: Alignment.centerLeft,
                child: _statusBadge(tenant['status']),
              ),
            ),
            Expanded(
              flex: 16,
              child: Text(
                tenant['date'],
                style: const TextStyle(
                  fontSize: 13,
                  color: TUi.muted,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _emptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32),
      alignment: Alignment.center,
      child: const Text(
        'No tenants found',
        style: TextStyle(
          fontSize: 13,
          color: TUi.hint,
        ),
      ),
    );
  }

  Widget _searchField() {
    return SizedBox(
      height: 40,
      child: TextField(
        controller: searchController,
        onChanged: (_) {
          setState(() {
            currentPage = 1;
          });
        },
        style: TUi.fieldText,
        decoration: TUi.input(
          hint: 'Search tenants...',
          fill: Colors.white,
          minHeight: 40,
          prefixIcon: const Icon(
            Icons.search,
            size: 19,
            color: TUi.muted,
          ),
        ).copyWith(contentPadding: EdgeInsets.zero),
      ),
    );
  }

  Widget _statusBadge(String status) {
    return TStatusBadge(
      status,
      tone: status == 'Active'
          ? TTone.success
          : TTone.danger,
    );
  }

  Widget _pagination() {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 6,
      children: [
        TPageButton(
          icon: Icons.chevron_left,
          enabled: currentPage > 1,
          onTap: () {
            if (currentPage > 1) {
              setState(() {
                currentPage--;
              });
            }
          },
        ),
        for (int page = 1; page <= totalPages; page++)
          TPageButton(
            text: '$page',
            selected: currentPage == page,
            onTap: () {
              setState(() {
                currentPage = page;
              });
            },
          ),
        TPageButton(
          icon: Icons.chevron_right,
          enabled: currentPage < totalPages,
          onTap: () {
            if (currentPage < totalPages) {
              setState(() {
                currentPage++;
              });
            }
          },
        ),
      ],
    );
  }
}