import 'package:flutter/material.dart';

class InvoicingPage extends StatelessWidget {
  const InvoicingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final invoices = [
      ['INV-2026-1042', 'TechNova Solutions', '₹1,24,000', '15 Sep 2026', 'Paid'],
      ['INV-2026-1043', 'CloudWorks Pvt Ltd', '₹87,500', '18 Sep 2026', 'Paid'],
      ['INV-2026-1044', 'DataBridge Systems', '₹52,000', '10 Sep 2026', 'Overdue'],
      ['INV-2026-1045', 'InnoSoft Labs', '₹31,000', '22 Sep 2026', 'Outstanding'],
      ['INV-2026-1046', 'NextGen Retail', '₹96,000', '20 Sep 2026', 'Outstanding'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(title: const Text('Invoicing'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Invoicing', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Manage invoices and track payment status across accounts.'),
          const SizedBox(height: 20),
          Row(children: [
            _stat('Total Invoices', '156', Icons.receipt_long_outlined, const Color(0xFF0F3D66)),
            const SizedBox(width: 14),
            _stat('Paid', '128', Icons.check_circle_outline, Colors.green),
            const SizedBox(width: 14),
            _stat('Overdue', '9', Icons.warning_amber_outlined, Colors.red),
            const SizedBox(width: 14),
            _stat('Outstanding Amount', '₹4.6L', Icons.account_balance_wallet_outlined, Colors.orange),
          ]),
          const SizedBox(height: 20),
          Expanded(child: Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('Invoice #')),
              DataColumn(label: Text('Account')),
              DataColumn(label: Text('Amount')),
              DataColumn(label: Text('Due Date')),
              DataColumn(label: Text('Status')),
            ],
            rows: invoices.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          )))),
        ]),
      ),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return Expanded(child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
