import 'package:flutter/material.dart';

class ForecastingPage extends StatelessWidget {
  const ForecastingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pipeline = [
      ['TechNova Solutions', 'Negotiation', 'Oct 2026', '80%', '₹15,00,000'],
      ['CloudWorks Pvt Ltd', 'Proposal Sent', 'Nov 2026', '55%', '₹9,50,000'],
      ['DataBridge Systems', 'Renewal', 'Sep 2026', '90%', '₹6,20,000'],
      ['InnoSoft Labs', 'Discovery', 'Dec 2026', '25%', '₹4,00,000'],
      ['NextGen Retail', 'Negotiation', 'Oct 2026', '70%', '₹11,80,000'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),title: const Text('Forecasting'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Revenue Forecasting', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Project future revenue based on pipeline and historical trends.'),
          const SizedBox(height: 20),
          Row(children: [
            _stat('Projected Revenue', '₹46.5L', Icons.insights_outlined, const Color(0xFF0F3D66)),
            const SizedBox(width: 14),
            _stat('Pipeline Value', '₹98.2L', Icons.filter_alt_outlined, Colors.blue),
            const SizedBox(width: 14),
            _stat('Confidence Score', '82%', Icons.verified_outlined, Colors.green),
            const SizedBox(width: 14),
            _stat('Forecast Accuracy', '91%', Icons.track_changes_outlined, Colors.amber),
          ]),
          const SizedBox(height: 20),
          Expanded(child: Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('Account')),
              DataColumn(label: Text('Deal Stage')),
              DataColumn(label: Text('Expected Close')),
              DataColumn(label: Text('Probability')),
              DataColumn(label: Text('Forecasted Value')),
            ],
            rows: pipeline.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          )))),
        ]),
      ),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return Expanded(child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
