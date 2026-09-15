import 'package:flutter/material.dart';

class PerformancePage extends StatelessWidget {
  const PerformancePage({super.key});

  final List<Map<String, String>> employees = const [
    {
      'employee': 'Arun Kumar',
      'department': 'Engineering',
      'rating': '4.5',
      'goal': '92%',
      'review': 'Completed',
    },
    {
      'employee': 'Priya Sharma',
      'department': 'HR',
      'rating': '4.7',
      'goal': '96%',
      'review': 'Completed',
    },
    {
      'employee': 'Rahul Raj',
      'department': 'Finance',
      'rating': '4.1',
      'goal': '84%',
      'review': 'In Progress',
    },
    {
      'employee': 'Karthik S',
      'department': 'Engineering',
      'rating': '4.3',
      'goal': '89%',
      'review': 'Completed',
    },
  ];

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
                    'Performance Management',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0A1E3F),
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Track employee goals, performance ratings and review progress.',
                    style: TextStyle(color: Color(0xFF64748B)),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      _summary('Employees Reviewed', '98', Icons.people_outline, const Color(0xFF1677C8)),
                      const SizedBox(width: 16),
                      _summary('Average Rating', '4.4', Icons.star_outline, Colors.orange),
                      const SizedBox(width: 16),
                      _summary('Goals Completed', '91%', Icons.flag_outlined, Colors.green),
                      const SizedBox(width: 16),
                      _summary('Pending Reviews', '14', Icons.pending_outlined, Colors.red),
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
                        columnSpacing: 40,
                        columns: const [
                          DataColumn(label: Text('Employee')),
                          DataColumn(label: Text('Department')),
                          DataColumn(label: Text('Rating')),
                          DataColumn(label: Text('Goal Completion')),
                          DataColumn(label: Text('Review Status')),
                        ],
                        rows: employees.map((item) {
                          return DataRow(
                            cells: [
                              DataCell(Text(item['employee']!)),
                              DataCell(Text(item['department']!)),
                              DataCell(
                                Text(
                                  '★ ${item['rating']}',
                                  style: const TextStyle(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              DataCell(Text(item['goal']!)),
                              DataCell(Text(item['review']!)),
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
            Icons.trending_up_outlined,
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