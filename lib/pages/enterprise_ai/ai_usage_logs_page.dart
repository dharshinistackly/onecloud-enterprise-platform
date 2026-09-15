import 'package:flutter/material.dart';

class AiUsageLogsPage extends StatelessWidget {
  const AiUsageLogsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logs = [
      ['Arun Kumar', 'AI Chat Copilot', '1,240 tokens', '2 hrs ago', 'Success'],
      ['Priya Sharma', 'Document AI / OCR', '3 pages', '5 hrs ago', 'Success'],
      ['Rahul Menon', 'Predictive Analytics', '1 query', '1 day ago', 'Success'],
      ['Sneha Iyer', 'AI Chat Copilot', '860 tokens', '3 hrs ago', 'Failed'],
      ['Vikram Rao', 'Recommendations', '1 batch run', '4 hrs ago', 'Success'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),title: const Text('AI Usage Logs'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('AI Usage Logs', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Audit trail of AI feature usage across the organization.'),
          const SizedBox(height: 20),
          Row(children: [
            _stat('Total Requests', '18,420', Icons.list_alt_outlined, const Color(0xFF0F3D66)),
            const SizedBox(width: 14),
            _stat('Tokens Used Today', '482K', Icons.token_outlined, Colors.indigo),
            const SizedBox(width: 14),
            _stat('Failed Requests', '38', Icons.error_outline, Colors.red),
            const SizedBox(width: 14),
            _stat('Success Rate', '99.2%', Icons.check_circle_outline, Colors.green),
          ]),
          const SizedBox(height: 20),
          Expanded(child: Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('User')),
              DataColumn(label: Text('Feature Used')),
              DataColumn(label: Text('Usage')),
              DataColumn(label: Text('Timestamp')),
              DataColumn(label: Text('Status')),
            ],
            rows: logs.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          )))),
        ]),
      ),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return Expanded(child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
