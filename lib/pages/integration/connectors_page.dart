import 'package:flutter/material.dart';

class ConnectorsPage extends StatelessWidget {
  const ConnectorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final connectors = [
      ['PostgreSQL Connector', 'Database', 'v4.2', 'Debezium', 'Active'],
      ['REST API Connector', 'API', 'v2.0', 'Internal', 'Active'],
      ['S3 File Connector', 'Storage', 'v1.6', 'AWS', 'Active'],
      ['SFTP Connector', 'File Transfer', 'v1.1', 'Internal', 'Deprecated'],
      ['Kafka Connector', 'Streaming', 'v3.4', 'Confluent', 'Available'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),title: const Text('Connectors'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Connectors', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Manage source and sink connectors used across integrations.'),
          const SizedBox(height: 20),
          Row(children: [
            _stat('Total Connectors', '19', Icons.cable_outlined, Colors.blue),
            const SizedBox(width: 14),
            _stat('Active', '14', Icons.check_circle_outline, Colors.green),
            const SizedBox(width: 14),
            _stat('Available', '3', Icons.add_link_outlined, Colors.indigo),
            const SizedBox(width: 14),
            _stat('Deprecated', '2', Icons.warning_amber_outlined, Colors.orange),
          ]),
          const SizedBox(height: 20),
          Expanded(child: Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('Connector Name')),
              DataColumn(label: Text('Type')),
              DataColumn(label: Text('Version')),
              DataColumn(label: Text('Vendor')),
              DataColumn(label: Text('Status')),
            ],
            rows: connectors.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          )))),
        ]),
      ),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return Expanded(child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
