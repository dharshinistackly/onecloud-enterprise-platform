import 'package:flutter/material.dart';

class AccountsPage extends StatelessWidget {
  const AccountsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final accounts = [
      ['TechNova Solutions', 'Technology', 'Chennai', 'Enterprise', 'Active'],
      ['CloudWorks Pvt Ltd', 'Cloud Services', 'Bengaluru', 'Enterprise', 'Active'],
      ['DataBridge Systems', 'Analytics', 'Hyderabad', 'Business', 'Active'],
      ['InnoSoft Labs', 'Software', 'Pune', 'Business', 'Inactive'],
      ['NextGen Retail', 'Retail', 'Mumbai', 'Enterprise', 'Active'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(title: const Text('Accounts'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Account Management', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Manage organizations and customer accounts.'),
          const SizedBox(height: 20),
          Row(children: [
            _stat('Total Accounts', '48', Icons.business_outlined, Colors.blue),
            const SizedBox(width: 14),
            _stat('Active Accounts', '42', Icons.check_circle_outline, Colors.green),
            const SizedBox(width: 14),
            _stat('Enterprise', '21', Icons.apartment_outlined, Colors.indigo),
            const SizedBox(width: 14),
            _stat('New This Month', '6', Icons.add_business_outlined, Colors.orange),
          ]),
          const SizedBox(height: 20),
          Expanded(child: Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('Account')),
              DataColumn(label: Text('Industry')),
              DataColumn(label: Text('Location')),
              DataColumn(label: Text('Type')),
              DataColumn(label: Text('Status')),
            ],
            rows: accounts.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          )))),
        ]),
      ),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return Expanded(child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
