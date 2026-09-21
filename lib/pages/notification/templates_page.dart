import 'package:flutter/material.dart';

class TemplatesPage extends StatelessWidget {
  const TemplatesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final templates = [
      ['Welcome Email', 'Email', 'Onboarding', '10 Aug 2026', 'Active'],
      ['Invoice Reminder SMS', 'SMS', 'Finance', '15 Aug 2026', 'Active'],
      ['Ticket Update Push', 'Push', 'Support', '20 Aug 2026', 'Active'],
      ['Renewal Notice', 'Email', 'Sales', '25 Aug 2026', 'Draft'],
      ['OTP Message', 'SMS', 'Security', '01 Sep 2026', 'Active'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),title: const Text('Templates'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Notification Templates', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Reusable templates for email, SMS, and push notifications.'),
          const SizedBox(height: 20),
          Wrap(
            spacing: 14,
            runSpacing: 14,
            children: [
            _stat('Total Templates', '46', Icons.article_outlined, const Color(0xFF0F3D66)),
            _stat('Active Templates', '38', Icons.check_circle_outline, Colors.green),
            _stat('Drafts', '8', Icons.edit_note_outlined, Colors.orange),
            _stat('Channels Covered', '4', Icons.hub_outlined, Colors.indigo),
          ]),
          const SizedBox(height: 20),
          Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('Template Name')),
              DataColumn(label: Text('Channel')),
              DataColumn(label: Text('Category')),
              DataColumn(label: Text('Last Updated')),
              DataColumn(label: Text('Status')),
            ],
            rows: templates.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          ))),
        ]),
      )),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return SizedBox(width: 220, child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
