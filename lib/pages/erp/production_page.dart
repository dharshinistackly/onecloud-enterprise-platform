import 'package:flutter/material.dart';

class ProductionPage extends StatelessWidget {
  const ProductionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = [
      ['WO-501', 'Hydraulic Pump Assembly', '150 units', 'Assembly', 'In Progress'],
      ['WO-502', 'Circuit Board Batch C', '500 units', 'Testing', 'In Progress'],
      ['WO-503', 'Steel Frame Model X', '80 units', 'Welding', 'Delayed'],
      ['WO-504', 'Packaging Line Run 12', '2,000 units', 'Packing', 'Completed'],
      ['WO-505', 'Motor Unit MU-9', '120 units', 'Quality Check', 'Completed'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),title: const Text('Production'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Production Management', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Monitor work orders and manufacturing stages.'),
          const SizedBox(height: 20),
          Row(children: [
            _stat('Total Work Orders', '74', Icons.precision_manufacturing_outlined, Colors.blue),
            const SizedBox(width: 14),
            _stat('In Progress', '39', Icons.autorenew, Colors.orange),
            const SizedBox(width: 14),
            _stat('Completed', '31', Icons.check_circle_outline, Colors.green),
            const SizedBox(width: 14),
            _stat('Delayed', '4', Icons.report_gmailerrorred_outlined, Colors.red),
          ]),
          const SizedBox(height: 20),
          Expanded(child: Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('Order No')),
              DataColumn(label: Text('Product')),
              DataColumn(label: Text('Quantity')),
              DataColumn(label: Text('Stage')),
              DataColumn(label: Text('Status')),
            ],
            rows: orders.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          )))),
        ]),
      ),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return Expanded(child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
