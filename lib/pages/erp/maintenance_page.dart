import 'package:flutter/material.dart';

class MaintenancePage extends StatelessWidget {
  const MaintenancePage({super.key});

  @override
  Widget build(BuildContext context) {
    final tickets = [
      ['MT-401', 'CNC Machine M1', 'Preventive', 'Ramesh Kumar', 'Scheduled'],
      ['MT-402', 'Server Rack SR-2', 'Corrective', 'Priya Sharma', 'In Progress'],
      ['MT-403', 'Forklift F-4', 'Inspection', 'Arun Vel', 'Completed'],
      ['MT-404', 'Generator G-3', 'Corrective', 'Sathish Raj', 'Overdue'],
      ['MT-405', 'Conveyor Belt CB-7', 'Preventive', 'Meena Raj', 'Completed'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),title: const Text('Maintenance'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Maintenance Management', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Track maintenance tickets and asset upkeep.'),
          const SizedBox(height: 20),
          Wrap(
            spacing: 14,
            runSpacing: 14,
            children: [
            _stat('Total Tickets', '142', Icons.build_circle_outlined, Colors.blue),
            _stat('In Progress', '36', Icons.autorenew, Colors.orange),
            _stat('Completed', '94', Icons.check_circle_outline, Colors.green),
            _stat('Overdue', '12', Icons.report_gmailerrorred_outlined, Colors.red),
          ]),
          const SizedBox(height: 20),
          Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('Ticket No')),
              DataColumn(label: Text('Asset')),
              DataColumn(label: Text('Type')),
              DataColumn(label: Text('Assigned To')),
              DataColumn(label: Text('Status')),
            ],
            rows: tickets.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          ))),
        ]),
      )),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return SizedBox(width: 220, child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
