import 'package:flutter/material.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final contacts = [
      ['Priya Sharma', 'CloudWorks', 'priya@cloudworks.com', '+91 98765 43210', 'Manager'],
      ['Arun Kumar', 'TechNova', 'arun@technova.com', '+91 98450 11223', 'Director'],
      ['Rahul Menon', 'DataBridge', 'rahul@databridge.com', '+91 99887 22110', 'CTO'],
      ['Sneha Raj', 'InnoSoft', 'sneha@innosoft.com', '+91 97654 33221', 'HR Manager'],
      ['Vikram Singh', 'NextGen', 'vikram@nextgen.com', '+91 96543 55667', 'Owner'],
    ];

    return _buildPage(context, contacts);
  }

  Widget _buildPage(BuildContext context, List<List<String>> contacts) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(title: const Text('Contacts'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: Padding(padding: const EdgeInsets.all(24), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Contact Management', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        const Text('Maintain customer contacts and communication details.'),
        const SizedBox(height: 20),
        Row(children: [
          _stat('Contacts', '126', Icons.contacts_outlined, Colors.blue),
          const SizedBox(width: 14),
          _stat('Active', '118', Icons.person_outline, Colors.green),
          const SizedBox(width: 14),
          _stat('Decision Makers', '34', Icons.manage_accounts_outlined, Colors.indigo),
        ]),
        const SizedBox(height: 20),
        Expanded(child: Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
          columns: const [DataColumn(label: Text('Name')), DataColumn(label: Text('Account')), DataColumn(label: Text('Email')), DataColumn(label: Text('Phone')), DataColumn(label: Text('Role'))],
          rows: contacts.map((c) => DataRow(cells: [for (final item in c) DataCell(Text(item))])).toList(),
        )))),
      ])),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return Expanded (child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 30), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
