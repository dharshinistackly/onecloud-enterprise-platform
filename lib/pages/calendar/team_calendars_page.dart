import 'package:flutter/material.dart';

class TeamCalendarsPage extends StatelessWidget {
  const TeamCalendarsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final teams = [
      ['Sales Team', '12 members', '24', '6 scheduled today', 'Active'],
      ['Support Team', '18 members', '31', '9 scheduled today', 'Active'],
      ['Engineering Team', '22 members', '15', '4 scheduled today', 'Active'],
      ['HR Team', '6 members', '9', '1 scheduled today', 'Active'],
      ['Finance Team', '8 members', '11', '2 scheduled today', 'Active'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),title: const Text('Team Calendars'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Team Calendars', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Shared calendars for teams and departments.'),
          const SizedBox(height: 20),
          Row(children: [
            _stat('Total Teams', '9', Icons.groups_outlined, const Color(0xFF0F3D66)),
            const SizedBox(width: 14),
            _stat('Events This Week', '90', Icons.event_note_outlined, Colors.blue),
            const SizedBox(width: 14),
            _stat('Meetings Today', '22', Icons.groups_2_outlined, Colors.orange),
            const SizedBox(width: 14),
            _stat('Avg Attendance', '87%', Icons.how_to_reg_outlined, Colors.green),
          ]),
          const SizedBox(height: 20),
          Expanded(child: Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('Team')),
              DataColumn(label: Text('Size')),
              DataColumn(label: Text('Events This Week')),
              DataColumn(label: Text('Today')),
              DataColumn(label: Text('Status')),
            ],
            rows: teams.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          )))),
        ]),
      ),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return Expanded(child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
