import 'package:flutter/material.dart';

class LicenseManagementPage extends StatelessWidget {
  const LicenseManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    final licenses = [
      ['OneCloud Basic', '20', '18', 'Active'],
      ['OneCloud Professional', '50', '42', 'Active'],
      ['OneCloud Enterprise', '100', '76', 'Active'],
      ['AI Module', '30', '24', 'Active'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      body: Column(
        children: [
          _header(context),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'License Management',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0F3D66),
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Manage platform licenses and allocations.',
                    style: TextStyle(color: Color(0xFF64748B)),
                  ),
                  const SizedBox(height: 24),
                  _summaryCards(),
                  const SizedBox(height: 24),
                  _licenseTable(licenses),
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
      padding: const EdgeInsets.symmetric(horizontal: 24),
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
            Icons.vpn_key_outlined,
            color: Color(0xFF1677C8),
            size: 27,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
            'License Management',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0F3D66),
            ),
          )),
        ],
      ),
    );
  }

  Widget _summaryCards() {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        SizedBox(
          width: 220,
          child: _summary('Total Licenses', '200'),
        ),
        SizedBox(
          width: 220,
          child: _summary('Assigned', '160'),
        ),
        SizedBox(
          width: 220,
          child: _summary('Available', '40'),
        ),
      ],
    );
  }

  Widget _summary(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Color(0xFF64748B))),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1677C8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _licenseTable(List<List<String>> licenses) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: DataTable(
        columns: const [
          DataColumn(label: Text('License')),
          DataColumn(label: Text('Total')),
          DataColumn(label: Text('Used')),
          DataColumn(label: Text('Status')),
        ],
        rows: licenses.map((license) {
          return DataRow(
            cells: [
              DataCell(Text(license[0])),
              DataCell(Text(license[1])),
              DataCell(Text(license[2])),
              DataCell(
                Text(
                  license[3],
                  style: const TextStyle(
                    color: Color(0xFF16A085),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}