import 'package:flutter/material.dart';

class QuotationsPage extends StatelessWidget {
  const QuotationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final quotes = [
      ['QT-1001', 'TechNova Solutions', '₹18,00,000', '10 Sep 2026', 'Sent'],
      ['QT-1002', 'CloudWorks Pvt Ltd', '₹9,50,000', '08 Sep 2026', 'Approved'],
      ['QT-1003', 'DataBridge Systems', '₹25,00,000', '06 Sep 2026', 'Draft'],
      ['QT-1004', 'InnoSoft Labs', '₹6,20,000', '03 Sep 2026', 'Accepted'],
      ['QT-1005', 'NextGen Retail', '₹12,00,000', '01 Sep 2026', 'Expired'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),title: const Text('Quotations'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: Padding(padding: const EdgeInsets.all(24), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Quotations', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            Text('Create and manage customer quotations.'),
          ]),
          ElevatedButton.icon(onPressed: () => _showCreateDialog(context), icon: const Icon(Icons.add), label: const Text('New Quotation')),
        ]),
        const SizedBox(height: 20),
        Row(children: [
          _stat('Total Quotes', '36', Icons.request_quote_outlined, Colors.blue),
          const SizedBox(width: 14),
          _stat('Sent', '14', Icons.send_outlined, Colors.indigo),
          const SizedBox(width: 14),
          _stat('Accepted', '11', Icons.check_circle_outline, Colors.green),
          const SizedBox(width: 14),
          _stat('Pending', '7', Icons.pending_outlined, Colors.orange),
        ]),
        const SizedBox(height: 20),
        Expanded(child: Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
          columns: const [DataColumn(label: Text('Quote ID')), DataColumn(label: Text('Customer')), DataColumn(label: Text('Amount')), DataColumn(label: Text('Date')), DataColumn(label: Text('Status'))],
          rows: quotes.map((q) => DataRow(cells: [for (final item in q) DataCell(Text(item))])).toList(),
        )))),
      ])),
    );
  }

  void _showCreateDialog(BuildContext context) {
    showDialog(context: context, builder: (_) => AlertDialog(
      title: const Text('New Quotation'),
      content: const Text('Quotation creation form is available in this demo CRM module.'),
      actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close'))],
    ));
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return Expanded(child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
