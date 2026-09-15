import 'package:flutter/material.dart';

class SynonymsPage extends StatelessWidget {
  const SynonymsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final synonyms = [
      ['invoice', 'bill, receipt, statement', 'English', 'Global', 'Active'],
      ['cancel', 'terminate, discontinue, stop', 'English', 'Global', 'Active'],
      ['laptop', 'notebook, portable computer', 'English', 'Products', 'Active'],
      ['refund', 'reimbursement, money back', 'English', 'Billing', 'Active'],
      ['support', 'help, assistance, service desk', 'English', 'Global', 'Disabled'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),title: const Text('Synonyms'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Synonyms', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Manage synonym groups that broaden search matching.'),
          const SizedBox(height: 20),
          Row(children: [
            _stat('Synonym Groups', '134', Icons.compare_arrows_outlined, Colors.blue),
            const SizedBox(width: 14),
            _stat('Active', '119', Icons.check_circle_outline, Colors.green),
            const SizedBox(width: 14),
            _stat('Languages', '6', Icons.translate_outlined, Colors.indigo),
            const SizedBox(width: 14),
            _stat('Last Updated', '2 hr ago', Icons.update_outlined, Colors.orange),
          ]),
          const SizedBox(height: 20),
          Expanded(child: Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('Term')),
              DataColumn(label: Text('Synonyms')),
              DataColumn(label: Text('Language')),
              DataColumn(label: Text('Scope')),
              DataColumn(label: Text('Status')),
            ],
            rows: synonyms.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          )))),
        ]),
      ),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return Expanded(child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
