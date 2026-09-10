import 'package:flutter/material.dart';

class PredictiveAnalyticsPage extends StatelessWidget {
  const PredictiveAnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final predictions = [
      ['TechNova Solutions', 'Churn Risk', 'Low', '92%', '05 Sep 2026'],
      ['CloudWorks Pvt Ltd', 'Upsell Potential', 'High', '87%', '05 Sep 2026'],
      ['DataBridge Systems', 'Payment Delay', 'Medium', '78%', '04 Sep 2026'],
      ['InnoSoft Labs', 'Churn Risk', 'High', '84%', '03 Sep 2026'],
      ['NextGen Retail', 'Demand Forecast', 'Growing', '90%', '05 Sep 2026'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(title: const Text('Predictive Analytics'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Predictive Analytics', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('AI-driven predictions on churn, demand, and business risk.'),
          const SizedBox(height: 20),
          Row(children: [
            _stat('Predictions Run', '1,280', Icons.auto_graph_outlined, const Color(0xFF0F3D66)),
            const SizedBox(width: 14),
            _stat('High Risk Accounts', '9', Icons.warning_amber_outlined, Colors.red),
            const SizedBox(width: 14),
            _stat('Upsell Opportunities', '17', Icons.trending_up, Colors.green),
            const SizedBox(width: 14),
            _stat('Model Confidence', '88%', Icons.verified_outlined, Colors.indigo),
          ]),
          const SizedBox(height: 20),
          Expanded(child: Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('Account')),
              DataColumn(label: Text('Prediction Type')),
              DataColumn(label: Text('Result')),
              DataColumn(label: Text('Confidence')),
              DataColumn(label: Text('Generated On')),
            ],
            rows: predictions.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          )))),
        ]),
      ),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return Expanded(child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
