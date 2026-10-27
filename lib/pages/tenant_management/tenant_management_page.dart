
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TenantManagementPage extends StatefulWidget {
  const TenantManagementPage({super.key});

  @override
  State<TenantManagementPage> createState() =>
      _TenantManagementPageState();
}

class _TenantManagementPageState extends State<TenantManagementPage> {
  static const Color navy = Color(0xFF252D63);
  static const Color primary = Color(0xFF303FF5);
  static const Color borderColor = Color(0xFFDCE4F0);
  static const Color muted = Color(0xFF718096);

  final TextEditingController searchController = TextEditingController();

  final List<Map<String, dynamic>> tenants = [
    {
      'name': 'ABC PVT LTD',
      'id': 'TEN00X',
      'plan': 'Enterprise',
      'status': 'Active',
      'date': '10-05-2026',
      'region': 'India',
      'selected': true,
    },
    {
      'name': 'ABC PVT LTD',
      'id': 'TEN00X',
      'plan': 'Enterprise',
      'status': 'Inactive',
      'date': '10-05-2026',
      'region': 'India',
      'selected': false,
    },
    {
      'name': 'ABC PVT LTD',
      'id': 'TEN00X',
      'plan': 'Enterprise',
      'status': 'Active',
      'date': '10-05-2026',
      'region': 'India',
      'selected': false,
    },
    {
      'name': 'ABC PVT LTD',
      'id': 'TEN00X',
      'plan': 'Enterprise',
      'status': 'Active',
      'date': '10-05-2026',
      'region': 'India',
      'selected': false,
    },
    {
      'name': 'ABC PVT LTD',
      'id': 'TEN00X',
      'plan': 'Enterprise',
      'status': 'Active',
      'date': '10-05-2026',
      'region': 'India',
      'selected': false,
    },
  ];

  String subscriptionFilter = 'All';
  String statusFilter = 'All';
  String regionFilter = 'All';
  int currentPage = 1;

  List<Map<String, dynamic>> get filteredTenants {
    return tenants.where((tenant) {
      final query = searchController.text.toLowerCase();

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

  int get selectedCount =>
      tenants.where((tenant) => tenant['selected'] == true).length;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void toggleTenant(int index, bool value) {
    setState(() => filteredTenants[index]['selected'] = value);
  }

  void toggleStatus(Map<String, dynamic> tenant) {
    setState(() {
      tenant['status'] =
          tenant['status'] == 'Active' ? 'Inactive' : 'Active';
    });
  }

  Future<void> exportTenants() async {
    final rows = <String>[
      'Tenant Name,Tenant ID,License Plan,Status,Created On,Region',
      ...filteredTenants.map((tenant) =>
          '${tenant['name']},${tenant['id']},${tenant['plan']},'
          '${tenant['status']},${tenant['date']},${tenant['region']}'),
    ];

    await Clipboard.setData(ClipboardData(text: rows.join('\n')));

    if (mounted) {
      showMessage('Tenant report copied as CSV. Paste it into Excel.');
    }
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

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 700;

        return Container(
          color: Colors.white,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(isDesktop ? 20 : 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeading(isDesktop),
                const SizedBox(height: 18),
                _buildSummaryCards(isDesktop),
                const SizedBox(height: 18),
                const Text(
                  'TENANT LIST',
                  style: TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.6,
                  ),
                ),
                const SizedBox(height: 14),
                if (isDesktop)
                  _buildDesktopTenantList()
                else
                  _buildMobileTenantList(),
                if (!isDesktop) ...[
                  const SizedBox(height: 18),
                  SizedBox(
                    width: double.infinity,
                    height: 46,
                    child: ElevatedButton.icon(
                      onPressed: exportTenants,
                      icon: const Icon(Icons.download, size: 17),
                      label: const Text('Export Report'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF182EDC),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeading(bool isDesktop) {
    if (!isDesktop) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Platform Administration / Tenant Management',
            style: TextStyle(color: Color(0xFF8DA0BF), fontSize: 10),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Tenant Management',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF202B40),
                  ),
                ),
              ),
              IconButton(
                onPressed: () => setState(() {}),
                icon: const Icon(Icons.refresh, color: muted),
                tooltip: 'Refresh',
              ),
            ],
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Expanded(
              child: Text(
                'Tenant Management',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF191919),
                ),
              ),
            ),
            _outlineButton(
              'Refresh',
              Icons.refresh,
              () => setState(() {}),
            ),
            const SizedBox(width: 10),
            _outlineButton('Export', Icons.download, exportTenants),
            const SizedBox(width: 10),
            ElevatedButton.icon(
              onPressed: () => showMessage('Create Tenant form is not connected yet.'),
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Create Tenant'),
              style: ElevatedButton.styleFrom(
                backgroundColor: primary,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 3),
        const Text(
          'Create, configure, and manage multiple tenants from a centralized interface.',
          style: TextStyle(fontSize: 14, color: Color(0xFF666666)),
        ),
      ],
    );
  }

  Widget _buildSummaryCards(bool isDesktop) {
    final cards = [
      _summaryCard('Total Tenants', '65', Icons.tune, navy),
      _summaryCard(
        'Active Tenants',
        '52',
        Icons.check_circle_outline,
        const Color(0xFF079447),
      ),
      _summaryCard(
        'Inactive Tenants',
        '13',
        Icons.error_outline,
        const Color(0xFFEF4444),
      ),
    ];

    if (isDesktop) {
      return Row(
        children: [
          for (int i = 0; i < cards.length; i++) ...[
            Expanded(child: cards[i]),
            if (i != cards.length - 1) const SizedBox(width: 16),
          ],
        ],
      );
    }

    return Column(
      children: [
        for (int i = 0; i < cards.length; i++) ...[
          cards[i],
          if (i != cards.length - 1) const SizedBox(height: 12),
        ],
      ],
    );
  }

  Widget _summaryCard(
    String title,
    String value,
    IconData icon,
    Color iconColor,
  ) {
    return Container(
      width: double.infinity,
      height: 115,
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x05000000),
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF737D8F),
                  ),
                ),
              ),
              Icon(icon, color: iconColor, size: 21),
            ],
          ),
          const SizedBox(height: 7),
          Text(
            value,
            style: const TextStyle(
              fontSize: 30,
              height: 1,
              fontWeight: FontWeight.w700,
              color: Color(0xFF111A30),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileTenantList() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(17),
      ),
      child: Column(
        children: [
          TextField(
            controller: searchController,
            onChanged: (_) => setState(() => currentPage = 1),
            decoration: InputDecoration(
              hintText: 'Search tenants...',
              hintStyle: const TextStyle(
                color: Color(0xFF9AA7BB),
                fontSize: 12,
              ),
              prefixIcon: const Icon(
                Icons.search,
                size: 18,
                color: muted,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 11),
              isDense: true,
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: borderColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: borderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: primary),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _filterDropdown(
                  subscriptionFilter,
                  'Subscription',
                  ['All', 'Enterprise', 'Professional', 'Standard'],
                  (value) => setState(() => subscriptionFilter = value!),
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: _filterDropdown(
                  statusFilter,
                  'Status',
                  ['All', 'Active', 'Inactive'],
                  (value) => setState(() => statusFilter = value!),
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: _filterDropdown(
                  regionFilter,
                  'Region',
                  ['All', 'India'],
                  (value) => setState(() => regionFilter = value!),
                ),
              ),
              TextButton(
                onPressed: clearFilters,
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text(
                  'Clear',
                  style: TextStyle(fontSize: 11, color: primary),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...filteredTenants.map((tenant) => _tenantMobileCard(tenant)),
          const SizedBox(height: 6),
          const Text(
            'Showing 1-5 of 65 features',
            style: TextStyle(fontSize: 11, color: Color(0xFF8DA0BF)),
          ),
          const SizedBox(height: 8),
          _pagination(),
        ],
      ),
    );
  }

  Widget _tenantMobileCard(Map<String, dynamic> tenant) {
    final isActive = tenant['status'] == 'Active';

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 3),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(17),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  tenant['name'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF202B40),
                  ),
                ),
              ),
              const SizedBox(width: 6),
              _statusBadge(tenant['status']),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            '${tenant['id']} · ${tenant['plan']}',
            style: const TextStyle(fontSize: 11, color: muted),
          ),
          const SizedBox(height: 15),

          // Keep all three action buttons on one horizontal row.
          Row(
            children: [
              Expanded(
                child: _mobileActionButton(
                  'Configure',
                  Icons.tune,
                  const Color(0xFF344054),
                  borderColor,
                  () => showMessage('Configure ${tenant['name']}'),
                ),
              ),
              const SizedBox(width: 7),
              Expanded(
                child: _mobileActionButton(
                  'Backup',
                  null,
                  const Color(0xFF344054),
                  borderColor,
                  () => showMessage('Backup ${tenant['name']}'),
                ),
              ),
              const SizedBox(width: 7),
              Expanded(
                child: _mobileActionButton(
                  isActive ? 'Disable' : 'Enable',
                  null,
                  isActive
                      ? const Color(0xFFEF4444)
                      : const Color(0xFF079447),
                  isActive
                      ? const Color(0xFFFFA3A3)
                      : const Color(0xFF86EFAC),
                  () => toggleStatus(tenant),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopTenantList() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFD6D6D6)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 247,
                height: 39,
                child: TextField(
                  controller: searchController,
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: const Icon(Icons.search, size: 18),
                    contentPadding: const EdgeInsets.symmetric(vertical: 8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: borderColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: borderColor),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              _filterDropdown(
                subscriptionFilter,
                'Subscription',
                ['All', 'Enterprise', 'Professional', 'Standard'],
                (value) => setState(() => subscriptionFilter = value!),
                desktop: true,
              ),
              const SizedBox(width: 12),
              _filterDropdown(
                statusFilter,
                'Status',
                ['All', 'Active', 'Inactive'],
                (value) => setState(() => statusFilter = value!),
                desktop: true,
              ),
              const SizedBox(width: 12),
              _filterDropdown(
                regionFilter,
                'Region',
                ['All', 'India'],
                (value) => setState(() => regionFilter = value!),
                desktop: true,
              ),
            ],
          ),
          if (selectedCount > 0) ...[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
              decoration: BoxDecoration(
                color: const Color(0xFFEBF0FF),
                border: Border.all(color: const Color(0xFF9CB4FF)),
                borderRadius: BorderRadius.circular(7),
              ),
              child: Row(
                children: [
                  Checkbox(
                    value: filteredTenants.isNotEmpty &&
                        filteredTenants.every((t) => t['selected'] == true),
                    onChanged: (value) {
                      setState(() {
                        for (final tenant in filteredTenants) {
                          tenant['selected'] = value ?? false;
                        }
                      });
                    },
                    visualDensity: VisualDensity.compact,
                  ),
                  Text('$selectedCount tenants selected'),
                  const Spacer(),
                  _smallAction('Enable', const Color(0xFF079447), () {
                    setState(() {
                      for (final tenant in tenants) {
                        if (tenant['selected'] == true) {
                          tenant['status'] = 'Active';
                        }
                      }
                    });
                  }),
                  const SizedBox(width: 8),
                  _smallAction('Disable', Colors.red, () {
                    setState(() {
                      for (final tenant in tenants) {
                        if (tenant['selected'] == true) {
                          tenant['status'] = 'Inactive';
                        }
                      }
                    });
                  }),
                  const SizedBox(width: 8),
                  _smallAction('Configure', navy,
                      () => showMessage('Configure selected tenants')),
                  const SizedBox(width: 8),
                  _smallAction('Backup', navy,
                      () => showMessage('Backup selected tenants')),
                ],
              ),
            ),
          ],
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: DataTable(
              headingRowColor: WidgetStateProperty.all(navy),
              headingTextStyle: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
              dataTextStyle: const TextStyle(
                color: Color(0xFF171923),
                fontSize: 14,
              ),
              horizontalMargin: 10,
              columnSpacing: 24,
              dataRowMinHeight: 55,
              dataRowMaxHeight: 55,
              columns: const [
                DataColumn(label: Text('TENANT NAME')),
                DataColumn(label: Text('TENANT ID')),
                DataColumn(label: Text('LICENSE PLAN')),
                DataColumn(label: Text('STATUS')),
                DataColumn(label: Text('CREATED ON')),
              ],
              rows: filteredTenants.map((tenant) {
                return DataRow(
                  selected: tenant['selected'] == true,
                  onSelectChanged: (value) {
                    setState(() => tenant['selected'] = value ?? false);
                  },
                  cells: [
                    DataCell(Text(tenant['name'])),
                    DataCell(Text(tenant['id'])),
                    DataCell(Text(tenant['plan'])),
                    DataCell(_statusBadge(tenant['status'])),
                    DataCell(Text(tenant['date'])),
                  ],
                );
              }).toList(),
            ),
          ),
          const Divider(height: 1, color: borderColor),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
            child: Row(
              children: [
                const Text(
                  'Showing 1-5 of 65 features',
                  style: TextStyle(fontSize: 12, color: muted),
                ),
                const Spacer(),
                _pagination(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _filterDropdown(
    String value,
    String label,
    List<String> options,
    ValueChanged<String?> onChanged, {
    bool desktop = false,
  }) {
    return Container(
      height: desktop ? 39 : 32,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isDense: true,
          icon: const Icon(Icons.keyboard_arrow_down, size: 15),
          style: TextStyle(
            fontSize: desktop ? 14 : 10,
            color: const Color(0xFF344054),
          ),
          items: options.map((option) {
            return DropdownMenuItem(
              value: option,
              child: Text(
                option == 'All' ? label : option,
                overflow: TextOverflow.ellipsis,
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _statusBadge(String status) {
    final active = status == 'Active';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: active
            ? const Color(0xFFE7F8EF)
            : const Color(0xFFFFDADA),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: active
                  ? const Color(0xFF10B981)
                  : const Color(0xFFEF4444),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            status,
            style: TextStyle(
              color: active
                  ? const Color(0xFF07864B)
                  : const Color(0xFFDC2626),
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _mobileActionButton(
    String label,
    IconData? icon,
    Color textColor,
    Color outlineColor,
    VoidCallback onPressed,
  ) {
    return SizedBox(
      height: 37,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 3),
          foregroundColor: textColor,
          side: BorderSide(color: outlineColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 13),
                const SizedBox(width: 4),
              ],
              Text(label),
            ],
          ),
        ),
      ),
    );
  }

  Widget _outlineButton(
    String label,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 16),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFF172033),
        side: const BorderSide(color: borderColor),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }

  Widget _smallAction(
    String label,
    Color color,
    VoidCallback onPressed,
  ) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: color,
        side: BorderSide(color: color),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
        ),
      ),
      child: Text(label, style: const TextStyle(fontSize: 12)),
    );
  }

  Widget _pagination() {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 7,
      children: [
        _pageButton(
          Icons.chevron_left,
          () => setState(() {
            if (currentPage > 1) currentPage--;
          }),
        ),
        _pageNumber('1'),
        _pageNumber('2'),
        _pageNumber('3'),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 1, vertical: 9),
          child: Text('...', style: TextStyle(color: muted, fontSize: 12)),
        ),
        _pageNumber('13'),
        _pageButton(
          Icons.chevron_right,
          () => setState(() {
            if (currentPage < 13) currentPage++;
          }),
        ),
      ],
    );
  }

  Widget _pageNumber(String number) {
    final selected = currentPage.toString() == number;

    return InkWell(
      onTap: () => setState(() => currentPage = int.parse(number)),
      borderRadius: BorderRadius.circular(6),
      child: Container(
        width: 28,
        height: 29,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? navy : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          number,
          style: TextStyle(
            fontSize: 12,
            color: selected ? Colors.white : const Color(0xFF172033),
          ),
        ),
      ),
    );
  }

  Widget _pageButton(IconData icon, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        width: 28,
        height: 29,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon, size: 18, color: muted),
      ),
    );
  }
}
