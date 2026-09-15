import 'package:flutter/material.dart';

class AssetManagementPage extends StatelessWidget {
  const AssetManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    final assets = [
      ['AST-101', 'CNC Machine M1', 'Machinery', 'Plant A', 'Active'],
      ['AST-102', 'Forklift F-4', 'Vehicle', 'Warehouse B', 'Active'],
      ['AST-103', 'Server Rack SR-2', 'IT Equipment', 'Office HQ', 'Under Repair'],
      ['AST-104', 'Conveyor Belt CB-7', 'Machinery', 'Plant A', 'Active'],
      ['AST-105', 'Generator G-3', 'Utility', 'Plant B', 'Retired'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),title: const Text('Asset Management'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Asset Management', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Track company assets, location and condition.'),
          const SizedBox(height: 20),
          Row(children: [
            _stat('Total Assets', '186', Icons.apartment_outlined, Colors.blue),
            const SizedBox(width: 14),
            _stat('Active', '154', Icons.check_circle_outline, Colors.green),
            const SizedBox(width: 14),
            _stat('Under Repair', '19', Icons.build_outlined, Colors.orange),
            const SizedBox(width: 14),
            _stat('Retired', '13', Icons.remove_circle_outline, Colors.red),
          ]),
          const SizedBox(height: 20),
          Expanded(child: Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('Asset ID')),
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Category')),
              DataColumn(label: Text('Location')),
              DataColumn(label: Text('Status')),
            ],
            rows: assets.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          )))),
        ]),
      ),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return Expanded(child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
