import 'package:flutter/material.dart';

class ApiManagementPage extends StatelessWidget {
  const ApiManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    final apis = [
      ['Orders API', 'v2.3', 'Production', 'OAuth 2.0', 'Active'],
      ['Payments API', 'v1.8', 'Production', 'API Key', 'Active'],
      ['Inventory API', 'v3.1', 'Staging', 'OAuth 2.0', 'Active'],
      ['Legacy Billing API', 'v1.0', 'Production', 'Basic Auth', 'Deprecated'],
      ['Notifications API', 'v1.4', 'Production', 'API Key', 'Active'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),title: const Text('API Management'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('API Management', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Manage, version, and monitor your organization\'s APIs.'),
          const SizedBox(height: 20),
          Wrap(
            spacing: 14,
            runSpacing: 14,
            children: [
            _stat('Total APIs', '24', Icons.api_outlined, Colors.blue),
            _stat('Active APIs', '20', Icons.check_circle_outline, Colors.green),
            _stat('Deprecated', '3', Icons.warning_amber_outlined, Colors.orange),
            _stat('Avg Requests/day', '1.2M', Icons.bar_chart_outlined, Colors.indigo),
          ]),
          const SizedBox(height: 20),
          Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('API Name')),
              DataColumn(label: Text('Version')),
              DataColumn(label: Text('Environment')),
              DataColumn(label: Text('Auth Type')),
              DataColumn(label: Text('Status')),
            ],
            rows: apis.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          ))),
        ]),
      )),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return SizedBox(width: 220, child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
