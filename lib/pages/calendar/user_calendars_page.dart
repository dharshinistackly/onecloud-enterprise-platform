import 'package:flutter/material.dart';

class UserCalendarsPage extends StatelessWidget {
  const UserCalendarsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final calendars = [
      ['Arun Kumar', 'Sales', '18', '2 scheduled today', 'Synced'],
      ['Priya Sharma', 'Support', '12', '1 scheduled today', 'Synced'],
      ['Rahul Menon', 'Operations', '9', '3 scheduled today', 'Synced'],
      ['Sneha Iyer', 'HR', '15', 'No events today', 'Synced'],
      ['Vikram Rao', 'Finance', '7', '1 scheduled today', 'Not Synced'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),title: const Text('User Calendars'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('User Calendars', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('View and manage individual user calendars across the org.'),
          const SizedBox(height: 20),
          Row(children: [
            _stat('Total Calendars', '312', Icons.calendar_today_outlined, const Color(0xFF0F3D66)),
            const SizedBox(width: 14),
            _stat('Events Today', '128', Icons.event_outlined, Colors.blue),
            const SizedBox(width: 14),
            _stat('Synced Calendars', '298', Icons.sync_outlined, Colors.green),
            const SizedBox(width: 14),
            _stat('Not Synced', '14', Icons.sync_problem_outlined, Colors.red),
          ]),
          const SizedBox(height: 20),
          Expanded(child: Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('User')),
              DataColumn(label: Text('Department')),
              DataColumn(label: Text('Events This Week')),
              DataColumn(label: Text('Today')),
              DataColumn(label: Text('Sync Status')),
            ],
            rows: calendars.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          )))),
        ]),
      ),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return Expanded(child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
