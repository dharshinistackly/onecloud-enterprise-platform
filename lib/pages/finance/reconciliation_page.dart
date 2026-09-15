import 'package:flutter/material.dart';

class ReconciliationPage extends StatelessWidget {
  const ReconciliationPage({super.key});

  static const _navy = Color(0xFF0A1F44);
  static const _bg = Color(0xFFF6F8FC);
  static const _border = Color(0xFFE7ECF3);

  @override
  Widget build(BuildContext context) {
    final items = [
      ['RC-201', 'HDFC Bank - Current A/c', '₹12,40,000', '₹12,40,000', 'Matched'],
      ['RC-202', 'ICICI Bank - Operations', '₹8,15,600', '₹8,12,400', 'Mismatch'],
      ['RC-203', 'Petty Cash Register', '₹25,000', '₹25,000', 'Matched'],
      ['RC-204', 'Credit Card Statement', '₹1,84,500', '₹1,79,200', 'Mismatch'],
      ['RC-205', 'SBI Bank - Payroll A/c', '₹6,60,000', '-', 'Pending'],
    ];

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),
        title: const Text('Reconciliation'),
        backgroundColor: _navy,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Reconciliation', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: _navy)),
          const Text('Match ledger balances against bank statements.', style: TextStyle(color: Colors.black54)),
          const SizedBox(height: 20),
          Row(children: [
            _stat('Total Accounts', '38', Icons.sync_alt_outlined, _navy),
            const SizedBox(width: 14),
            _stat('Matched', '29', Icons.check_circle_outline, const Color(0xFF1E8E5A)),
            const SizedBox(width: 14),
            _stat('Mismatch', '7', Icons.error_outline, const Color(0xFFC0392B)),
            const SizedBox(width: 14),
            _stat('Pending', '2', Icons.schedule_outlined, const Color(0xFFC98A1B)),
          ]),
          const SizedBox(height: 20),
          Expanded(child: _table(items)),
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
            DataColumn(label: Text('Reference')),
            DataColumn(label: Text('Account')),
            DataColumn(label: Text('Book Balance')),
            DataColumn(label: Text('Bank Balance')),
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
