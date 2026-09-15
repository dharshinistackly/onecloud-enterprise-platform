import 'package:flutter/material.dart';

class LicenseAllocationPage extends StatelessWidget {
  const LicenseAllocationPage({super.key});

  static const _navy = Color(0xFF0A1F44);
  static const _bg = Color(0xFFF6F8FC);
  static const _border = Color(0xFFE7ECF3);

  @override
  Widget build(BuildContext context) {
    final allocations = [
      ['TechNova Solutions', 'Enterprise', '200 licenses', '186 assigned', 'Active'],
      ['CloudWorks Pvt Ltd', 'Business', '25 licenses', '25 assigned', 'Fully Allocated'],
      ['NextGen Retail', 'Business', '25 licenses', '18 assigned', 'Active'],
      ['InnoSoft Labs', 'Starter', '5 licenses', '5 assigned', 'Fully Allocated'],
      ['DataBridge Systems', 'Enterprise', '200 licenses', '48 assigned', 'Active'],
    ];

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),
        title: const Text('License Allocation'),
        backgroundColor: _navy,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('License Allocation', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: _navy)),
          const Text('Distribute and track seat allocation per tenant.', style: TextStyle(color: Colors.black54)),
          const SizedBox(height: 20),
          Row(children: [
            _stat('Total Licenses', '1,842', Icons.badge_outlined, _navy),
            const SizedBox(width: 14),
            _stat('Assigned', '1,340', Icons.check_circle_outline, const Color(0xFF1E8E5A)),
            const SizedBox(width: 14),
            _stat('Unassigned', '502', Icons.person_outline, const Color(0xFF2E6DB4)),
            const SizedBox(width: 14),
            _stat('Fully Allocated', '38', Icons.done_all_outlined, const Color(0xFFC98A1B)),
          ]),
          const SizedBox(height: 20),
          Expanded(child: _table(allocations)),
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
            DataColumn(label: Text('Total Licenses')),
            DataColumn(label: Text('Assigned')),
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
