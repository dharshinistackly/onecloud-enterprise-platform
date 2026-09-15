import 'package:flutter/material.dart';

class AiChatCopilotPage extends StatelessWidget {
  const AiChatCopilotPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sessions = [
      ['Arun Kumar', 'Sales', 'Draft a follow-up email', '2 hrs ago', 'Completed'],
      ['Priya Sharma', 'Support', 'Summarize ticket thread', '5 hrs ago', 'Completed'],
      ['Rahul Menon', 'Operations', 'Explain inventory variance', '1 day ago', 'Completed'],
      ['Sneha Iyer', 'HR', 'Draft onboarding checklist', '3 hrs ago', 'Completed'],
      ['Vikram Rao', 'Finance', 'Summarize Q3 expenses', '4 hrs ago', 'In Progress'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),title: const Text('AI Chat Copilot'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('AI Chat Copilot', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Conversational AI assistant embedded across the workspace.'),
          const SizedBox(height: 20),
          Row(children: [
            _stat('Total Sessions', '3,240', Icons.chat_bubble_outline, const Color(0xFF0F3D66)),
            const SizedBox(width: 14),
            _stat('Active Users', '186', Icons.people_outline, Colors.green),
            const SizedBox(width: 14),
            _stat('Avg Response Time', '1.4s', Icons.speed_outlined, Colors.teal),
            const SizedBox(width: 14),
            _stat('Satisfaction Rate', '94%', Icons.thumb_up_alt_outlined, Colors.orange),
          ]),
          const SizedBox(height: 20),
          Expanded(child: Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('User')),
              DataColumn(label: Text('Department')),
              DataColumn(label: Text('Query')),
              DataColumn(label: Text('Last Active')),
              DataColumn(label: Text('Status')),
            ],
            rows: sessions.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          )))),
        ]),
      ),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return Expanded(child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
