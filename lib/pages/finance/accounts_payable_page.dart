import 'package:flutter/material.dart';

class AccountsPayablePage extends StatelessWidget {
  const AccountsPayablePage({super.key});

  static const _navy = Color(0xFF0A1F44);
  static const _bg = Color(0xFFF6F8FC);
  static const _border = Color(0xFFE7ECF3);

  @override
  Widget build(BuildContext context) {
    final bills = [
      ['BL-701', 'SteelCorp Industries', '₹2,40,000', '15 Sep 2026', 'Due'],
      ['BL-702', 'ElectroParts Ltd', '₹1,10,500', '20 Sep 2026', 'Due'],
      ['BL-703', 'HydroTech Supplies', '₹85,000', '05 Sep 2026', 'Overdue'],
      ['BL-704', 'PackRight Co', '₹32,400', '28 Aug 2026', 'Paid'],
      ['BL-705', 'LubeWell Traders', '₹18,900', '30 Aug 2026', 'Paid'],
    ];

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),
        title: const Text('Accounts Payable'),
        backgroundColor: _navy,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Accounts Payable', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: _navy)),
          const Text('Track and settle outstanding vendor bills.', style: TextStyle(color: Colors.black54)),
          const SizedBox(height: 20),
          Wrap(
            spacing: 14,
            runSpacing: 14,
            children: [
            _stat('Total Payable', '₹28.4L', Icons.receipt_long_outlined, _navy),
            _stat('Paid', '₹19.1L', Icons.check_circle_outline, const Color(0xFF1E8E5A)),
            _stat('Due', '₹6.8L', Icons.schedule_outlined, const Color(0xFFC98A1B)),
            _stat('Overdue', '₹2.5L', Icons.warning_amber_outlined, const Color(0xFFC0392B)),
          ]),
          const SizedBox(height: 20),
          _table(bills),
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
            DataColumn(label: Text('Bill No')),
            DataColumn(label: Text('Vendor')),
            DataColumn(label: Text('Amount')),
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
