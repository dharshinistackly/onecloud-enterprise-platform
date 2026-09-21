import 'package:flutter/material.dart';

class CampaignsPage extends StatelessWidget {
  const CampaignsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final campaigns = [
      ['Cloud Expo 2026', 'Email', '4,500', '₹2,40,000', 'Active'],
      ['CRM Upgrade Drive', 'Email + SMS', '7,800', '₹3,75,000', 'Active'],
      ['Enterprise AI Webinar', 'Social Media', '12,400', '₹1,80,000', 'Scheduled'],
      ['New Product Launch', 'Multi-Channel', '18,600', '₹5,20,000', 'Completed'],
      ['Customer Referral', 'Referral', '2,100', '₹95,000', 'Active'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),title: const Text('Campaigns'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: SingleChildScrollView(child: Padding(padding: const EdgeInsets.all(24), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Wrap(alignment: WrapAlignment.spaceBetween, crossAxisAlignment: WrapCrossAlignment.center, spacing: 12, runSpacing: 12, children: [
          const Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
            Text('Campaign Management', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            Text('Plan, execute and monitor marketing campaigns.'),
          ]),
          ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.add), label: const Text('Create Campaign')),
        ]),
        const SizedBox(height: 20),
        Wrap(
            spacing: 14,
            runSpacing: 14,
            children: [
          _stat('Campaigns', '18', Icons.campaign_outlined, Colors.blue),
          const SizedBox(width: 14),
          _stat('Active', '7', Icons.play_circle_outline, Colors.green),
          const SizedBox(width: 14),
          _stat('Audience', '45.4K', Icons.groups_outlined, Colors.indigo),
          const SizedBox(width: 14),
          _stat('Conversions', '2,486', Icons.ads_click, Colors.orange),
        ]),
        const SizedBox(height: 20),
        Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
          columns: const [DataColumn(label: Text('Campaign')), DataColumn(label: Text('Channel')), DataColumn(label: Text('Audience')), DataColumn(label: Text('Budget')), DataColumn(label: Text('Status'))],
          rows: campaigns.map((c) => DataRow(cells: [for (final item in c) DataCell(Text(item))])).toList(),
        ))),
      ]))),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return SizedBox(width: 220, child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
