import 'package:flutter/material.dart';

class TaxManagementPage extends StatelessWidget {
  const TaxManagementPage({super.key});

  static const _navy = Color(0xFF0A1F44);
  static const _bg = Color(0xFFF6F8FC);
  static const _border = Color(0xFFE7ECF3);

  @override
  Widget build(BuildContext context) {
    final filings = [
      ['GST-Aug26', 'GSTR-3B', 'August 2026', '₹1,85,000', 'Filed'],
      ['GST-Jul26', 'GSTR-1', 'July 2026', '₹2,10,000', 'Filed'],
      ['TDS-Q1', 'TDS Return', 'Q1 FY26-27', '₹64,500', 'Filed'],
      ['GST-Sep26', 'GSTR-3B', 'September 2026', '₹1,95,000', 'Pending'],
      ['IT-FY25', 'Income Tax', 'FY 2025-26', '₹8,40,000', 'Under Review'],
    ];

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        title: const Text('Tax Management'),
        backgroundColor: _navy,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Tax Management', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: _navy)),
          const Text('Manage GST, TDS and income tax filings.', style: TextStyle(color: Colors.black54)),
          const SizedBox(height: 20),
          Row(children: [
            _stat('Total Filings', '52', Icons.description_outlined, _navy),
            const SizedBox(width: 14),
            _stat('Filed', '44', Icons.check_circle_outline, const Color(0xFF1E8E5A)),
            const SizedBox(width: 14),
            _stat('Pending', '6', Icons.schedule_outlined, const Color(0xFFC98A1B)),
            const SizedBox(width: 14),
            _stat('Under Review', '2', Icons.fact_check_outlined, const Color(0xFF6C4EB6)),
          ]),
          const SizedBox(height: 20),
          Expanded(child: _table(filings)),
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
            DataColumn(label: Text('Filing ID')),
            DataColumn(label: Text('Type')),
            DataColumn(label: Text('Period')),
            DataColumn(label: Text('Amount')),
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
