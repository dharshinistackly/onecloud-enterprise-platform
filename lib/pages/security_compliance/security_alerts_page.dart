import 'package:flutter/material.dart';

class SecurityAlertsPage extends StatelessWidget {
  const SecurityAlertsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final alerts = [
      ['Multiple Failed Logins', 'High', 'Auth Service', '09:44:10', 'Unacknowledged'],
      ['Unusual Data Export Volume', 'Critical', 'Reporting Service', '09:30:05', 'Investigating'],
      ['New Admin Account Created', 'Medium', 'User Management', '09:12:47', 'Acknowledged'],
      ['Firewall Rule Changed', 'Medium', 'Network Security', '08:58:19', 'Acknowledged'],
      ['Expired Certificate Detected', 'High', 'API Gateway', '08:40:02', 'Resolved'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),title: const Text('Security Alerts'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Security Alerts', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Review and respond to security alerts across the organization.'),
          const SizedBox(height: 20),
          Wrap(
            spacing: 14,
            runSpacing: 14,
            children: [
            _stat('Alerts Today', '29', Icons.notifications_active_outlined, Colors.blue),
            _stat('Critical', '3', Icons.error_outline, Colors.red),
            _stat('Acknowledged', '21', Icons.mark_email_read_outlined, Colors.green),
            _stat('Avg Response Time', '11 min', Icons.timer_outlined, Colors.orange),
          ]),
          const SizedBox(height: 20),
          Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('Alert')),
              DataColumn(label: Text('Severity')),
              DataColumn(label: Text('Source')),
              DataColumn(label: Text('Triggered At')),
              DataColumn(label: Text('Status')),
            ],
            rows: alerts.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          ))),
        ]),
      )),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return SizedBox(width: 220, child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
