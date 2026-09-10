import 'package:flutter/material.dart';

class RelevanceRankingPage extends StatelessWidget {
  const RelevanceRankingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final models = [
      ['Default Ranking Model', 'v5.2', 'Title 3x, Body 1x', '2 days ago', 'Live'],
      ['Personalized Ranking', 'v2.0', 'User History 2x', '5 days ago', 'A/B Testing'],
      ['Popularity Boost', 'v1.4', 'Clicks 2.5x', '1 week ago', 'Live'],
      ['Recency Ranking', 'v1.1', 'Date 2x', '3 weeks ago', 'Paused'],
      ['Category Match Model', 'v3.0', 'Category 1.8x', '1 month ago', 'Live'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(title: const Text('Relevance Ranking'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Relevance Ranking', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Tune and evaluate models that rank search results.'),
          const SizedBox(height: 20),
          Row(children: [
            _stat('Ranking Models', '7', Icons.tune_outlined, Colors.blue),
            const SizedBox(width: 14),
            _stat('Live Models', '4', Icons.check_circle_outline, Colors.green),
            const SizedBox(width: 14),
            _stat('A/B Tests Running', '2', Icons.science_outlined, Colors.indigo),
            const SizedBox(width: 14),
            _stat('Avg Relevance Score', '0.87', Icons.star_border_outlined, Colors.orange),
          ]),
          const SizedBox(height: 20),
          Expanded(child: Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('Model Name')),
              DataColumn(label: Text('Version')),
              DataColumn(label: Text('Field Weights')),
              DataColumn(label: Text('Last Trained')),
              DataColumn(label: Text('Status')),
            ],
            rows: models.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          )))),
        ]),
      ),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return Expanded(child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
