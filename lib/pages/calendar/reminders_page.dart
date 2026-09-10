import 'package:flutter/material.dart';

class RemindersPage extends StatelessWidget {
  const RemindersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final reminders = [
      ['Follow up with TechNova', 'Arun Kumar', '11 Sep 2026, 9:00 AM', 'One-time', 'Pending'],
      ['Renew CloudWorks Contract', 'Priya Sharma', '15 Sep 2026, 10:00 AM', 'One-time', 'Pending'],
      ['Weekly Standup Prep', 'Rahul Menon', 'Every Mon, 8:30 AM', 'Recurring', 'Active'],
      ['Submit Expense Report', 'Sneha Iyer', '30 Sep 2026, 5:00 PM', 'One-time', 'Pending'],
      ['Quarterly Review Prep', 'Vikram Rao', 'Every Quarter', 'Recurring', 'Active'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(title: const Text('Reminders'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Reminders', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Personal and recurring reminders tied to calendar events.'),
          const SizedBox(height: 20),
          Row(children: [
            _stat('Total Reminders', '68', Icons.alarm_outlined, const Color(0xFF0F3D66)),
            const SizedBox(width: 14),
            _stat('Due Today', '9', Icons.today_outlined, Colors.orange),
            const SizedBox(width: 14),
            _stat('Recurring', '14', Icons.repeat_outlined, Colors.indigo),
            const SizedBox(width: 14),
            _stat('Completed', '312', Icons.check_circle_outline, Colors.green),
          ]),
          const SizedBox(height: 20),
          Expanded(child: Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('Reminder')),
              DataColumn(label: Text('Owner')),
              DataColumn(label: Text('Due')),
              DataColumn(label: Text('Type')),
              DataColumn(label: Text('Status')),
            ],
            rows: reminders.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          )))),
        ]),
      ),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return Expanded(child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
