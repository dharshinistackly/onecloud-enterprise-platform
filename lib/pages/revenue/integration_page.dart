import 'package:flutter/material.dart';

class RevenueIntegrationPage extends StatelessWidget {
  const RevenueIntegrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final integrations = [
      ['Stripe', 'Payment Gateway', 'Connected', '2 min ago', 'Healthy'],
      ['QuickBooks', 'Accounting', 'Connected', '10 min ago', 'Healthy'],
      ['Salesforce CRM', 'CRM Sync', 'Connected', '1 hr ago', 'Healthy'],
      ['Zoho Books', 'Accounting', 'Disconnected', '2 days ago', 'Error'],
      ['Razorpay', 'Payment Gateway', 'Connected', '15 min ago', 'Healthy'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),title: const Text('Integration'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Revenue Integrations', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Manage connections with payment, accounting, and CRM systems.'),
          const SizedBox(height: 20),
          Wrap(
            spacing: 14,
            runSpacing: 14,
            children: [
            _stat('Connected Systems', '4', Icons.hub_outlined, const Color(0xFF0F3D66)),
            _stat('Active Syncs', '3', Icons.sync_outlined, Colors.green),
            _stat('Failed Syncs', '1', Icons.sync_problem_outlined, Colors.red),
            _stat('Last Sync', '2 min ago', Icons.update_outlined, Colors.blue),
          ]),
          const SizedBox(height: 20),
          Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('Integration')),
              DataColumn(label: Text('Type')),
              DataColumn(label: Text('Status')),
              DataColumn(label: Text('Last Synced')),
              DataColumn(label: Text('Health')),
            ],
            rows: integrations.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          ))),
        ]),
      )),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return SizedBox(width: 220, child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
