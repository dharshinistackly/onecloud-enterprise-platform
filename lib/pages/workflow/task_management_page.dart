import 'package:flutter/material.dart';

class TaskManagementPage extends StatelessWidget {
  const TaskManagementPage({super.key});

  static const _navy = Color(0xFF0A1F44);
  static const _bg = Color(0xFFF6F8FC);
  static const _border = Color(0xFFE7ECF3);

  @override
  Widget build(BuildContext context) {
    final tasks = [
      ['TSK-601', 'Review Q3 Budget Proposal', 'Meena Raj', '12 Sep 2026', 'In Progress'],
      ['TSK-602', 'Update Vendor Contracts', 'Arun Vel', '14 Sep 2026', 'Not Started'],
      ['TSK-603', 'Finalize Onboarding Checklist', 'Priya Sharma', '10 Sep 2026', 'Completed'],
      ['TSK-604', 'Audit Warehouse B Stock', 'Ramesh Kumar', '08 Sep 2026', 'Overdue'],
      ['TSK-605', 'Prepare Board Presentation', 'Sathish Raj', '16 Sep 2026', 'In Progress'],
    ];

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),
        title: const Text('Task Management'),
        backgroundColor: _navy,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Task Management', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: _navy)),
          const Text('Assign, track and close tasks across teams.', style: TextStyle(color: Colors.black54)),
          const SizedBox(height: 20),
          Wrap(
            spacing: 14,
            runSpacing: 14,
            children: [
            _stat('Total Tasks', '318', Icons.checklist_outlined, _navy),
            _stat('Completed', '212', Icons.check_circle_outline, const Color(0xFF1E8E5A)),
            _stat('In Progress', '84', Icons.autorenew, const Color(0xFF2E6DB4)),
            _stat('Overdue', '22', Icons.warning_amber_outlined, const Color(0xFFC0392B)),
          ]),
          const SizedBox(height: 20),
          _table(tasks),
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
            DataColumn(label: Text('Task No')),
            DataColumn(label: Text('Title')),
            DataColumn(label: Text('Assigned To')),
            DataColumn(label: Text('Due Date')),
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
