import 'package:flutter/material.dart';

class AdhocReportsPage extends StatelessWidget {
  const AdhocReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final reports = [
      ['Q3 Regional Sales Breakdown', 'Arun Kumar', 'Sales DB', '05 Sep 2026', 'Shared'],
      ['Support Ticket Aging', 'Priya Sharma', 'Support DB', '04 Sep 2026', 'Private'],
      ['Vendor Payment Delay Analysis', 'Rahul Menon', 'Finance DB', '03 Sep 2026', 'Shared'],
      ['New Hire Onboarding Time', 'Sneha Iyer', 'HR DB', '02 Sep 2026', 'Private'],
      ['Churned Accounts Deep Dive', 'Vikram Rao', 'CRM DB', '06 Sep 2026', 'Shared'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(title: const Text('Ad-hoc Reports'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Ad-hoc Reports', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Custom, user-created reports built on demand.'),
          const SizedBox(height: 20),
          Row(children: [
            _stat('Total Ad-hoc Reports', '87', Icons.article_outlined, const Color(0xFF0F3D66)),
            const SizedBox(width: 14),
            _stat('Created This Week', '12', Icons.add_chart_outlined, Colors.green),
            const SizedBox(width: 14),
            _stat('Shared Reports', '34', Icons.share_outlined, Colors.blue),
            const SizedBox(width: 14),
            _stat('Active Users', '21', Icons.people_outline, Colors.purple),
          ]),
          const SizedBox(height: 20),
          Expanded(child: Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('Report Name')),
              DataColumn(label: Text('Created By')),
              DataColumn(label: Text('Data Source')),
              DataColumn(label: Text('Created On')),
              DataColumn(label: Text('Status')),
            ],
            rows: reports.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          )))),
        ]),
      ),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return Expanded(child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
