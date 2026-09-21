import 'package:flutter/material.dart';

class PlansFeaturesPage extends StatelessWidget {
  const PlansFeaturesPage({super.key});

  static const _navy = Color(0xFF0A1F44);
  static const _bg = Color(0xFFF6F8FC);
  static const _border = Color(0xFFE7ECF3);

  @override
  Widget build(BuildContext context) {
    final plans = [
      ['Starter', '₹4,999/mo', '5 users, 10 GB storage', '82 tenants', 'Active'],
      ['Business', '₹14,999/mo', '25 users, 100 GB storage', '146 tenants', 'Active'],
      ['Enterprise', '₹39,999/mo', 'Unlimited users, 1 TB storage', '58 tenants', 'Active'],
      ['Legacy Pro', '₹9,999/mo', '15 users, 50 GB storage', '12 tenants', 'Deprecated'],
      ['Custom - GlobalTech', '₹65,000/mo', 'Negotiated SLA & storage', '1 tenant', 'Active'],
    ];

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),
        title: const Text('Plans & Features'),
        backgroundColor: _navy,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Plans & Features', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: _navy)),
          const Text('Manage subscription plans and their feature sets.', style: TextStyle(color: Colors.black54)),
          const SizedBox(height: 20),
          Wrap(
            spacing: 14,
            runSpacing: 14,
            children: [
            _stat('Total Plans', '9', Icons.dashboard_outlined, _navy),
            _stat('Active', '7', Icons.check_circle_outline, const Color(0xFF1E8E5A)),
            _stat('Deprecated', '2', Icons.archive_outlined, const Color(0xFFC98A1B)),
            _stat('Total Tenants', '299', Icons.apartment_outlined, const Color(0xFF2E6DB4)),
          ]),
          const SizedBox(height: 20),
          _table(plans),
        ]),
      )),
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
            DataColumn(label: Text('Plan')),
            DataColumn(label: Text('Price')),
            DataColumn(label: Text('Features')),
            DataColumn(label: Text('Tenants')),
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
