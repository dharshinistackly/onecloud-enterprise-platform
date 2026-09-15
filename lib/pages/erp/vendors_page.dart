import 'package:flutter/material.dart';

class VendorsPage extends StatelessWidget {
  const VendorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vendors = [
      ['SteelCorp Industries', 'Raw Material', 'Chennai', '4.6', 'Active'],
      ['ElectroParts Ltd', 'Electronics', 'Bengaluru', '4.2', 'Active'],
      ['HydroTech Supplies', 'Components', 'Hyderabad', '4.8', 'Active'],
      ['PackRight Co', 'Packaging', 'Coimbatore', '3.5', 'On Hold'],
      ['LubeWell Traders', 'Consumables', 'Chennai', '4.0', 'Active'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),title: const Text('Vendors'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Vendor Management', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Manage supplier relationships and performance.'),
          const SizedBox(height: 20),
          Row(children: [
            _stat('Total Vendors', '67', Icons.storefront_outlined, Colors.blue),
            const SizedBox(width: 14),
            _stat('Active', '58', Icons.check_circle_outline, Colors.green),
            const SizedBox(width: 14),
            _stat('On Hold', '6', Icons.pause_circle_outline, Colors.orange),
            const SizedBox(width: 14),
            _stat('Blacklisted', '3', Icons.block_outlined, Colors.red),
          ]),
          const SizedBox(height: 20),
          Expanded(child: Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('Vendor Name')),
              DataColumn(label: Text('Category')),
              DataColumn(label: Text('Location')),
              DataColumn(label: Text('Rating')),
              DataColumn(label: Text('Status')),
            ],
            rows: vendors.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          )))),
        ]),
      ),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return Expanded(child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
