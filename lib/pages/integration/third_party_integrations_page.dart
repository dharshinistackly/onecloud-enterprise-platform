import 'package:flutter/material.dart';

class ThirdPartyIntegrationsPage extends StatelessWidget {
  const ThirdPartyIntegrationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final integrations = [
      ['Salesforce', 'CRM', 'Salesforce Inc.', 'Real-time', 'Connected'],
      ['Slack', 'Communication', 'Slack Technologies', 'Real-time', 'Connected'],
      ['Zendesk', 'Support', 'Zendesk Inc.', 'Hourly', 'Connected'],
      ['Mailchimp', 'Marketing', 'Intuit', 'Daily', 'Failed'],
      ['QuickBooks', 'Finance', 'Intuit', 'Daily', 'Pending Setup'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),title: const Text('Third-Party Integrations'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Third-Party Integrations', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Connect and manage external platforms and services.'),
          const SizedBox(height: 20),
          Row(children: [
            _stat('Total Integrations', '18', Icons.extension_outlined, Colors.blue),
            const SizedBox(width: 14),
            _stat('Connected', '14', Icons.link, Colors.green),
            const SizedBox(width: 14),
            _stat('Failed', '2', Icons.error_outline, Colors.red),
            const SizedBox(width: 14),
            _stat('Pending Setup', '2', Icons.hourglass_empty, Colors.orange),
          ]),
          const SizedBox(height: 20),
          Expanded(child: Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('Integration')),
              DataColumn(label: Text('Category')),
              DataColumn(label: Text('Provider')),
              DataColumn(label: Text('Sync Frequency')),
              DataColumn(label: Text('Status')),
            ],
            rows: integrations.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          )))),
        ]),
      ),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return Expanded(child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
