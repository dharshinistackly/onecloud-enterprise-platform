import 'package:flutter/material.dart';

class ProcurementPage extends StatelessWidget {
  const ProcurementPage({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = [
      ['PO-1001', 'SteelCorp Industries', 'Steel Rod 12mm', '₹2,40,000', 'Approved'],
      ['PO-1002', 'ElectroParts Ltd', 'Circuit Board CB-45', '₹1,10,500', 'Pending'],
      ['PO-1003', 'HydroTech Supplies', 'Hydraulic Pump HP-200', '₹85,000', 'Approved'],
      ['PO-1004', 'PackRight Co', 'Packaging Box L', '₹32,400', 'Rejected'],
      ['PO-1005', 'LubeWell Traders', 'Lubricant Oil 5L', '₹18,900', 'Pending'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(title: const Text('Procurement'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Procurement Management', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Manage purchase orders and supplier requests.'),
          const SizedBox(height: 20),
          Row(children: [
            _stat('Total POs', '96', Icons.receipt_long_outlined, Colors.blue),
            const SizedBox(width: 14),
            _stat('Approved', '61', Icons.check_circle_outline, Colors.green),
            const SizedBox(width: 14),
            _stat('Pending', '27', Icons.hourglass_empty_outlined, Colors.orange),
            const SizedBox(width: 14),
            _stat('Rejected', '8', Icons.cancel_outlined, Colors.red),
          ]),
          const SizedBox(height: 20),
          Expanded(child: Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('PO Number')),
              DataColumn(label: Text('Vendor')),
              DataColumn(label: Text('Item')),
              DataColumn(label: Text('Amount')),
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
