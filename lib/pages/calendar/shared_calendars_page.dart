import 'package:flutter/material.dart';

class SharedCalendarsPage extends StatelessWidget {
  const SharedCalendarsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final shared = [
      ['Company Holidays', 'All Employees', 'View Only', '15', 'Active'],
      ['Sales Pipeline Events', 'Sales Team', 'Edit Access', '24', 'Active'],
      ['Product Launch Timeline', 'Leadership + Marketing', 'Edit Access', '9', 'Active'],
      ['Support On-Call Roster', 'Support Team', 'Edit Access', '12', 'Active'],
      ['Client Events Calendar', 'Account Managers', 'View Only', '18', 'Active'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(title: const Text('Shared Calendars'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Shared Calendars', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Calendars shared across teams, departments, or the org.'),
          const SizedBox(height: 20),
          Row(children: [
            _stat('Shared Calendars', '16', Icons.calendar_month_outlined, const Color(0xFF0F3D66)),
            const SizedBox(width: 14),
            _stat('With Edit Access', '9', Icons.edit_calendar_outlined, Colors.indigo),
            const SizedBox(width: 14),
            _stat('View Only', '7', Icons.visibility_outlined, Colors.blue),
            const SizedBox(width: 14),
            _stat('Total Events', '78', Icons.event_outlined, Colors.green),
          ]),
          const SizedBox(height: 20),
          Expanded(child: Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('Calendar Name')),
              DataColumn(label: Text('Shared With')),
              DataColumn(label: Text('Access Level')),
              DataColumn(label: Text('Events')),
              DataColumn(label: Text('Status')),
            ],
            rows: shared.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          )))),
        ]),
      ),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return Expanded(child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
