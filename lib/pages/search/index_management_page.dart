import 'package:flutter/material.dart';

class IndexManagementPage extends StatelessWidget {
  const IndexManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    final indices = [
      ['products_v3', '842,120', '4.2 GB', '5', 'Healthy'],
      ['customers_v2', '318,900', '1.6 GB', '3', 'Healthy'],
      ['orders_v4', '1,204,330', '6.8 GB', '6', 'Healthy'],
      ['support_tickets_v1', '96,410', '540 MB', '2', 'Optimizing'],
      ['legacy_docs_v1', '54,220', '310 MB', '1', 'Deprecated'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),title: const Text('Index Management'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Index Management', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('View and maintain search indices and their health.'),
          const SizedBox(height: 20),
          Row(children: [
            _stat('Total Indices', '9', Icons.dns_outlined, Colors.blue),
            const SizedBox(width: 14),
            _stat('Healthy', '7', Icons.check_circle_outline, Colors.green),
            const SizedBox(width: 14),
            _stat('Documents Indexed', '2.5M', Icons.description_outlined, Colors.indigo),
            const SizedBox(width: 14),
            _stat('Storage Used', '13.5 GB', Icons.storage_outlined, Colors.orange),
          ]),
          const SizedBox(height: 20),
          Expanded(child: Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('Index Name')),
              DataColumn(label: Text('Documents')),
              DataColumn(label: Text('Size')),
              DataColumn(label: Text('Shards')),
              DataColumn(label: Text('Status')),
            ],
            rows: indices.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          )))),
        ]),
      ),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return Expanded(child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
