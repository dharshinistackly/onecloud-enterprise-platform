import 'package:flutter/material.dart';

class EtlDataSyncPage extends StatelessWidget {
  const EtlDataSyncPage({super.key});

  @override
  Widget build(BuildContext context) {
    final jobs = [
      ['Nightly Orders Sync', 'MySQL - Orders', 'Snowflake', '11:00 PM', 'Success'],
      ['CRM Contacts Sync', 'Salesforce', 'PostgreSQL', '6:00 AM', 'Success'],
      ['Inventory Feed', 'SAP ERP', 'Data Lake', '2:00 AM', 'Running'],
      ['Marketing Events ETL', 'Segment', 'BigQuery', '4:00 AM', 'Failed'],
      ['Finance Ledger Sync', 'QuickBooks', 'Snowflake', '1:00 AM', 'Success'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),title: const Text('ETL & Data Sync'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('ETL & Data Sync', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Track extract-transform-load jobs and data synchronization runs.'),
          const SizedBox(height: 20),
          Row(children: [
            _stat('Total Jobs', '40', Icons.sync_outlined, Colors.blue),
            const SizedBox(width: 14),
            _stat('Successful', '33', Icons.check_circle_outline, Colors.green),
            const SizedBox(width: 14),
            _stat('Running', '4', Icons.autorenew, Colors.indigo),
            const SizedBox(width: 14),
            _stat('Failed', '3', Icons.error_outline, Colors.red),
          ]),
          const SizedBox(height: 20),
          Expanded(child: Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('Job Name')),
              DataColumn(label: Text('Source System')),
              DataColumn(label: Text('Destination')),
              DataColumn(label: Text('Last Run')),
              DataColumn(label: Text('Status')),
            ],
            rows: jobs.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          )))),
        ]),
      ),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return Expanded(child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
