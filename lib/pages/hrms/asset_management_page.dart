import 'package:flutter/material.dart';

class AssetManagementPage extends StatelessWidget {
  const AssetManagementPage({super.key});

  final List<Map<String, String>> assets = const [
    {
      'assetId': 'AST001',
      'asset': 'Dell Latitude Laptop',
      'employee': 'Arun Kumar',
      'category': 'Laptop',
      'status': 'Assigned',
    },
    {
      'assetId': 'AST002',
      'asset': 'iPhone 15',
      'employee': 'Priya Sharma',
      'category': 'Mobile',
      'status': 'Assigned',
    },
    {
      'assetId': 'AST003',
      'asset': 'HP Monitor',
      'employee': 'Rahul Raj',
      'category': 'Monitor',
      'status': 'Assigned',
    },
    {
      'assetId': 'AST004',
      'asset': 'MacBook Pro',
      'employee': 'Unassigned',
      'category': 'Laptop',
      'status': 'Available',
    },
    {
      'assetId': 'AST005',
      'asset': 'Samsung Tablet',
      'employee': 'Unassigned',
      'category': 'Tablet',
      'status': 'Maintenance',
    },
  ];

  Color _statusColor(String status) {
    if (status == 'Assigned') return const Color(0xFF1677C8);
    if (status == 'Available') return Colors.green;
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
              padding: const EdgeInsets.all(28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Asset Management',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0A1E3F),
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Track company assets, assignments, availability and maintenance status.',
                    style: TextStyle(color: Color(0xFF64748B)),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      _summary('Total Assets', '245', Icons.devices_outlined, const Color(0xFF1677C8)),
                      const SizedBox(width: 16),
                      _summary('Assigned', '198', Icons.assignment_ind_outlined, Colors.purple),
                      const SizedBox(width: 16),
                      _summary('Available', '32', Icons.inventory_2_outlined, Colors.green),
                      const SizedBox(width: 16),
                      _summary('Maintenance', '15', Icons.build_outlined, Colors.orange),
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
                          DataColumn(label: Text('Asset ID')),
                          DataColumn(label: Text('Asset')),
                          DataColumn(label: Text('Employee')),
                          DataColumn(label: Text('Category')),
                          DataColumn(label: Text('Status')),
                        ],
                        rows: assets.map((item) {
                          final color = _statusColor(item['status']!);
                          return DataRow(
                            cells: [
                              DataCell(Text(item['assetId']!)),
                              DataCell(Text(item['asset']!)),
                              DataCell(Text(item['employee']!)),
                              DataCell(Text(item['category']!)),
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
            Icons.inventory_2_outlined,
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