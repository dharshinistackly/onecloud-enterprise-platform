import 'package:flutter/material.dart';

class TenantSubscriptionsPage extends StatelessWidget {
  const TenantSubscriptionsPage({super.key});

  static const _navy = Color(0xFF0A1F44);
  static const _bg = Color(0xFFF6F8FC);
  static const _border = Color(0xFFE7ECF3);

  @override
  Widget build(BuildContext context) {
    final tenants = [
      ['TechNova Solutions', 'Enterprise', '01 Jan 2026', '31 Dec 2026', 'Active'],
      ['CloudWorks Pvt Ltd', 'Business', '15 Mar 2026', '14 Mar 2027', 'Active'],
      ['NextGen Retail', 'Business', '10 Feb 2026', '09 Feb 2027', 'Active'],
      ['InnoSoft Labs', 'Starter', '20 Jun 2025', '19 Jun 2026', 'Expiring Soon'],
      ['DataBridge Systems', 'Enterprise', '05 Sep 2025', '04 Sep 2026', 'Suspended'],
    ];

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),
        title: const Text('Tenant Subscriptions'),
        backgroundColor: _navy,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Tenant Subscriptions', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: _navy)),
          const Text('Manage subscription status across all tenants.', style: TextStyle(color: Colors.black54)),
          const SizedBox(height: 20),
          Row(children: [
            _stat('Total Tenants', '299', Icons.apartment_outlined, _navy),
            const SizedBox(width: 14),
            _stat('Active', '268', Icons.check_circle_outline, const Color(0xFF1E8E5A)),
            const SizedBox(width: 14),
            _stat('Expiring Soon', '19', Icons.timelapse_outlined, const Color(0xFFC98A1B)),
            const SizedBox(width: 14),
            _stat('Suspended', '12', Icons.block_outlined, const Color(0xFFC0392B)),
          ]),
          const SizedBox(height: 20),
          Expanded(child: _table(tenants)),
        ]),
      ),
    );
  }

  Widget _table(List<List<String>> rows) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: _border)),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor: MaterialStateProperty.all(const Color(0xFFF0F4FA)),
          headingTextStyle: const TextStyle(color: _navy, fontWeight: FontWeight.bold),
          columns: const [
            DataColumn(label: Text('Tenant')),
            DataColumn(label: Text('Plan')),
            DataColumn(label: Text('Start Date')),
            DataColumn(label: Text('Renewal Date')),
            DataColumn(label: Text('Status')),
          ],
          rows: rows.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
        ),
      ),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: _border)),
        child: Row(children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: color.withOpacity(0.12), borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: const TextStyle(color: Colors.black54, fontSize: 12)),
              Text(value, style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: _navy)),
            ]),
          ),
        ]),
      ),
    );
  }
}
