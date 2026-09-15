import 'package:flutter/material.dart';

class WebhooksPage extends StatelessWidget {
  const WebhooksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final webhooks = [
      ['/orders/created', 'order.created', 'POST', '2 min ago', 'Active'],
      ['/payments/status', 'payment.updated', 'POST', '14 min ago', 'Active'],
      ['/users/deleted', 'user.deleted', 'POST', '1 hr ago', 'Failed'],
      ['/inventory/low-stock', 'inventory.alert', 'POST', '3 hr ago', 'Active'],
      ['/tickets/closed', 'ticket.closed', 'POST', 'Yesterday', 'Disabled'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),title: const Text('Webhooks'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Webhooks', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Monitor outbound event notifications to external endpoints.'),
          const SizedBox(height: 20),
          Row(children: [
            _stat('Total Webhooks', '32', Icons.webhook_outlined, Colors.blue),
            const SizedBox(width: 14),
            _stat('Active', '27', Icons.check_circle_outline, Colors.green),
            const SizedBox(width: 14),
            _stat('Failed Deliveries', '5', Icons.error_outline, Colors.red),
            const SizedBox(width: 14),
            _stat('Avg Latency', '210ms', Icons.speed_outlined, Colors.indigo),
          ]),
          const SizedBox(height: 20),
          Expanded(child: Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('Endpoint')),
              DataColumn(label: Text('Event Type')),
              DataColumn(label: Text('Method')),
              DataColumn(label: Text('Last Triggered')),
              DataColumn(label: Text('Status')),
            ],
            rows: webhooks.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          )))),
        ]),
      ),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return Expanded(child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
