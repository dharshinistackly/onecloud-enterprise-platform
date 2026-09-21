import 'package:flutter/material.dart';

class WorkflowTemplatesPage extends StatelessWidget {
  const WorkflowTemplatesPage({super.key});

  static const _navy = Color(0xFF0A1F44);
  static const _bg = Color(0xFFF6F8FC);
  static const _border = Color(0xFFE7ECF3);

  @override
  Widget build(BuildContext context) {
    final templates = [
      ['Standard PO Approval', 'Procurement', '48 uses', '04 Sep 2026', 'Active'],
      ['New Hire Onboarding', 'HRMS', '22 uses', '20 Aug 2026', 'Active'],
      ['Customer Refund Process', 'Finance', '15 uses', '30 Aug 2026', 'Active'],
      ['Deal Closure Checklist', 'CRM', '36 uses', '01 Sep 2026', 'Active'],
      ['Legacy Expense Approval', 'Finance', '3 uses', '10 Jun 2026', 'Deprecated'],
    ];

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),
        title: const Text('Workflow Templates'),
        backgroundColor: _navy,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Workflow Templates', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: _navy)),
          const Text('Reusable templates to launch workflows quickly.', style: TextStyle(color: Colors.black54)),
          const SizedBox(height: 20),
          Wrap(
            spacing: 14,
            runSpacing: 14,
            children: [
            _stat('Total Templates', '34', Icons.dashboard_customize_outlined, _navy),
            _stat('Active', '28', Icons.check_circle_outline, const Color(0xFF1E8E5A)),
            _stat('Draft', '4', Icons.edit_note_outlined, const Color(0xFFC98A1B)),
            _stat('Deprecated', '2', Icons.archive_outlined, const Color(0xFF6C4EB6)),
          ]),
          const SizedBox(height: 20),
          _table(templates),
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
            DataColumn(label: Text('Template')),
            DataColumn(label: Text('Module')),
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
