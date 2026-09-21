import 'package:flutter/material.dart';

class TaggingSearchPage extends StatelessWidget {
  const TaggingSearchPage({super.key});

  static const _navy = Color(0xFF0A1F44);
  static const _bg = Color(0xFFF6F8FC);
  static const _border = Color(0xFFE7ECF3);

  @override
  Widget build(BuildContext context) {
    final tags = [
      ['Vendor Agreement - SteelCorp.pdf', 'contract, vendor, steel', '3 tags', '05 Sep 2026', 'Indexed'],
      ['Q3 Financial Report.docx', 'finance, quarterly, report', '3 tags', '10 Sep 2026', 'Indexed'],
      ['Employee Handbook.pdf', 'hr, policy, onboarding', '3 tags', '20 Aug 2026', 'Indexed'],
      ['Product Spec - Motor Unit.xlsx', 'engineering, spec, motor', '3 tags', '28 Aug 2026', 'Pending'],
      ['Board Meeting Minutes.pdf', 'governance, board, minutes', '3 tags', '01 Sep 2026', 'Indexed'],
    ];

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),
        title: const Text('Tagging & Search'),
        backgroundColor: _navy,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Tagging & Search', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: _navy)),
          const Text('Organize and quickly locate documents by tag.', style: TextStyle(color: Colors.black54)),
          const SizedBox(height: 20),
          Wrap(
            spacing: 14,
            runSpacing: 14,
            children: [
            _stat('Tagged Documents', '2,140', Icons.label_outline, _navy),
            _stat('Indexed', '2,046', Icons.check_circle_outline, const Color(0xFF1E8E5A)),
            _stat('Pending Index', '82', Icons.hourglass_empty_outlined, const Color(0xFFC98A1B)),
            _stat('Unique Tags', '318', Icons.sell_outlined, const Color(0xFF2E6DB4)),
          ]),
          const SizedBox(height: 20),
          _table(tags),
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
            DataColumn(label: Text('Tags')),
            DataColumn(label: Text('Tag Count')),
            DataColumn(label: Text('Modified')),
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
