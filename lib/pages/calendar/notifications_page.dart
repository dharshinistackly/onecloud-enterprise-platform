import 'package:flutter/material.dart';

class CalendarNotificationsPage extends StatelessWidget {
  const CalendarNotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final alerts = [
      ['Meeting starts in 10 min', 'Q3 Sales Review', 'Push', '9:50 AM', 'Sent'],
      ['Room booking confirmed', 'Conference Room A', 'Email', '9:00 AM', 'Sent'],
      ['Event rescheduled', 'Client Onboarding Call', 'Email + Push', '8:30 AM', 'Sent'],
      ['Reminder: Submit report', 'Expense Report', 'Push', '8:00 AM', 'Sent'],
      ['New invite received', 'Sprint Planning', 'Email', '7:45 AM', 'Sent'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),title: const Text('Calendar Notifications'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Calendar Notifications', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Alerts and reminders triggered by calendar activity.'),
          const SizedBox(height: 20),
          Wrap(
            spacing: 14,
            runSpacing: 14,
            children: [
            _stat('Total Alerts Today', '84', Icons.notifications_outlined, const Color(0xFF0F3D66)),
            _stat('Meeting Reminders', '52', Icons.event_outlined, Colors.blue),
            _stat('Reschedule Alerts', '6', Icons.update_outlined, Colors.orange),
            _stat('Delivery Rate', '99.1%', Icons.check_circle_outline, Colors.green),
          ]),
          const SizedBox(height: 20),
          Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('Alert')),
              DataColumn(label: Text('Event')),
              DataColumn(label: Text('Channel')),
              DataColumn(label: Text('Time')),
              DataColumn(label: Text('Status')),
            ],
            rows: alerts.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          ))),
        ]),
      )),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return SizedBox(width: 220, child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
