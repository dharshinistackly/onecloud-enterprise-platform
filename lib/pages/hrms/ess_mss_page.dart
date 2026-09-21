import 'package:flutter/material.dart';

class EssMssPage extends StatelessWidget {
  const EssMssPage({super.key});

  final List<Map<String, String>> requests = const [
    {
      'employee': 'Arun Kumar',
      'request': 'Leave Request',
      'submitted': '10 Sep 2026',
      'status': 'Pending',
    },
    {
      'employee': 'Priya Sharma',
      'request': 'Profile Update',
      'submitted': '09 Sep 2026',
      'status': 'Approved',
    },
    {
      'employee': 'Rahul Raj',
      'request': 'Attendance Correction',
      'submitted': '08 Sep 2026',
      'status': 'Pending',
    },
    {
      'employee': 'Karthik S',
      'request': 'Document Request',
      'submitted': '07 Sep 2026',
      'status': 'Completed',
    },
  ];

  Color _statusColor(String status) {
    if (status == 'Approved' || status == 'Completed') return Colors.green;
    return Colors.orange;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      body: Column(
        children: [
          _header(context),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'ESS / MSS',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0A1E3F),
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Employee and manager self-service requests, approvals and HR activities.',
                    style: TextStyle(color: Color(0xFF64748B)),
                  ),
                  const SizedBox(height: 24),
                  Wrap(
                    children: [
                      _summary('Employee Requests', '42', Icons.person_outline, const Color(0xFF1677C8)),
                      _summary('Manager Requests', '16', Icons.supervisor_account_outlined, Colors.purple),
                      _summary('Pending', '8', Icons.pending_outlined, Colors.orange),
                      _summary('Completed', '50', Icons.check_circle_outline, Colors.green),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columnSpacing: 45,
                        columns: const [
                          DataColumn(label: Text('Employee')),
                          DataColumn(label: Text('Request')),
                          DataColumn(label: Text('Submitted')),
                          DataColumn(label: Text('Status')),
                        ],
                        rows: requests.map((item) {
                          final color = _statusColor(item['status']!);
                          return DataRow(
                            cells: [
                              DataCell(Text(item['employee']!)),
                              DataCell(Text(item['request']!)),
                              DataCell(Text(item['submitted']!)),
                              DataCell(
                                Text(
                                  item['status']!,
                                  style: TextStyle(
                                    color: color,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _summary(String title, String value, IconData icon, Color color) {
    return SizedBox(
      width: 240,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F3D66),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 28),
      color: Colors.white,
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back,
              color: Color(0xFF0F3D66),
            ),
            tooltip: 'Back',
          ),
          const SizedBox(width: 4),
          Icon(
            Icons.manage_accounts_outlined,
            color: Color(0xFF1677C8),
            size: 28,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
            'HRMS Service',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F3D66),
            ),
          )),
        ],
      ),
    );
  }
}