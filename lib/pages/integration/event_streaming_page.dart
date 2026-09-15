import 'package:flutter/material.dart';

class EventStreamingPage extends StatelessWidget {
  const EventStreamingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final streams = [
      ['orders.events', '6', '4.2K/s', 'orders-consumer-grp', 'Healthy'],
      ['payments.events', '4', '1.8K/s', 'payments-consumer-grp', 'Healthy'],
      ['user.activity', '8', '9.6K/s', 'analytics-consumer-grp', 'Lagging'],
      ['inventory.updates', '3', '620/s', 'inventory-consumer-grp', 'Healthy'],
      ['notifications.out', '2', '310/s', 'notify-consumer-grp', 'Healthy'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),title: const Text('Event Streaming'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Event Streaming', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Monitor real-time topics, throughput, and consumer health.'),
          const SizedBox(height: 20),
          Row(children: [
            _stat('Total Topics', '15', Icons.stream_outlined, Colors.blue),
            const SizedBox(width: 14),
            _stat('Active Streams', '13', Icons.podcasts_outlined, Colors.green),
            const SizedBox(width: 14),
            _stat('Messages/sec', '16.5K', Icons.speed_outlined, Colors.indigo),
            const SizedBox(width: 14),
            _stat('Consumer Lag', '1 group', Icons.timelapse_outlined, Colors.orange),
          ]),
          const SizedBox(height: 20),
          Expanded(child: Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('Topic Name')),
              DataColumn(label: Text('Partitions')),
              DataColumn(label: Text('Throughput')),
              DataColumn(label: Text('Consumer Group')),
              DataColumn(label: Text('Status')),
            ],
            rows: streams.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          )))),
        ]),
      ),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return Expanded(child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
