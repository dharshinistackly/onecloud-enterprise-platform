import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool emailNotifications = true;
  bool pushNotifications = true;
  bool twoFactorAuthentication = true;
  bool loginAlerts = true;

  String selectedLanguage = 'English';
  String selectedTheme = 'Light';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      body: Column(
        children: [
          Container(
            height: 76,
            padding: const EdgeInsets.symmetric(horizontal: 28),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color(0x14000000),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.of(context).maybePop(),
                  icon: const Icon(Icons.arrow_back, color: Color(0xFF0F3D66)),
                  tooltip: 'Back',
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.settings_outlined,
                  color: Color(0xFF1677C8),
                  size: 28,
                ),
                SizedBox(width: 14),
                Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF102A43),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Application Settings',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF102A43),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Manage your account, application preferences and security settings.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF64748B),
                    ),
                  ),
                  const SizedBox(height: 24),

                  _buildSection(
                    title: 'Account Settings',
                    icon: Icons.person_outline,
                    children: [
                      _buildSettingTile(
                        icon: Icons.account_circle_outlined,
                        title: 'Profile',
                        subtitle: 'Manage your personal information',
                        onTap: () {
                          _showMessage('Profile settings selected');
                        },
                      ),
                      _buildSettingTile(
                        icon: Icons.lock_outline,
                        title: 'Change Password',
                        subtitle: 'Update your account password',
                        onTap: () {
                          _showChangePasswordDialog();
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  _buildSection(
                    title: 'Preferences',
                    icon: Icons.tune_outlined,
                    children: [
                      _buildDropdownTile(
                        icon: Icons.language_outlined,
                        title: 'Language',
                        subtitle: 'Choose application language',
                        value: selectedLanguage,
                        items: const [
                          'English',
                          'Tamil',
                          'Hindi',
                        ],
                        onChanged: (value) {
                          setState(() {
                            selectedLanguage = value!;
                          });
                        },
                      ),
                      _buildDropdownTile(
                        icon: Icons.palette_outlined,
                        title: 'Theme',
                        subtitle: 'Choose application appearance',
                        value: selectedTheme,
                        items: const [
                          'Light',
                          'Dark',
                          'System Default',
                        ],
                        onChanged: (value) {
                          setState(() {
                            selectedTheme = value!;
                          });
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  _buildSection(
                    title: 'Notifications',
                    icon: Icons.notifications_none,
                    children: [
                      _buildSwitchTile(
                        icon: Icons.email_outlined,
                        title: 'Email Notifications',
                        subtitle: 'Receive important updates through email',
                        value: emailNotifications,
                        onChanged: (value) {
                          setState(() {
                            emailNotifications = value;
                          });
                        },
                      ),
                      _buildSwitchTile(
                        icon: Icons.notifications_active_outlined,
                        title: 'Push Notifications',
                        subtitle: 'Receive notifications inside the application',
                        value: pushNotifications,
                        onChanged: (value) {
                          setState(() {
                            pushNotifications = value;
                          });
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  _buildSection(
                    title: 'Security',
                    icon: Icons.security_outlined,
                    children: [
                      _buildSwitchTile(
                        icon: Icons.verified_user_outlined,
                        title: 'Two-Factor Authentication',
                        subtitle: 'Add an additional security layer to your account',
                        value: twoFactorAuthentication,
                        onChanged: (value) {
                          setState(() {
                            twoFactorAuthentication = value;
                          });
                        },
                      ),
                      _buildSwitchTile(
                        icon: Icons.warning_amber_outlined,
                        title: 'Login Alerts',
                        subtitle: 'Get notified about new login activity',
                        value: loginAlerts,
                        onChanged: (value) {
                          setState(() {
                            loginAlerts = value;
                          });
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  _buildSection(
                    title: 'System',
                    icon: Icons.settings_applications_outlined,
                    children: [
                      _buildSettingTile(
                        icon: Icons.info_outline,
                        title: 'System Information',
                        subtitle: 'View platform and application information',
                        onTap: () {
                          _showSystemInformation();
                        },
                      ),
                      _buildSettingTile(
                        icon: Icons.restore_outlined,
                        title: 'Reset Preferences',
                        subtitle: 'Restore your application preferences',
                        onTap: () {
                          _showResetDialog();
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: const Color(0xFFD8E6F2),
                      ),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.cloud_outlined,
                          color: Color(0xFF1677C8),
                          size: 30,
                        ),
                        SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'OneCloud Enterprise Platform',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF102A43),
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Centralized settings and configuration management',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF64748B),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'v1.0.0',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF64748B),
                          ),
                        ),
                      ],
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

  Widget _buildSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFD8E6F2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
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
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF102A43),
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            height: 1,
            color: Color(0xFFE5EDF4),
          ),
          ...children,
        ],
      ),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 7,
      ),
      leading: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: const Color(0xFFEAF5FF),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          color: const Color(0xFF1677C8),
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Color(0xFF102A43),
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Text(
          subtitle,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF64748B),
          ),
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: Color(0xFF94A3B8),
      ),
      onTap: onTap,
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 7,
      ),
      leading: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: const Color(0xFFEAF5FF),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          color: const Color(0xFF1677C8),
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Color(0xFF102A43),
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Text(
          subtitle,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF64748B),
          ),
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeThumbColor: const Color(0xFF1677C8),
      ),
    );
  }

  Widget _buildDropdownTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 7,
      ),
      leading: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: const Color(0xFFEAF5FF),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          color: const Color(0xFF1677C8),
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Color(0xFF102A43),
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Text(
          subtitle,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF64748B),
          ),
        ),
      ),
      trailing: DropdownButton<String>(
        value: value,
        underline: const SizedBox(),
        items: items.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  void _showChangePasswordDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Change Password'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Current Password',
                ),
              ),
              SizedBox(height: 14),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'New Password',
                ),
              ),
              SizedBox(height: 14),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _showMessage('Password updated successfully');
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  void _showSystemInformation() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('System Information'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Platform: OneCloud Enterprise Platform'),
              SizedBox(height: 10),
              Text('Version: 1.0.0'),
              SizedBox(height: 10),
              Text('Environment: Production'),
              SizedBox(height: 10),
              Text('Status: Active'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showResetDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Reset Preferences'),
          content: const Text(
            'Are you sure you want to reset your application preferences?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  emailNotifications = true;
                  pushNotifications = true;
                  twoFactorAuthentication = true;
                  loginAlerts = true;
                  selectedLanguage = 'English';
                  selectedTheme = 'Light';
                });

                Navigator.pop(context);
                _showMessage('Preferences reset successfully');
              },
              child: const Text('Reset'),
            ),
          ],
        );
      },
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}