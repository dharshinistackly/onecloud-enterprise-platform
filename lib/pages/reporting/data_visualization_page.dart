import 'package:flutter/material.dart';

class DataVisualizationPage extends StatelessWidget {
  const DataVisualizationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final charts = [
      ['Revenue by Region', 'Bar Chart', 'Executive Overview', 'Arun Kumar', '2 hrs ago'],
      ['Customer Growth Trend', 'Line Chart', 'Customer Health Score', 'Priya Sharma', '5 hrs ago'],
      ['Ticket Resolution Funnel', 'Funnel Chart', 'Operations Efficiency', 'Rahul Menon', '1 day ago'],
      ['Headcount by Department', 'Pie Chart', 'HR Workforce Insights', 'Sneha Iyer', '3 hrs ago'],
      ['Cash Flow Overview', 'Area Chart', 'Financial Health Dashboard', 'Vikram Rao', '4 hrs ago'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),title: const Text('Data Visualization'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Data Visualization', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Build and manage charts embedded across BI dashboards.'),
          const SizedBox(height: 20),
          Row(children: [
            _stat('Total Charts', '96', Icons.insert_chart_outlined, const Color(0xFF0F3D66)),
            const SizedBox(width: 14),
            _stat('Dashboards', '24', Icons.dashboard_outlined, Colors.indigo),
            const SizedBox(width: 14),
            _stat('Most Viewed', 'Revenue by Region', Icons.visibility_outlined, Colors.orange),
            const SizedBox(width: 14),
            _stat('Avg Load Time', '0.9s', Icons.speed_outlined, Colors.teal),
          ]),
          const SizedBox(height: 20),
          Expanded(child: Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('Chart Name')),
              DataColumn(label: Text('Type')),
              DataColumn(label: Text('Dashboard')),
              DataColumn(label: Text('Created By')),
              DataColumn(label: Text('Last Modified')),
            ],
            rows: charts.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          )))),
        ]),
      ),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return Expanded(child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
