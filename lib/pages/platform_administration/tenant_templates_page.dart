import 'package:flutter/material.dart';

class TenantTemplatesPage extends StatelessWidget {
  const TenantTemplatesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final templates = [
      ['Standard Enterprise', 'HRMS, CRM, ERP', 'Active'],
      ['Small Business', 'CRM, Finance', 'Active'],
      ['AI Enterprise', 'AI, Analytics, CRM', 'Active'],
      ['Trial Template', 'Basic Services', 'Active'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      body: Column(
        children: [
          _header(context),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                const Text(
                  'Tenant Templates',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F3D66),
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Manage reusable configurations for tenants.',
                  style: TextStyle(color: Color(0xFF64748B)),
                ),
                const SizedBox(height: 24),
                ...templates.map(
                  (template) => _templateCard(template),
                ),
              ],
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
            Icons.layers_outlined,
            color: Color(0xFF1677C8),
            size: 27,
          ),
          SizedBox(width: 12),
          Text(
            'Tenant Templates',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0F3D66),
            ),
          ),
        ],
      ),
    );
  }

  Widget _templateCard(List<String> template) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFEAF4FC),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.business_outlined,
              color: Color(0xFF1677C8),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  template[0],
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F3D66),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  template[1],
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFDCFCE7),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              template[2],
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Color(0xFF15803D),
              ),
            ),
          ),
        ],
      ),
    );
  }
}