import 'package:flutter/material.dart';

class RevenueTrackingPage extends StatelessWidget {
  const RevenueTrackingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final streams = [
      ['TechNova Solutions', 'Subscription', '₹12,40,000', 'Monthly', 'Active'],
      ['CloudWorks Pvt Ltd', 'Subscription', '₹8,75,000', 'Monthly', 'Active'],
      ['DataBridge Systems', 'Usage-Based', '₹5,20,000', 'Monthly', 'Active'],
      ['InnoSoft Labs', 'One-Time', '₹3,10,000', 'Annual', 'Closed'],
      ['NextGen Retail', 'Subscription', '₹9,60,000', 'Monthly', 'Active'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),title: const Text('Revenue Tracking'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Revenue Tracking', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Monitor revenue streams across all accounts in real time.'),
          const SizedBox(height: 20),
          Wrap(
            spacing: 14,
            runSpacing: 14,
            children: [
            _stat('Total Revenue', '₹39.05L', Icons.currency_rupee, const Color(0xFF0F3D66)),
            _stat('MRR', '₹30.75L', Icons.trending_up, Colors.teal),
            _stat('ARR', '₹3.69Cr', Icons.calendar_today_outlined, Colors.indigo),
            _stat('Growth Rate', '+14.2%', Icons.show_chart, Colors.orange),
          ]),
          const SizedBox(height: 20),
          Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('Account')),
              DataColumn(label: Text('Revenue Stream')),
              DataColumn(label: Text('Amount')),
              DataColumn(label: Text('Frequency')),
              DataColumn(label: Text('Status')),
            ],
            rows: streams.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          ))),
        ]),
      )),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return SizedBox(width: 220, child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
