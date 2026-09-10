import 'package:flutter/material.dart';

class VersioningPage extends StatelessWidget {
  const VersioningPage({super.key});

  static const _navy = Color(0xFF0A1F44);
  static const _bg = Color(0xFFF6F8FC);
  static const _border = Color(0xFFE7ECF3);

  @override
  Widget build(BuildContext context) {
    final versions = [
      ['Vendor Agreement - SteelCorp.pdf', 'v4', 'Sathish Raj', '05 Sep 2026', 'Current'],
      ['Employee Handbook.pdf', 'v3', 'Priya Sharma', '20 Aug 2026', 'Current'],
      ['Employee Handbook.pdf', 'v2', 'Priya Sharma', '02 Jul 2026', 'Superseded'],
      ['Product Spec - Motor Unit.xlsx', 'v6', 'Arun Vel', '28 Aug 2026', 'Current'],
      ['Board Meeting Minutes.pdf', 'v1', 'Meena Raj', '01 Sep 2026', 'Current'],
    ];

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        title: const Text('Versioning'),
        backgroundColor: _navy,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Document Versioning', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: _navy)),
          const Text('Track revision history and version control.', style: TextStyle(color: Colors.black54)),
          const SizedBox(height: 20),
          Row(children: [
            _stat('Versioned Files', '842', Icons.history_outlined, _navy),
            const SizedBox(width: 14),
            _stat('Current', '842', Icons.check_circle_outline, const Color(0xFF1E8E5A)),
            const SizedBox(width: 14),
            _stat('Superseded', '1,960', Icons.restore_outlined, const Color(0xFFC98A1B)),
            const SizedBox(width: 14),
            _stat('Conflicts', '3', Icons.warning_amber_outlined, const Color(0xFFC0392B)),
          ]),
          const SizedBox(height: 20),
          Expanded(child: _table(versions)),
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
            DataColumn(label: Text('Version')),
            DataColumn(label: Text('Modified By')),
            DataColumn(label: Text('Date')),
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
