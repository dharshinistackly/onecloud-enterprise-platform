import 'package:flutter/material.dart';

class GlobalSettingsPage extends StatefulWidget {
  const GlobalSettingsPage({super.key});

  @override
  State<GlobalSettingsPage> createState() => _GlobalSettingsPageState();
}

class _GlobalSettingsPageState extends State<GlobalSettingsPage> {
  // ============================================================
  // PLATFORM BEHAVIOR
  // ============================================================

  bool maintenanceMode = false;
  bool forceMfaForAllTenants = true;
  bool allowTenantSelfSignup = false;
  bool enableAiCopilot = true;
  bool dataResidencyLock = true;

  // ============================================================
  // SECURITY
  // ============================================================

  bool multiFactorAuthentication = true;

  // ============================================================
  // NOTIFICATIONS
  // ============================================================

  bool emailNotifications = false;
  bool smsNotifications = false;
  bool pushNotifications = false;

  // ============================================================
  // PLATFORM SETTINGS
  // ============================================================

  bool platformMaintenanceMode = false;

  final TextEditingController defaultLanguageController =
      TextEditingController(text: 'English');

  final TextEditingController timeZoneController =
      TextEditingController(text: 'Asia/Kolkata (UTC +05:30)');

  final TextEditingController dateFormatController =
      TextEditingController(text: 'DD/MM/YYYY');

  final TextEditingController timeFormatController =
      TextEditingController(text: '24 Hours');

  final TextEditingController currencyController =
      TextEditingController(text: 'INR (₹)');

  final TextEditingController passwordExpiryController =
      TextEditingController(text: '90 Days');

  final TextEditingController sessionTimeoutController =
      TextEditingController(text: '30 Minutes');

  final TextEditingController maximumLoginAttemptsController =
      TextEditingController(text: '5');

  final TextEditingController maximumFileUploadController =
      TextEditingController(text: '100');

  final TextEditingController defaultThemeController =
      TextEditingController(text: 'Light');

  @override
  void dispose() {
    defaultLanguageController.dispose();
    timeZoneController.dispose();
    dateFormatController.dispose();
    timeFormatController.dispose();
    currencyController.dispose();
    passwordExpiryController.dispose();
    sessionTimeoutController.dispose();
    maximumLoginAttemptsController.dispose();
    maximumFileUploadController.dispose();
    defaultThemeController.dispose();

    super.dispose();
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
          color: const Color(0xFFF8FAFC),
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              isMobile ? 14 : 16,
              isMobile ? 18 : 14,
              isMobile ? 14 : 16,
              isMobile ? 90 : 24,
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

        const SizedBox(height: 4),

        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Expanded(
              child: Text(
                'Global Settings',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF172033),
                ),
              ),
            ),

            const Text(
              'Refresh',
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w600,
                color: Color(0xFF64748B),
              ),
            ),

            const SizedBox(width: 14),

            _buildResetButton(),

            const SizedBox(width: 7),

            _buildSaveButton(),
          ],
        ),

        const SizedBox(height: 13),

        // --------------------------------------------------------
        // PLATFORM BEHAVIOR
        // --------------------------------------------------------

        _buildPlatformBehavior(),

        const SizedBox(height: 12),

        // --------------------------------------------------------
        // REGIONAL SETTINGS
        // --------------------------------------------------------

        _buildRegionalSettings(),

        const SizedBox(height: 12),

        // --------------------------------------------------------
        // SECURITY SETTINGS
        // --------------------------------------------------------

        _buildSecuritySettings(),

        const SizedBox(height: 12),

        // --------------------------------------------------------
        // NOTIFICATION + CONFIGURATION INFORMATION
        // --------------------------------------------------------

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _buildNotificationSettings(),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: _buildConfigurationInformation(),
            ),
          ],
        ),

        const SizedBox(height: 12),

        // --------------------------------------------------------
        // PLATFORM SETTINGS - FULL WIDTH
        // --------------------------------------------------------

        _buildPlatformSettings(),
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
          'Global Settings',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xFF172033),
          ),
        ),

        const SizedBox(height: 13),

        // Platform behavior
        _buildPlatformBehavior(),

        const SizedBox(height: 9),

        // Regional
        _buildRegionalSettings(),

        const SizedBox(height: 9),

        // Security
        _buildSecuritySettings(),

        const SizedBox(height: 9),

        // Notifications
        _buildNotificationSettings(),

        const SizedBox(height: 9),

        // Configuration information
        _buildConfigurationInformation(),

        const SizedBox(height: 9),

        // Platform settings
        _buildPlatformSettings(),

        const SizedBox(height: 12),

        Row(
          children: [
            Expanded(
              child: _buildResetButton(
                height: 45,
              ),
            ),
            const SizedBox(width: 7),
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
              color: Color(0xFF94A3B8),
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
            text: 'Global Settings',
            style: TextStyle(
              fontSize: 9,
              color: Color(0xFF94A3B8),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // PLATFORM BEHAVIOR
  // ============================================================

  Widget _buildPlatformBehavior() {
    return _sectionCard(
      title: 'Platform behavior',
      children: [
        _buildBehaviorRow(
          title: 'Maintenance mode',
          description:
              'Blocks tenant access platform-wide during scheduled updates.',
          value: maintenanceMode,
          onChanged: (value) {
            setState(() {
              maintenanceMode = value;
            });
          },
        ),

        _buildBehaviorRow(
          title: 'Force MFA for all tenants',
          description:
              'Overrides tenant-level MFA settings and requires it globally.',
          value: forceMfaForAllTenants,
          onChanged: (value) {
            setState(() {
              forceMfaForAllTenants = value;
            });
          },
        ),

        _buildBehaviorRow(
          title: 'Allow tenant self-signup',
          description:
              'New organizations can create a workspace without Super Admin approval.',
          value: allowTenantSelfSignup,
          onChanged: (value) {
            setState(() {
              allowTenantSelfSignup = value;
            });
          },
        ),

        _buildBehaviorRow(
          title: 'Enable AI Copilot platform-wide',
          description:
              'Makes the AI Copilot available to all tenants regardless of plan.',
          value: enableAiCopilot,
          onChanged: (value) {
            setState(() {
              enableAiCopilot = value;
            });
          },
        ),

        _buildBehaviorRow(
          title: 'Data residency lock',
          description:
              'Prevents tenant data from being stored outside its assigned region.',
          value: dataResidencyLock,
          onChanged: (value) {
            setState(() {
              dataResidencyLock = value;
            });
          },
          showBottomBorder: false,
        ),
      ],
    );
  }

  Widget _buildBehaviorRow({
    required String title,
    required String description,
    required bool value,
    required ValueChanged<bool> onChanged,
    bool showBottomBorder = true,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        border: showBottomBorder
            ? const Border(
                bottom: BorderSide(
                  color: Color(0xFFE5EAF0),
                ),
              )
            : null,
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
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1E293B),
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 9.5,
                    height: 1.35,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 15),

          _buildToggle(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  // ============================================================
  // REGIONAL SETTINGS
  // ============================================================

  Widget _buildRegionalSettings() {
    return _sectionCard(
      title: 'Regional settings',
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final bool mobileInsideCard = constraints.maxWidth < 550;

            if (mobileInsideCard) {
              return Column(
                children: [
                  _buildInputField(
                    label: 'Default language',
                    controller: defaultLanguageController,
                    requiredField: true,
                    helperText: 'Required',
                  ),

                  const SizedBox(height: 10),

                  _buildInputField(
                    label: 'Time zone',
                    controller: timeZoneController,
                    requiredField: true,
                    helperText: 'Required',
                  ),

                  const SizedBox(height: 10),

                  _buildInputField(
                    label: 'Date format',
                    controller: dateFormatController,
                  ),

                  const SizedBox(height: 10),

                  _buildInputField(
                    label: 'Time format',
                    controller: timeFormatController,
                  ),

                  const SizedBox(height: 10),

                  _buildInputField(
                    label: 'Default currency',
                    controller: currencyController,
                    requiredField: true,
                    helperText: 'Required',
                  ),
                ],
              );
            }

            return Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildInputField(
                        label: 'Default language',
                        controller: defaultLanguageController,
                        requiredField: true,
                        helperText: 'Required',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildInputField(
                        label: 'Time zone',
                        controller: timeZoneController,
                        requiredField: true,
                        helperText: 'Required',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildInputField(
                        label: 'Date format',
                        controller: dateFormatController,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 13),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildInputField(
                        label: 'Time format',
                        controller: timeFormatController,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildInputField(
                        label: 'Default currency',
                        controller: currencyController,
                        requiredField: true,
                        helperText: 'Required',
                      ),
                    ),
                    const Expanded(
                      child: SizedBox(),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  // ============================================================
  // SECURITY SETTINGS
  // ============================================================

  Widget _buildSecuritySettings() {
    return _sectionCard(
      title: 'Security settings',
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final bool mobileInsideCard = constraints.maxWidth < 550;

            if (mobileInsideCard) {
              return Column(
                children: [
                  _buildInputField(
                    label: 'Password expiry',
                    controller: passwordExpiryController,
                    helperText: 'Must be between 30 and 365 days',
                  ),

                  const SizedBox(height: 10),

                  _buildInputField(
                    label: 'Session timeout',
                    controller: sessionTimeoutController,
                    helperText: 'Must be between 5 and 240 minutes',
                  ),

                  const SizedBox(height: 10),

                  _buildInputField(
                    label: 'Maximum login attempts',
                    controller: maximumLoginAttemptsController,
                    helperText: 'Must be between 3 and 10',
                  ),
                ],
              );
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _buildInputField(
                    label: 'Password expiry',
                    controller: passwordExpiryController,
                    helperText: 'Must be between 30 and 365 days',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildInputField(
                    label: 'Session timeout',
                    controller: sessionTimeoutController,
                    helperText: 'Must be between 5 and 240 minutes',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildInputField(
                    label: 'Maximum login attempts',
                    controller: maximumLoginAttemptsController,
                    helperText: 'Must be between 3 and 10',
                  ),
                ),
              ],
            );
          },
        ),

        const SizedBox(height: 13),

        Container(
          padding: const EdgeInsets.only(
            top: 13,
          ),
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Color(0xFFE5EAF0),
              ),
            ),
          ),
          child: Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Multi-Factor Authentication',
                      style: TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Requires a second verification step at sign-in, platform-wide.',
                      style: TextStyle(
                        fontSize: 9,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              _buildToggle(
                value: multiFactorAuthentication,
                onChanged: (value) {
                  setState(() {
                    multiFactorAuthentication = value;
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================
  // NOTIFICATION SETTINGS
  // ============================================================

  Widget _buildNotificationSettings() {
    return _sectionCard(
      title: 'Notification settings',
      children: [
        _buildCheckboxRow(
          title: 'Email notifications',
          value: emailNotifications,
          onChanged: (value) {
            setState(() {
              emailNotifications = value ?? false;
            });
          },
        ),

        _buildCheckboxRow(
          title: 'SMS notifications',
          value: smsNotifications,
          onChanged: (value) {
            setState(() {
              smsNotifications = value ?? false;
            });
          },
        ),

        _buildCheckboxRow(
          title: 'Push notifications',
          value: pushNotifications,
          onChanged: (value) {
            setState(() {
              pushNotifications = value ?? false;
            });
          },
        ),
      ],
    );
  }

  Widget _buildCheckboxRow({
    required String title,
    required bool value,
    required ValueChanged<bool?> onChanged,
  }) {
    return SizedBox(
      height: 29,
      child: Row(
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: Checkbox(
              value: value,
              onChanged: onChanged,
              side: const BorderSide(
                color: Color(0xFF94A3B8),
                width: 1.2,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2),
              ),
              activeColor: const Color(0xFF4F46E5),
            ),
          ),

          const SizedBox(width: 7),

          Text(
            title,
            style: const TextStyle(
              fontSize: 9.5,
              color: Color(0xFF334155),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // CONFIGURATION INFORMATION
  // ============================================================

  Widget _buildConfigurationInformation() {
    return _sectionCard(
      title: 'Configuration information',
      children: [
        _informationRow(
          label: 'Last updated by',
          value: 'Super Administrator',
        ),

        const SizedBox(height: 12),

        _informationRow(
          label: 'Last updated on',
          value: '31-Jul-2026 09:30 AM',
        ),
      ],
    );
  }

  Widget _informationRow({
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 9.5,
              color: Color(0xFF64748B),
            ),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 9.5,
            fontWeight: FontWeight.w700,
            color: Color(0xFF334155),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // PLATFORM SETTINGS
  // ============================================================

  Widget _buildPlatformSettings() {
    return _sectionCard(
      title: 'Platform settings',
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final bool mobileInsideCard = constraints.maxWidth < 550;

            if (mobileInsideCard) {
              return Column(
                children: [
                  _buildUploadSizeField(),

                  const SizedBox(height: 12),

                  _buildInputField(
                    label: 'Default theme',
                    controller: defaultThemeController,
                  ),
                ],
              );
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _buildUploadSizeField(),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildInputField(
                    label: 'Default theme',
                    controller: defaultThemeController,
                  ),
                ),
                const Expanded(
                  child: SizedBox(),
                ),
              ],
            );
          },
        ),

        const SizedBox(height: 14),

        Container(
          padding: const EdgeInsets.only(
            top: 13,
          ),
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Color(0xFFE5EAF0),
              ),
            ),
          ),
          child: Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Maintenance mode',
                      style: TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Blocks tenant access platform-wide during scheduled updates.',
                      style: TextStyle(
                        fontSize: 9,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              _buildToggle(
                value: platformMaintenanceMode,
                onChanged: (value) {
                  setState(() {
                    platformMaintenanceMode = value;
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUploadSizeField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Maximum file upload size',
          style: TextStyle(
            fontSize: 9.5,
            fontWeight: FontWeight.w600,
            color: Color(0xFF334155),
          ),
        ),

        const SizedBox(height: 5),

        SizedBox(
          height: 37,
          child: TextField(
            controller: maximumFileUploadController,
            keyboardType: TextInputType.number,
            style: const TextStyle(
              fontSize: 10,
              color: Color(0xFF334155),
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              suffixText: 'MB',
              suffixStyle: const TextStyle(
                fontSize: 9,
                color: Color(0xFF94A3B8),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(
                  color: Color(0xFFDCE4ED),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(
                  color: Color(0xFF4F46E5),
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 4),

        const Text(
          'Must be a positive value within the allowed platform limit',
          style: TextStyle(
            fontSize: 8,
            color: Color(0xFF94A3B8),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // COMMON SECTION CARD
  // ============================================================

  Widget _sectionCard({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
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
              horizontal: 14,
              vertical: 10,
            ),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFE5EAF0),
                ),
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1E293B),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(13),
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
  // INPUT FIELD
  // ============================================================

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    bool requiredField = false,
    String? helperText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: label,
                style: const TextStyle(
                  fontSize: 9.5,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF475569),
                ),
              ),
              if (requiredField)
                const TextSpan(
                  text: ' *',
                  style: TextStyle(
                    fontSize: 9.5,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFEF4444),
                  ),
                ),
            ],
          ),
        ),

        const SizedBox(height: 5),

        SizedBox(
          height: 37,
          child: TextField(
            controller: controller,
            style: const TextStyle(
              fontSize: 10,
              color: Color(0xFF334155),
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 8,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(
                  color: Color(0xFFDCE4ED),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(
                  color: Color(0xFF4F46E5),
                ),
              ),
            ),
          ),
        ),

        if (helperText != null) ...[
          const SizedBox(height: 3),
          Text(
            helperText,
            style: const TextStyle(
              fontSize: 8,
              color: Color(0xFF94A3B8),
            ),
          ),
        ],
      ],
    );
  }

  // ============================================================
  // TOGGLE
  // ============================================================

  Widget _buildToggle({
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        width: 34,
        height: 21,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: value
              ? const Color(0xFF4F46E5)
              : const Color(0xFFE2E8F0),
          borderRadius: BorderRadius.circular(20),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 160),
          alignment:
              value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 17,
            height: 17,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // RESET BUTTON
  // ============================================================

  Widget _buildResetButton({
    double height = 30,
  }) {
    return SizedBox(
      height: height,
      child: OutlinedButton(
        onPressed: _resetSettings,
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF334155),
          side: const BorderSide(
            color: Color(0xFFD7DEE7),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 13,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: const Text(
          'Reset',
          style: TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SAVE BUTTON
  // ============================================================

  Widget _buildSaveButton({
    double height = 30,
  }) {
    return SizedBox(
      height: height,
      child: ElevatedButton.icon(
        onPressed: _saveSettings,
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
          backgroundColor: const Color(0xFF2639E6),
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: 13,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // ACTIONS
  // ============================================================

  void _resetSettings() {
    setState(() {
      maintenanceMode = false;
      forceMfaForAllTenants = true;
      allowTenantSelfSignup = false;
      enableAiCopilot = true;
      dataResidencyLock = true;

      multiFactorAuthentication = true;

      emailNotifications = false;
      smsNotifications = false;
      pushNotifications = false;

      platformMaintenanceMode = false;

      defaultLanguageController.text = 'English';
      timeZoneController.text = 'Asia/Kolkata (UTC +05:30)';
      dateFormatController.text = 'DD/MM/YYYY';
      timeFormatController.text = '24 Hours';
      currencyController.text = 'INR (₹)';

      passwordExpiryController.text = '90 Days';
      sessionTimeoutController.text = '30 Minutes';
      maximumLoginAttemptsController.text = '5';

      maximumFileUploadController.text = '100';
      defaultThemeController.text = 'Light';
    });
  }

  void _saveSettings() {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text(
            'Global settings saved successfully.',
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }
}