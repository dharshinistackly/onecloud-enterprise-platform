import 'package:flutter/material.dart';

class AvailabilityPage extends StatelessWidget {
  const AvailabilityPage({super.key});

  @override
  Widget build(BuildContext context) {
    final availability = [
      ['Arun Kumar', 'Sales', 'Busy', '10:00 AM - 11:00 AM', 'Mon - Fri, 9 AM - 6 PM'],
      ['Priya Sharma', 'Support', 'Available', '-', 'Mon - Fri, 8 AM - 5 PM'],
      ['Rahul Menon', 'Operations', 'In a Meeting', '9:30 AM - 10:30 AM', 'Mon - Sat, 9 AM - 6 PM'],
      ['Sneha Iyer', 'HR', 'Available', '-', 'Mon - Fri, 9 AM - 5 PM'],
      ['Vikram Rao', 'Finance', 'Out of Office', 'All day', 'Mon - Fri, 9 AM - 6 PM'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),title: const Text('Availability'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Availability', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Check real-time availability before scheduling meetings.'),
          const SizedBox(height: 20),
          Wrap(
            spacing: 14,
            runSpacing: 14,
            children: [
            _stat('Available Now', '186', Icons.event_available_outlined, const Color(0xFF0F3D66)),
            _stat('In Meetings', '64', Icons.groups_2_outlined, Colors.orange),
            _stat('Busy', '42', Icons.do_not_disturb_on_outlined, Colors.red),
            _stat('Out of Office', '20', Icons.beach_access_outlined, Colors.grey),
          ]),
          const SizedBox(height: 20),
          Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('User')),
              DataColumn(label: Text('Department')),
              DataColumn(label: Text('Current Status')),
              DataColumn(label: Text('Busy Until')),
              DataColumn(label: Text('Working Hours')),
            ],
            rows: availability.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          ))),
        ]),
      )),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return SizedBox(width: 220, child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
