import 'package:flutter/material.dart';

class SavedSearchesPage extends StatelessWidget {
  const SavedSearchesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final searches = [
      ['Overdue Invoices', 'r.menon@company.com', 'status:overdue', 'Daily', '1 hr ago'],
      ['High-Value Leads', 's.rao@company.com', 'value:>50000', 'Weekly', '2 days ago'],
      ['Open Support Tickets', 'k.das@company.com', 'status:open', 'None', '5 hr ago'],
      ['Enterprise Accounts', 'a.iyer@company.com', 'type:enterprise', 'Weekly', '1 day ago'],
      ['Churn Risk Customers', 'p.singh@company.com', 'risk:high', 'Daily', '3 hr ago'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(title: const Text('Saved Searches'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Saved Searches', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Reusable queries and alerts saved by your team.'),
          const SizedBox(height: 20),
          Row(children: [
            _stat('Total Saved Searches', '56', Icons.bookmark_border_outlined, Colors.blue),
            const SizedBox(width: 14),
            _stat('Shared', '21', Icons.people_outline, Colors.green),
            const SizedBox(width: 14),
            _stat('Alerts Enabled', '18', Icons.notifications_active_outlined, Colors.indigo),
            const SizedBox(width: 14),
            _stat('Most Used', 'Overdue Invoices', Icons.trending_up_outlined, Colors.orange),
          ]),
          const SizedBox(height: 20),
          Expanded(child: Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('Search Name')),
              DataColumn(label: Text('Owner')),
              DataColumn(label: Text('Query')),
              DataColumn(label: Text('Alerts')),
              DataColumn(label: Text('Last Run')),
            ],
            rows: searches.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          )))),
        ]),
      ),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return Expanded(child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
