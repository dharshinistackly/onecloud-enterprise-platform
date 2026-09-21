import 'package:flutter/material.dart';

class CostingPage extends StatelessWidget {
  const CostingPage({super.key});

  static const _navy = Color(0xFF0A1F44);
  static const _bg = Color(0xFFF6F8FC);
  static const _border = Color(0xFFE7ECF3);

  @override
  Widget build(BuildContext context) {
    final costs = [
      ['Hydraulic Pump Assembly', 'Labour + Material', '₹1,42,000', '₹1,38,500', 'Under Budget'],
      ['Circuit Board Batch C', 'Material', '₹2,05,000', '₹2,20,000', 'Over Budget'],
      ['Steel Frame Model X', 'Labour', '₹68,000', '₹66,200', 'Under Budget'],
      ['Packaging Line Run 12', 'Overhead', '₹35,000', '₹35,000', 'On Budget'],
      ['Motor Unit MU-9', 'Material + Overhead', '₹92,000', '₹97,600', 'Over Budget'],
    ];

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),
        title: const Text('Costing'),
        backgroundColor: _navy,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Costing', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: _navy)),
          const Text('Analyze product and project cost variances.', style: TextStyle(color: Colors.black54)),
          const SizedBox(height: 20),
          Wrap(
            spacing: 14,
            runSpacing: 14,
            children: [
            _stat('Cost Items', '58', Icons.calculate_outlined, _navy),
            _stat('Under Budget', '24', Icons.trending_down_outlined, const Color(0xFF1E8E5A)),
            _stat('On Budget', '19', Icons.check_circle_outline, const Color(0xFF2E6DB4)),
            _stat('Over Budget', '15', Icons.trending_up_outlined, const Color(0xFFC0392B)),
          ]),
          const SizedBox(height: 20),
          _table(costs),
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
            DataColumn(label: Text('Item / Project')),
            DataColumn(label: Text('Cost Type')),
            DataColumn(label: Text('Estimated')),
            DataColumn(label: Text('Actual')),
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
