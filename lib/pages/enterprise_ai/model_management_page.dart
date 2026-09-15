import 'package:flutter/material.dart';

class ModelManagementPage extends StatelessWidget {
  const ModelManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    final versions = [
      ['Churn Predictor', 'v3.2', 'Production', '01 Sep 2026', 'Healthy'],
      ['Recommendation Engine', 'v2.8', 'Staging', '03 Sep 2026', 'Testing'],
      ['Document OCR Engine', 'v4.1', 'Production', '28 Aug 2026', 'Healthy'],
      ['Sentiment Analyzer', 'v1.5', 'Production', '20 Aug 2026', 'Healthy'],
      ['Demand Forecaster', 'v2.0', 'Staging', '05 Sep 2026', 'Testing'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),title: const Text('Model Management'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Model Management', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Manage model versions, deployments, and lifecycle stages.'),
          const SizedBox(height: 20),
          Row(children: [
            _stat('Total Versions', '27', Icons.layers_outlined, const Color(0xFF0F3D66)),
            const SizedBox(width: 14),
            _stat('In Production', '18', Icons.rocket_launch_outlined, Colors.green),
            const SizedBox(width: 14),
            _stat('In Staging', '6', Icons.science_outlined, Colors.orange),
            const SizedBox(width: 14),
            _stat('Deprecated', '3', Icons.archive_outlined, Colors.grey),
          ]),
          const SizedBox(height: 20),
          Expanded(child: Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('Model Name')),
              DataColumn(label: Text('Version')),
              DataColumn(label: Text('Environment')),
              DataColumn(label: Text('Last Deployed')),
              DataColumn(label: Text('Health')),
            ],
            rows: versions.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          )))),
        ]),
      ),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return Expanded(child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
