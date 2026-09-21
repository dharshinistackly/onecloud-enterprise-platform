import 'package:flutter/material.dart';

class CommissionManagementPage extends StatelessWidget {
  const CommissionManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    final commissions = [
      ['Arun Kumar', 'TechNova Solutions', '8%', '₹99,200', 'Paid'],
      ['Priya Sharma', 'CloudWorks Pvt Ltd', '7%', '₹61,250', 'Paid'],
      ['Rahul Menon', 'DataBridge Systems', '6%', '₹31,200', 'Pending'],
      ['Sneha Iyer', 'InnoSoft Labs', '5%', '₹15,500', 'Pending'],
      ['Vikram Rao', 'NextGen Retail', '8%', '₹76,800', 'Paid'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),title: const Text('Commission Management'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Commission Management', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Track commission payouts for sales representatives.'),
          const SizedBox(height: 20),
          Wrap(
            spacing: 14,
            runSpacing: 14,
            children: [
            _stat('Total Commissions', '₹2.84L', Icons.payments_outlined, const Color(0xFF0F3D66)),
            _stat('Paid Commissions', '₹2.37L', Icons.check_circle_outline, Colors.green),
            _stat('Pending Payouts', '₹46,700', Icons.hourglass_bottom_outlined, Colors.orange),
            _stat('Avg Commission Rate', '6.8%', Icons.percent_outlined, Colors.purple),
          ]),
          const SizedBox(height: 20),
          Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('Sales Rep')),
              DataColumn(label: Text('Deal')),
              DataColumn(label: Text('Commission Rate')),
              DataColumn(label: Text('Commission Amount')),
              DataColumn(label: Text('Payout Status')),
            ],
            rows: commissions.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          ))),
        ]),
      )),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return SizedBox(width: 220, child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
