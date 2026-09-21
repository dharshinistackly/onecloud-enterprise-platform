import 'package:flutter/material.dart';

class LicenseKeysPage extends StatelessWidget {
  const LicenseKeysPage({super.key});

  static const _navy = Color(0xFF0A1F44);
  static const _bg = Color(0xFFF6F8FC);
  static const _border = Color(0xFFE7ECF3);

  @override
  Widget build(BuildContext context) {
    final keys = [
      ['LIC-XJ29-K481', 'TechNova Solutions', 'Enterprise', '31 Dec 2026', 'Active'],
      ['LIC-QW83-M120', 'CloudWorks Pvt Ltd', 'Business', '14 Mar 2027', 'Active'],
      ['LIC-ZT56-P907', 'NextGen Retail', 'Business', '09 Feb 2027', 'Active'],
      ['LIC-RD12-N345', 'InnoSoft Labs', 'Starter', '19 Jun 2026', 'Expiring Soon'],
      ['LIC-BV77-L602', 'DataBridge Systems', 'Enterprise', '04 Sep 2026', 'Revoked'],
    ];

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),
        title: const Text('License Keys'),
        backgroundColor: _navy,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('License Keys', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: _navy)),
          const Text('Generate, issue and revoke license keys.', style: TextStyle(color: Colors.black54)),
          const SizedBox(height: 20),
          Wrap(
            spacing: 14,
            runSpacing: 14,
            children: [
            _stat('Total Keys', '299', Icons.vpn_key_outlined, _navy),
            _stat('Active', '268', Icons.check_circle_outline, const Color(0xFF1E8E5A)),
            _stat('Expiring Soon', '19', Icons.timelapse_outlined, const Color(0xFFC98A1B)),
            _stat('Revoked', '12', Icons.block_outlined, const Color(0xFFC0392B)),
          ]),
          const SizedBox(height: 20),
          _table(keys),
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
            DataColumn(label: Text('License Key')),
            DataColumn(label: Text('Tenant')),
            DataColumn(label: Text('Plan')),
            DataColumn(label: Text('Expires On')),
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
