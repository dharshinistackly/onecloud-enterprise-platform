import 'package:flutter/material.dart';

class RecruitmentPage extends StatelessWidget {
  const RecruitmentPage({super.key});

  final List<Map<String, String>> candidates = const [
    {
      'name': 'Anjali Kumar',
      'position': 'Flutter Developer',
      'department': 'Engineering',
      'experience': '2 Years',
      'status': 'Interview',
    },
    {
      'name': 'Vijay Raj',
      'position': 'Backend Developer',
      'department': 'Engineering',
      'experience': '3 Years',
      'status': 'Shortlisted',
    },
    {
      'name': 'Sneha R',
      'position': 'HR Executive',
      'department': 'HR',
      'experience': '1 Year',
      'status': 'Screening',
    },
    {
      'name': 'Manoj S',
      'position': 'Sales Executive',
      'department': 'Sales',
      'experience': '2 Years',
      'status': 'Selected',
    },
  ];

  Color _statusColor(String status) {
    if (status == 'Selected') return Colors.green;
    if (status == 'Shortlisted') return const Color(0xFF1677C8);
    if (status == 'Interview') return Colors.orange;
    return Colors.grey;
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
                    'Recruitment',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0A1E3F),
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Manage job openings, candidates, interviews and recruitment activities.',
                    style: TextStyle(color: Color(0xFF64748B)),
                  ),
                  const SizedBox(height: 24),
                  Wrap(
                    children: [
                      _summary('Open Positions', '12', Icons.work_outline, const Color(0xFF1677C8)),
                      _summary('Candidates', '86', Icons.people_outline, Colors.purple),
                      _summary('Interviews', '18', Icons.calendar_month_outlined, Colors.orange),
                      _summary('Selected', '7', Icons.check_circle_outline, Colors.green),
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
                        columns: const [
                          DataColumn(label: Text('Candidate')),
                          DataColumn(label: Text('Position')),
                          DataColumn(label: Text('Department')),
                          DataColumn(label: Text('Experience')),
                          DataColumn(label: Text('Status')),
                        ],
                        rows: candidates.map((item) {
                          final color = _statusColor(item['status']!);
                          return DataRow(
                            cells: [
                              DataCell(Text(item['name']!)),
                              DataCell(Text(item['position']!)),
                              DataCell(Text(item['department']!)),
                              DataCell(Text(item['experience']!)),
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
            Icons.person_search_outlined,
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