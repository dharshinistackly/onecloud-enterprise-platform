import 'package:flutter/material.dart';

class LearningPage extends StatelessWidget {
  const LearningPage({super.key});

  final List<Map<String, String>> courses = const [
    {
      'course': 'Flutter Development',
      'employees': '24',
      'completed': '18',
      'progress': '75%',
      'status': 'Active',
    },
    {
      'course': 'Leadership Skills',
      'employees': '18',
      'completed': '14',
      'progress': '78%',
      'status': 'Active',
    },
    {
      'course': 'Cloud Fundamentals',
      'employees': '30',
      'completed': '20',
      'progress': '67%',
      'status': 'Active',
    },
    {
      'course': 'Cyber Security Awareness',
      'employees': '52',
      'completed': '50',
      'progress': '96%',
      'status': 'Completed',
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
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Learning & Development',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0A1E3F),
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Manage employee training, courses, learning progress and development programs.',
                    style: TextStyle(color: Color(0xFF64748B)),
                  ),
                  const SizedBox(height: 24),
                  Wrap(
                    children: [
                      _summary('Active Courses', '18', Icons.menu_book_outlined, const Color(0xFF1677C8)),
                      _summary('Enrolled Employees', '124', Icons.people_outline, Colors.purple),
                      _summary('Completed', '86', Icons.check_circle_outline, Colors.green),
                      _summary('Average Progress', '79%', Icons.show_chart, Colors.orange),
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
                          DataColumn(label: Text('Course')),
                          DataColumn(label: Text('Employees')),
                          DataColumn(label: Text('Completed')),
                          DataColumn(label: Text('Progress')),
                          DataColumn(label: Text('Status')),
                        ],
                        rows: courses.map((item) {
                          return DataRow(
                            cells: [
                              DataCell(Text(item['course']!)),
                              DataCell(Text(item['employees']!)),
                              DataCell(Text(item['completed']!)),
                              DataCell(
                                Text(
                                  item['progress']!,
                                  style: const TextStyle(
                                    color: Color(0xFF1677C8),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              DataCell(Text(item['status']!)),
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
            Icons.school_outlined,
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