import 'package:flutter/material.dart';

class AiModelsPage extends StatelessWidget {
  const AiModelsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final models = [
      ['Claude Sonnet 5', 'LLM', 'Anthropic', 'Active', '99.9%'],
      ['Document OCR Engine', 'Vision', 'Internal', 'Active', '99.4%'],
      ['Churn Predictor v3', 'Classification', 'Internal', 'Active', '98.7%'],
      ['Recommendation Engine', 'Ranking', 'Internal', 'Training', '97.2%'],
      ['Sentiment Analyzer', 'NLP', 'Internal', 'Active', '98.9%'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),title: const Text('AI Models'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('AI Models', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Overview of all AI models deployed across the platform.'),
          const SizedBox(height: 20),
          Wrap(
            spacing: 14,
            runSpacing: 14,
            children: [
            _stat('Total Models', '14', Icons.model_training_outlined, const Color(0xFF0F3D66)),
            _stat('Active Models', '11', Icons.check_circle_outline, Colors.green),
            _stat('In Training', '2', Icons.hourglass_bottom_outlined, Colors.orange),
            _stat('Avg Accuracy', '98.6%', Icons.verified_outlined, Colors.indigo),
          ]),
          const SizedBox(height: 20),
          Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('Model Name')),
              DataColumn(label: Text('Type')),
              DataColumn(label: Text('Provider')),
              DataColumn(label: Text('Status')),
              DataColumn(label: Text('Accuracy')),
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
