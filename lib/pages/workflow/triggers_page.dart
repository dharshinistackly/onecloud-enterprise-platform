import 'package:flutter/material.dart';

class TriggersPage extends StatelessWidget {
  const TriggersPage({super.key});

  static const _navy = Color(0xFF0A1F44);
  static const _bg = Color(0xFFF6F8FC);
  static const _border = Color(0xFFE7ECF3);

  @override
  Widget build(BuildContext context) {
    final triggers = [
      ['New Lead Created', 'Send Welcome Email', 'CRM', '860 fires', 'Enabled'],
      ['Stock Below Threshold', 'Notify Procurement', 'ERP', '212 fires', 'Enabled'],
      ['Invoice Overdue 7 Days', 'Escalate to Finance', 'Finance', '64 fires', 'Enabled'],
      ['Employee Exit Initiated', 'Trigger Offboarding Flow', 'HRMS', '18 fires', 'Enabled'],
      ['SLA Breach Detected', 'Alert Support Lead', 'Support', '31 fires', 'Disabled'],
    ];

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        title: const Text('Triggers'),
        backgroundColor: _navy,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Triggers', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: _navy)),
          const Text('Event-based triggers that kick off workflows.', style: TextStyle(color: Colors.black54)),
          const SizedBox(height: 20),
          Row(children: [
            _stat('Total Triggers', '89', Icons.bolt_outlined, _navy),
            const SizedBox(width: 14),
            _stat('Enabled', '76', Icons.check_circle_outline, const Color(0xFF1E8E5A)),
            const SizedBox(width: 14),
            _stat('Disabled', '11', Icons.pause_circle_outline, const Color(0xFFC98A1B)),
            const SizedBox(width: 14),
            _stat('Errored', '2', Icons.error_outline, const Color(0xFFC0392B)),
          ]),
          const SizedBox(height: 20),
          Expanded(child: _table(triggers)),
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
            DataColumn(label: Text('Trigger Event')),
            DataColumn(label: Text('Action')),
            DataColumn(label: Text('Module')),
            DataColumn(label: Text('Fired')),
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
