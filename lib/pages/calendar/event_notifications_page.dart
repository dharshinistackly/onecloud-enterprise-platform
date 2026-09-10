import 'package:flutter/material.dart';

class EventNotificationsPage extends StatelessWidget {
  const EventNotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final events = [
      ['Q3 Sales Review', '30 min before', 'Email + Push', '18 attendees', 'Scheduled'],
      ['Client Onboarding Call', '15 min before', 'Push', '3 attendees', 'Scheduled'],
      ['Sprint Planning', '10 min before', 'Push', '22 attendees', 'Scheduled'],
      ['Performance Review', '1 hr before', 'Email', '2 attendees', 'Scheduled'],
      ['All Hands Meeting', '1 day before', 'Email + Push', '312 attendees', 'Scheduled'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(title: const Text('Event Notifications'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Event Notifications', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Configure reminder timing and channels for calendar events.'),
          const SizedBox(height: 20),
          Row(children: [
            _stat('Events with Alerts', '96', Icons.event_note_outlined, const Color(0xFF0F3D66)),
            const SizedBox(width: 14),
            _stat('Sent This Week', '312', Icons.send_outlined, Colors.blue),
            const SizedBox(width: 14),
            _stat('Avg Lead Time', '22 min', Icons.timer_outlined, Colors.indigo),
            const SizedBox(width: 14),
            _stat('Missed Alerts', '4', Icons.notifications_off_outlined, Colors.red),
          ]),
          const SizedBox(height: 20),
          Expanded(child: Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('Event')),
              DataColumn(label: Text('Reminder Timing')),
              DataColumn(label: Text('Channel')),
              DataColumn(label: Text('Attendees')),
              DataColumn(label: Text('Status')),
            ],
            rows: events.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          )))),
        ]),
      ),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return Expanded(child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
