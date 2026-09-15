import 'package:flutter/material.dart';

class BudgetingPage extends StatelessWidget {
  const BudgetingPage({super.key});

  static const _navy = Color(0xFF0A1F44);
  static const _bg = Color(0xFFF6F8FC);
  static const _border = Color(0xFFE7ECF3);

  @override
  Widget build(BuildContext context) {
    final budgets = [
      ['Marketing', 'FY 2026-27', '₹20,00,000', '₹14,20,000', 'On Track'],
      ['Operations', 'FY 2026-27', '₹45,00,000', '₹41,80,000', 'Near Limit'],
      ['R&D', 'FY 2026-27', '₹30,00,000', '₹18,50,000', 'On Track'],
      ['HR & Admin', 'FY 2026-27', '₹15,00,000', '₹16,10,000', 'Exceeded'],
      ['IT Infrastructure', 'FY 2026-27', '₹12,00,000', '₹7,40,000', 'On Track'],
    ];

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),
        title: const Text('Budgeting'),
        backgroundColor: _navy,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Budgeting', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: _navy)),
          const Text('Plan and monitor departmental budgets.', style: TextStyle(color: Colors.black54)),
          const SizedBox(height: 20),
          Row(children: [
            _stat('Total Budget', '₹1.22Cr', Icons.account_balance_wallet_outlined, _navy),
            const SizedBox(width: 14),
            _stat('On Track', '3', Icons.check_circle_outline, const Color(0xFF1E8E5A)),
            const SizedBox(width: 14),
            _stat('Near Limit', '1', Icons.trending_up_outlined, const Color(0xFFC98A1B)),
            const SizedBox(width: 14),
            _stat('Exceeded', '1', Icons.error_outline, const Color(0xFFC0392B)),
          ]),
          const SizedBox(height: 20),
          Expanded(child: _table(budgets)),
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
            DataColumn(label: Text('Department')),
            DataColumn(label: Text('Period')),
            DataColumn(label: Text('Allocated')),
            DataColumn(label: Text('Spent')),
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
