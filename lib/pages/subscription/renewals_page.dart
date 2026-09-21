import 'package:flutter/material.dart';

class RenewalsPage extends StatelessWidget {
  const RenewalsPage({super.key});

  static const _navy = Color(0xFF0A1F44);
  static const _bg = Color(0xFFF6F8FC);
  static const _border = Color(0xFFE7ECF3);

  @override
  Widget build(BuildContext context) {
    final renewals = [
      ['TechNova Solutions', 'Enterprise', '31 Dec 2026', '₹39,999', 'Auto-Renew'],
      ['CloudWorks Pvt Ltd', 'Business', '14 Mar 2027', '₹14,999', 'Auto-Renew'],
      ['InnoSoft Labs', 'Starter', '19 Jun 2026', '₹4,999', 'Pending Renewal'],
      ['NextGen Retail', 'Business', '09 Feb 2027', '₹14,999', 'Auto-Renew'],
      ['DataBridge Systems', 'Enterprise', '04 Sep 2026', '₹39,999', 'Not Renewing'],
    ];

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),
        title: const Text('Renewals'),
        backgroundColor: _navy,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Renewals', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: _navy)),
          const Text('Track upcoming subscription renewals.', style: TextStyle(color: Colors.black54)),
          const SizedBox(height: 20),
          Wrap(
            spacing: 14,
            runSpacing: 14,
            children: [
            _stat('Upcoming Renewals', '52', Icons.event_repeat_outlined, _navy),
            _stat('Auto-Renew', '38', Icons.autorenew, const Color(0xFF1E8E5A)),
            _stat('Pending Action', '9', Icons.hourglass_empty_outlined, const Color(0xFFC98A1B)),
            _stat('Not Renewing', '5', Icons.cancel_outlined, const Color(0xFFC0392B)),
          ]),
          const SizedBox(height: 20),
          _table(renewals),
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
            DataColumn(label: Text('Tenant')),
            DataColumn(label: Text('Plan')),
            DataColumn(label: Text('Renewal Date')),
            DataColumn(label: Text('Amount')),
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
