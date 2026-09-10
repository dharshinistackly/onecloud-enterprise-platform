import 'package:flutter/material.dart';

class ProcessAutomationPage extends StatelessWidget {
  const ProcessAutomationPage({super.key});

  static const _navy = Color(0xFF0A1F44);
  static const _bg = Color(0xFFF6F8FC);
  static const _border = Color(0xFFE7ECF3);

  @override
  Widget build(BuildContext context) {
    final automations = [
      ['Auto-send Invoice Reminders', 'Daily 9:00 AM', '412 runs', '99.2%', 'Running'],
      ['Sync Inventory to Sales', 'Every 15 min', '2,180 runs', '99.8%', 'Running'],
      ['Generate Payroll Batch', 'Monthly - 1st', '9 runs', '100%', 'Running'],
      ['Vendor Rating Recalculation', 'Weekly - Mon', '38 runs', '94.7%', 'Paused'],
      ['Lead Score Refresh', 'Hourly', '1,540 runs', '97.1%', 'Failed'],
    ];

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        title: const Text('Process Automation'),
        backgroundColor: _navy,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Process Automation', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: _navy)),
          const Text('Automate recurring tasks across the platform.', style: TextStyle(color: Colors.black54)),
          const SizedBox(height: 20),
          Row(children: [
            _stat('Total Automations', '52', Icons.smart_toy_outlined, _navy),
            const SizedBox(width: 14),
            _stat('Running', '44', Icons.play_circle_outline, const Color(0xFF1E8E5A)),
            const SizedBox(width: 14),
            _stat('Paused', '6', Icons.pause_circle_outline, const Color(0xFFC98A1B)),
            const SizedBox(width: 14),
            _stat('Failed', '2', Icons.error_outline, const Color(0xFFC0392B)),
          ]),
          const SizedBox(height: 20),
          Expanded(child: _table(automations)),
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
            DataColumn(label: Text('Automation')),
            DataColumn(label: Text('Schedule')),
            DataColumn(label: Text('Total Runs')),
            DataColumn(label: Text('Success Rate')),
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
