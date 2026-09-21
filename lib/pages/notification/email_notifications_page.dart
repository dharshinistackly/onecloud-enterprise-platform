import 'package:flutter/material.dart';

class EmailNotificationsPage extends StatelessWidget {
  const EmailNotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emails = [
      ['Invoice Reminder', 'finance@company.com', '840', '92%', 'Sent'],
      ['Welcome Email', 'onboarding@company.com', '120', '98%', 'Sent'],
      ['Password Reset', 'security@company.com', '64', '99%', 'Sent'],
      ['Weekly Digest', 'updates@company.com', '2,140', '74%', 'Sent'],
      ['Renewal Notice', 'accounts@company.com', '210', '88%', 'Scheduled'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),title: const Text('Email Notifications'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Email Notifications', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Manage transactional and bulk email notifications.'),
          const SizedBox(height: 20),
          Wrap(
            spacing: 14,
            runSpacing: 14,
            children: [
            _stat('Emails Sent', '3,374', Icons.mail_outline, const Color(0xFF0F3D66)),
            _stat('Delivery Rate', '98.4%', Icons.check_circle_outline, Colors.green),
            _stat('Avg Open Rate', '86%', Icons.visibility_outlined, Colors.blue),
            _stat('Bounced', '14', Icons.error_outline, Colors.red),
          ]),
          const SizedBox(height: 20),
          Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('Email Name')),
              DataColumn(label: Text('From Address')),
              DataColumn(label: Text('Recipients')),
              DataColumn(label: Text('Open Rate')),
              DataColumn(label: Text('Status')),
            ],
            rows: emails.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          ))),
        ]),
      )),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return SizedBox(width: 220, child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
