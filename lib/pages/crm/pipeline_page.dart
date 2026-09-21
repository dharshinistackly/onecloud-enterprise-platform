import 'package:flutter/material.dart';

class PipelinePage extends StatelessWidget {
  const PipelinePage({super.key});

  @override
  Widget build(BuildContext context) {
    final stages = [
      {'stage': 'New', 'count': '8', 'value': '₹12.5 L', 'color': Colors.blue},
      {'stage': 'Qualified', 'count': '12', 'value': '₹28.4 L', 'color': Colors.indigo},
      {'stage': 'Proposal', 'count': '7', 'value': '₹19.8 L', 'color': Colors.orange},
      {'stage': 'Negotiation', 'count': '5', 'value': '₹14.2 L', 'color': Colors.deepPurple},
      {'stage': 'Closed Won', 'count': '9', 'value': '₹31.6 L', 'color': Colors.green},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),title: const Text('Pipeline'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: SingleChildScrollView(child: Padding(padding: const EdgeInsets.all(24), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Sales Pipeline', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        const Text('Monitor opportunities across every sales stage.'),
        const SizedBox(height: 24),
        Expanded(child: ListView.separated(
          itemCount: stages.length,
          separatorBuilder: (_, __) => const SizedBox(height: 14),
          itemBuilder: (context, index) {
            final stage = stages[index];
            return Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(22), child: Row(children: [
              Container(width: 52, height: 52, decoration: BoxDecoration(color: (stage['color'] as Color).withValues(alpha: 0.12), borderRadius: BorderRadius.circular(12)), child: Icon(Icons.trending_up, color: stage['color'] as Color)),
              const SizedBox(width: 18),
              Expanded(child: Text(stage['stage'] as String, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600))),
              Text('${stage['count']} deals', style: const TextStyle(color: Colors.grey)),
              const SizedBox(width: 40),
              Text(stage['value'] as String, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ])));
          },
        )),
      ]))),
    );
  }
}
