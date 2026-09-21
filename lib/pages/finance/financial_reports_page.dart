import 'package:flutter/material.dart';

class FinancialReportsPage extends StatelessWidget {
  const FinancialReportsPage({super.key});

  static const _navy = Color(0xFF0A1F44);
  static const _bg = Color(0xFFF6F8FC);
  static const _border = Color(0xFFE7ECF3);

  @override
  Widget build(BuildContext context) {
    final reports = [
      ['Profit & Loss Statement', 'Monthly', 'August 2026', '10 Sep 2026', 'Ready'],
      ['Balance Sheet', 'Quarterly', 'Q1 FY26-27', '05 Sep 2026', 'Ready'],
      ['Cash Flow Statement', 'Monthly', 'August 2026', '10 Sep 2026', 'Ready'],
      ['Trial Balance', 'Monthly', 'September 2026', '-', 'Generating'],
      ['Annual Report Draft', 'Yearly', 'FY 2025-26', '30 Aug 2026', 'Under Review'],
    ];

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),
        title: const Text('Financial Reports'),
        backgroundColor: _navy,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Financial Reports', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: _navy)),
          const Text('Generate and review key financial statements.', style: TextStyle(color: Colors.black54)),
          const SizedBox(height: 20),
          Wrap(
            spacing: 14,
            runSpacing: 14,
            children: [
            _stat('Total Reports', '86', Icons.bar_chart_outlined, _navy),
            _stat('Ready', '71', Icons.check_circle_outline, const Color(0xFF1E8E5A)),
            _stat('Generating', '9', Icons.autorenew, const Color(0xFFC98A1B)),
            _stat('Under Review', '6', Icons.rate_review_outlined, const Color(0xFF6C4EB6)),
          ]),
          const SizedBox(height: 20),
          _table(reports),
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
            DataColumn(label: Text('Report')),
            DataColumn(label: Text('Frequency')),
            DataColumn(label: Text('Period')),
            DataColumn(label: Text('Generated On')),
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
