import 'package:flutter/material.dart';

class AuditTrailsPage extends StatelessWidget {
  const AuditTrailsPage({super.key});

  static const _navy = Color(0xFF0A1F44);
  static const _bg = Color(0xFFF6F8FC);
  static const _border = Color(0xFFE7ECF3);

  @override
  Widget build(BuildContext context) {
    final logs = [
      ['Vendor Agreement - SteelCorp.pdf', 'Edited', 'Sathish Raj', '10 Sep 2026, 09:40', 'Logged'],
      ['Q3 Financial Report.docx', 'Downloaded', 'Meena Raj', '10 Sep 2026, 08:15', 'Logged'],
      ['Employee Handbook.pdf', 'Shared', 'Priya Sharma', '09 Sep 2026, 17:20', 'Logged'],
      ['Legacy Payroll Data.xlsx', 'Access Revoked', 'System', '09 Sep 2026, 14:00', 'Logged'],
      ['Board Meeting Minutes.pdf', 'Deleted Attempt', 'Unknown User', '08 Sep 2026, 23:05', 'Flagged'],
    ];

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        title: const Text('Audit Trails'),
        backgroundColor: _navy,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Audit Trails', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: _navy)),
          const Text('Complete log of document activity and access.', style: TextStyle(color: Colors.black54)),
          const SizedBox(height: 20),
          Row(children: [
            _stat('Total Events', '9,420', Icons.receipt_long_outlined, _navy),
            const SizedBox(width: 14),
            _stat('Logged', '9,381', Icons.check_circle_outline, const Color(0xFF1E8E5A)),
            const SizedBox(width: 14),
            _stat('Flagged', '32', Icons.flag_outlined, const Color(0xFFC98A1B)),
            const SizedBox(width: 14),
            _stat('Suspicious', '7', Icons.gpp_maybe_outlined, const Color(0xFFC0392B)),
          ]),
          const SizedBox(height: 20),
          Expanded(child: _table(logs)),
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
            DataColumn(label: Text('File Name')),
            DataColumn(label: Text('Action')),
            DataColumn(label: Text('User')),
            DataColumn(label: Text('Timestamp')),
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
