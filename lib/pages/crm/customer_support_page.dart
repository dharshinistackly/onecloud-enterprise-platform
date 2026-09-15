import 'package:flutter/material.dart';

class CustomerSupportPage extends StatelessWidget {
  const CustomerSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tickets = [
      ['CS-2041', 'TechNova Solutions', 'Login issue', 'High', 'Open'],
      ['CS-2042', 'CloudWorks Pvt Ltd', 'Billing clarification', 'Medium', 'In Progress'],
      ['CS-2043', 'DataBridge Systems', 'API integration', 'High', 'Open'],
      ['CS-2044', 'InnoSoft Labs', 'Password reset', 'Low', 'Resolved'],
      ['CS-2045', 'NextGen Retail', 'Report export issue', 'Medium', 'In Progress'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),title: const Text('Customer Support'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: Padding(padding: const EdgeInsets.all(24), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Customer Support', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            Text('Manage customer tickets, issues and service requests.'),
          ]),
          ElevatedButton.icon(onPressed: () => _showTicketDialog(context), icon: const Icon(Icons.add), label: const Text('New Ticket')),
        ]),
        const SizedBox(height: 20),
        Row(children: [
          _stat('Total Tickets', '64', Icons.support_agent_outlined, Colors.blue),
          const SizedBox(width: 14),
          _stat('Open', '18', Icons.error_outline, Colors.red),
          const SizedBox(width: 14),
          _stat('In Progress', '12', Icons.sync, Colors.orange),
          const SizedBox(width: 14),
          _stat('Resolved', '34', Icons.check_circle_outline, Colors.green),
        ]),
        const SizedBox(height: 20),
        Expanded(child: Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
          columns: const [DataColumn(label: Text('Ticket')), DataColumn(label: Text('Customer')), DataColumn(label: Text('Issue')), DataColumn(label: Text('Priority')), DataColumn(label: Text('Status'))],
          rows: tickets.map((t) => DataRow(cells: [for (final item in t) DataCell(Text(item))])).toList(),
        )))),
      ])),
    );
  }

  void _showTicketDialog(BuildContext context) {
    showDialog(context: context, builder: (_) => AlertDialog(
      title: const Text('New Support Ticket'),
      content: const Text('Ticket creation form is available in this demo CRM module.'),
      actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close'))],
    ));
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return Expanded(child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
