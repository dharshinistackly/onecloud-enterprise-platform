import 'package:flutter/material.dart';

class WorkflowBuilderPage extends StatelessWidget {
  const WorkflowBuilderPage({super.key});

  static const _navy = Color(0xFF0A1F44);
  static const _bg = Color(0xFFF6F8FC);
  static const _border = Color(0xFFE7ECF3);

  @override
  Widget build(BuildContext context) {
    final flows = [
      ['Employee Onboarding', 'HRMS', '6 steps', '12 Aug 2026', 'Published'],
      ['Purchase Order Approval', 'ERP', '4 steps', '02 Sep 2026', 'Published'],
      ['Lead to Deal Conversion', 'CRM', '5 steps', '28 Aug 2026', 'Draft'],
      ['Invoice Escalation', 'Finance', '3 steps', '05 Sep 2026', 'Published'],
      ['Asset Retirement', 'ERP', '4 steps', '20 Aug 2026', 'Draft'],
    ];

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),
        title: const Text('Workflow Builder'),
        backgroundColor: _navy,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Workflow Builder', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: _navy)),
          const Text('Design and publish visual automation workflows.', style: TextStyle(color: Colors.black54)),
          const SizedBox(height: 20),
          Row(children: [
            _stat('Total Workflows', '64', Icons.account_tree_outlined, _navy),
            const SizedBox(width: 14),
            _stat('Published', '48', Icons.check_circle_outline, const Color(0xFF1E8E5A)),
            const SizedBox(width: 14),
            _stat('Draft', '13', Icons.edit_note_outlined, const Color(0xFFC98A1B)),
            const SizedBox(width: 14),
            _stat('Archived', '3', Icons.archive_outlined, const Color(0xFF6C4EB6)),
          ]),
          const SizedBox(height: 20),
          Expanded(child: _table(flows)),
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
            DataColumn(label: Text('Workflow')),
            DataColumn(label: Text('Module')),
            DataColumn(label: Text('Steps')),
            DataColumn(label: Text('Last Modified')),
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
