import 'package:flutter/material.dart';

class CreateTenantPage extends StatefulWidget {
  const CreateTenantPage({super.key});

  @override
  State<CreateTenantPage> createState() => _CreateTenantPageState();
}

class _CreateTenantPageState extends State<CreateTenantPage> {
  final _formKey = GlobalKey<FormState>();

  final _tenantNameController = TextEditingController();
  final _organizationController = TextEditingController();
  final _tenantIdController = TextEditingController(
    text: 'TEN-20250918-001',
  );
  final _domainController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();

  String _subscriptionPlan = 'Enterprise';
  String _status = 'Active';
  String _timeZone = 'UTC +05:30 (India Standard Time)';
  String _language = 'English';
  String _country = '';

  static const Color primaryColor = Color(0xFF3047FF);
  static const Color borderColor = Color(0xFFDCE4F0);
  static const Color textColor = Color(0xFF202D40);
  static const Color mutedColor = Color(0xFF53647D);

  @override
  void dispose() {
    _tenantNameController.dispose();
    _organizationController.dispose();
    _tenantIdController.dispose();
    _domainController.dispose();
    _fullNameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    super.dispose();
  }

  void _resetForm() {
    _formKey.currentState?.reset();

    _tenantNameController.clear();
    _organizationController.clear();
    _tenantIdController.text = 'TEN-20250918-001';
    _domainController.clear();
    _fullNameController.clear();
    _emailController.clear();
    _mobileController.clear();

    setState(() {
      _subscriptionPlan = 'Enterprise';
      _status = 'Active';
      _timeZone = 'UTC +05:30 (India Standard Time)';
      _language = 'English';
      _country = '';
    });
  }

  void _createTenant() {
    if (!_formKey.currentState!.validate()) return;

    if (_country.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a country.')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Form validated. Tenant creation is not connected yet.',
        ),
      ),
    );
  }

  Widget _field({
    required String label,
    required TextEditingController controller,
    required String hint,
    String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: mutedColor,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 42,
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            validator: validator,
            style: const TextStyle(fontSize: 14, color: textColor),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(
                fontSize: 14,
                color: Color(0xFF42536D),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
                borderSide: const BorderSide(color: borderColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
                borderSide: const BorderSide(color: borderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
                borderSide: const BorderSide(color: primaryColor),
              ),
              errorStyle: const TextStyle(fontSize: 10),
            ),
          ),
        ),
      ],
    );
  }

  Widget _dropdown({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: mutedColor,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 42,
          child: DropdownButtonFormField<String>(
            value: value,
            isExpanded: true,
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: mutedColor,
            ),
            style: const TextStyle(fontSize: 14, color: textColor),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
                borderSide: const BorderSide(color: borderColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
                borderSide: const BorderSide(color: borderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
                borderSide: const BorderSide(color: primaryColor),
              ),
            ),
            items: items
                .map(
                  (item) => DropdownMenuItem(
                    value: item,
                    child: Text(
                      item,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )
                .toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _countryDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Country',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: mutedColor,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 42,
          child: DropdownButtonFormField<String>(
            value: _country.isEmpty ? null : _country,
            isExpanded: true,
            hint: const Text(
              'Select Country',
              style: TextStyle(fontSize: 14, color: textColor),
            ),
            icon: const Icon(Icons.keyboard_arrow_down),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
                borderSide: const BorderSide(color: borderColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
                borderSide: const BorderSide(color: borderColor),
              ),
            ),
            items: const [
              'India',
              'United States',
              'United Kingdom',
              'Singapore',
              'Australia',
              'Canada',
              'Germany',
              'Japan',
            ]
                .map(
                  (country) => DropdownMenuItem(
                    value: country,
                    child: Text(country),
                  ),
                )
                .toList(),
            onChanged: (value) {
              setState(() => _country = value ?? '');
            },
          ),
        ),
      ],
    );
  }

  Widget _statusOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Status',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: mutedColor,
          ),
        ),
        const SizedBox(height: 6),
        Wrap(
          spacing: 12,
          children: ['Active', 'Inactive'].map((status) {
            return InkWell(
              onTap: () => setState(() => _status = status),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio<String>(
                    value: status,
                    groupValue: _status,
                    activeColor: const Color(0xFF009B70),
                    materialTapTargetSize:
                        MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _status = value);
                      }
                    },
                  ),
                  Text(
                    status,
                    style: const TextStyle(
                      fontSize: 13,
                      color: textColor,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _section({
    required String title,
    required int number,
    required List<Widget> children,
    required bool isDesktop,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 12,
            ),
            child: Row(
              children: [
                if (isDesktop) ...[
                  Container(
                    width: 30,
                    height: 30,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF0F6FF),
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '$number',
                      style: const TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFEDF1F7)),
          Padding(
            padding: const EdgeInsets.all(16),
            child: isDesktop
                ? Column(
                    children: [
                      for (final row in children)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: row,
                        ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (int i = 0; i < children.length; i++) ...[
                        children[i],
                        if (i != children.length - 1)
                          const SizedBox(height: 16),
                      ],
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _twoColumns(Widget first, Widget second) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: first),
        const SizedBox(width: 16),
        Expanded(child: second),
      ],
    );
  }

  Widget _pageButton({
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
    required bool primary,
  }) {
    return SizedBox(
      height: 44,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 18),
        label: Text(label),
        style: OutlinedButton.styleFrom(
          backgroundColor: primary ? primaryColor : Colors.white,
          foregroundColor: primary ? Colors.white : textColor,
          side: BorderSide(
            color: primary ? primaryColor : borderColor,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9),
          ),
          textStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 800;

        final tenantInfo = _section(
          title: 'Tenant Information',
          number: 1,
          isDesktop: isDesktop,
          children: isDesktop
              ? [
                  _twoColumns(
                    _field(
                      label: 'Tenant Name',
                      controller: _tenantNameController,
                      hint: 'Enter tenant name',
                      validator: (value) =>
                          value == null || value.trim().isEmpty
                              ? 'Enter tenant name'
                              : null,
                    ),
                    _field(
                      label: 'Organization Name',
                      controller: _organizationController,
                      hint: 'Enter organization name',
                      validator: (value) =>
                          value == null || value.trim().isEmpty
                              ? 'Enter organization name'
                              : null,
                    ),
                  ),
                  _twoColumns(
                    _field(
                      label: 'Tenant ID',
                      controller: _tenantIdController,
                      hint: 'Enter tenant ID',
                      validator: (value) =>
                          value == null || value.trim().isEmpty
                              ? 'Enter tenant ID'
                              : null,
                    ),
                    _field(
                      label: 'Domain / Subdomain',
                      controller: _domainController,
                      hint: 'Your company domain',
                      validator: (value) =>
                          value == null || value.trim().isEmpty
                              ? 'Enter domain or subdomain'
                              : null,
                    ),
                  ),
                ]
              : [
                  _field(
                    label: 'Tenant Name',
                    controller: _tenantNameController,
                    hint: 'Java Enterprise Suite',
                    validator: (value) =>
                        value == null || value.trim().isEmpty
                            ? 'Enter tenant name'
                            : null,
                  ),
                  _field(
                    label: 'Organization Name',
                    controller: _organizationController,
                    hint: 'Enter Organization name',
                    validator: (value) =>
                        value == null || value.trim().isEmpty
                            ? 'Enter organization name'
                            : null,
                  ),
                  _field(
                    label: 'Tenant ID',
                    controller: _tenantIdController,
                    hint: 'TEN-345678',
                    validator: (value) =>
                        value == null || value.trim().isEmpty
                            ? 'Enter tenant ID'
                            : null,
                  ),
                  _field(
                    label: 'Domain / Subdomain',
                    controller: _domainController,
                    hint: 'Your company domain',
                    validator: (value) =>
                        value == null || value.trim().isEmpty
                            ? 'Enter domain or subdomain'
                            : null,
                  ),
                ],
        );

        final subscription = _section(
          title: 'Subscription',
          number: 2,
          isDesktop: isDesktop,
          children: [
            if (isDesktop)
              _twoColumns(
                _dropdown(
                  label: 'Subscription Plan',
                  value: _subscriptionPlan,
                  items: const [
                    'Basic',
                    'Professional',
                    'Enterprise',
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _subscriptionPlan = value);
                    }
                  },
                ),
                _statusOptions(),
              )
            else ...[
              _dropdown(
                label: 'Subscription Plan',
                value: _subscriptionPlan,
                items: const [
                  'Basic',
                  'Professional',
                  'Enterprise',
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _subscriptionPlan = value);
                  }
                },
              ),
              _statusOptions(),
            ],
          ],
        );

        final administrator = _section(
          title: 'Primary Administrator',
          number: 3,
          isDesktop: isDesktop,
          children: isDesktop
              ? [
                  _twoColumns(
                    _field(
                      label: 'Full Name',
                      controller: _fullNameController,
                      hint: 'Enter full name',
                      validator: (value) =>
                          value == null || value.trim().isEmpty
                              ? 'Enter full name'
                              : null,
                    ),
                    _field(
                      label: 'Email Address',
                      controller: _emailController,
                      hint: 'Enter email address',
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Enter email address';
                        }
                        if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                            .hasMatch(value.trim())) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      },
                    ),
                  ),
                  _field(
                    label: 'Mobile Number',
                    controller: _mobileController,
                    hint: 'Enter mobile number',
                    keyboardType: TextInputType.phone,
                    validator: (value) =>
                        value == null || value.trim().isEmpty
                            ? 'Enter mobile number'
                            : null,
                  ),
                ]
              : [
                  _field(
                    label: 'Full Name',
                    controller: _fullNameController,
                    hint: 'Enter full name',
                    validator: (value) =>
                        value == null || value.trim().isEmpty
                            ? 'Enter full name'
                            : null,
                  ),
                  _field(
                    label: 'Email Address',
                    controller: _emailController,
                    hint: 'Enter email address',
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Enter email address';
                      }
                      if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                          .hasMatch(value.trim())) {
                        return 'Enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  _field(
                    label: 'Mobile Number',
                    controller: _mobileController,
                    hint: 'Enter mobile number',
                    keyboardType: TextInputType.phone,
                    validator: (value) =>
                        value == null || value.trim().isEmpty
                            ? 'Enter mobile number'
                            : null,
                  ),
                ],
        );

        final regionalSettings = _section(
          title: 'Regional Settings',
          number: 4,
          isDesktop: isDesktop,
          children: [
            if (isDesktop)
              _twoColumns(
                _dropdown(
                  label: 'TIME ZONE',
                  value: _timeZone,
                  items: const [
                    'UTC +05:30 (India Standard Time)',
                    'UTC +00:00 (Greenwich Mean Time)',
                    'UTC -05:00 (Eastern Standard Time)',
                    'UTC +08:00 (Singapore Time)',
                    'UTC +09:00 (Japan Standard Time)',
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _timeZone = value);
                    }
                  },
                ),
                _dropdown(
                  label: 'LANGUAGE',
                  value: _language,
                  items: const [
                    'English',
                    'Tamil',
                    'Hindi',
                    'French',
                    'German',
                    'Japanese',
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _language = value);
                    }
                  },
                ),
              )
            else ...[
              _dropdown(
                label: 'Time Zone',
                value: _timeZone,
                items: const [
                  'UTC +05:30 (India Standard Time)',
                  'UTC +00:00 (Greenwich Mean Time)',
                  'UTC -05:00 (Eastern Standard Time)',
                  'UTC +08:00 (Singapore Time)',
                  'UTC +09:00 (Japan Standard Time)',
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _timeZone = value);
                  }
                },
              ),
              _dropdown(
                label: 'Language',
                value: _language,
                items: const [
                  'English',
                  'Tamil',
                  'Hindi',
                  'French',
                  'German',
                  'Japanese',
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _language = value);
                  }
                },
              ),
            ],
            _countryDropdown(),
          ],
        );

        return Container(
          color: const Color(0xFFFAFBFD),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(isDesktop ? 20 : 16),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1500),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Tenant Management  /  Create tenant',
                        style: TextStyle(
                          fontSize: 12,
                          color: mutedColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (isDesktop)
                        Row(
                          children: [
                            const Expanded(
                              child: Text(
                                'Create tenant',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700,
                                  color: textColor,
                                ),
                              ),
                            ),
                            _pageButton(
                              label: 'Reset',
                              icon: Icons.refresh,
                              onPressed: _resetForm,
                              primary: false,
                            ),
                            const SizedBox(width: 10),
                            _pageButton(
                              label: 'Create Tenant',
                              icon: Icons.add,
                              onPressed: _createTenant,
                              primary: true,
                            ),
                          ],
                        )
                      else
                        const Text(
                          'Create tenant',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: textColor,
                          ),
                        ),
                      const SizedBox(height: 18),
                      tenantInfo,
                      subscription,
                      administrator,
                      regionalSettings,
                      if (!isDesktop)
                        Row(
                          children: [
                            Expanded(
                              child: _pageButton(
                                label: 'Reset',
                                icon: Icons.refresh,
                                onPressed: _resetForm,
                                primary: false,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _pageButton(
                                label: 'Create Tenant',
                                icon: Icons.add,
                                onPressed: _createTenant,
                                primary: true,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
