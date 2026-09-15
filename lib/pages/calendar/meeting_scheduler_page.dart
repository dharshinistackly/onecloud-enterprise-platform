import 'package:flutter/material.dart';

class MeetingSchedulerPage extends StatelessWidget {
  const MeetingSchedulerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final meetings = [
      ['Q3 Sales Review', 'Sales Team', '11 Sep 2026, 10:00 AM', '45 min', 'Confirmed'],
      ['Client Onboarding Call', 'TechNova Solutions', '11 Sep 2026, 2:00 PM', '30 min', 'Confirmed'],
      ['Sprint Planning', 'Engineering Team', '12 Sep 2026, 9:30 AM', '60 min', 'Confirmed'],
      ['Performance Review', 'Sneha Iyer', '12 Sep 2026, 4:00 PM', '30 min', 'Pending'],
      ['Vendor Negotiation', 'Finance Team', '13 Sep 2026, 11:00 AM', '45 min', 'Confirmed'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),title: const Text('Meeting Scheduler'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Meeting Scheduler', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Schedule and manage meetings across teams and clients.'),
          const SizedBox(height: 20),
          Row(children: [
            _stat('Meetings This Week', '42', Icons.event_available_outlined, const Color(0xFF0F3D66)),
            const SizedBox(width: 14),
            _stat('Confirmed', '36', Icons.check_circle_outline, Colors.green),
            const SizedBox(width: 14),
            _stat('Pending', '6', Icons.hourglass_bottom_outlined, Colors.orange),
            const SizedBox(width: 14),
            _stat('Avg Duration', '38 min', Icons.timer_outlined, Colors.indigo),
          ]),
          const SizedBox(height: 20),
          Expanded(child: Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('Meeting')),
              DataColumn(label: Text('With')),
              DataColumn(label: Text('Date & Time')),
              DataColumn(label: Text('Duration')),
              DataColumn(label: Text('Status')),
            ],
            rows: meetings.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          )))),
        ]),
      ),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return Expanded(child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
