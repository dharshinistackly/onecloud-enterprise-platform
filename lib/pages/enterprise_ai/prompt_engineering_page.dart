import 'package:flutter/material.dart';

class PromptEngineeringPage extends StatelessWidget {
  const PromptEngineeringPage({super.key});

  @override
  Widget build(BuildContext context) {
    final prompts = [
      ['Support Ticket Summarizer', 'Claude Sonnet 5', 'v4', '96% accuracy', 'Live'],
      ['Sales Email Drafter', 'Claude Sonnet 5', 'v2', '91% accuracy', 'Live'],
      ['Invoice Field Extractor', 'Document OCR Engine', 'v6', '98% accuracy', 'Live'],
      ['Meeting Notes Summarizer', 'Claude Sonnet 5', 'v1', '89% accuracy', 'Testing'],
      ['Churn Explanation Generator', 'Claude Sonnet 5', 'v3', '93% accuracy', 'Live'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(title: const Text('Prompt Engineering'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Prompt Engineering', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Design, version, and evaluate prompts used across AI features.'),
          const SizedBox(height: 20),
          Row(children: [
            _stat('Total Prompts', '42', Icons.edit_note_outlined, const Color(0xFF0F3D66)),
            const SizedBox(width: 14),
            _stat('Live Prompts', '35', Icons.check_circle_outline, Colors.green),
            const SizedBox(width: 14),
            _stat('In Testing', '7', Icons.science_outlined, Colors.orange),
            const SizedBox(width: 14),
            _stat('Avg Accuracy', '93.4%', Icons.verified_outlined, Colors.indigo),
          ]),
          const SizedBox(height: 20),
          Expanded(child: Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('Prompt Name')),
              DataColumn(label: Text('Model')),
              DataColumn(label: Text('Version')),
              DataColumn(label: Text('Evaluation')),
              DataColumn(label: Text('Status')),
            ],
            rows: prompts.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          )))),
        ]),
      ),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return Expanded(child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
