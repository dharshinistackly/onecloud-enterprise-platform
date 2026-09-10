import 'package:flutter/material.dart';

class SalesOrdersPage extends StatelessWidget {
  const SalesOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = [
      ['SO-2001', 'TechNova Solutions', '₹4,50,000', '10 Sep 2026', 'Confirmed'],
      ['SO-2002', 'CloudWorks Pvt Ltd', '₹2,15,000', '09 Sep 2026', 'Shipped'],
      ['SO-2003', 'NextGen Retail', '₹6,80,000', '08 Sep 2026', 'Pending'],
      ['SO-2004', 'DataBridge Systems', '₹1,25,000', '07 Sep 2026', 'Delivered'],
      ['SO-2005', 'InnoSoft Labs', '₹3,40,000', '05 Sep 2026', 'Cancelled'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(title: const Text('Sales Orders'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Sales Order Management', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Track customer orders from confirmation to delivery.'),
          const SizedBox(height: 20),
          Row(children: [
            _stat('Total Orders', '128', Icons.shopping_cart_outlined, Colors.blue),
            const SizedBox(width: 14),
            _stat('Confirmed', '54', Icons.check_circle_outline, Colors.green),
            const SizedBox(width: 14),
            _stat('Pending', '22', Icons.hourglass_empty_outlined, Colors.orange),
            const SizedBox(width: 14),
            _stat('Cancelled', '9', Icons.cancel_outlined, Colors.red),
          ]),
          const SizedBox(height: 20),
          Expanded(child: Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('Order No')),
              DataColumn(label: Text('Customer')),
              DataColumn(label: Text('Amount')),
              DataColumn(label: Text('Date')),
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
