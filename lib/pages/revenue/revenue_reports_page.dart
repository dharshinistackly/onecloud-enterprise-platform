import 'package:flutter/material.dart';

class RevenueReportsPage extends StatelessWidget {
  const RevenueReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final reports = [
      ['Monthly Revenue Summary', 'Summary', 'Aug 2026', '01 Sep 2026', 'Generated'],
      ['Quarterly Growth Report', 'Growth', 'Q2 2026', '05 Jul 2026', 'Generated'],
      ['Account-wise Revenue', 'Detailed', 'Aug 2026', '02 Sep 2026', 'Generated'],
      ['Churn & Retention Report', 'Retention', 'Aug 2026', 'Scheduled', 'Pending'],
      ['Annual Revenue Statement', 'Annual', 'FY 2025-26', '10 Apr 2026', 'Generated'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),title: const Text('Revenue Reports'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Revenue Reports', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Generate and review revenue reports across periods.'),
          const SizedBox(height: 20),
          Wrap(
            spacing: 14,
            runSpacing: 14,
            children: [
            _stat('Total Reports', '32', Icons.description_outlined, const Color(0xFF0F3D66)),
            _stat('Scheduled', '4', Icons.schedule_outlined, Colors.orange),
            _stat('Last Generated', 'Today', Icons.event_available_outlined, Colors.green),
            _stat('Export Formats', '3', Icons.file_download_outlined, Colors.indigo),
          ]),
          const SizedBox(height: 20),
          Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('Report Name')),
              DataColumn(label: Text('Type')),
              DataColumn(label: Text('Period')),
              DataColumn(label: Text('Generated On')),
              DataColumn(label: Text('Status')),
            ],
            rows: reports.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          ))),
        ]),
      )),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return SizedBox(width: 220, child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
