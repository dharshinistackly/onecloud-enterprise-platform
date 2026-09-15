import 'package:flutter/material.dart';

class AuditLogsPage extends StatelessWidget {
  const AuditLogsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logs = [
      ['09:44:10', 'r.menon@company.com', 'Updated Role', 'User: a.iyer', 'Success'],
      ['09:38:22', 'admin@company.com', 'Deleted Record', 'Account: InnoSoft Labs', 'Success'],
      ['09:30:47', 's.rao@company.com', 'Login Attempt', 'Auth Service', 'Failed'],
      ['09:21:05', 'k.das@company.com', 'Exported Data', 'Customer Report', 'Success'],
      ['09:15:33', 'p.singh@company.com', 'Changed Permission', 'Policy: Data Access', 'Success'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),title: const Text('Audit Logs'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Audit Logs', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Track every action taken across the system for accountability.'),
          const SizedBox(height: 20),
          Row(children: [
            _stat('Total Audit Events', '18,204', Icons.fact_check_outlined, Colors.blue),
            const SizedBox(width: 14),
            _stat('Critical Events', '12', Icons.report_gmailerrorred_outlined, Colors.red),
            const SizedBox(width: 14),
            _stat('Users Tracked', '312', Icons.people_alt_outlined, Colors.indigo),
            const SizedBox(width: 14),
            _stat('Avg Events/day', '640', Icons.timeline_outlined, Colors.orange),
          ]),
          const SizedBox(height: 20),
          Expanded(child: Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('Timestamp')),
              DataColumn(label: Text('User')),
              DataColumn(label: Text('Action')),
              DataColumn(label: Text('Resource')),
              DataColumn(label: Text('Result')),
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
