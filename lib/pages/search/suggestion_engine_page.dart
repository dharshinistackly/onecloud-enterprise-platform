import 'package:flutter/material.dart';

class SuggestionEnginePage extends StatelessWidget {
  const SuggestionEnginePage({super.key});

  @override
  Widget build(BuildContext context) {
    final suggestions = [
      ['Related Products', 'Collaborative Filtering', '182,400', '12.4%', 'Live'],
      ['Trending Searches', 'Popularity Model', '94,220', '9.8%', 'Live'],
      ['Personalized Picks', 'User Embeddings', '210,760', '17.2%', 'A/B Testing'],
      ['Recently Viewed', 'Session History', '38,910', '6.1%', 'Live'],
      ['New Arrivals', 'Recency Model', '56,300', '4.3%', 'Paused'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(title: const Text('Suggestion Engine'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Suggestion Engine', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Monitor recommendation and suggestion models across the app.'),
          const SizedBox(height: 20),
          Row(children: [
            _stat('Suggestions Served', '582K', Icons.recommend_outlined, Colors.blue),
            const SizedBox(width: 14),
            _stat('Click-Through Rate', '11.6%', Icons.ads_click_outlined, Colors.green),
            const SizedBox(width: 14),
            _stat('Model Version', 'v4.3', Icons.model_training_outlined, Colors.indigo),
            const SizedBox(width: 14),
            _stat('Personalization', 'Enabled', Icons.person_outline, Colors.orange),
          ]),
          const SizedBox(height: 20),
          Expanded(child: Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('Suggestion Type')),
              DataColumn(label: Text('Source')),
              DataColumn(label: Text('Impressions')),
              DataColumn(label: Text('CTR')),
              DataColumn(label: Text('Status')),
            ],
            rows: suggestions.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          )))),
        ]),
      ),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return Expanded(child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
