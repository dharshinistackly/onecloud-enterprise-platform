import 'package:flutter/material.dart';

class DataTransformationPage extends StatelessWidget {
  const DataTransformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pipelines = [
      ['Order Normalization', 'Orders DB', 'Data Warehouse', 'Every 15 min', 'Running'],
      ['Customer Enrichment', 'CRM API', 'Analytics Store', 'Hourly', 'Running'],
      ['Currency Conversion', 'Payments DB', 'Reporting DB', 'Daily', 'Scheduled'],
      ['Address Standardization', 'Shipping DB', 'Data Warehouse', 'Daily', 'Failed'],
      ['Product Catalog Merge', 'Inventory DB', 'Search Index', 'Every 30 min', 'Running'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),title: const Text('Data Transformation'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Data Transformation', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Manage pipelines that clean, map, and reshape data between systems.'),
          const SizedBox(height: 20),
          Wrap(
            spacing: 14,
            runSpacing: 14,
            children: [
            _stat('Total Pipelines', '22', Icons.transform_outlined, Colors.blue),
            _stat('Running', '17', Icons.play_circle_outline, Colors.green),
            _stat('Scheduled', '3', Icons.schedule_outlined, Colors.indigo),
            _stat('Failed', '2', Icons.error_outline, Colors.red),
          ]),
          const SizedBox(height: 20),
          Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('Pipeline Name')),
              DataColumn(label: Text('Source')),
              DataColumn(label: Text('Target')),
              DataColumn(label: Text('Schedule')),
              DataColumn(label: Text('Status')),
            ],
            rows: pipelines.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          ))),
        ]),
      )),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return SizedBox(width: 220, child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
