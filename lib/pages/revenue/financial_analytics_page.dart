import 'package:flutter/material.dart';

class FinancialAnalyticsPage extends StatelessWidget {
  const FinancialAnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final metrics = [
      ['Gross Margin', 'Profitability', '62%', '58%', '+4%'],
      ['Operating Cost', 'Expense', '₹18.5L', '₹19.8L', '-6.6%'],
      ['Net Profit', 'Profitability', '₹14.2L', '₹11.9L', '+19.3%'],
      ['EBITDA', 'Profitability', '₹16.8L', '₹15.1L', '+11.3%'],
      ['Customer Acquisition Cost', 'Expense', '₹8,400', '₹9,100', '-7.7%'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(title: const Text('Financial Analytics'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Financial Analytics', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Analyze margins, costs, and profitability trends.'),
          const SizedBox(height: 20),
          Row(children: [
            _stat('Gross Margin', '62%', Icons.pie_chart_outline, const Color(0xFF0F3D66)),
            const SizedBox(width: 14),
            _stat('Net Profit', '₹14.2L', Icons.savings_outlined, Colors.green),
            const SizedBox(width: 14),
            _stat('Operating Cost', '₹18.5L', Icons.request_quote_outlined, Colors.red),
            const SizedBox(width: 14),
            _stat('EBITDA', '₹16.8L', Icons.bar_chart_outlined, Colors.indigo),
          ]),
          const SizedBox(height: 20),
          Expanded(child: Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('Metric')),
              DataColumn(label: Text('Category')),
              DataColumn(label: Text('Current Period')),
              DataColumn(label: Text('Previous Period')),
              DataColumn(label: Text('Change')),
            ],
            rows: metrics.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          )))),
        ]),
      ),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return Expanded(child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
