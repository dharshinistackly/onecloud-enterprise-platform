import 'package:flutter/material.dart';

class BiManagementPage extends StatelessWidget {
  const BiManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dashboards = [
      ['Executive Overview', 'Arun Kumar', 'Sales DB', '2 hrs ago', 'Live'],
      ['Customer Health Score', 'Priya Sharma', 'CRM DB', '5 hrs ago', 'Live'],
      ['Operations Efficiency', 'Rahul Menon', 'ERP DB', '1 day ago', 'Live'],
      ['HR Workforce Insights', 'Sneha Iyer', 'HR DB', '3 hrs ago', 'Draft'],
      ['Financial Health Dashboard', 'Vikram Rao', 'Finance DB', '4 hrs ago', 'Live'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),title: const Text('BI Management'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('BI Management', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Manage business intelligence dashboards and data connectors.'),
          const SizedBox(height: 20),
          Wrap(
            spacing: 14,
            runSpacing: 14,
            children: [
            _stat('BI Dashboards', '24', Icons.dashboard_outlined, const Color(0xFF0F3D66)),
            _stat('Active Users', '58', Icons.people_outline, Colors.green),
            _stat('Data Connectors', '11', Icons.cable_outlined, Colors.indigo),
            _stat('Uptime', '99.8%', Icons.health_and_safety_outlined, Colors.teal),
          ]),
          const SizedBox(height: 20),
          Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('Dashboard Name')),
              DataColumn(label: Text('Owner')),
              DataColumn(label: Text('Data Source')),
              DataColumn(label: Text('Last Updated')),
              DataColumn(label: Text('Status')),
            ],
            rows: dashboards.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          ))),
        ]),
      )),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return SizedBox(width: 220, child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
