import 'package:flutter/material.dart';

import 'tenant_ui.dart';
import '../../widgets/tenant_management_dialogs.dart';

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

  Future<void> _resetForm() async {
    if (!await showResetChangesDialog(context)) return;
    if (!mounted) return;
    _clearForm();
  }

  void _clearForm() {
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

  Future<void> _createTenant() async {
    if (!_formKey.currentState!.validate()) return;

    if (_country.isEmpty) {
      showTenantToast(
        context,
        title: 'Country Required',
        message: 'Please select a country.',
        type: TenantToastType.danger,
        icon: Icons.error_outline,
      );
      return;
    }

    final name = _tenantNameController.text.trim();

    await showTenantCreatedDialog(
      context,
      tenantName: name.isEmpty ? 'The tenant' : name,
    );

    if (!mounted) return;
    _clearForm();
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
        TLabel(label),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          style: TUi.fieldText,
          decoration: TUi.input(hint: hint),
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
        TLabel(label),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 18,
            color: TUi.muted,
          ),
          style: TUi.fieldText,
          decoration: TUi.input(),
          items: items
              .map(
                (item) => DropdownMenuItem(
                  value: item,
                  child: Text(item, overflow: TextOverflow.ellipsis),
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _countryDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TLabel('Country'),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          value: _country.isEmpty ? null : _country,
          isExpanded: true,
          hint: const Text(
            'Select Country',
            style: TextStyle(fontSize: 13, color: TUi.hint),
          ),
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 18,
            color: TUi.muted,
          ),
          style: TUi.fieldText,
          decoration: TUi.input(),
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
      ],
    );
  }

  Widget _statusOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TLabel('Status'),
        const SizedBox(height: 4),
        Wrap(
          spacing: 16,
          children: ['Active', 'Inactive'].map((status) {
            return InkWell(
              borderRadius: BorderRadius.circular(6),
              onTap: () => setState(() => _status = status),
              child: Padding(
                padding: const EdgeInsets.only(right: 4),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Radio<String>(
                      value: status,
                      groupValue: _status,
                      activeColor: TUi.blue,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => _status = value);
                        }
                      },
                    ),
                    Text(status, style: TUi.fieldText),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _section({
    required String title,
    required IconData icon,
    required List<Widget> children,
    required bool isDesktop,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TCard(
        title: title,
        icon: icon,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (int i = 0; i < children.length; i++) ...[
              children[i],
              if (i != children.length - 1) const SizedBox(height: 16),
            ],
          ],
        ),
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
    bool expand = false,
  }) {
    return TButton(
      label,
      icon: icon,
      onPressed: onPressed,
      kind: primary ? TButtonKind.primary : TButtonKind.outline,
      height: expand ? 46 : 34,
      expand: expand,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 800;

        final tenantInfo = _section(
          title: 'Tenant Information',
          icon: Icons.apartment_outlined,
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
          icon: Icons.workspace_premium_outlined,
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
          icon: Icons.admin_panel_settings_outlined,
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
          icon: Icons.language_outlined,
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
          color: TUi.bg,
          child: SingleChildScrollView(
            padding: TUi.pagePadding(!isDesktop),
            child: Align(
              alignment: Alignment.topLeft,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1500),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TBreadcrumb(['Tenant Management', 'Create Tenant']),
                      const SizedBox(height: 8),
                      TPageHeader(
                        title: 'Create Tenant',
                        subtitle:
                            'Set up a new tenant organization with its plan, administrator and regional defaults.',
                        mobile: !isDesktop,
                        actions: [
                          _pageButton(
                            label: 'Reset',
                            icon: Icons.refresh,
                            onPressed: _resetForm,
                            primary: false,
                          ),
                          _pageButton(
                            label: 'Create Tenant',
                            icon: Icons.add,
                            onPressed: _createTenant,
                            primary: true,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
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
                                expand: true,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _pageButton(
                                label: 'Create Tenant',
                                icon: Icons.add,
                                onPressed: _createTenant,
                                primary: true,
                                expand: true,
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