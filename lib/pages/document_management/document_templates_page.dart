import 'package:flutter/material.dart';

class DocumentTemplatesPage extends StatelessWidget {
  const DocumentTemplatesPage({super.key});

  static const _navy = Color(0xFF0A1F44);
  static const _bg = Color(0xFFF6F8FC);
  static const _border = Color(0xFFE7ECF3);

  @override
  Widget build(BuildContext context) {
    final templates = [
      ['Vendor Contract Template', 'Legal', '62 uses', '04 Sep 2026', 'Active'],
      ['Offer Letter Template', 'HR', '38 uses', '20 Aug 2026', 'Active'],
      ['Invoice Template', 'Finance', '210 uses', '10 Sep 2026', 'Active'],
      ['NDA Template', 'Legal', '44 uses', '28 Aug 2026', 'Active'],
      ['Old Purchase Order Format', 'Procurement', '2 uses', '15 Mar 2026', 'Deprecated'],
    ];

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        title: const Text('Document Templates'),
        backgroundColor: _navy,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Document Templates', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: _navy)),
          const Text('Reusable templates for common document types.', style: TextStyle(color: Colors.black54)),
          const SizedBox(height: 20),
          Row(children: [
            _stat('Total Templates', '58', Icons.description_outlined, _navy),
            const SizedBox(width: 14),
            _stat('Active', '51', Icons.check_circle_outline, const Color(0xFF1E8E5A)),
            const SizedBox(width: 14),
            _stat('Draft', '4', Icons.edit_note_outlined, const Color(0xFFC98A1B)),
            const SizedBox(width: 14),
            _stat('Deprecated', '3', Icons.archive_outlined, const Color(0xFF6C4EB6)),
          ]),
          const SizedBox(height: 20),
          Expanded(child: _table(templates)),
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
            DataColumn(label: Text('Template')),
            DataColumn(label: Text('Category')),
            DataColumn(label: Text('Usage')),
            DataColumn(label: Text('Last Updated')),
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
