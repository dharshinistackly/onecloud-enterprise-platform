import 'package:flutter/material.dart';

class PushNotificationsPage extends StatelessWidget {
  const PushNotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pushes = [
      ['New Message Alert', 'Android + iOS', '2,840', '64%', 'Delivered'],
      ['Deal Closing Soon', 'Android + iOS', '412', '58%', 'Delivered'],
      ['Task Assigned', 'Android', '980', '71%', 'Delivered'],
      ['Approval Pending', 'iOS', '260', '66%', 'Delivered'],
      ['System Maintenance Notice', 'Android + iOS', '3,120', '49%', 'Scheduled'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),title: const Text('Push Notifications'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Push Notifications', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Manage mobile push notifications across platforms.'),
          const SizedBox(height: 20),
          Row(children: [
            _stat('Push Sent', '7,612', Icons.notifications_active_outlined, const Color(0xFF0F3D66)),
            const SizedBox(width: 14),
            _stat('Delivery Rate', '96.8%', Icons.check_circle_outline, Colors.green),
            const SizedBox(width: 14),
            _stat('Avg Tap Rate', '61%', Icons.touch_app_outlined, Colors.orange),
            const SizedBox(width: 14),
            _stat('Opted-Out Devices', '84', Icons.notifications_off_outlined, Colors.grey),
          ]),
          const SizedBox(height: 20),
          Expanded(child: Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('Notification')),
              DataColumn(label: Text('Platform')),
              DataColumn(label: Text('Recipients')),
              DataColumn(label: Text('Tap Rate')),
              DataColumn(label: Text('Status')),
            ],
            rows: pushes.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          )))),
        ]),
      ),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return Expanded(child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
