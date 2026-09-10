import 'package:flutter/material.dart';

class ResourceManagementPage extends StatelessWidget {
  const ResourceManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    final resources = [
      ['Compute Resources', '72%', 'Healthy'],
      ['Storage', '64%', 'Healthy'],
      ['Database', '48%', 'Healthy'],
      ['API Requests', '38%', 'Normal'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      body: Column(
        children: [
          _header(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                const Text(
                  'Resource Management',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F3D66),
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Monitor platform resource usage.',
                  style: TextStyle(color: Color(0xFF64748B)),
                ),
                const SizedBox(height: 24),
                ...resources.map(
                  (resource) => _resourceCard(resource),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _header() {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      color: Colors.white,
      child: const Row(
        children: [
          Icon(
            Icons.memory_outlined,
            color: Color(0xFF1677C8),
            size: 27,
          ),
          SizedBox(width: 12),
          Text(
            'Resource Management',
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

  Widget _resourceCard(List<String> resource) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  resource[0],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F3D66),
                  ),
                ),
              ),
              Text(
                resource[1],
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1677C8),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: double.parse(resource[1].replaceAll('%', '')) / 100,
            minHeight: 8,
            borderRadius: BorderRadius.circular(10),
          ),
          const SizedBox(height: 10),
          Text(
            resource[2],
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF16A085),
            ),
          ),
        ],
      ),
    );
  }
}