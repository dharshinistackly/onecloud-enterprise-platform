import 'package:flutter/material.dart';

class DataExportPage extends StatelessWidget {
  const DataExportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final exports = [
      ['Customer Master Export', 'CSV', 'Local Download', '05 Sep 2026', 'Completed'],
      ['Sales Ledger Export', 'Excel', 'Email', '04 Sep 2026', 'Completed'],
      ['Inventory Snapshot', 'JSON', 'API Endpoint', '03 Sep 2026', 'Completed'],
      ['Support Tickets Backup', 'CSV', 'Cloud Storage', '02 Sep 2026', 'Failed'],
      ['Payroll Summary Export', 'PDF', 'Email', '01 Sep 2026', 'Completed'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),title: const Text('Data Export'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Data Export', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Export data to files, storage, or downstream systems.'),
          const SizedBox(height: 20),
          Row(children: [
            _stat('Total Exports', '212', Icons.file_upload_outlined, const Color(0xFF0F3D66)),
            const SizedBox(width: 14),
            _stat('Scheduled Exports', '15', Icons.schedule_outlined, Colors.orange),
            const SizedBox(width: 14),
            _stat('Export Formats', '4', Icons.folder_zip_outlined, Colors.indigo),
            const SizedBox(width: 14),
            _stat('Exported This Month', '18.4 GB', Icons.cloud_upload_outlined, Colors.teal),
          ]),
          const SizedBox(height: 20),
          Expanded(child: Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('Export Name')),
              DataColumn(label: Text('Format')),
              DataColumn(label: Text('Destination')),
              DataColumn(label: Text('Last Exported')),
              DataColumn(label: Text('Status')),
            ],
            rows: exports.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          )))),
        ]),
      ),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return Expanded(child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
