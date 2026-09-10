import 'package:flutter/material.dart';

class MultiCurrencyPage extends StatelessWidget {
  const MultiCurrencyPage({super.key});

  static const _navy = Color(0xFF0A1F44);
  static const _bg = Color(0xFFF6F8FC);
  static const _border = Color(0xFFE7ECF3);

  @override
  Widget build(BuildContext context) {
    final rates = [
      ['USD', 'US Dollar', '₹83.42', '+0.12%', 'Updated'],
      ['EUR', 'Euro', '₹90.15', '-0.08%', 'Updated'],
      ['GBP', 'British Pound', '₹105.60', '+0.21%', 'Updated'],
      ['AED', 'UAE Dirham', '₹22.72', '0.00%', 'Updated'],
      ['SGD', 'Singapore Dollar', '₹61.30', '-0.15%', 'Stale'],
    ];

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        title: const Text('Multi-Currency'),
        backgroundColor: _navy,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Multi-Currency Management', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: _navy)),
          const Text('Manage exchange rates across global transactions.', style: TextStyle(color: Colors.black54)),
          const SizedBox(height: 20),
          Row(children: [
            _stat('Currencies Tracked', '12', Icons.currency_exchange_outlined, _navy),
            const SizedBox(width: 14),
            _stat('Updated Today', '10', Icons.check_circle_outline, const Color(0xFF1E8E5A)),
            const SizedBox(width: 14),
            _stat('Rate Rising', '5', Icons.trending_up_outlined, const Color(0xFF2E6DB4)),
            const SizedBox(width: 14),
            _stat('Stale Rates', '2', Icons.warning_amber_outlined, const Color(0xFFC98A1B)),
          ]),
          const SizedBox(height: 20),
          Expanded(child: _table(rates)),
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
            DataColumn(label: Text('Code')),
            DataColumn(label: Text('Currency')),
            DataColumn(label: Text('Rate (INR)')),
            DataColumn(label: Text('Change')),
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
