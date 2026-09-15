import 'package:flutter/material.dart';

class ActivitiesPage extends StatelessWidget {
  const ActivitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final activities = [
      ['Client Meeting', 'Priya Sharma', 'Today, 10:00 AM', 'Meeting', 'Completed'],
      ['Follow-up Call', 'Arun Kumar', 'Today, 12:30 PM', 'Call', 'Scheduled'],
      ['Product Demo', 'Rahul Menon', 'Tomorrow, 11:00 AM', 'Demo', 'Scheduled'],
      ['Proposal Review', 'Sneha Raj', 'Tomorrow, 03:00 PM', 'Task', 'Pending'],
      ['Contract Discussion', 'Vikram Singh', 'Friday, 02:00 PM', 'Meeting', 'Scheduled'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),title: const Text('Activities'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: Padding(padding: const EdgeInsets.all(24), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Activities', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        const Text('Track meetings, calls, tasks and customer interactions.'),
        const SizedBox(height: 20),
        Row(children: [
          _stat('Total Activities', '86', Icons.event_note_outlined, Colors.blue),
          const SizedBox(width: 14),
          _stat('Completed', '52', Icons.task_alt, Colors.green),
          const SizedBox(width: 14),
          _stat('Scheduled', '27', Icons.schedule, Colors.indigo),
          const SizedBox(width: 14),
          _stat('Pending', '7', Icons.pending_actions, Colors.orange),
        ]),
        const SizedBox(height: 20),
        Expanded(child: Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
          columns: const [DataColumn(label: Text('Activity')), DataColumn(label: Text('Contact')), DataColumn(label: Text('Date & Time')), DataColumn(label: Text('Type')), DataColumn(label: Text('Status'))],
          rows: activities.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
        )))),
      ])),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return Expanded(child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
