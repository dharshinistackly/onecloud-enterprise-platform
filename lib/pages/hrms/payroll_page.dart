import 'package:flutter/material.dart';

class PayrollPage extends StatelessWidget {
  const PayrollPage({super.key});

  final List<Map<String, String>> payroll = const [
    {
      'employee': 'Arun Kumar',
      'department': 'Engineering',
      'basic': '₹45,000',
      'allowance': '₹8,000',
      'deduction': '₹5,000',
      'net': '₹48,000',
    },
    {
      'employee': 'Priya Sharma',
      'department': 'HR',
      'basic': '₹55,000',
      'allowance': '₹10,000',
      'deduction': '₹7,000',
      'net': '₹58,000',
    },
    {
      'employee': 'Rahul Raj',
      'department': 'Finance',
      'basic': '₹40,000',
      'allowance': '₹6,000',
      'deduction': '₹4,000',
      'net': '₹42,000',
    },
    {
      'employee': 'Karthik S',
      'department': 'Engineering',
      'basic': '₹42,000',
      'allowance': '₹7,000',
      'deduction': '₹4,500',
      'net': '₹44,500',
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
                    'Payroll',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0A1E3F),
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Manage employee salaries, allowances, deductions and payroll processing.',
                    style: TextStyle(color: Color(0xFF64748B)),
                  ),
                  const SizedBox(height: 24),
                  Wrap(
                    children: [
                      _summary('Employees', '124', Icons.people_outline, const Color(0xFF1677C8)),
                      _summary('Monthly Payroll', '₹68.4L', Icons.payments_outlined, Colors.green),
                      _summary('Processed', '118', Icons.check_circle_outline, Colors.green),
                      _summary('Pending', '6', Icons.pending_outlined, Colors.orange),
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
                          DataColumn(label: Text('Department')),
                          DataColumn(label: Text('Basic Salary')),
                          DataColumn(label: Text('Allowances')),
                          DataColumn(label: Text('Deductions')),
                          DataColumn(label: Text('Net Salary')),
                        ],
                        rows: payroll.map((item) {
                          return DataRow(
                            cells: [
                              DataCell(Text(item['employee']!)),
                              DataCell(Text(item['department']!)),
                              DataCell(Text(item['basic']!)),
                              DataCell(Text(item['allowance']!)),
                              DataCell(Text(item['deduction']!)),
                              DataCell(
                                Text(
                                  item['net']!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1677C8),
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
            Icons.account_balance_wallet_outlined,
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