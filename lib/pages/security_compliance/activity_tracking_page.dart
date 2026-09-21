import 'package:flutter/material.dart';

class ActivityTrackingPage extends StatelessWidget {
  const ActivityTrackingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final activity = [
      ['r.menon@company.com', 'Viewed Dashboard', 'Chrome / Windows', 'Chennai, IN', '2 min ago'],
      ['a.iyer@company.com', 'Downloaded Report', 'Safari / macOS', 'Bengaluru, IN', '9 min ago'],
      ['s.rao@company.com', 'Multiple Failed Logins', 'Unknown Device', 'Unknown Location', '14 min ago'],
      ['k.das@company.com', 'Updated Profile', 'Chrome / Android', 'Hyderabad, IN', '30 min ago'],
      ['p.singh@company.com', 'Accessed Admin Panel', 'Edge / Windows', 'Pune, IN', '1 hr ago'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),title: const Text('Activity Tracking'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Activity Tracking', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Monitor user sessions and behavior across the platform.'),
          const SizedBox(height: 20),
          Wrap(
            spacing: 14,
            runSpacing: 14,
            children: [
            _stat('Active Sessions', '86', Icons.people_outline, Colors.blue),
            _stat('Total Actions Today', '4,920', Icons.touch_app_outlined, Colors.green),
            _stat('Suspicious Activity', '3', Icons.visibility_off_outlined, Colors.red),
            _stat('Avg Session Duration', '18 min', Icons.timer_outlined, Colors.indigo),
          ]),
          const SizedBox(height: 20),
          Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('User')),
              DataColumn(label: Text('Activity')),
              DataColumn(label: Text('Device')),
              DataColumn(label: Text('Location')),
              DataColumn(label: Text('Time')),
            ],
            rows: activity.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          ))),
        ]),
      )),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return SizedBox(width: 220, child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
