import 'package:flutter/material.dart';

class DataExplorationPage extends StatelessWidget {
  const DataExplorationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final datasets = [
      ['Customer Transactions', 'Sales DB', '2.4M', '2 hrs ago', 'Arun Kumar'],
      ['Support Tickets', 'Support DB', '860K', '5 hrs ago', 'Priya Sharma'],
      ['Employee Records', 'HR DB', '12K', '1 day ago', 'Sneha Iyer'],
      ['Inventory Movements', 'ERP DB', '1.1M', '3 hrs ago', 'Rahul Menon'],
      ['Marketing Campaign Data', 'CRM DB', '340K', '6 hrs ago', 'Vikram Rao'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(title: const Text('Data Exploration'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Data Exploration', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Explore raw datasets across connected data sources.'),
          const SizedBox(height: 20),
          Row(children: [
            _stat('Datasets Explored', '46', Icons.dataset_outlined, const Color(0xFF0F3D66)),
            const SizedBox(width: 14),
            _stat('Active Queries', '9', Icons.query_stats_outlined, Colors.blue),
            const SizedBox(width: 14),
            _stat('Avg Query Time', '1.8s', Icons.speed_outlined, Colors.teal),
            const SizedBox(width: 14),
            _stat('Data Sources', '7', Icons.storage_outlined, Colors.indigo),
          ]),
          const SizedBox(height: 20),
          Expanded(child: Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('Dataset')),
              DataColumn(label: Text('Source')),
              DataColumn(label: Text('Rows')),
              DataColumn(label: Text('Last Explored')),
              DataColumn(label: Text('Explored By')),
            ],
            rows: datasets.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          )))),
        ]),
      ),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return Expanded(child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
