import 'package:flutter/material.dart';

class SystemHealthPage extends StatelessWidget {
  const SystemHealthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final services = [
      ['API Gateway', 'Operational', Icons.api_outlined],
      ['Database', 'Operational', Icons.storage_outlined],
      ['Authentication', 'Operational', Icons.lock_outline],
      ['Notification Service', 'Operational', Icons.notifications_outlined],
      ['Cloud Storage', 'Operational', Icons.cloud_outlined],
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
                  'System Health',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F3D66),
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Monitor the health of platform services.',
                  style: TextStyle(color: Color(0xFF64748B)),
                ),
                const SizedBox(height: 24),
                _healthSummary(),
                const SizedBox(height: 20),
                ...services.map(
                  (service) => _serviceCard(service),
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
            Icons.monitor_heart_outlined,
            color: Color(0xFF1677C8),
            size: 27,
          ),
          SizedBox(width: 12),
          Text(
            'System Health',
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

  Widget _healthSummary() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.check_circle,
            color: Color(0xFF10B981),
            size: 45,
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'All Systems Operational',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0F3D66),
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Last checked: Just now',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF64748B),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _serviceCard(List<dynamic> service) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Icon(
            service[2],
            color: const Color(0xFF1677C8),
            size: 25,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              service[0],
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(0xFF334155),
              ),
            ),
          ),
          const Icon(
            Icons.check_circle_outline,
            color: Color(0xFF10B981),
          ),
          const SizedBox(width: 8),
          Text(
            service[1],
            style: const TextStyle(
              color: Color(0xFF10B981),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}