import 'package:flutter/material.dart';

class DeliveryTrackingPage extends StatelessWidget {
  const DeliveryTrackingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final deliveries = [
      ['Invoice Reminder', 'Email', 'priya@technova.com', '2 min ago', 'Delivered'],
      ['OTP Verification', 'SMS', '+91 98XXX XX210', '5 min ago', 'Delivered'],
      ['Ticket Update', 'Push', 'Device #A102', '10 min ago', 'Delivered'],
      ['Renewal Notice', 'Email', 'accounts@cloudworks.com', '1 hr ago', 'Bounced'],
      ['Payment Confirmation', 'SMS', '+91 87XXX XX432', '3 hrs ago', 'Delivered'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),title: const Text('Delivery Tracking'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Delivery Tracking', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Track delivery status of notifications across all channels.'),
          const SizedBox(height: 20),
          Row(children: [
            _stat('Total Deliveries', '16,842', Icons.local_shipping_outlined, const Color(0xFF0F3D66)),
            const SizedBox(width: 14),
            _stat('Delivered', '16,320', Icons.check_circle_outline, Colors.green),
            const SizedBox(width: 14),
            _stat('Bounced', '96', Icons.error_outline, Colors.red),
            const SizedBox(width: 14),
            _stat('Avg Delivery Time', '2.6s', Icons.speed_outlined, Colors.indigo),
          ]),
          const SizedBox(height: 20),
          Expanded(child: Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('Notification')),
              DataColumn(label: Text('Channel')),
              DataColumn(label: Text('Recipient')),
              DataColumn(label: Text('Sent')),
              DataColumn(label: Text('Status')),
            ],
            rows: deliveries.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          )))),
        ]),
      ),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return Expanded(child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
