import 'package:flutter/material.dart';

class PlatformConfigPage extends StatefulWidget {
  const PlatformConfigPage({super.key});

  @override
  State<PlatformConfigPage> createState() => _PlatformConfigPageState();
}

class _PlatformConfigPageState extends State<PlatformConfigPage> {
  bool apiEnabled = true;
  bool cloudStorage = true;
  bool loggingEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Platform Configuration',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0F3D66),
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Configure core platform services and system options.',
                    style: TextStyle(color: Color(0xFF64748B)),
                  ),
                  const SizedBox(height: 24),
                  _buildCard(
                    'Core Services',
                    Icons.settings_applications_outlined,
                    [
                      _buildSwitch(
                        'API Services',
                        'Enable platform API services',
                        apiEnabled,
                        (value) => setState(() => apiEnabled = value),
                      ),
                      _buildSwitch(
                        'Cloud Storage',
                        'Enable enterprise cloud storage',
                        cloudStorage,
                        (value) => setState(() => cloudStorage = value),
                      ),
                      _buildSwitch(
                        'System Logging',
                        'Record system activities',
                        loggingEnabled,
                        (value) => setState(() => loggingEnabled = value),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildCard(
                    'Environment',
                    Icons.cloud_outlined,
                    [
                      _buildInfo('Environment', 'Development'),
                      _buildInfo('API Version', 'v1.0'),
                      _buildInfo('Region', 'Asia Pacific'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return _header('Platform Configuration', Icons.tune_outlined);
  }

  Widget _header(String title, IconData icon) {
    return Container(
      height: 70,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      color: Colors.white,
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF1677C8), size: 27),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0F3D66),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(String title, IconData icon, List<Widget> children) {
    return Container(
      width: double.infinity,
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
              Icon(icon, color: const Color(0xFF1677C8)),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0F3D66),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          ...children,
        ],
      ),
    );
  }

  Widget _buildSwitch(
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: const Color(0xFF1677C8),
      ),
    );
  }

  Widget _buildInfo(String title, String value) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      trailing: Text(
        value,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Color(0xFF1677C8),
        ),
      ),
    );
  }
}