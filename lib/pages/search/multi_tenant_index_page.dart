import 'package:flutter/material.dart';

class MultiTenantIndexPage extends StatelessWidget {
  const MultiTenantIndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tenants = [
      ['TechNova Solutions', 'Isolated', '182,400', 'ap-south-1', 'Active'],
      ['CloudWorks Pvt Ltd', 'Shared', '94,220', 'ap-south-1', 'Active'],
      ['DataBridge Systems', 'Isolated', '210,760', 'ap-south-1', 'Active'],
      ['InnoSoft Labs', 'Shared', '38,910', 'ap-south-1', 'Suspended'],
      ['NextGen Retail', 'Isolated', '156,300', 'ap-south-1', 'Active'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),title: const Text('Multi-Tenant Index'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Multi-Tenant Index', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Manage per-tenant search indices, isolation, and storage.'),
          const SizedBox(height: 20),
          Wrap(
            spacing: 14,
            runSpacing: 14,
            children: [
            _stat('Total Tenants', '48', Icons.groups_outlined, Colors.blue),
            _stat('Isolated Indices', '31', Icons.shield_outlined, Colors.green),
            _stat('Shared Indices', '17', Icons.hub_outlined, Colors.indigo),
            _stat('Storage Used', '28.4 GB', Icons.storage_outlined, Colors.orange),
          ]),
          const SizedBox(height: 20),
          Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('Tenant Name')),
              DataColumn(label: Text('Index Strategy')),
              DataColumn(label: Text('Documents')),
              DataColumn(label: Text('Region')),
              DataColumn(label: Text('Status')),
            ],
            rows: tenants.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          ))),
        ]),
      )),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return SizedBox(width: 220, child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
