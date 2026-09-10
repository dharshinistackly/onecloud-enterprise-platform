import 'package:flutter/material.dart';

class ScheduledReportsPage extends StatelessWidget {
  const ScheduledReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final schedules = [
      ['Weekly Sales Digest', 'Weekly', 'Sales Team (12)', '15 Sep 2026', 'Active'],
      ['Monthly Financial Statement', 'Monthly', 'Finance Team (6)', '01 Oct 2026', 'Active'],
      ['Daily Support Snapshot', 'Daily', 'Support Leads (4)', '11 Sep 2026', 'Active'],
      ['Quarterly Board Report', 'Quarterly', 'Leadership (8)', '01 Oct 2026', 'Paused'],
      ['Bi-weekly HR Attendance', 'Bi-weekly', 'HR Team (5)', '20 Sep 2026', 'Active'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(title: const Text('Scheduled Reports'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Scheduled Reports', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Automate recurring report delivery to teams and stakeholders.'),
          const SizedBox(height: 20),
          Row(children: [
            _stat('Total Scheduled', '38', Icons.event_repeat_outlined, const Color(0xFF0F3D66)),
            const SizedBox(width: 14),
            _stat('Active Schedules', '34', Icons.check_circle_outline, Colors.green),
            const SizedBox(width: 14),
            _stat('Next Run', 'Today, 6 PM', Icons.schedule_outlined, Colors.orange),
            const SizedBox(width: 14),
            _stat('Failed Deliveries', '2', Icons.error_outline, Colors.red),
          ]),
          const SizedBox(height: 20),
          Expanded(child: Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('Report Name')),
              DataColumn(label: Text('Frequency')),
              DataColumn(label: Text('Recipients')),
              DataColumn(label: Text('Next Run')),
              DataColumn(label: Text('Status')),
            ],
            rows: schedules.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          )))),
        ]),
      ),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return Expanded(child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
