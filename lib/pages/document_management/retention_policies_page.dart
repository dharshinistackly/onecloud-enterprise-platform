import 'package:flutter/material.dart';

class RetentionPoliciesPage extends StatelessWidget {
  const RetentionPoliciesPage({super.key});

  static const _navy = Color(0xFF0A1F44);
  static const _bg = Color(0xFFF6F8FC);
  static const _border = Color(0xFFE7ECF3);

  @override
  Widget build(BuildContext context) {
    final policies = [
      ['Financial Records', '7 years', '1,240 files', '10 Sep 2026', 'Active'],
      ['HR Records', '5 years', '860 files', '20 Aug 2026', 'Active'],
      ['Vendor Contracts', '10 years', '412 files', '05 Sep 2026', 'Active'],
      ['Marketing Assets', '2 years', '2,180 files', '01 Sep 2026', 'Active'],
      ['Legacy System Logs', '1 year', '5,600 files', '15 Jun 2026', 'Expiring Soon'],
    ];

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        title: const Text('Retention Policies'),
        backgroundColor: _navy,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Retention Policies', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: _navy)),
          const Text('Define how long documents are kept before archival.', style: TextStyle(color: Colors.black54)),
          const SizedBox(height: 20),
          Row(children: [
            _stat('Total Policies', '18', Icons.policy_outlined, _navy),
            const SizedBox(width: 14),
            _stat('Active', '15', Icons.check_circle_outline, const Color(0xFF1E8E5A)),
            const SizedBox(width: 14),
            _stat('Expiring Soon', '2', Icons.timelapse_outlined, const Color(0xFFC98A1B)),
            const SizedBox(width: 14),
            _stat('Archived', '1', Icons.archive_outlined, const Color(0xFF6C4EB6)),
          ]),
          const SizedBox(height: 20),
          Expanded(child: _table(policies)),
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
            DataColumn(label: Text('Policy Name')),
            DataColumn(label: Text('Retention Period')),
            DataColumn(label: Text('Applies To')),
            DataColumn(label: Text('Last Reviewed')),
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
