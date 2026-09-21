import 'package:flutter/material.dart';

class StandardReportsPage extends StatelessWidget {
  const StandardReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final reports = [
      ['Monthly Sales Summary', 'Sales', 'PDF', '01 Sep 2026', 'Generated'],
      ['Employee Attendance Report', 'HR', 'Excel', '02 Sep 2026', 'Generated'],
      ['Inventory Stock Report', 'Operations', 'PDF', '31 Aug 2026', 'Generated'],
      ['Customer Support Summary', 'Support', 'Excel', '03 Sep 2026', 'Generated'],
      ['Financial Statement', 'Finance', 'PDF', '01 Sep 2026', 'Generated'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),title: const Text('Standard Reports'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Standard Reports', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Access predefined reports across all business modules.'),
          const SizedBox(height: 20),
          Wrap(
            spacing: 14,
            runSpacing: 14,
            children: [
            _stat('Total Reports', '64', Icons.description_outlined, const Color(0xFF0F3D66)),
            _stat('Most Used', 'Sales Summary', Icons.star_border_outlined, Colors.orange),
            _stat('Run Today', '18', Icons.play_circle_outline, Colors.green),
            _stat('Avg Generation Time', '3.2s', Icons.speed_outlined, Colors.indigo),
          ]),
          const SizedBox(height: 20),
          Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('Report Name')),
              DataColumn(label: Text('Category')),
              DataColumn(label: Text('Format')),
              DataColumn(label: Text('Last Run')),
              DataColumn(label: Text('Status')),
            ],
            rows: reports.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          ))),
        ]),
      )),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return SizedBox(width: 220, child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
