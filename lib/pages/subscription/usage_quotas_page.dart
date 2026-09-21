import 'package:flutter/material.dart';

class UsageQuotasPage extends StatelessWidget {
  const UsageQuotasPage({super.key});

  static const _navy = Color(0xFF0A1F44);
  static const _bg = Color(0xFFF6F8FC);
  static const _border = Color(0xFFE7ECF3);

  @override
  Widget build(BuildContext context) {
    final usage = [
      ['TechNova Solutions', 'Storage', '840 GB / 1 TB', '84%', 'Normal'],
      ['CloudWorks Pvt Ltd', 'API Calls', '92,400 / 100,000', '92%', 'Near Limit'],
      ['NextGen Retail', 'Users', '22 / 25', '88%', 'Near Limit'],
      ['InnoSoft Labs', 'Storage', '9.8 GB / 10 GB', '98%', 'Exceeded'],
      ['DataBridge Systems', 'Users', '48 / 200', '24%', 'Normal'],
    ];

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),
        title: const Text('Usage & Quotas'),
        backgroundColor: _navy,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Usage & Quotas', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: _navy)),
          const Text('Monitor tenant consumption against plan limits.', style: TextStyle(color: Colors.black54)),
          const SizedBox(height: 20),
          Wrap(
            spacing: 14,
            runSpacing: 14,
            children: [
            _stat('Tracked Tenants', '299', Icons.speed_outlined, _navy),
            _stat('Normal', '241', Icons.check_circle_outline, const Color(0xFF1E8E5A)),
            _stat('Near Limit', '42', Icons.warning_amber_outlined, const Color(0xFFC98A1B)),
            _stat('Exceeded', '16', Icons.error_outline, const Color(0xFFC0392B)),
          ]),
          const SizedBox(height: 20),
          _table(usage),
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
            DataColumn(label: Text('Resource')),
            DataColumn(label: Text('Usage')),
            DataColumn(label: Text('% Used')),
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
