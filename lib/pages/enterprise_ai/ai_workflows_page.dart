import 'package:flutter/material.dart';

class AiWorkflowsPage extends StatelessWidget {
  const AiWorkflowsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final workflows = [
      ['Invoice Extraction & Approval', 'Document AI + Workflow', '5 steps', '2 hrs ago', 'Active'],
      ['Lead Scoring & Routing', 'Predictive Model + CRM', '4 steps', '5 hrs ago', 'Active'],
      ['Support Ticket Triage', 'NLP Classifier', '3 steps', '1 day ago', 'Active'],
      ['Contract Risk Review', 'Document AI + Rules Engine', '6 steps', '3 hrs ago', 'Paused'],
      ['Expense Anomaly Detection', 'Anomaly Model + Finance', '4 steps', '4 hrs ago', 'Active'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(title: const Text('AI Workflows'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('AI Workflows', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Automated multi-step workflows powered by AI models.'),
          const SizedBox(height: 20),
          Row(children: [
            _stat('Total Workflows', '19', Icons.account_tree_outlined, const Color(0xFF0F3D66)),
            const SizedBox(width: 14),
            _stat('Active Workflows', '16', Icons.play_circle_outline, Colors.green),
            const SizedBox(width: 14),
            _stat('Runs Today', '284', Icons.bolt_outlined, Colors.orange),
            const SizedBox(width: 14),
            _stat('Avg Success Rate', '96.5%', Icons.verified_outlined, Colors.indigo),
          ]),
          const SizedBox(height: 20),
          Expanded(child: Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('Workflow Name')),
              DataColumn(label: Text('Components')),
              DataColumn(label: Text('Steps')),
              DataColumn(label: Text('Last Run')),
              DataColumn(label: Text('Status')),
            ],
            rows: workflows.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          )))),
        ]),
      ),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return Expanded(child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
