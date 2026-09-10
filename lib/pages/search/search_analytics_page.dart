import 'package:flutter/material.dart';

class SearchAnalyticsPage extends StatelessWidget {
  const SearchAnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final analytics = [
      ['pricing plans', '4,201', '38.2%', '1.4', 'Up'],
      ['api documentation', '3,890', '44.7%', '1.1', 'Up'],
      ['refund policy', '2,150', '21.5%', '2.8', 'Down'],
      ['login issues', '1,760', '29.9%', '2.1', 'Flat'],
      ['integration guide', '1,502', '33.4%', '1.7', 'Up'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(title: const Text('Search Analytics'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Search Analytics', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Understand what users search for and how results perform.'),
          const SizedBox(height: 20),
          Row(children: [
            _stat('Total Queries', '48,290', Icons.query_stats_outlined, Colors.blue),
            const SizedBox(width: 14),
            _stat('Click-Through Rate', '34.6%', Icons.ads_click_outlined, Colors.green),
            const SizedBox(width: 14),
            _stat('Avg Position Clicked', '1.8', Icons.leaderboard_outlined, Colors.indigo),
            const SizedBox(width: 14),
            _stat('Zero Results', '6.2%', Icons.search_off_outlined, Colors.orange),
          ]),
          const SizedBox(height: 20),
          Expanded(child: Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('Query')),
              DataColumn(label: Text('Search Count')),
              DataColumn(label: Text('Click Rate')),
              DataColumn(label: Text('Avg Rank')),
              DataColumn(label: Text('Trend')),
            ],
            rows: analytics.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          )))),
        ]),
      ),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return Expanded(child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
