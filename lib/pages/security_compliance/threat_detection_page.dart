import 'package:flutter/material.dart';

class ThreatDetectionPage extends StatelessWidget {
  const ThreatDetectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final threats = [
      ['Brute Force Attempt', '203.0.113.4', 'High', '09:44:10', 'Blocked'],
      ['Malware Signature Match', 'Endpoint: LAP-2291', 'Critical', '09:30:22', 'Investigating'],
      ['Unusual Login Location', 'User: k.das', 'Medium', '09:18:47', 'Blocked'],
      ['Port Scan Detected', '198.51.100.22', 'Medium', '08:55:05', 'Blocked'],
      ['Phishing Email Reported', 'Email Gateway', 'High', '08:40:19', 'Investigating'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),title: const Text('Threat Detection'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Threat Detection', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Real-time monitoring of suspicious and malicious activity.'),
          const SizedBox(height: 20),
          Wrap(
            spacing: 14,
            runSpacing: 14,
            children: [
            _stat('Threats Detected Today', '47', Icons.gpp_maybe_outlined, Colors.blue),
            _stat('Blocked', '39', Icons.block_outlined, Colors.green),
            _stat('Under Investigation', '5', Icons.search_outlined, Colors.orange),
            _stat('High Severity', '8', Icons.report_outlined, Colors.red),
          ]),
          const SizedBox(height: 20),
          Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('Threat Type')),
              DataColumn(label: Text('Source')),
              DataColumn(label: Text('Severity')),
              DataColumn(label: Text('Detected At')),
              DataColumn(label: Text('Status')),
            ],
            rows: threats.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          ))),
        ]),
      )),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return SizedBox(width: 220, child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
