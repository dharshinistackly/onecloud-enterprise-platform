import 'package:flutter/material.dart';

class AttendancePage extends StatelessWidget {
  const AttendancePage({super.key});

  final List<Map<String, String>> attendance = const [
    {
      'employee': 'Arun Kumar',
      'date': '10 Sep 2026',
      'checkIn': '09:12 AM',
      'checkOut': '06:20 PM',
      'hours': '9h 08m',
      'status': 'Present',
    },
    {
      'employee': 'Priya Sharma',
      'date': '10 Sep 2026',
      'checkIn': '09:05 AM',
      'checkOut': '06:10 PM',
      'hours': '9h 05m',
      'status': 'Present',
    },
    {
      'employee': 'Rahul Raj',
      'date': '10 Sep 2026',
      'checkIn': '09:45 AM',
      'checkOut': '06:30 PM',
      'hours': '8h 45m',
      'status': 'Late',
    },
    {
      'employee': 'Divya Mohan',
      'date': '10 Sep 2026',
      'checkIn': '-',
      'checkOut': '-',
      'hours': '-',
      'status': 'On Leave',
    },
    {
      'employee': 'Karthik S',
      'date': '10 Sep 2026',
      'checkIn': '08:55 AM',
      'checkOut': '06:05 PM',
      'hours': '9h 10m',
      'status': 'Present',
    },
  ];

  Color _statusColor(String status) {
    if (status == 'Present') return Colors.green;
    if (status == 'Late') return Colors.orange;
    return Colors.red;
  }

  Widget _card(String title, String value, IconData icon, Color color) {
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
            Icon(icon, color: color, size: 30),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 5),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 23,
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
                    'Attendance',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0A1E3F),
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Monitor employee attendance, working hours and attendance status.',
                    style: TextStyle(color: Color(0xFF64748B)),
                  ),
                  const SizedBox(height: 24),
                  Wrap(
                    children: [
                      _card(
                        'Present Today',
                        '4',
                        Icons.check_circle_outline,
                        Colors.green,
                      ),
                      _card(
                        'Late Arrivals',
                        '1',
                        Icons.access_time,
                        Colors.orange,
                      ),
                      _card(
                        'On Leave',
                        '1',
                        Icons.event_busy_outlined,
                        Colors.red,
                      ),
                      _card(
                        'Attendance Rate',
                        '92%',
                        Icons.analytics_outlined,
                        const Color(0xFF1677C8),
                      ),
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
                        headingRowHeight: 55,
                        dataRowMinHeight: 55,
                        dataRowMaxHeight: 62,
                        columnSpacing: 35,
                        columns: const [
                          DataColumn(label: Text('Employee')),
                          DataColumn(label: Text('Date')),
                          DataColumn(label: Text('Check In')),
                          DataColumn(label: Text('Check Out')),
                          DataColumn(label: Text('Working Hours')),
                          DataColumn(label: Text('Status')),
                        ],
                        rows: attendance.map((item) {
                          final color = _statusColor(item['status']!);
                          return DataRow(
                            cells: [
                              DataCell(Text(item['employee']!)),
                              DataCell(Text(item['date']!)),
                              DataCell(Text(item['checkIn']!)),
                              DataCell(Text(item['checkOut']!)),
                              DataCell(Text(item['hours']!)),
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

  Widget _header(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 28),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Color(0xFFE2E8F0)),
        ),
      ),
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
            Icons.access_time_outlined,
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