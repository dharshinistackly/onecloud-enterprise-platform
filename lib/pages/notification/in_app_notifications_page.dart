import 'package:flutter/material.dart';

class InAppNotificationsPage extends StatelessWidget {
  const InAppNotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      ['New lead assigned', 'Sales', 'Arun Kumar', '2 min ago', 'Unread'],
      ['Invoice INV-1045 overdue', 'Finance', 'Priya Sharma', '1 hr ago', 'Unread'],
      ['Ticket #4821 resolved', 'Support', 'Rahul Menon', '3 hrs ago', 'Read'],
      ['Leave request approved', 'HR', 'Sneha Iyer', '5 hrs ago', 'Read'],
      ['New comment on deal', 'Sales', 'Vikram Rao', '1 day ago', 'Read'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),title: const Text('In-App Notifications'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('In-App Notifications', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Live notification feed shown within the application.'),
          const SizedBox(height: 20),
          Wrap(
            spacing: 14,
            runSpacing: 14,
            children: [
            _stat('Total Notifications', '1,240', Icons.notifications_outlined, const Color(0xFF0F3D66)),
            _stat('Unread', '38', Icons.mark_email_unread_outlined, Colors.orange),
            _stat('Sent Today', '96', Icons.today_outlined, Colors.blue),
            _stat('Avg Open Rate', '78%', Icons.visibility_outlined, Colors.green),
          ]),
          const SizedBox(height: 20),
          Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('Notification')),
              DataColumn(label: Text('Module')),
              DataColumn(label: Text('Recipient')),
              DataColumn(label: Text('Time')),
              DataColumn(label: Text('Status')),
            ],
            rows: notifications.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          ))),
        ]),
      )),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return SizedBox(width: 220, child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
