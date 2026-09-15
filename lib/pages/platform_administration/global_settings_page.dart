import 'package:flutter/material.dart';

class GlobalSettingsPage extends StatefulWidget {
  const GlobalSettingsPage({super.key});

  @override
  State<GlobalSettingsPage> createState() => _GlobalSettingsPageState();
}

class _GlobalSettingsPageState extends State<GlobalSettingsPage> {
  bool emailNotifications = true;
  bool maintenanceMode = false;
  bool automaticBackup = true;

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
                    'Global Settings',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0F3D66),
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Manage general platform configuration.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF64748B),
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildSettingsCard(
                    'General Configuration',
                    Icons.settings_outlined,
                    [
                      _buildSettingRow(
                        'Platform Name',
                        'OneCloud Enterprise',
                        Icons.cloud_outlined,
                      ),
                      _buildSettingRow(
                        'Default Language',
                        'English',
                        Icons.language_outlined,
                      ),
                      _buildSettingRow(
                        'Time Zone',
                        'Asia/Kolkata',
                        Icons.access_time_outlined,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildSettingsCard(
                    'Platform Controls',
                    Icons.tune_outlined,
                    [
                      _buildSwitchRow(
                        'Email Notifications',
                        'Enable platform email notifications',
                        emailNotifications,
                        (value) {
                          setState(() {
                            emailNotifications = value;
                          });
                        },
                      ),
                      _buildSwitchRow(
                        'Automatic Backup',
                        'Enable automatic system backup',
                        automaticBackup,
                        (value) {
                          setState(() {
                            automaticBackup = value;
                          });
                        },
                      ),
                      _buildSwitchRow(
                        'Maintenance Mode',
                        'Temporarily restrict platform access',
                        maintenanceMode,
                        (value) {
                          setState(() {
                            maintenanceMode = value;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildSettingsCard(
                    'System Information',
                    Icons.info_outline,
                    [
                      _buildSettingRow(
                        'Platform Version',
                        '1.0.0',
                        Icons.code_outlined,
                      ),
                      _buildSettingRow(
                        'Environment',
                        'Development',
                        Icons.developer_mode_outlined,
                      ),
                      _buildSettingRow(
                        'System Status',
                        'Operational',
                        Icons.check_circle_outline,
                      ),
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
    return Container(
      height: 70,
      width: double.infinity,
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
          const Icon(
            Icons.admin_panel_settings_outlined,
            color: Color(0xFF1677C8),
            size: 27,
          ),
          const SizedBox(width: 12),
          const Text(
            'Platform Administration',
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

  Widget _buildSettingsCard(
    String title,
    IconData icon,
    List<Widget> children,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: const Color(0xFF1677C8),
                size: 22,
              ),
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
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildSettingRow(
    String title,
    String value,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFE2E8F0),
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFF64748B),
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF334155),
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1677C8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchRow(
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF334155),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF1677C8),
          ),
        ],
      ),
    );
  }
}