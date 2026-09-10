import 'package:flutter/material.dart';

class RevenueRecognitionPage extends StatelessWidget {
  const RevenueRecognitionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final contracts = [
      ['TechNova Solutions', 'Straight-Line', '₹10,20,000', '₹2,20,000', 'Compliant'],
      ['CloudWorks Pvt Ltd', 'Milestone-Based', '₹6,40,000', '₹2,35,000', 'Compliant'],
      ['DataBridge Systems', 'Straight-Line', '₹4,80,000', '₹40,000', 'Compliant'],
      ['InnoSoft Labs', 'Usage-Based', '₹2,10,000', '₹1,00,000', 'Under Review'],
      ['NextGen Retail', 'Straight-Line', '₹8,50,000', '₹1,10,000', 'Compliant'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(title: const Text('Revenue Recognition'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Revenue Recognition', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Track recognized and deferred revenue in line with compliance standards.'),
          const SizedBox(height: 20),
          Row(children: [
            _stat('Recognized Revenue', '₹32.0L', Icons.check_circle_outline, const Color(0xFF0F3D66)),
            const SizedBox(width: 14),
            _stat('Deferred Revenue', '₹7.05L', Icons.hourglass_bottom_outlined, Colors.orange),
            const SizedBox(width: 14),
            _stat('Pending Recognition', '₹1.2L', Icons.pending_actions_outlined, Colors.red),
            const SizedBox(width: 14),
            _stat('Compliance Rate', '96%', Icons.gavel_outlined, Colors.green),
          ]),
          const SizedBox(height: 20),
          Expanded(child: Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('Contract')),
              DataColumn(label: Text('Recognition Method')),
              DataColumn(label: Text('Recognized Amount')),
              DataColumn(label: Text('Deferred Amount')),
              DataColumn(label: Text('Status')),
            ],
            rows: contracts.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          )))),
        ]),
      ),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return Expanded(child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
