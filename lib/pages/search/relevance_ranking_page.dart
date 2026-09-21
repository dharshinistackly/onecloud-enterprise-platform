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
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),title: const Text('Relevance Ranking'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Relevance Ranking', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Tune and evaluate models that rank search results.'),
          const SizedBox(height: 20),
          Wrap(
            spacing: 14,
            runSpacing: 14,
            children: [
            _stat('Ranking Models', '7', Icons.tune_outlined, Colors.blue),
            _stat('Live Models', '4', Icons.check_circle_outline, Colors.green),
            _stat('A/B Tests Running', '2', Icons.science_outlined, Colors.indigo),
            _stat('Avg Relevance Score', '0.87', Icons.star_border_outlined, Colors.orange),
          ]),
          const SizedBox(height: 20),
          Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('Model Name')),
              DataColumn(label: Text('Version')),
              DataColumn(label: Text('Field Weights')),
              DataColumn(label: Text('Last Trained')),
              DataColumn(label: Text('Status')),
            ],
            rows: models.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          ))),
        ]),
      )),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return SizedBox(width: 220, child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
