import 'package:flutter/material.dart';

class TrialManagementPage extends StatelessWidget {
  const TrialManagementPage({super.key});

  static const _navy = Color(0xFF0A1F44);
  static const _bg = Color(0xFFF6F8FC);
  static const _border = Color(0xFFE7ECF3);

  @override
  Widget build(BuildContext context) {
    final trials = [
      ['GreenLeaf Foods', 'Business Trial', '01 Sep 2026', '15 Sep 2026', 'Active'],
      ['UrbanBuild Contractors', 'Enterprise Trial', '28 Aug 2026', '11 Sep 2026', 'Ending Soon'],
      ['SwiftCart Logistics', 'Starter Trial', '20 Aug 2026', '03 Sep 2026', 'Expired'],
      ['Medico Health Systems', 'Business Trial', '05 Sep 2026', '19 Sep 2026', 'Active'],
      ['BrightPath Academy', 'Starter Trial', '10 Aug 2026', '24 Aug 2026', 'Converted'],
    ];

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        title: const Text('Trial Management'),
        backgroundColor: _navy,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Trial Management', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: _navy)),
          const Text('Track free trials and conversion outcomes.', style: TextStyle(color: Colors.black54)),
          const SizedBox(height: 20),
          Row(children: [
            _stat('Active Trials', '34', Icons.hourglass_top_outlined, _navy),
            const SizedBox(width: 14),
            _stat('Converted', '21', Icons.check_circle_outline, const Color(0xFF1E8E5A)),
            const SizedBox(width: 14),
            _stat('Ending Soon', '8', Icons.timelapse_outlined, const Color(0xFFC98A1B)),
            const SizedBox(width: 14),
            _stat('Expired', '15', Icons.cancel_outlined, const Color(0xFFC0392B)),
          ]),
          const SizedBox(height: 20),
          Expanded(child: _table(trials)),
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
            DataColumn(label: Text('Company')),
            DataColumn(label: Text('Trial Plan')),
            DataColumn(label: Text('Started')),
            DataColumn(label: Text('Ends')),
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
