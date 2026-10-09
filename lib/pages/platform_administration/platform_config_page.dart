import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:one_cloud_enterprise/widgets/config_dialogs.dart';
import '../../providers/menu_provider.dart';
import '../../routes/app_routes.dart';

class PlatformConfigPage extends StatefulWidget {
  const PlatformConfigPage({super.key});

  @override
  State<PlatformConfigPage> createState() => _PlatformConfigPageState();
}

class _PlatformConfigPageState extends State<PlatformConfigPage> {
  final TextEditingController _platformNameController =
      TextEditingController(
    text: 'Java Enterprise Suite',
  );

  final TextEditingController _platformUrlController =
      TextEditingController(
    text: 'https://app.javasuite.enterprise',
  );

  String _timeZone = 'UTC +05:30 (India Standard Time)';
  String _language = 'ENGLISH';

  @override
  void dispose() {
    _platformNameController.dispose();
    _platformUrlController.dispose();
    super.dispose();
  }

  // ============================================================
  // RETURN TO SUPER ADMIN DASHBOARD
  // ============================================================

  void _goToDashboard() {
    final navigator = Navigator.of(context);

    navigator.popUntil(
      (route) => route.settings.name == AppRoutes.home,
    );

    context.read<MenuProvider>().selectRoute(AppRoutes.home);
  }

  void _saveConfiguration() {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text(
            'Platform configuration saved successfully.',
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  // ============================================================
  // MAIN
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = constraints.maxWidth < 700;

        return Container(
          color: const Color(0xFFF7F9FC),
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              isMobile ? 16 : 24,
              isMobile ? 18 : 18,
              isMobile ? 16 : 24,
              isMobile ? 28 : 24,
            ),
            child: isMobile
                ? _buildMobileLayout()
                : _buildDesktopLayout(),
          ),
        );
      },
    );
  }

  // ============================================================
  // DESKTOP LAYOUT
  // ============================================================

  Widget _buildDesktopLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBreadcrumb(),

        const SizedBox(height: 5),

        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Platform Configuration',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF172033),
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    'Manage core platform settings, regional defaults, and security handling.',
                    style: TextStyle(
                      fontSize: 10,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),

            _buildCancelButton(),

            const SizedBox(width: 7),

            _buildSaveButton(),
          ],
        ),

        const SizedBox(height: 12),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 7,
              child: Column(
                children: [
                  _buildBasicConfiguration(),

                  const SizedBox(height: 10),

                  _buildRegionalConfiguration(),

                  const SizedBox(height: 10),

                  _buildCommunicationIntegration(),

                  const SizedBox(height: 10),

                  _buildDeploymentNote(),
                ],
              ),
            ),

            const SizedBox(width: 10),

            Expanded(
              flex: 4,
              child: _buildSecurityHandling(),
            ),
          ],
        ),
      ],
    );
  }

  // ============================================================
  // MOBILE LAYOUT
  // ============================================================

  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBreadcrumb(),

        const SizedBox(height: 7),

        const Text(
          'Platform Configuration',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xFF172033),
          ),
        ),

        const SizedBox(height: 15),

        _buildBasicConfiguration(),

        const SizedBox(height: 8),

        _buildRegionalConfiguration(),

        const SizedBox(height: 8),

        _buildSecurityHandling(),

        const SizedBox(height: 8),

        _buildCommunicationIntegration(),

        const SizedBox(height: 8),

        _buildDeploymentNote(),

        const SizedBox(height: 12),

        Row(
          children: [
            Expanded(
              child: _buildCancelButton(
                height: 45,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildSaveButton(
                height: 45,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ============================================================
  // BREADCRUMB
  // ============================================================

  Widget _buildBreadcrumb() {
    return RichText(
      text: const TextSpan(
        children: [
          TextSpan(
            text: 'Platform Administration',
            style: TextStyle(
              fontSize: 9,
              color: Color(0xFF9AA9BD),
            ),
          ),
          TextSpan(
            text: '  /  ',
            style: TextStyle(
              fontSize: 9,
              color: Color(0xFFCBD5E1),
            ),
          ),
          TextSpan(
            text: 'Platform Configuration',
            style: TextStyle(
              fontSize: 9,
              color: Color(0xFF718096),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // BASIC CONFIGURATION
  // ============================================================

  Widget _buildBasicConfiguration() {
    return _sectionCard(
      title: 'Basic Configuration',
      icon: Icons.settings_outlined,
      children: [
        _inputLabel('Platform Name'),

        const SizedBox(height: 5),

        _textField(
          controller: _platformNameController,
        ),

        const SizedBox(height: 9),

        _inputLabel('Platform URL'),

        const SizedBox(height: 5),

        _textField(
          controller: _platformUrlController,
        ),
      ],
    );
  }

  // ============================================================
  // REGIONAL CONFIGURATION
  // ============================================================

  Widget _buildRegionalConfiguration() {
    return _sectionCard(
      title: 'Regional Configuration',
      icon: Icons.language_outlined,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 500) {
              return Column(
                children: [
                  _dropdownField(
                    label: 'Default Time Zone',
                    value: _timeZone,
                    items: const [
                      'UTC +05:30 (India Standard Time)',
                      'UTC +00:00 (GMT)',
                      'UTC -05:00 (Eastern Time)',
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _timeZone = value;
                        });
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  _dropdownField(
                    label: 'Default Language',
                    value: _language,
                    items: const [
                      'ENGLISH',
                      'TAMIL',
                      'HINDI',
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _language = value;
                        });
                      }
                    },
                  ),
                ],
              );
            }

            return Row(
              children: [
                Expanded(
                  child: _dropdownField(
                    label: 'Default Time Zone',
                    value: _timeZone,
                    items: const [
                      'UTC +05:30 (India Standard Time)',
                      'UTC +00:00 (GMT)',
                      'UTC -05:00 (Eastern Time)',
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _timeZone = value;
                        });
                      }
                    },
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: _dropdownField(
                    label: 'Default Language',
                    value: _language,
                    items: const [
                      'ENGLISH',
                      'TAMIL',
                      'HINDI',
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _language = value;
                        });
                      }
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  // ============================================================
  // SECURITY HANDLING
  // ============================================================

  Widget _buildSecurityHandling() {
    return _sectionCard(
      title: 'Security Handling',
      icon: Icons.security_outlined,
      children: [
        _securityItem(
          icon: Icons.verified_user_outlined,
          title: 'Configuration version control',
          description:
              'All changes are tracked and can be rolled back.',
        ),

        _securityItem(
          icon: Icons.lock_outline,
          title: 'Encryption of sensitive credentials',
          description:
              'API keys and passwords are AES-256 encrypted.',
        ),

        _securityItem(
          icon: Icons.manage_search_outlined,
          title: 'Audit logs',
          description:
              'Comprehensive logging of administrative actions.',
        ),

        const SizedBox(height: 3),

        Container(
          height: 1,
          color: const Color(0xFFE8EDF3),
        ),

        const SizedBox(height: 10),

        Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: const Color(0xFFEAF4FF),
                borderRadius: BorderRadius.circular(7),
              ),
              child: const Icon(
                Icons.health_and_safety_outlined,
                size: 18,
                color: Color(0xFF1268C4),
              ),
            ),

            const SizedBox(width: 9),

            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'System Health',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1E293B),
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Optimal State',
                  style: TextStyle(
                    fontSize: 9.5,
                    color: Color(0xFF00A66A),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _securityItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 17,
            color: const Color(0xFF1268C4),
          ),

          const SizedBox(width: 8),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1E293B),
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 9,
                    height: 1.35,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // COMMUNICATION & INTEGRATION
  // ============================================================

  Future<void> _openConfig(
    Future<Map<String, dynamic>?> dialog,
    String name,
  ) async {
    final values = await dialog;
    if (values == null || !mounted) return;
    // TODO: send `values` to your backend / provider to save it.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$name saved')),
    );
  }

  Widget _buildCommunicationIntegration() {
    return _sectionCard(
      title: 'Communication & Integration',
      icon: Icons.hub_outlined,
      children: [
        _configureRow(
          title: 'SMTP Configuration',
          subtitle: 'Manage email server settings',
          onConfigure: () => _openConfig(
            showSmtpConfigDialog(context),
            'SMTP configuration',
          ),
        ),

        _configureRow(
          title: 'SMS Gateway',
          subtitle: 'Twilio integration settings',
          onConfigure: () => _openConfig(
            showSmsGatewayDialog(context),
            'SMS gateway',
          ),
        ),

        _configureRow(
          title: 'API Gateway',
          subtitle: 'External system access tokens',
          onConfigure: () => _openConfig(
            showApiGatewayDialog(context),
            'API gateway',
          ),
        ),
      ],
    );
  }

  Widget _configureRow({
    required String title,
    required String subtitle,
    required VoidCallback onConfigure,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFE8EDF3),
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E293B),
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 9,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          SizedBox(
            height: 27,
            child: OutlinedButton(
              onPressed: onConfigure,
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF334EEA),
                side: const BorderSide(
                  color: Color(0xFF4C6FFF),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 11,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: const Text(
                'Configure',
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // DEPLOYMENT NOTE
  // ============================================================

  Widget _buildDeploymentNote() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 11,
        vertical: 9,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFE2E6EB),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.info_outline,
            size: 18,
            color: Color(0xFF1268C4),
          ),

          const SizedBox(width: 8),

          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Deployment Note',
                  style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF334155),
                  ),
                ),

                SizedBox(height: 3),

                Text(
                  'Changes to Core Platform configurations may require a service restart for integrated modules to reflect the updates completely.',
                  style: TextStyle(
                    fontSize: 9,
                    height: 1.4,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SECTION CARD
  // ============================================================

  Widget _sectionCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(9),
        border: Border.all(
          color: const Color(0xFFDCE5EF),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 9,
            ),
            decoration: const BoxDecoration(
              color: Color(0xFFF8FAFC),
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFE8EDF3),
                ),
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(9),
                topRight: Radius.circular(9),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 14,
                  color: const Color(0xFF1268C4),
                ),

                const SizedBox(width: 6),

                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1E293B),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(11),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // TEXT FIELD
  // ============================================================

  Widget _inputLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 9,
        fontWeight: FontWeight.w600,
        color: Color(0xFF475569),
      ),
    );
  }

  Widget _textField({
    required TextEditingController controller,
  }) {
    return SizedBox(
      height: 36,
      child: TextField(
        controller: controller,
        style: const TextStyle(
          fontSize: 10.5,
          color: Color(0xFF334155),
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFFF8FAFC),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 8,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: Color(0xFFE1E8F0),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: Color(0xFFE1E8F0),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: Color(0xFF4C6FFF),
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // DROPDOWN
  // ============================================================

  Widget _dropdownField({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _inputLabel(label),

        const SizedBox(height: 5),

        SizedBox(
          height: 36,
          child: DropdownButtonFormField<String>(
            value: value,
            isExpanded: true,
            icon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 16,
              color: Color(0xFF64748B),
            ),
            style: const TextStyle(
              fontSize: 9.5,
              color: Color(0xFF334155),
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFF8FAFC),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 9,
                vertical: 8,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(
                  color: Color(0xFFE1E8F0),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(
                  color: Color(0xFF4C6FFF),
                ),
              ),
            ),
            items: items.map(
              (item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              },
            ).toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // CANCEL / SAVE
  // ============================================================

  Widget _buildCancelButton({
    double height = 30,
  }) {
    return SizedBox(
      height: height,
      child: OutlinedButton(
        onPressed: _goToDashboard,
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF334155),
          side: const BorderSide(
            color: Color(0xFFD4DDE8),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        child: const Text(
          'Cancel',
          style: TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildSaveButton({
    double height = 30,
  }) {
    return SizedBox(
      height: height,
      child: ElevatedButton.icon(
        onPressed: _saveConfiguration,
        icon: const Icon(
          Icons.save_outlined,
          size: 13,
        ),
        label: const Text(
          'Save',
          style: TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF293BE5),
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}