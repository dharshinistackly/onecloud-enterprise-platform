import 'package:flutter/material.dart';

class ComplianceReportsPage extends StatelessWidget {
  const ComplianceReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final reports = [
      ['SOC 2 Type II', 'SOC 2', 'Organization-wide', '2 days ago', 'Compliant'],
      ['GDPR Data Processing', 'GDPR', 'EU Customer Data', '1 week ago', 'Compliant'],
      ['ISO 27001 Assessment', 'ISO 27001', 'Infrastructure', '3 weeks ago', 'Non-Compliant'],
      ['HIPAA Safeguards', 'HIPAA', 'Health Data Module', '5 days ago', 'Pending Review'],
      ['PCI DSS Audit', 'PCI DSS', 'Payments Platform', '1 month ago', 'Compliant'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),title: const Text('Compliance Reports'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Compliance Reports', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Track regulatory and industry compliance across frameworks.'),
          const SizedBox(height: 20),
          Wrap(
            spacing: 14,
            runSpacing: 14,
            children: [
            _stat('Total Reports', '26', Icons.assignment_outlined, Colors.blue),
            _stat('Compliant', '21', Icons.verified_outlined, Colors.green),
            _stat('Non-Compliant', '2', Icons.gpp_bad_outlined, Colors.red),
            _stat('Pending Review', '3', Icons.hourglass_empty, Colors.orange),
          ]),
          const SizedBox(height: 20),
          Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('Report Name')),
              DataColumn(label: Text('Framework')),
              DataColumn(label: Text('Scope')),
              DataColumn(label: Text('Last Generated')),
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
