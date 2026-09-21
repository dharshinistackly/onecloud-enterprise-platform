import 'package:flutter/material.dart';

class RecommendationsPage extends StatelessWidget {
  const RecommendationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final recommendations = [
      ['TechNova Solutions', 'Upgrade to Enterprise Plus', 'Sales', 'High', 'New'],
      ['CloudWorks Pvt Ltd', 'Add Storage Add-on', 'Sales', 'Medium', 'New'],
      ['DataBridge Systems', 'Renew Annual Contract', 'Customer Success', 'High', 'Actioned'],
      ['InnoSoft Labs', 'Re-engagement Campaign', 'Marketing', 'Medium', 'New'],
      ['NextGen Retail', 'Cross-sell Analytics Module', 'Sales', 'High', 'Actioned'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),title: const Text('Recommendations'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('AI Recommendations', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Actionable, AI-generated recommendations across teams.'),
          const SizedBox(height: 20),
          Wrap(
            spacing: 14,
            runSpacing: 14,
            children: [
            _stat('Total Recommendations', '64', Icons.lightbulb_outline, const Color(0xFF0F3D66)),
            _stat('High Priority', '22', Icons.priority_high_outlined, Colors.red),
            _stat('Actioned', '38', Icons.check_circle_outline, Colors.green),
            _stat('Est. Revenue Impact', '₹18.4L', Icons.trending_up, Colors.orange),
          ]),
          const SizedBox(height: 20),
          Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('Account')),
              DataColumn(label: Text('Recommendation')),
              DataColumn(label: Text('Team')),
              DataColumn(label: Text('Priority')),
              DataColumn(label: Text('Status')),
            ],
            rows: recommendations.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          ))),
        ]),
      )),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return SizedBox(width: 220, child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
