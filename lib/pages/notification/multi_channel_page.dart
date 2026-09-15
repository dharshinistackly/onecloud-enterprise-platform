import 'package:flutter/material.dart';

class MultiChannelPage extends StatelessWidget {
  const MultiChannelPage({super.key});

  @override
  Widget build(BuildContext context) {
    final campaigns = [
      ['Product Launch Announcement', 'Email + Push + SMS', '12,400', '68%', 'Completed'],
      ['Renewal Reminder Series', 'Email + SMS', '3,200', '74%', 'Running'],
      ['Feature Update Alert', 'Push + In-App', '8,900', '81%', 'Completed'],
      ['Festive Offer Campaign', 'Email + SMS + Push', '15,600', '59%', 'Scheduled'],
      ['Service Outage Notice', 'All Channels', '20,300', '92%', 'Completed'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),title: const Text('Multi-Channel'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Multi-Channel Campaigns', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Coordinate notifications across email, SMS, push, and in-app.'),
          const SizedBox(height: 20),
          Row(children: [
            _stat('Total Campaigns', '18', Icons.campaign_outlined, const Color(0xFF0F3D66)),
            const SizedBox(width: 14),
            _stat('Running', '4', Icons.play_circle_outline, Colors.green),
            const SizedBox(width: 14),
            _stat('Scheduled', '3', Icons.schedule_outlined, Colors.orange),
            const SizedBox(width: 14),
            _stat('Avg Engagement', '75%', Icons.insights_outlined, Colors.indigo),
          ]),
          const SizedBox(height: 20),
          Expanded(child: Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('Campaign Name')),
              DataColumn(label: Text('Channels')),
              DataColumn(label: Text('Recipients')),
              DataColumn(label: Text('Engagement')),
              DataColumn(label: Text('Status')),
            ],
            rows: campaigns.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          )))),
        ]),
      ),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return Expanded(child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
