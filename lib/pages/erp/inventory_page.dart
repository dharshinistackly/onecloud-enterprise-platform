import 'package:flutter/material.dart';

class InventoryPage extends StatelessWidget {
  const InventoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      ['Steel Rod 12mm', 'Raw Material', 'Warehouse A', '1,240 units', 'In Stock'],
      ['Hydraulic Pump HP-200', 'Component', 'Warehouse B', '38 units', 'Low Stock'],
      ['Circuit Board CB-45', 'Electronics', 'Warehouse A', '560 units', 'In Stock'],
      ['Packaging Box L', 'Packaging', 'Warehouse C', '0 units', 'Out of Stock'],
      ['Lubricant Oil 5L', 'Consumable', 'Warehouse B', '210 units', 'In Stock'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),title: const Text('Inventory'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Inventory Management', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Track stock levels across all warehouses.'),
          const SizedBox(height: 20),
          Wrap(
            spacing: 14,
            runSpacing: 14,
            children: [
            _stat('Total Items', '312', Icons.inventory_2_outlined, Colors.blue),
            _stat('In Stock', '268', Icons.check_circle_outline, Colors.green),
            _stat('Low Stock', '31', Icons.warning_amber_outlined, Colors.orange),
            _stat('Out of Stock', '13', Icons.remove_circle_outline, Colors.red),
          ]),
          const SizedBox(height: 20),
          Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('Item')),
              DataColumn(label: Text('Category')),
              DataColumn(label: Text('Warehouse')),
              DataColumn(label: Text('Stock')),
              DataColumn(label: Text('Status')),
            ],
            rows: items.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          ))),
        ]),
      )),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return SizedBox(width: 220, child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
