import 'package:flutter/material.dart';

class PreferencesPage extends StatelessWidget {
  const PreferencesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final preferences = [
      ['Arun Kumar', 'Email, Push', 'Immediate', '05 Sep 2026', 'Active'],
      ['Priya Sharma', 'Email, SMS', 'Daily Digest', '04 Sep 2026', 'Active'],
      ['Rahul Menon', 'Push Only', 'Immediate', '03 Sep 2026', 'Active'],
      ['Sneha Iyer', 'Email Only', 'Weekly Digest', '02 Sep 2026', 'Active'],
      ['Vikram Rao', 'All Channels', 'Immediate', '01 Sep 2026', 'Active'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(title: const Text('Preferences'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Notification Preferences', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Manage how and when users receive notifications.'),
          const SizedBox(height: 20),
          Row(children: [
            _stat('Total Users', '312', Icons.people_outline, const Color(0xFF0F3D66)),
            const SizedBox(width: 14),
            _stat('Immediate Alerts', '186', Icons.flash_on_outlined, Colors.orange),
            const SizedBox(width: 14),
            _stat('Digest Subscribers', '98', Icons.summarize_outlined, Colors.blue),
            const SizedBox(width: 14),
            _stat('Opted Out', '28', Icons.notifications_off_outlined, Colors.grey),
          ]),
          const SizedBox(height: 20),
          Expanded(child: Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('User')),
              DataColumn(label: Text('Channels')),
              DataColumn(label: Text('Frequency')),
              DataColumn(label: Text('Last Updated')),
              DataColumn(label: Text('Status')),
            ],
            rows: preferences.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          )))),
        ]),
      ),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return Expanded(child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
