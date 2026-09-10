import 'package:flutter/material.dart';

class GlobalSearchPage extends StatelessWidget {
  const GlobalSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final queries = [
      ['invoice #4521', 'r.menon@company.com', '18', '82ms', '09:44:10'],
      ['reset password', 'a.iyer@company.com', '6', '54ms', '09:41:02'],
      ['q3 sales report', 's.rao@company.com', '32', '110ms', '09:38:47'],
      ['pending approvals', 'k.das@company.com', '0', '61ms', '09:35:19'],
      ['contract renewal', 'p.singh@company.com', '9', '73ms', '09:30:55'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(title: const Text('Global Search'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Global Search', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Monitor search activity across the platform in real time.'),
          const SizedBox(height: 20),
          Row(children: [
            _stat('Searches Today', '12,904', Icons.search_outlined, Colors.blue),
            const SizedBox(width: 14),
            _stat('Avg Response Time', '78ms', Icons.speed_outlined, Colors.green),
            const SizedBox(width: 14),
            _stat('Indexed Documents', '2.4M', Icons.description_outlined, Colors.indigo),
            const SizedBox(width: 14),
            _stat('Zero-Result Rate', '4.1%', Icons.search_off_outlined, Colors.orange),
          ]),
          const SizedBox(height: 20),
          Expanded(child: Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('Query')),
              DataColumn(label: Text('User')),
              DataColumn(label: Text('Results')),
              DataColumn(label: Text('Response Time')),
              DataColumn(label: Text('Timestamp')),
            ],
            rows: queries.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          )))),
        ]),
      ),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return Expanded(child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
