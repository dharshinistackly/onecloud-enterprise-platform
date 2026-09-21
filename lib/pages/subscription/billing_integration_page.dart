import 'package:flutter/material.dart';

class BillingIntegrationPage extends StatelessWidget {
  const BillingIntegrationPage({super.key});

  static const _navy = Color(0xFF0A1F44);
  static const _bg = Color(0xFFF6F8FC);
  static const _border = Color(0xFFE7ECF3);

  @override
  Widget build(BuildContext context) {
    final gateways = [
      ['Razorpay', 'Primary', '1,240 txns', '₹32.4L', 'Connected'],
      ['Stripe', 'International', '86 txns', '₹6.1L', 'Connected'],
      ['PayU', 'Secondary', '412 txns', '₹9.8L', 'Connected'],
      ['Paytm Business', 'Legacy', '18 txns', '₹0.4L', 'Disconnected'],
      ['Wise (Payouts)', 'Vendor Payouts', '64 txns', '₹4.2L', 'Connected'],
    ];

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),
        title: const Text('Billing Integration'),
        backgroundColor: _navy,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Billing Integration', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: _navy)),
          const Text('Manage connected payment gateways and billing sync.', style: TextStyle(color: Colors.black54)),
          const SizedBox(height: 20),
          Wrap(
            spacing: 14,
            runSpacing: 14,
            children: [
            _stat('Connected Gateways', '4', Icons.account_balance_outlined, _navy),
            _stat('Total Transactions', '1,820', Icons.receipt_long_outlined, const Color(0xFF1E8E5A)),
            _stat('Total Volume', '₹52.9L', Icons.trending_up_outlined, const Color(0xFF2E6DB4)),
            _stat('Disconnected', '1', Icons.link_off_outlined, const Color(0xFFC0392B)),
          ]),
          const SizedBox(height: 20),
          _table(gateways),
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
            DataColumn(label: Text('Gateway')),
            DataColumn(label: Text('Role')),
            DataColumn(label: Text('Transactions')),
            DataColumn(label: Text('Volume')),
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
