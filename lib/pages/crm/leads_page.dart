import 'package:flutter/material.dart';

class LeadsPage extends StatefulWidget {
  const LeadsPage({super.key});

  @override
  State<LeadsPage> createState() => _LeadsPageState();
}

class _LeadsPageState extends State<LeadsPage> {
  final TextEditingController searchController = TextEditingController();

  final List<Map<String, String>> leads = [
    {'name': 'Arun Kumar', 'company': 'TechNova', 'email': 'arun@technova.com', 'status': 'New', 'source': 'Website'},
    {'name': 'Priya Sharma', 'company': 'CloudWorks', 'email': 'priya@cloudworks.com', 'status': 'Contacted', 'source': 'Referral'},
    {'name': 'Rahul Menon', 'company': 'DataBridge', 'email': 'rahul@databridge.com', 'status': 'Qualified', 'source': 'Campaign'},
    {'name': 'Sneha Raj', 'company': 'InnoSoft', 'email': 'sneha@innosoft.com', 'status': 'New', 'source': 'Social Media'},
    {'name': 'Vikram Singh', 'company': 'NextGen', 'email': 'vikram@nextgen.com', 'status': 'Converted', 'source': 'Event'},
  ];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Color statusColor(String status) {
    switch (status) {
      case 'Converted':
        return Colors.green;
      case 'Qualified':
        return Colors.indigo;
      case 'Contacted':
        return Colors.orange;
      default:
        return Colors.blue;
    }
  }

  void showAddLeadDialog() {
    final name = TextEditingController();
    final company = TextEditingController();
    final email = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Lead'),
        content: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: name, decoration: const InputDecoration(labelText: 'Lead Name')),
              TextField(controller: company, decoration: const InputDecoration(labelText: 'Company')),
              TextField(controller: email, decoration: const InputDecoration(labelText: 'Email')),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              if (name.text.isNotEmpty) {
                setState(() {
                  leads.insert(0, {
                    'name': name.text,
                    'company': company.text,
                    'email': email.text,
                    'status': 'New',
                    'source': 'Manual',
                  });
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Add Lead'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final query = searchController.text.toLowerCase();
    final filtered = leads.where((lead) {
      return lead.values.any((value) => value.toLowerCase().contains(query));
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),
        title: const Text('Leads'),
        backgroundColor: const Color(0xFF0F3D66),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Lead Management', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            const Text('Track, qualify and manage CRM leads.'),
            const SizedBox(height: 22),
            Row(
              children: [
                _stat('Total Leads', '${leads.length}', Icons.people_alt_outlined, Colors.blue),
                const SizedBox(width: 14),
                _stat('Qualified', '${leads.where((e) => e['status'] == 'Qualified').length}', Icons.verified_outlined, Colors.indigo),
                const SizedBox(width: 14),
                _stat('Converted', '${leads.where((e) => e['status'] == 'Converted').length}', Icons.check_circle_outline, Colors.green),
                const Spacer(),
                ElevatedButton.icon(onPressed: showAddLeadDialog, icon: const Icon(Icons.add), label: const Text('Add Lead')),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: searchController,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: 'Search leads...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 18),
            Expanded(
              child: Card(
                elevation: 0,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('Name')),
                      DataColumn(label: Text('Company')),
                      DataColumn(label: Text('Email')),
                      DataColumn(label: Text('Source')),
                      DataColumn(label: Text('Status')),
                    ],
                    rows: filtered.map((lead) {
                      final status = lead['status']!;
                      return DataRow(cells: [
                        DataCell(Text(lead['name']!)),
                        DataCell(Text(lead['company']!)),
                        DataCell(Text(lead['email']!)),
                        DataCell(Text(lead['source']!)),
                        DataCell(Text(status, style: TextStyle(color: statusColor(status), fontWeight: FontWeight.w600))),
                      ]);
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Icon(icon, color: color, size: 30),
              const SizedBox(width: 12),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(title, style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 4),
                Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
