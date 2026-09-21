import 'package:flutter/material.dart';

class FileUploadDownloadPage extends StatelessWidget {
  const FileUploadDownloadPage({super.key});

  static const _navy = Color(0xFF0A1F44);
  static const _bg = Color(0xFFF6F8FC);
  static const _border = Color(0xFFE7ECF3);

  @override
  Widget build(BuildContext context) {
    final transfers = [
      ['Vendor Agreement - SteelCorp.pdf', 'Upload', 'Sathish Raj', '2.4 MB', 'Completed'],
      ['Q3 Financial Report.docx', 'Download', 'Meena Raj', '1.1 MB', 'Completed'],
      ['Product Catalog 2026.zip', 'Upload', 'Arun Vel', '45.2 MB', 'In Progress'],
      ['Employee Photos.zip', 'Download', 'Priya Sharma', '18.6 MB', 'Failed'],
      ['Audit Report Draft.pdf', 'Upload', 'Ramesh Kumar', '3.0 MB', 'Completed'],
    ];

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),
        title: const Text('File Upload / Download'),
        backgroundColor: _navy,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('File Upload / Download', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: _navy)),
          const Text('Monitor file transfer activity across the system.', style: TextStyle(color: Colors.black54)),
          const SizedBox(height: 20),
          Wrap(
            spacing: 14,
            runSpacing: 14,
            children: [
            _stat('Total Transfers', '1,340', Icons.swap_vert_outlined, _navy),
            _stat('Completed', '1,268', Icons.check_circle_outline, const Color(0xFF1E8E5A)),
            _stat('In Progress', '58', Icons.autorenew, const Color(0xFF2E6DB4)),
            _stat('Failed', '14', Icons.error_outline, const Color(0xFFC0392B)),
          ]),
          const SizedBox(height: 20),
          _table(transfers),
        ]),
      )),
    );
  }

  Widget _table(List<List<String>> rows) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: _border)),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor: MaterialStateProperty.all(const Color(0xFFF0F4FA)),
          headingTextStyle: const TextStyle(color: _navy, fontWeight: FontWeight.bold),
          columns: const [
            DataColumn(label: Text('File Name')),
            DataColumn(label: Text('Action')),
            DataColumn(label: Text('User')),
            DataColumn(label: Text('Size')),
            DataColumn(label: Text('Status')),
          ],
          rows: rows.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
        ),
      ),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: _border)),
        child: Row(children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: color.withOpacity(0.12), borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: const TextStyle(color: Colors.black54, fontSize: 12)),
              Text(value, style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: _navy)),
            ]),
          ),
        ]),
      ),
    );
  }
}
