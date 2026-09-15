import 'package:flutter/material.dart';

class DocumentRepositoryPage extends StatelessWidget {
  const DocumentRepositoryPage({super.key});

  static const _navy = Color(0xFF0A1F44);
  static const _bg = Color(0xFFF6F8FC);
  static const _border = Color(0xFFE7ECF3);

  @override
  Widget build(BuildContext context) {
    final docs = [
      ['Vendor Agreement - SteelCorp.pdf', 'Contracts', '2.4 MB', '05 Sep 2026', 'Shared'],
      ['Q3 Financial Report.docx', 'Finance', '1.1 MB', '10 Sep 2026', 'Private'],
      ['Employee Handbook v3.pdf', 'HR', '3.8 MB', '20 Aug 2026', 'Shared'],
      ['Product Spec - Motor Unit.xlsx', 'Engineering', '640 KB', '28 Aug 2026', 'Private'],
      ['Board Meeting Minutes.pdf', 'Governance', '480 KB', '01 Sep 2026', 'Restricted'],
    ];

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),
        title: const Text('Document Repository'),
        backgroundColor: _navy,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Document Repository', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: _navy)),
          const Text('Central storage for all company documents.', style: TextStyle(color: Colors.black54)),
          const SizedBox(height: 20),
          Row(children: [
            _stat('Total Documents', '2,486', Icons.folder_open_outlined, _navy),
            const SizedBox(width: 14),
            _stat('Shared', '1,120', Icons.people_outline, const Color(0xFF1E8E5A)),
            const SizedBox(width: 14),
            _stat('Private', '1,240', Icons.lock_outline, const Color(0xFF2E6DB4)),
            const SizedBox(width: 14),
            _stat('Restricted', '126', Icons.shield_outlined, const Color(0xFFC0392B)),
          ]),
          const SizedBox(height: 20),
          Expanded(child: _table(docs)),
        ]),
      ),
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
            DataColumn(label: Text('Category')),
            DataColumn(label: Text('Size')),
            DataColumn(label: Text('Modified')),
            DataColumn(label: Text('Visibility')),
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
