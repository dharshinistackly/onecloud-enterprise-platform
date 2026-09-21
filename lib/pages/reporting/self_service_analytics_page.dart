import 'package:flutter/material.dart';

class SelfServiceAnalyticsPage extends StatelessWidget {
  const SelfServiceAnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final activity = [
      ['Arun Kumar', 'Regional Sales View', 'Sales DB', '2 hrs ago', 'Editor'],
      ['Priya Sharma', 'Support Ticket Query', 'Support DB', '5 hrs ago', 'Viewer'],
      ['Rahul Menon', 'Inventory Aging View', 'ERP DB', '1 day ago', 'Editor'],
      ['Sneha Iyer', 'Attrition Rate Query', 'HR DB', '3 hrs ago', 'Viewer'],
      ['Vikram Rao', 'Campaign ROI View', 'CRM DB', '4 hrs ago', 'Editor'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),title: const Text('Self-Service Analytics'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Self-Service Analytics', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Let teams build their own queries and saved views without IT support.'),
          const SizedBox(height: 20),
          Wrap(
            spacing: 14,
            runSpacing: 14,
            children: [
            _stat('Active Users', '73', Icons.people_outline, const Color(0xFF0F3D66)),
            _stat('Custom Queries', '142', Icons.query_stats_outlined, Colors.blue),
            _stat('Saved Views', '58', Icons.bookmark_border_outlined, Colors.purple),
            _stat('Avg Session Time', '11m 40s', Icons.timer_outlined, Colors.teal),
          ]),
          const SizedBox(height: 20),
          Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('User')),
              DataColumn(label: Text('Query / View')),
              DataColumn(label: Text('Data Source')),
              DataColumn(label: Text('Last Used')),
              DataColumn(label: Text('Access Level')),
            ],
            rows: activity.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          ))),
        ]),
      )),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return SizedBox(width: 220, child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
