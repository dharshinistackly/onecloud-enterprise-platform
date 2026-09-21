import 'package:flutter/material.dart';

class AccessControlPage extends StatelessWidget {
  const AccessControlPage({super.key});

  static const _navy = Color(0xFF0A1F44);
  static const _bg = Color(0xFFF6F8FC);
  static const _border = Color(0xFFE7ECF3);

  @override
  Widget build(BuildContext context) {
    final permissions = [
      ['Vendor Agreement - SteelCorp.pdf', 'Finance Team', 'View + Edit', '05 Sep 2026', 'Active'],
      ['Employee Handbook.pdf', 'All Employees', 'View Only', '20 Aug 2026', 'Active'],
      ['Board Meeting Minutes.pdf', 'Executive Team', 'View + Edit', '01 Sep 2026', 'Active'],
      ['Product Spec - Motor Unit.xlsx', 'Engineering Team', 'View + Edit', '28 Aug 2026', 'Active'],
      ['Legacy Payroll Data.xlsx', 'HR Admins', 'View Only', '10 May 2026', 'Revoked'],
    ];

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),
        title: const Text('Access Control'),
        backgroundColor: _navy,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Access Control', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: _navy)),
          const Text('Manage who can view, edit or share documents.', style: TextStyle(color: Colors.black54)),
          const SizedBox(height: 20),
          Wrap(
            spacing: 14,
            runSpacing: 14,
            children: [
            _stat('Total Permissions', '624', Icons.admin_panel_settings_outlined, _navy),
            _stat('Active', '588', Icons.check_circle_outline, const Color(0xFF1E8E5A)),
            _stat('Revoked', '31', Icons.block_outlined, const Color(0xFFC98A1B)),
            _stat('Expiring Soon', '5', Icons.timelapse_outlined, const Color(0xFFC0392B)),
          ]),
          const SizedBox(height: 20),
          _table(permissions),
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
            DataColumn(label: Text('File Name')),
            DataColumn(label: Text('Granted To')),
            DataColumn(label: Text('Access Level')),
            DataColumn(label: Text('Granted On')),
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
