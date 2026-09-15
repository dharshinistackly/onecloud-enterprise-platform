import 'package:flutter/material.dart';

class PolicyManagementPage extends StatelessWidget {
  const PolicyManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    final policies = [
      ['Password Policy', 'Access Control', 'IT Security', '5 days ago', 'Active'],
      ['Data Classification Policy', 'Data Governance', 'Compliance Team', '2 weeks ago', 'Active'],
      ['Remote Access Policy', 'Access Control', 'IT Security', '1 month ago', 'Under Review'],
      ['Incident Response Policy', 'Security Ops', 'Security Team', '3 months ago', 'Active'],
      ['Vendor Risk Policy', 'Third-Party Risk', 'Legal Team', '11 months ago', 'Expiring Soon'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),title: const Text('Policy Management'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Policy Management', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Define, review, and maintain organizational security policies.'),
          const SizedBox(height: 20),
          Row(children: [
            _stat('Total Policies', '31', Icons.gavel_outlined, Colors.blue),
            const SizedBox(width: 14),
            _stat('Active', '25', Icons.check_circle_outline, Colors.green),
            const SizedBox(width: 14),
            _stat('Under Review', '4', Icons.rate_review_outlined, Colors.indigo),
            const SizedBox(width: 14),
            _stat('Expiring Soon', '2', Icons.warning_amber_outlined, Colors.orange),
          ]),
          const SizedBox(height: 20),
          Expanded(child: Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('Policy Name')),
              DataColumn(label: Text('Category')),
              DataColumn(label: Text('Owner')),
              DataColumn(label: Text('Last Updated')),
              DataColumn(label: Text('Status')),
            ],
            rows: policies.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          )))),
        ]),
      ),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return Expanded(child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
