import 'package:flutter/material.dart';

class OpportunitiesPage extends StatelessWidget {
  const OpportunitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final data = [
      ['Enterprise Cloud Deal', 'TechNova', '₹18,00,000', 'Negotiation', '75%'],
      ['CRM Upgrade', 'CloudWorks', '₹9,50,000', 'Proposal', '60%'],
      ['ERP Integration', 'DataBridge', '₹25,00,000', 'Qualified', '45%'],
      ['Support Contract', 'InnoSoft', '₹6,20,000', 'Closed Won', '100%'],
      ['Analytics Platform', 'NextGen', '₹12,00,000', 'New', '20%'],
    ];

    return _page(
      context,
      'Opportunities',
      'Manage sales opportunities and track their progress.',
      Icons.trending_up,
      [
        _card('Total Opportunities', '24', Icons.business_center_outlined, Colors.blue),
        _card('Pipeline Value', '₹71.7 L', Icons.currency_rupee, Colors.indigo),
        _card('Win Rate', '68%', Icons.show_chart, Colors.green),
        _card('Open Deals', '18', Icons.folder_open, Colors.orange),
      ],
      DataTable(
        columns: const [
          DataColumn(label: Text('Opportunity')),
          DataColumn(label: Text('Account')),
          DataColumn(label: Text('Value')),
          DataColumn(label: Text('Stage')),
          DataColumn(label: Text('Probability')),
        ],
        rows: data.map((row) => DataRow(cells: [
          DataCell(Text(row[0])),
          DataCell(Text(row[1])),
          DataCell(Text(row[2])),
          DataCell(Text(row[3])),
          DataCell(Text(row[4])),
        ])).toList(),
      ),
    );
  }

  Widget _page(BuildContext context, String title, String subtitle, IconData icon, List<Widget> cards, Widget table) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),title: Text(title), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [Icon(icon, color: const Color(0xFF1677C8), size: 34), const SizedBox(width: 8), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)), Text(subtitle)])]),
          const SizedBox(height: 20),
          Row(children: [for (int i = 0; i < cards.length; i++) ...[Expanded(child: cards[i]), if (i != cards.length - 1) const SizedBox(width: 14)]]),
          const SizedBox(height: 20),
          Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: table)),
        ]),
      )),
    );
  }

  Widget _card(String title, String value, IconData icon, Color color) {
    return Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 30), const SizedBox(width: 12), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), const SizedBox(height: 4), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])])));
  }
}
