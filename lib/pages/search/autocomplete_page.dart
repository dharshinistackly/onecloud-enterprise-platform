import 'package:flutter/material.dart';

class AutocompletePage extends StatelessWidget {
  const AutocompletePage({super.key});

  @override
  Widget build(BuildContext context) {
    final suggestions = [
      ['inv', 'invoice history', 'Query Log', 'High', 'Active'],
      ['res', 'reset password', 'Manual Rule', 'High', 'Active'],
      ['pri', 'pricing plans', 'Query Log', 'Medium', 'Active'],
      ['api', 'api documentation', 'Manual Rule', 'High', 'Active'],
      ['ref', 'refund status', 'Query Log', 'Low', 'Disabled'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),title: const Text('Autocomplete'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Autocomplete', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Configure and monitor type-ahead search suggestions.'),
          const SizedBox(height: 20),
          Row(children: [
            _stat('Total Suggestions', '312', Icons.auto_awesome_outlined, Colors.blue),
            const SizedBox(width: 14),
            _stat('Active Rules', '284', Icons.rule_outlined, Colors.green),
            const SizedBox(width: 14),
            _stat('Avg Suggestions Shown', '5.4', Icons.list_alt_outlined, Colors.indigo),
            const SizedBox(width: 14),
            _stat('Acceptance Rate', '61.2%', Icons.thumb_up_alt_outlined, Colors.orange),
          ]),
          const SizedBox(height: 20),
          Expanded(child: Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('Trigger')),
              DataColumn(label: Text('Suggestion')),
              DataColumn(label: Text('Source')),
              DataColumn(label: Text('Priority')),
              DataColumn(label: Text('Status')),
            ],
            rows: suggestions.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          )))),
        ]),
      ),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return Expanded(child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
