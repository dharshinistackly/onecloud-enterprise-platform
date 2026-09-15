import 'package:flutter/material.dart';

class DataRetentionPage extends StatelessWidget {
  const DataRetentionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final policies = [
      ['Customer PII Retention', 'Personal Data', '24 months', '1 day ago', 'Active'],
      ['Transaction Logs', 'Financial Data', '7 years', '3 days ago', 'Active'],
      ['Support Tickets', 'Operational Data', '18 months', '1 week ago', 'Active'],
      ['Marketing Consent Records', 'Consent Data', '36 months', '2 weeks ago', 'Under Review'],
      ['Archived Employee Records', 'HR Data', '10 years', '1 month ago', 'Active'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),title: const Text('Data Retention'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Data Retention', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Manage retention schedules and automated purging of data.'),
          const SizedBox(height: 20),
          Row(children: [
            _stat('Total Policies', '14', Icons.folder_special_outlined, Colors.blue),
            const SizedBox(width: 14),
            _stat('Active Policies', '12', Icons.check_circle_outline, Colors.green),
            const SizedBox(width: 14),
            _stat('Records Purged (30d)', '84,210', Icons.delete_sweep_outlined, Colors.orange),
            const SizedBox(width: 14),
            _stat('Storage Reclaimed', '6.2 GB', Icons.storage_outlined, Colors.indigo),
          ]),
          const SizedBox(height: 20),
          Expanded(child: Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('Policy Name')),
              DataColumn(label: Text('Data Type')),
              DataColumn(label: Text('Retention Period')),
              DataColumn(label: Text('Last Enforced')),
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
