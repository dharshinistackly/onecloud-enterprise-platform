import 'package:flutter/material.dart';

class DispatchPage extends StatelessWidget {
  const DispatchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dispatches = [
      ['DS-301', 'SO-2001', 'Chennai', 'BlueDart Express', 'Delivered'],
      ['DS-302', 'SO-2002', 'Bengaluru', 'Delhivery', 'In Transit'],
      ['DS-303', 'SO-2004', 'Hyderabad', 'DTDC', 'Delivered'],
      ['DS-304', 'SO-2003', 'Mumbai', 'BlueDart Express', 'Scheduled'],
      ['DS-305', 'SO-2005', 'Pune', 'Delhivery', 'Cancelled'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(title: const Text('Dispatch'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Dispatch Management', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Track shipments from warehouse to customer.'),
          const SizedBox(height: 20),
          Row(children: [
            _stat('Total Dispatches', '210', Icons.local_shipping_outlined, Colors.blue),
            const SizedBox(width: 14),
            _stat('In Transit', '48', Icons.sync_alt_outlined, Colors.orange),
            const SizedBox(width: 14),
            _stat('Delivered', '152', Icons.check_circle_outline, Colors.green),
            const SizedBox(width: 14),
            _stat('Cancelled', '10', Icons.cancel_outlined, Colors.red),
          ]),
          const SizedBox(height: 20),
          Expanded(child: Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('Dispatch No')),
              DataColumn(label: Text('Order Ref')),
              DataColumn(label: Text('Destination')),
              DataColumn(label: Text('Carrier')),
              DataColumn(label: Text('Status')),
            ],
            rows: dispatches.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          )))),
        ]),
      ),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return Expanded(child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
