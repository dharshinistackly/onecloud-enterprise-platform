import 'package:flutter/material.dart';

import '../widgets/auth_brand_panel.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  int _step = 1;

  final TextEditingController _organizationNameController =
      TextEditingController();

  final TextEditingController _organizationCodeController =
      TextEditingController(text: 'ABC-TECH');

  final TextEditingController _cityController =
      TextEditingController(text: 'Hyderabad');

  final TextEditingController _firstNameController =
      TextEditingController();

  final TextEditingController _lastNameController =
      TextEditingController();

  final TextEditingController _emailController =
      TextEditingController();

  final TextEditingController _mobileController =
      TextEditingController();

  final TextEditingController _usernameController =
      TextEditingController();

  final TextEditingController _passwordController =
      TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String _organizationType = 'Enterprise';
  String _industry = 'Information Technology';
  String _companySize = '501-1000';
  String _country = 'India';
  String _state = 'Telangana';
  String _timeZone = 'Asia/Kolkata (UTC +05:30)';

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  static const Color navy = Color(0xFF10133A);
  static const Color textDark = Color(0xFF111827);
  static const Color textMedium = Color(0xFF667085);
  static const Color textLight = Color(0xFF98A2B3);
  static const Color border = Color(0xFFD9DEE8);
  static const Color background = Color(0xFFF6F7F9);
  static const Color blue = Color(0xFF2F6BFF);

  static const TextStyle bodyStyle = TextStyle(
    fontFamily: 'Onest',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.0,
    letterSpacing: 0,
    color: textDark,
  );

  static const TextStyle labelStyle = TextStyle(
    fontFamily: 'Onest',
    fontSize: 13,
    fontWeight: FontWeight.w600,
    height: 1.0,
    letterSpacing: 0,
    color: textDark,
  );

  static const TextStyle headingStyle = TextStyle(
    fontFamily: 'Onest',
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 1.0,
    letterSpacing: -0.3,
    color: textDark,
  );

  @override
  void dispose() {
    _organizationNameController.dispose();
    _organizationCodeController.dispose();
    _cityController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth >= 900) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Expanded(
                    flex: 51,
                    child: AuthBrandPanel(
                      isMobile: false,
                    ),
                  ),
                  Expanded(
                    flex: 49,
                    child: _buildFormPanel(
                      isMobile: false,
                    ),
                  ),
                ],
              );
            }

            return SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const AuthBrandPanel(
                    isMobile: true,
                    showGraphic: false,
                    compactMobile: true,
                  ),
                  _buildFormPanel(
                    isMobile: true,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFormPanel({
    required bool isMobile,
  }) {
    final form = ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 650,
      ),
      child: _step == 1
          ? _buildOrganizationStep(isMobile)
          : _buildAdminStep(isMobile),
    );

    if (isMobile) {
      return Container(
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(
          22,
          24,
          22,
          32,
        ),
        child: form,
      );
    }

    return Container(
      color: Colors.white,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 44,
                  vertical: 34,
                ),
                child: Center(
                  child: form,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildOrganizationStep(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStepProgress(1),
        const SizedBox(height: 18),
        Text(
          'Tell us about your\norganization',
          style: headingStyle.copyWith(
            fontSize: isMobile ? 21 : 24,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          "This creates your organization's workspace on One Enterprise.",
          style: TextStyle(
            fontFamily: 'Onest',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            height: 1.35,
            letterSpacing: 0,
            color: textMedium,
          ),
        ),
        const SizedBox(height: 22),
        _buildLabel(
          'Organization Name',
          required: true,
        ),
        const SizedBox(height: 7),
        _buildTextField(
          controller: _organizationNameController,
          hint: 'ABC Technologies Pvt Ltd',
        ),
        const SizedBox(height: 15),
        _buildLabel(
          'Organization Code',
          required: true,
        ),
        const SizedBox(height: 7),
        _buildTextField(
          controller: _organizationCodeController,
          hint: 'ABC-TECH',
        ),
        const SizedBox(height: 5),
        const Text(
          'A unique identifier for your organization — will appear in your workspace URL.',
          style: TextStyle(
            fontFamily: 'Onest',
            fontSize: 10,
            fontWeight: FontWeight.w400,
            height: 1.3,
            color: textLight,
          ),
        ),
        const SizedBox(height: 15),
        _buildLabel(
          'Organization Type',
          required: true,
        ),
        const SizedBox(height: 7),
        _buildDropdown(
          value: _organizationType,
          items: const [
            'Enterprise',
            'Business',
            'Startup',
            'Government',
          ],
          onChanged: (value) {
            setState(() {
              _organizationType = value;
            });
          },
        ),
        const SizedBox(height: 15),
        _buildLabel(
          'Industry',
          required: true,
        ),
        const SizedBox(height: 7),
        _buildDropdown(
          value: _industry,
          items: const [
            'Information Technology',
            'Finance',
            'Healthcare',
            'Education',
            'Manufacturing',
            'Retail',
          ],
          onChanged: (value) {
            setState(() {
              _industry = value;
            });
          },
        ),
        const SizedBox(height: 15),
        _buildLabel(
          'Company Size',
          required: true,
        ),
        const SizedBox(height: 7),
        _buildDropdown(
          value: _companySize,
          items: const [
            '1-50',
            '51-200',
            '201-500',
            '501-1000',
            '1001-5000',
            '5000+',
          ],
          onChanged: (value) {
            setState(() {
              _companySize = value;
            });
          },
        ),
        const SizedBox(height: 15),
        if (isMobile)
          _buildMobileLocationFields()
        else
          _buildDesktopLocationFields(),
        const SizedBox(height: 15),
        _buildLabel(
          'Time Zone',
          required: true,
        ),
        const SizedBox(height: 7),
        _buildDropdown(
          value: _timeZone,
          items: const [
            'Asia/Kolkata (UTC +05:30)',
            'Asia/Dubai (UTC +04:00)',
            'Europe/London (UTC +00:00)',
            'America/New_York (UTC -05:00)',
          ],
          onChanged: (value) {
            setState(() {
              _timeZone = value;
            });
          },
        ),
        const SizedBox(height: 15),
        _buildLabel(
          'Organization Logo',
          required: false,
        ),
        const SizedBox(height: 7),
        _buildUploadBox(),
        const SizedBox(height: 20),
        _buildPrimaryButton(
          text: 'Continue',
          onPressed: _continueToAdmin,
        ),
        const SizedBox(height: 14),
        _buildBottomSignIn(),
      ],
    );
  }

  Widget _buildAdminStep(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBackButton(),
        const SizedBox(height: 15),
        _buildStepProgress(2),
        const SizedBox(height: 18),
        Text(
          'Create your admin account',
          style: headingStyle.copyWith(
            fontSize: isMobile ? 21 : 24,
          ),
        ),
        const SizedBox(height: 10),
        Text.rich(
          TextSpan(
            style: const TextStyle(
              fontFamily: 'Onest',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 1.35,
              letterSpacing: 0,
              color: textMedium,
            ),
            children: [
              const TextSpan(
                text: "You'll use this account to manage ",
              ),
              TextSpan(
                text: _orgDisplayName(
                  fallback: 'your organization',
                ),
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: textMedium,
                ),
              ),
              const TextSpan(
                text: '.',
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        _buildInfoBox(),
        const SizedBox(height: 18),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel(
                    'First Name',
                    required: true,
                  ),
                  const SizedBox(height: 7),
                  _buildTextField(
                    controller: _firstNameController,
                    hint: 'Ananya',
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel(
                    'Last Name',
                    required: true,
                  ),
                  const SizedBox(height: 7),
                  _buildTextField(
                    controller: _lastNameController,
                    hint: 'Rao',
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        _buildLabel(
          'Official Email',
          required: true,
        ),
        const SizedBox(height: 7),
        _buildTextField(
          controller: _emailController,
          hint: 'ananya.rao@abctech.com',
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 15),
        _buildLabel(
          'Mobile Number',
          required: true,
        ),
        const SizedBox(height: 7),
        _buildTextField(
          controller: _mobileController,
          hint: '+91 98765 43210',
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 15),
        _buildLabel(
          'Username',
          required: true,
        ),
        const SizedBox(height: 7),
        _buildTextField(
          controller: _usernameController,
          hint: 'ananya.rao',
        ),
        const SizedBox(height: 15),
        if (isMobile)
          Column(
            children: [
              _buildPasswordField(
                label: 'Password',
                controller: _passwordController,
                obscure: _obscurePassword,
                onToggle: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
              const SizedBox(height: 15),
              _buildPasswordField(
                label: 'Confirm Password',
                controller: _confirmPasswordController,
                obscure: _obscureConfirmPassword,
                onToggle: () {
                  setState(() {
                    _obscureConfirmPassword =
                        !_obscureConfirmPassword;
                  });
                },
              ),
            ],
          )
        else
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildPasswordField(
                  label: 'Password',
                  controller: _passwordController,
                  obscure: _obscurePassword,
                  onToggle: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _buildPasswordField(
                  label: 'Confirm Password',
                  controller: _confirmPasswordController,
                  obscure: _obscureConfirmPassword,
                  onToggle: () {
                    setState(() {
                      _obscureConfirmPassword =
                          !_obscureConfirmPassword;
                    });
                  },
                ),
              ),
            ],
          ),
        const SizedBox(height: 6),
        const Text(
          'Minimum 8 characters, with a number and symbol.',
          style: TextStyle(
            fontFamily: 'Onest',
            fontSize: 10,
            fontWeight: FontWeight.w400,
            color: textLight,
          ),
        ),
        const SizedBox(height: 20),
        _buildPrimaryButton(
          text: 'Continue',
          onPressed: _finishSignup,
        ),
        const SizedBox(height: 14),
        _buildBottomSignIn(),
      ],
    );
  }

  Widget _buildStepProgress(int step) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                height: 3,
                decoration: BoxDecoration(
                  color: blue,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Container(
                height: 3,
                decoration: BoxDecoration(
                  color: step >= 2
                      ? blue
                      : const Color(0xFFE4E7EC),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Container(
                height: 3,
                decoration: BoxDecoration(
                  color: const Color(0xFFE4E7EC),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 9),
        Text(
          'STEP $step OF 3  ·  ${step == 1 ? 'ORGANIZATION DETAILS' : 'SETUP ADMIN ACCOUNT'}',
          style: const TextStyle(
            fontFamily: 'Onest',
            color: textLight,
            fontSize: 9,
            fontWeight: FontWeight.w400,
            letterSpacing: 1.1,
          ),
        ),
      ],
    );
  }

  Widget _buildBackButton() {
    return InkWell(
      onTap: () {
        setState(() {
          _step = 1;
        });
      },
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.chevron_left,
            color: textLight,
            size: 18,
          ),
          Text(
            'Back',
            style: TextStyle(
              fontFamily: 'Onest',
              color: textLight,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(
    String text, {
    required bool required,
  }) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: text,
            style: labelStyle,
          ),
          if (required)
            const TextSpan(
              text: ' *',
              style: TextStyle(
                fontFamily: 'Onest',
                fontSize: 13,
                fontWeight: FontWeight.w600,
                height: 1.0,
                letterSpacing: 0,
                color: Color(0xFF667085),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: bodyStyle,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          fontFamily: 'Onest',
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 1.0,
          letterSpacing: 0,
          color: textLight,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(
            color: border,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(
            color: border,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(
            color: blue,
            width: 1.2,
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required String label,
    required TextEditingController controller,
    required bool obscure,
    required VoidCallback onToggle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(
          label,
          required: true,
        ),
        const SizedBox(height: 7),
        TextField(
          controller: controller,
          obscureText: obscure,
          style: bodyStyle,
          decoration: InputDecoration(
            hintText: 'Create a password',
            hintStyle: const TextStyle(
              fontFamily: 'Onest',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 1.0,
              color: textLight,
            ),
            suffixIcon: IconButton(
              onPressed: onToggle,
              icon: Icon(
                obscure
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: textLight,
                size: 17,
              ),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            isDense: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(
                color: border,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(
                color: border,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(
                color: blue,
                width: 1.2,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      onChanged: (value) {
        if (value != null) {
          onChanged(value);
        }
      },
      isExpanded: true,
      icon: const Icon(
        Icons.keyboard_arrow_down_rounded,
        color: textLight,
        size: 17,
      ),
      style: bodyStyle,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 9,
        ),
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(
            color: border,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(
            color: border,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(
            color: blue,
            width: 1.2,
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
    );
  }

  Widget _buildDesktopLocationFields() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel(
                    'Country',
                    required: true,
                  ),
                  const SizedBox(height: 7),
                  _buildDropdown(
                    value: _country,
                    items: const [
                      'India',
                      'United States',
                      'United Kingdom',
                      'United Arab Emirates',
                    ],
                    onChanged: (value) {
                      setState(() {
                        _country = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel(
                    'State / Province',
                    required: true,
                  ),
                  const SizedBox(height: 7),
                  _buildDropdown(
                    value: _state,
                    items: const [
                      'Telangana',
                      'Tamil Nadu',
                      'Karnataka',
                      'Maharashtra',
                    ],
                    onChanged: (value) {
                      setState(() {
                        _state = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            width: 230,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLabel(
                  'City',
                  required: true,
                ),
                const SizedBox(height: 7),
                _buildTextField(
                  controller: _cityController,
                  hint: 'Hyderabad',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLocationFields() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel(
                    'Country',
                    required: true,
                  ),
                  const SizedBox(height: 7),
                  _buildDropdown(
                    value: _country,
                    items: const [
                      'India',
                      'United States',
                      'United Kingdom',
                      'United Arab Emirates',
                    ],
                    onChanged: (value) {
                      setState(() {
                        _country = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel(
                    'State / Province',
                    required: true,
                  ),
                  const SizedBox(height: 7),
                  _buildDropdown(
                    value: _state,
                    items: const [
                      'Telangana',
                      'Tamil Nadu',
                      'Karnataka',
                      'Maharashtra',
                    ],
                    onChanged: (value) {
                      setState(() {
                        _state = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Align(
          alignment: Alignment.centerLeft,
          child: _buildLabel(
            'City',
            required: true,
          ),
        ),
        const SizedBox(height: 7),
        _buildTextField(
          controller: _cityController,
          hint: 'Hyderabad',
        ),
      ],
    );
  }

  Widget _buildUploadBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 13,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFBFC),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: border,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: const Color(0xFFEAF2FF),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Icon(
              Icons.cloud_upload_outlined,
              color: blue,
              size: 16,
            ),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Text(
              'Upload logo  PNG, JPG up to 5MB',
              style: TextStyle(
                fontFamily: 'Onest',
                color: blue,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 11,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F6FF),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: const Color(0xFFD8E4FF),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 20,
            height: 20,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: const Icon(
              Icons.info_outline,
              color: blue,
              size: 13,
            ),
          ),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              'This account is automatically assigned the SUPER_ADMIN role with full access to your organization.',
              style: TextStyle(
                fontFamily: 'Onest',
                color: textMedium,
                fontSize: 10,
                fontWeight: FontWeight.w400,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrimaryButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 42,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: navy,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontFamily: 'Onest',
            fontSize: 13,
            fontWeight: FontWeight.w600,
            height: 1.0,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomSignIn() {
    return Center(
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          const Text(
            'Already have an organization? ',
            style: TextStyle(
              fontFamily: 'Onest',
              color: textLight,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Sign in',
              style: TextStyle(
                fontFamily: 'Onest',
                color: blue,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _continueToAdmin() {
    final organizationName =
        _organizationNameController.text.trim();
    final organizationCode =
        _organizationCodeController.text.trim();
    final city =
        _cityController.text.trim();

    if (organizationName.isEmpty) {
      _showMessage(
        'Please enter your organization name.',
      );
      return;
    }

    if (organizationCode.isEmpty) {
      _showMessage(
        'Please enter your organization code.',
      );
      return;
    }

    if (organizationCode.length < 3) {
      _showMessage(
        'Please enter a valid organization code.',
      );
      return;
    }

    if (city.isEmpty) {
      _showMessage(
        'Please enter your city.',
      );
      return;
    }

    setState(() {
      _step = 2;
    });
  }

  void _finishSignup() {
    final firstName =
        _firstNameController.text.trim();
    final lastName =
        _lastNameController.text.trim();
    final email =
        _emailController.text.trim();
    final mobile =
        _mobileController.text.trim();
    final username =
        _usernameController.text.trim();
    final password =
        _passwordController.text;
    final confirmPassword =
        _confirmPasswordController.text;

    if (firstName.isEmpty) {
      _showMessage(
        'Please enter your first name.',
      );
      return;
    }

    if (lastName.isEmpty) {
      _showMessage(
        'Please enter your last name.',
      );
      return;
    }

    if (email.isEmpty) {
      _showMessage(
        'Please enter your official email.',
      );
      return;
    }

    if (!RegExp(
      r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
    ).hasMatch(email)) {
      _showMessage(
        'Please enter a valid email address.',
      );
      return;
    }

    if (mobile.isEmpty) {
      _showMessage(
        'Please enter your mobile number.',
      );
      return;
    }

    if (!RegExp(r'^\+?[0-9\s-]{10,15}$')
        .hasMatch(mobile)) {
      _showMessage(
        'Please enter a valid mobile number.',
      );
      return;
    }

    if (username.isEmpty) {
      _showMessage(
        'Please enter a username.',
      );
      return;
    }

    if (!RegExp(
      r'^[a-zA-Z0-9._-]{3,30}$',
    ).hasMatch(username)) {
      _showMessage(
        'Please enter a valid username.',
      );
      return;
    }

    if (password.isEmpty) {
      _showMessage(
        'Please enter your password.',
      );
      return;
    }

    if (password.length < 8) {
      _showMessage(
        'Please enter a valid password with at least 8 characters.',
      );
      return;
    }

    if (!RegExp(r'[0-9]').hasMatch(password)) {
      _showMessage(
        'Password must contain at least one number.',
      );
      return;
    }

    if (!RegExp(
      r'[!@#$%^&*(),.?":{}|<>_\-]',
    ).hasMatch(password)) {
      _showMessage(
        'Password must contain at least one symbol.',
      );
      return;
    }

    if (confirmPassword.isEmpty) {
      _showMessage(
        'Please confirm your password.',
      );
      return;
    }

    if (password != confirmPassword) {
      _showMessage(
        'Passwords do not match.',
      );
      return;
    }

    _showTermsAuthorizationDialog();
  }

  void _showTermsAuthorizationDialog() {
    bool termsAccepted = false;
    bool authorizationAccepted = false;
    bool dataProcessingAccepted = false;
    bool productUpdatesAccepted = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            final double screenWidth =
                MediaQuery.of(context).size.width;

            final double horizontalPadding =
                screenWidth < 500 ? 16 : 24;

            return Dialog(
              backgroundColor: Colors.white,
              insetPadding: EdgeInsets.symmetric(
                horizontal:
                    screenWidth < 500 ? 12 : 28,
                vertical: 20,
              ),
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(8),
              ),
              child: ConstrainedBox(
                constraints:
                    const BoxConstraints(
                  maxWidth: 620,
                  maxHeight: 700,
                ),
                child: SingleChildScrollView(
                  physics:
                      const ClampingScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(
                    horizontalPadding,
                    20,
                    horizontalPadding,
                    18,
                  ),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      _buildDialogBackButton(
                        dialogContext,
                      ),
                      const SizedBox(height: 15),
                      _buildDialogProgress(),
                      const SizedBox(height: 18),
                      const Text(
                        'STEP 3 OF 3  ·  TERMS & AUTHORIZATION',
                        style: TextStyle(
                          fontFamily: 'Onest',
                          color: textLight,
                          fontSize: 9,
                          fontWeight:
                              FontWeight.w400,
                          letterSpacing: 1.1,
                        ),
                      ),
                      const SizedBox(height: 14),
                      const Text(
                        'Review and confirm',
                        style: headingStyle,
                      ),
                      const SizedBox(height: 9),
                      Text(
                        'One last step before we create '
                        '${_organizationNameController.text.trim().isEmpty ? 'your organization' : _organizationNameController.text.trim()}\'s workspace.',
                        style: const TextStyle(
                          fontFamily: 'Onest',
                          fontSize: 14,
                          fontWeight:
                              FontWeight.w400,
                          height: 1.35,
                          color: textMedium,
                        ),
                      ),
                      const SizedBox(height: 18),
                      Container(
                        width: double.infinity,
                        padding:
                            const EdgeInsets.fromLTRB(
                          12,
                          13,
                          12,
                          11,
                        ),
                        decoration: BoxDecoration(
                          color:
                              const Color(0xFFFAFBFC),
                          border: Border.all(
                            color:
                                const Color(0xFFE4E7EC),
                          ),
                          borderRadius:
                              BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            _buildConsentRow(
                              value: termsAccepted,
                              onChanged: (value) {
                                setDialogState(() {
                                  termsAccepted =
                                      value;
                                });
                              },
                              text:
                                  'I have read and agree to the ',
                              links: const [
                                'Terms of Service',
                                ' and ',
                                'Privacy Policy',
                                '.',
                              ],
                            ),
                            const SizedBox(height: 15),
                            _buildConsentRow(
                              value:
                                  authorizationAccepted,
                              onChanged: (value) {
                                setDialogState(() {
                                  authorizationAccepted =
                                      value;
                                });
                              },
                              text:
                                  'I confirm I am authorized to register ',
                              links: const [],
                              extraText:
                                  '${_organizationNameController.text.trim().isEmpty ? 'this organization' : _organizationNameController.text.trim()} and accept responsibility as its Super Administrator.',
                            ),
                            const SizedBox(height: 15),
                            _buildConsentRow(
                              value:
                                  dataProcessingAccepted,
                              onChanged: (value) {
                                setDialogState(() {
                                  dataProcessingAccepted =
                                      value;
                                });
                              },
                              text:
                                  'I agree to the ',
                              links: const [
                                'Data Processing Agreement',
                              ],
                              extraText:
                                  ' governing how organization data is stored and processed.',
                            ),
                            const SizedBox(height: 15),
                            _buildConsentRow(
                              value:
                                  productUpdatesAccepted,
                              onChanged: (value) {
                                setDialogState(() {
                                  productUpdatesAccepted =
                                      value;
                                });
                              },
                              text:
                                  'Send me product updates and security notices',
                              links: const [],
                              optional: true,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: 42,
                        child: ElevatedButton(
                          onPressed: termsAccepted &&
                                  authorizationAccepted &&
                                  dataProcessingAccepted
                              ? () {
                                  Navigator.of(
                                    dialogContext,
                                  ).pop();
                                 _createAccount();
                                }
                              : null,
                          style:
                              ElevatedButton.styleFrom(
                            backgroundColor: navy,
                            disabledBackgroundColor:
                                const Color(0xFFE4E7EC),
                            foregroundColor:
                                Colors.white,
                            elevation: 0,
                            shape:
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(
                                7,
                              ),
                            ),
                          ),
                          child: const Text(
                            'Create account',
                            style: TextStyle(
                              fontFamily: 'Onest',
                              fontSize: 13,
                              fontWeight:
                                  FontWeight.w600,
                              height: 1.0,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: Wrap(
                          alignment:
                              WrapAlignment.center,
                          children: [
                            const Text(
                              'Already have an organization? ',
                              style: TextStyle(
                                fontFamily: 'Onest',
                                fontSize: 12,
                                fontWeight:
                                    FontWeight.w400,
                                color: textLight,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(
                                  dialogContext,
                                ).pop();
                                Navigator.pop(
                                  context,
                                );
                              },
                              child: const Text(
                                'Sign in',
                                style: TextStyle(
                                  fontFamily: 'Onest',
                                  fontSize: 12,
                                  fontWeight:
                                      FontWeight.w600,
                                  color: blue,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  String _orgDisplayName({
    required String fallback,
  }) {
    final String name =
        _organizationNameController.text.trim();

    return name.isEmpty ? fallback : name;
  }

  void _createAccount() {
  final organizationName =
      _organizationNameController.text.trim();

  final organizationCode =
      _organizationCodeController.text.trim();

  final email =
      _emailController.text.trim();

  final username =
      _usernameController.text.trim();

  final password =
      _passwordController.text;

  context.read<AuthProvider>().registerAccount(
    organizationName: organizationName,
    organizationCode: organizationCode,
    email: email,
    username: username,
    password: password,
  );

  _showWelcomeDialog();
}

  void _showWelcomeDialog() {
    if (!mounted) return;

    final String orgName =
        _orgDisplayName(
      fallback: 'Your organization',
    );

    final String code =
        _organizationCodeController.text
            .trim()
            .toLowerCase();

    final String workspace =
        '${code.isEmpty ? 'your-org' : code}.oneenterprise.io';

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: Colors.white,
          clipBehavior: Clip.antiAlias,
          insetPadding:
              const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 20,
          ),
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(8),
          ),
          child: ConstrainedBox(
            constraints:
                BoxConstraints(
              maxWidth: 420,
             maxHeight: MediaQuery.sizeOf(context).height * 0.9,
            ),
            child: SingleChildScrollView(
              physics:
                  const ClampingScrollPhysics(),
              child: Column(
                mainAxisSize:
                    MainAxisSize.min,
                crossAxisAlignment:
                    CrossAxisAlignment.stretch,
                children: [
                  const AuthBrandPanel(
                    isMobile: true,
                    showGraphic: false,
                    compactMobile: true,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.fromLTRB(
                      22,
                      26,
                      22,
                      22,
                    ),
                    child: Column(
                      mainAxisSize:
                          MainAxisSize.min,
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          decoration:
                              const BoxDecoration(
                            color:
                                Color(0xFFE8F6EE),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.check_rounded,
                            color:
                                Color(0xFF12B76A),
                            size: 26,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Welcome to One Enterprise',
                          textAlign:
                              TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Onest',
                            fontSize: 21,
                            fontWeight:
                                FontWeight.w600,
                            letterSpacing: -0.3,
                            color: textDark,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text.rich(
                          TextSpan(
                            style:
                                const TextStyle(
                              fontFamily: 'Onest',
                              fontSize: 13,
                              fontWeight:
                                  FontWeight.w400,
                              height: 1.5,
                              color: textMedium,
                            ),
                            children: [
                              TextSpan(
                                text: orgName,
                                style:
                                    const TextStyle(
                                  fontWeight:
                                      FontWeight.w600,
                                ),
                              ),
                              const TextSpan(
                                text:
                                    ' is ready. Your Super Admin account has been created — verify your email to activate full access.',
                              ),
                            ],
                          ),
                          textAlign:
                              TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: double.infinity,
                          padding:
                              const EdgeInsets.all(
                            12,
                          ),
                          decoration:
                              BoxDecoration(
                            color:
                                const Color(0xFFF2F6FF),
                            borderRadius:
                                BorderRadius.circular(
                              8,
                            ),
                            border: Border.all(
                              color:
                                  const Color(0xFFD8E4FF),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,
                            children: [
                              Container(
                                width: 26,
                                height: 26,
                                decoration:
                                    BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius
                                          .circular(
                                    6,
                                  ),
                                ),
                                child: const Icon(
                                  Icons
                                      .mail_outline_rounded,
                                  color: blue,
                                  size: 15,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text.rich(
                                  TextSpan(
                                    style:
                                        const TextStyle(
                                      fontFamily:
                                          'Onest',
                                      fontSize: 12,
                                      height: 1.5,
                                      color:
                                          textMedium,
                                    ),
                                    children: [
                                      const TextSpan(
                                        text:
                                            "We've sent a verification link to your official email. Your workspace:  ",
                                      ),
                                      TextSpan(
                                        text:
                                            workspace,
                                        style:
                                            const TextStyle(
                                          fontFamily:
                                              'monospace',
                                          fontWeight:
                                              FontWeight
                                                  .w600,
                                          color:
                                              textDark,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildPrimaryButton(
                          text:
                              'Go to sign in',
                          onPressed: () {
                            Navigator.of(
                              dialogContext,
                            ).pop();
                            Navigator.pop(
                              context,
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        Wrap(
                          alignment:
                              WrapAlignment.center,
                          children: [
                            const Text(
                              "Didn't get the email? ",
                              style: TextStyle(
                                fontFamily: 'Onest',
                                fontSize: 12,
                                color:
                                    textLight,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                ScaffoldMessenger
                                    .of(context)
                                    .showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Verification email sent again.',
                                      style:
                                          TextStyle(
                                        fontFamily:
                                            'Onest',
                                      ),
                                    ),
                                    backgroundColor:
                                        navy,
                                    behavior:
                                        SnackBarBehavior
                                            .floating,
                                  ),
                                );
                              },
                              child: const Text(
                                'Resend verification',
                                style: TextStyle(
                                  fontFamily:
                                      'Onest',
                                  fontSize: 12,
                                  fontWeight:
                                      FontWeight.w600,
                                  color: blue,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDialogBackButton(
    BuildContext dialogContext,
  ) {
    return InkWell(
      onTap: () {
        Navigator.of(dialogContext).pop();
      },
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.chevron_left,
            size: 18,
            color: textLight,
          ),
          Text(
            'Back',
            style: TextStyle(
              fontFamily: 'Onest',
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: textLight,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDialogProgress() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 3,
            decoration: BoxDecoration(
              color: blue,
              borderRadius:
                  BorderRadius.circular(4),
            ),
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Container(
            height: 3,
            decoration: BoxDecoration(
              color: blue,
              borderRadius:
                  BorderRadius.circular(4),
            ),
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Container(
            height: 3,
            decoration: BoxDecoration(
              color: navy,
              borderRadius:
                  BorderRadius.circular(4),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildConsentRow({
    required bool value,
    required ValueChanged<bool> onChanged,
    required String text,
    required List<String> links,
    String? extraText,
    bool optional = false,
  }) {
    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 22,
          height: 22,
          child: Checkbox(
            value: value,
            onChanged: (checked) {
              onChanged(checked ?? false);
            },
            activeColor: navy,
            side: const BorderSide(
              color: Color(0xFF98A2B3),
              width: 1,
            ),
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(2),
            ),
          ),
        ),
        const SizedBox(width: 7),
        Expanded(
          child: Wrap(
            children: [
              Text(
                text,
                style: const TextStyle(
                  fontFamily: 'Onest',
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  height: 1.35,
                  color: textMedium,
                ),
              ),
              for (final link in links)
                Text(
                  link,
                  style: const TextStyle(
                    fontFamily: 'Onest',
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    height: 1.35,
                    color: blue,
                  ),
                ),
              if (extraText != null)
                Text(
                  extraText,
                  style: const TextStyle(
                    fontFamily: 'Onest',
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    height: 1.35,
                    color: textMedium,
                  ),
                ),
              if (optional)
                const Text(
                  '  OPTIONAL',
                  style: TextStyle(
                    fontFamily: 'Onest',
                    fontSize: 9,
                    fontWeight: FontWeight.w400,
                    color: textLight,
                    letterSpacing: 0.3,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  void _showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: const TextStyle(
              fontFamily: 'Onest',
            ),
          ),
          backgroundColor: navy,
          behavior: SnackBarBehavior.floating,
        ),
      );
  }
}