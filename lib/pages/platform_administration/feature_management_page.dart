import 'package:flutter/material.dart';

class FeatureManagementPage extends StatefulWidget {
  const FeatureManagementPage({super.key});

  @override
  State<FeatureManagementPage> createState() => _FeatureManagementPageState();
}

class _FeatureManagementPageState extends State<FeatureManagementPage> {
  final List<Map<String, dynamic>> features = [
    {'name': 'HRMS', 'description': 'Employee management', 'enabled': true},
    {'name': 'CRM', 'description': 'Customer management', 'enabled': true},
    {'name': 'ERP', 'description': 'Enterprise operations', 'enabled': true},
    {'name': 'AI Assistant', 'description': 'AI powered tools', 'enabled': false},
    {'name': 'Analytics', 'description': 'Business analytics', 'enabled': true},
  ];

  @override
  Widget build(BuildContext context) {
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
                  'Feature Management',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F3D66),
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Enable or disable enterprise platform features.',
                  style: TextStyle(color: Color(0xFF64748B)),
                ),
                const SizedBox(height: 24),
                ...features.asMap().entries.map(
                  (entry) => _featureCard(entry.key, entry.value),
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
            Icons.extension_outlined,
            color: Color(0xFF1677C8),
            size: 27,
          ),
          SizedBox(width: 12),
          Text(
            'Feature Management',
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

  Widget _featureCard(int index, Map<String, dynamic> feature) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Color(0xFFEAF4FC),
            child: Icon(
              Icons.apps_outlined,
              color: Color(0xFF1677C8),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  feature['name'],
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F3D66),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  feature['description'],
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: feature['enabled'],
            activeColor: const Color(0xFF1677C8),
            onChanged: (value) {
              setState(() {
                features[index]['enabled'] = value;
              });
            },
          ),
        ],
      ),
    );
  }
}