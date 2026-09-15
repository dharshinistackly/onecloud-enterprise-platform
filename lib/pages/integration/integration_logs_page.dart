import 'package:flutter/material.dart';

class IntegrationLogsPage extends StatelessWidget {
  const IntegrationLogsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logs = [
      ['09:41:12', 'Salesforce', 'Contact Sync', 'INFO', 'Synced 240 records'],
      ['09:38:05', 'Payments API', 'Webhook Delivery', 'ERROR', 'Timeout after 30s'],
      ['09:30:47', 'ETL Job', 'Nightly Orders Sync', 'INFO', 'Completed successfully'],
      ['09:22:19', 'Slack', 'Message Post', 'WARNING', 'Rate limit approaching'],
      ['09:15:03', 'S3 Connector', 'File Upload', 'INFO', 'Uploaded 12 files'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),title: const Text('Integration Logs'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Integration Logs', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Review activity, errors, and warnings across all integrations.'),
          const SizedBox(height: 20),
          Row(children: [
            _stat('Logs Today', '3,482', Icons.receipt_long_outlined, Colors.blue),
            const SizedBox(width: 14),
            _stat('Errors', '17', Icons.error_outline, Colors.red),
            const SizedBox(width: 14),
            _stat('Warnings', '42', Icons.warning_amber_outlined, Colors.orange),
            const SizedBox(width: 14),
            _stat('Success Rate', '98.3%', Icons.verified_outlined, Colors.green),
          ]),
          const SizedBox(height: 20),
          Expanded(child: Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('Timestamp')),
              DataColumn(label: Text('Integration')),
              DataColumn(label: Text('Event')),
              DataColumn(label: Text('Level')),
              DataColumn(label: Text('Message')),
            ],
            rows: logs.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          )))),
        ]),
      ),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return Expanded(child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
