import 'package:flutter/material.dart';

class UsageAnalyticsPage extends StatelessWidget {
  const UsageAnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final usage = [
      ['TechNova Solutions', 'API Calls', '1,24,500', '2 hrs ago', 'Enterprise'],
      ['CloudWorks Pvt Ltd', 'Storage', '840 GB', '5 hrs ago', 'Enterprise'],
      ['DataBridge Systems', 'Active Seats', '312', '1 day ago', 'Business'],
      ['InnoSoft Labs', 'API Calls', '18,200', '3 days ago', 'Business'],
      ['NextGen Retail', 'Storage', '410 GB', '6 hrs ago', 'Enterprise'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(title: const Text('Usage Analytics'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Usage Analytics', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Track product usage and feature adoption across accounts.'),
          const SizedBox(height: 20),
          Row(children: [
            _stat('Active Users', '2,840', Icons.people_outline, const Color(0xFF0F3D66)),
            const SizedBox(width: 14),
            _stat('Total Sessions', '18,920', Icons.timeline_outlined, Colors.blue),
            const SizedBox(width: 14),
            _stat('Avg Session', '14m 20s', Icons.timer_outlined, Colors.purple),
            const SizedBox(width: 14),
            _stat('Feature Adoption', '76%', Icons.extension_outlined, Colors.green),
          ]),
          const SizedBox(height: 20),
          Expanded(child: Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('Account')),
              DataColumn(label: Text('Feature')),
              DataColumn(label: Text('Usage')),
              DataColumn(label: Text('Last Active')),
              DataColumn(label: Text('Plan')),
            ],
            rows: usage.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          )))),
        ]),
      ),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return Expanded(child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
