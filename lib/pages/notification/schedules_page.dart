import 'package:flutter/material.dart';

class SchedulesPage extends StatelessWidget {
  const SchedulesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final schedules = [
      ['Weekly Digest Email', 'Weekly - Mon 9 AM', 'Email', '15 Sep 2026', 'Active'],
      ['Invoice Reminder SMS', 'Daily - 10 AM', 'SMS', '11 Sep 2026', 'Active'],
      ['Renewal Notice Push', 'Monthly - 1st', 'Push', '01 Oct 2026', 'Active'],
      ['System Maintenance Alert', 'On Demand', 'All Channels', '-', 'Paused'],
      ['Feedback Request Email', 'Bi-weekly - Fri 5 PM', 'Email', '18 Sep 2026', 'Active'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),title: const Text('Schedules'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Notification Schedules', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Automate recurring notification deliveries across channels.'),
          const SizedBox(height: 20),
          Wrap(
            spacing: 14,
            runSpacing: 14,
            children: [
            _stat('Total Schedules', '24', Icons.event_repeat_outlined, const Color(0xFF0F3D66)),
            _stat('Active', '21', Icons.check_circle_outline, Colors.green),
            _stat('Paused', '3', Icons.pause_circle_outline, Colors.orange),
            _stat('Next Run', 'Today, 5 PM', Icons.schedule_outlined, Colors.indigo),
          ]),
          const SizedBox(height: 20),
          Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('Schedule Name')),
              DataColumn(label: Text('Frequency')),
              DataColumn(label: Text('Channel')),
              DataColumn(label: Text('Next Run')),
              DataColumn(label: Text('Status')),
            ],
            rows: schedules.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          ))),
        ]),
      )),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return SizedBox(width: 220, child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
