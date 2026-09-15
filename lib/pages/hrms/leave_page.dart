import 'package:flutter/material.dart';

class LeavePage extends StatelessWidget {
  const LeavePage({super.key});

  final List<Map<String, String>> leaves = const [
    {
      'employee': 'Divya Mohan',
      'type': 'Annual Leave',
      'from': '10 Sep 2026',
      'to': '12 Sep 2026',
      'days': '3',
      'status': 'Approved',
    },
    {
      'employee': 'Arun Kumar',
      'type': 'Sick Leave',
      'from': '15 Sep 2026',
      'to': '15 Sep 2026',
      'days': '1',
      'status': 'Pending',
    },
    {
      'employee': 'Priya Sharma',
      'type': 'Casual Leave',
      'from': '18 Sep 2026',
      'to': '19 Sep 2026',
      'days': '2',
      'status': 'Approved',
    },
    {
      'employee': 'Rahul Raj',
      'type': 'Casual Leave',
      'from': '22 Sep 2026',
      'to': '22 Sep 2026',
      'days': '1',
      'status': 'Rejected',
    },
  ];

  Color _statusColor(String status) {
    if (status == 'Approved') return Colors.green;
    if (status == 'Pending') return Colors.orange;
    return Colors.red;
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
              padding: const EdgeInsets.all(28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Leave Management',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0A1E3F),
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Manage employee leave requests, approvals and leave balances.',
                    style: TextStyle(color: Color(0xFF64748B)),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      _summary('Total Requests', '24', Icons.list_alt, const Color(0xFF1677C8)),
                      const SizedBox(width: 16),
                      _summary('Approved', '18', Icons.check_circle_outline, Colors.green),
                      const SizedBox(width: 16),
                      _summary('Pending', '4', Icons.pending_outlined, Colors.orange),
                      const SizedBox(width: 16),
                      _summary('Rejected', '2', Icons.cancel_outlined, Colors.red),
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
                        columnSpacing: 35,
                        headingRowHeight: 55,
                        columns: const [
                          DataColumn(label: Text('Employee')),
                          DataColumn(label: Text('Leave Type')),
                          DataColumn(label: Text('From')),
                          DataColumn(label: Text('To')),
                          DataColumn(label: Text('Days')),
                          DataColumn(label: Text('Status')),
                        ],
                        rows: leaves.map((item) {
                          final color = _statusColor(item['status']!);
                          return DataRow(
                            cells: [
                              DataCell(Text(item['employee']!)),
                              DataCell(Text(item['type']!)),
                              DataCell(Text(item['from']!)),
                              DataCell(Text(item['to']!)),
                              DataCell(Text(item['days']!)),
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
    return Expanded(
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
                    fontSize: 22,
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
            Icons.event_available_outlined,
            color: Color(0xFF1677C8),
            size: 28,
          ),
          SizedBox(width: 12),
          Text(
            'HRMS Service',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F3D66),
            ),
          ),
        ],
      ),
    );
  }
}