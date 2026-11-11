import 'package:flutter/material.dart';

import 'tenant_ui.dart';
import '../../widgets/tenant_management_dialogs.dart';

class TenantConfigurationPage extends StatefulWidget {
  const TenantConfigurationPage({super.key});

  @override
  State<TenantConfigurationPage> createState() =>
      _TenantConfigurationPageState();
}

class _TenantConfigurationPageState
    extends State<TenantConfigurationPage> {
  final _formKey = GlobalKey<FormState>();

  final _tenantNameController =
      TextEditingController(text: 'ABC Technologies Pvt. Ltd.');
  final _tenantIdController =
      TextEditingController(text: 'TEN-8493-IN');
  final _storageController = TextEditingController(text: '100');
  final _passwordController =
      TextEditingController(text: 'Enterprise@Password123');

  String _country = 'India';
  String _timeZone = 'Asia/Kolkata';
  String _currency = 'INR';
  String _timeFormat = '12-hour';
  String _language = 'English';
  String _dateFormat = 'DD/MM/YYYY';
  String _storageUnit = 'GB';
  int _storageUsed = 32;
  int _idleTimeout = 30;

  bool _emailNotifications = true;
  bool _smsNotifications = false;
  bool _mfaMandatory = true;
  bool _showPassword = false;
  bool _enabled = true;

  @override
  void dispose() {
    _tenantNameController.dispose();
    _tenantIdController.dispose();
    _storageController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _message(String message) {
    if (!mounted) return;
    showTenantMessageToast(context, message);
  }

  Future<void> _resetDefaults() async {
    if (!await showResetChangesDialog(context)) return;
    if (!mounted) return;
    setState(() {
      _tenantNameController.text = 'ABC Technologies Pvt. Ltd.';
      _tenantIdController.text = 'TEN-8493-IN';
      _storageController.text = '100';
      _passwordController.text = 'Enterprise@Password123';

      _country = 'India';
      _timeZone = 'Asia/Kolkata';
      _currency = 'INR';
      _timeFormat = '12-hour';
      _language = 'English';
      _dateFormat = 'DD/MM/YYYY';
      _storageUnit = 'GB';
      _storageUsed = 32;
      _idleTimeout = 30;

      _emailNotifications = true;
      _smsNotifications = false;
      _mfaMandatory = true;
      _showPassword = false;
      _enabled = true;
    });

    _message('Default settings restored.');
  }

  Future<void> _cancel() async {
    await _resetDefaults();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) {
      _message('Please correct the highlighted fields.');
      return;
    }

    // Frontend demonstration only.
    // Connect this action to your API when backend integration begins.
    _message('Tenant configuration validated successfully.');
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final mobile = constraints.maxWidth < 700;

        return Container(
          color: TUi.bg,
          child: SingleChildScrollView(
            padding: TUi.pagePadding(mobile),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TBreadcrumb(['Tenant Management', 'Tenant Configuration']),
                  const SizedBox(height: 8),
                  _pageHeader(mobile),
                  SizedBox(height: mobile ? 18 : 22),
                  _tenantDetails(mobile),
                  const SizedBox(height: 16),
                  _regionalSettings(mobile),
                  const SizedBox(height: 16),
                  _storageSettings(mobile),
                  const SizedBox(height: 16),
                  _securitySettings(mobile),
                  if (mobile) ...[
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: _actionButton(
                            'Cancel',
                            onPressed: _cancel,
                            outlined: true,
                            height: 46,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _actionButton(
                            'Save',
                            onPressed: _save,
                            height: 46,
                            icon: Icons.save_outlined,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }



  Widget _pageHeader(bool mobile) {
    return TPageHeader(
      title: 'Tenant Configuration',
      subtitle:
          'Manage regional, security, storage and notification settings for this tenant.',
      mobile: mobile,
      actions: [
        _actionButton(
          'Reset Default',
          onPressed: _resetDefaults,
          outlined: true,
          icon: Icons.restart_alt,
        ),
        _actionButton('Cancel', onPressed: _cancel, outlined: true),
        _actionButton('Save', onPressed: _save, icon: Icons.save_outlined),
      ],
    );
  }

  Widget _tenantDetails(bool mobile) {
    return _card(
      title: 'Tenant Details',
      icon: Icons.apartment_outlined,
      subtitle: mobile
          ? null
          : 'Tenant ID is system-generated and cannot be changed.',
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TStatusBadge(
            _enabled ? 'Enabled' : 'Disabled',
            tone: _enabled ? TTone.success : TTone.danger,
          ),
          const SizedBox(width: 4),
          IconButton(
            tooltip: 'Toggle tenant status',
            visualDensity: VisualDensity.compact,
            onPressed: () {
              setState(() => _enabled = !_enabled);
            },
            icon: const Icon(Icons.edit_outlined, size: 16, color: TUi.muted),
          ),
        ],
      ),
      child: _responsiveFields(
        mobile: mobile,
        children: [
          _textField(
            label: 'Tenant Name',
            controller: _tenantNameController,
            validator: (value) =>
                value == null || value.trim().isEmpty
                    ? 'Tenant name is required'
                    : null,
          ),
          _textField(
            label: 'Tenant ID',
            controller: _tenantIdController,
            readOnly: true,
            monospace: true,
          ),
        ],
      ),
    );
  }

  Widget _regionalSettings(bool mobile) {
    return _card(
      title: 'Regional Settings',
      icon: Icons.language_outlined,
      subtitle: 'Localization applied to all users of this tenant.',
      child: _responsiveFields(
        mobile: mobile,
        children: [
          _dropdown(
            label: 'Country',
            value: _country,
            items: const [
              'India',
              'United States',
              'United Kingdom',
              'Singapore',
              'Australia',
            ],
            onChanged: (v) => setState(() => _country = v!),
          ),
          _dropdown(
            label: 'Time Zone',
            value: _timeZone,
            items: const [
              'Asia/Kolkata',
              'UTC',
              'Europe/London',
              'America/New_York',
              'Asia/Singapore',
              'Australia/Sydney',
            ],
            onChanged: (v) => setState(() => _timeZone = v!),
          ),
          _dropdown(
            label: 'Currency',
            value: _currency,
            items: const ['INR', 'USD', 'GBP', 'EUR', 'SGD', 'AUD'],
            onChanged: (v) => setState(() => _currency = v!),
          ),
          _dropdown(
            label: 'Time Format',
            value: _timeFormat,
            items: const ['12-hour', '24-hour'],
            onChanged: (v) => setState(() => _timeFormat = v!),
          ),
          _dropdown(
            label: 'Language',
            value: _language,
            items: const [
              'English',
              'Tamil',
              'Hindi',
              'French',
              'Spanish',
            ],
            onChanged: (v) => setState(() => _language = v!),
          ),
          _dropdown(
            label: 'Standard Date Format',
            value: _dateFormat,
            items: const [
              'DD/MM/YYYY',
              'MM/DD/YYYY',
              'YYYY-MM-DD',
            ],
            onChanged: (v) => setState(() => _dateFormat = v!),
          ),
        ],
      ),
    );
  }

  Widget _storageSettings(bool mobile) {
    return _card(
      title: 'Storage & Notifications',
      icon: Icons.storage_outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Storage Limit *',
            style: _labelStyle(),
          ),
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SizedBox(
                  child: TextFormField(
                    controller: _storageController,
                    keyboardType: TextInputType.number,
                    decoration: _inputDecoration(),
                    validator: (value) {
                      final limit = int.tryParse(value ?? '');
                      if (limit == null || limit <= 0) {
                        return 'Enter a valid storage limit';
                      }
                      if (limit < _storageUsed) {
                        return 'Limit cannot be below current usage';
                      }
                      return null;
                    },
                    onChanged: (_) => setState(() {}),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: mobile ? 88 : 80,
                child: DropdownButtonFormField<String>(
                  value: _storageUnit,
                  isExpanded: true,
                  decoration: _inputDecoration(),
                  items: const ['GB', 'MB', 'TB']
                      .map(
                        (v) => DropdownMenuItem(
                          value: v,
                          child: Text(v),
                        ),
                      )
                      .toList(),
                  onChanged: (v) =>
                      setState(() => _storageUnit = v!),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: (int.tryParse(_storageController.text) ?? 0) > 0
                  ? (_storageUsed /
                          (int.tryParse(_storageController.text) ?? 1))
                      .clamp(0.0, 1.0)
                  : 0,
              minHeight: 8,
              backgroundColor: const Color(0xFFE8EDF3),
              valueColor: const AlwaysStoppedAnimation(TUi.blue),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '$_storageUsed $_storageUnit of ${_storageController.text.isEmpty ? '0' : _storageController.text} $_storageUnit used',
            style: const TextStyle(fontSize: 12, color: TUi.muted),
          ),
          const SizedBox(height: 14),
          const Divider(color: TUi.border, height: 1),
          _switchRow(
            title: 'Email Notifications',
            subtitle: 'System alerts and reports by email.',
            value: _emailNotifications,
            onChanged: (v) => setState(() => _emailNotifications = v),
          ),
          const Divider(color: TUi.border, height: 1),
          _switchRow(
            title: 'SMS Notifications',
            subtitle: 'Requires a configured SMS provider.',
            value: _smsNotifications,
            onChanged: (v) => setState(() => _smsNotifications = v),
          ),
        ],
      ),
    );
  }

  Widget _securitySettings(bool mobile) {
    return _card(
      title: 'Security & Access Controls',
      icon: Icons.security_outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Enterprise Password Policy *',
            style: _labelStyle(),
          ),
          const SizedBox(height: 7),
          TextFormField(
            controller: _passwordController,
            obscureText: !_showPassword,
            decoration: _inputDecoration(
              prefixIcon: const Icon(
                Icons.password,
                size: 18,
                color: TUi.muted,
              ),
              suffixIcon: IconButton(
                tooltip: _showPassword ? 'Hide password' : 'Show password',
                onPressed: () =>
                    setState(() => _showPassword = !_showPassword),
                icon: Icon(
                  _showPassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: 17,
                ),
              ),
            ),
            validator: (value) {
              final password = value ?? '';
              if (password.length < 8 ||
                  !password.contains(RegExp(r'[A-Z]')) ||
                  !password.contains(RegExp(r'[a-z]')) ||
                  !password.contains(RegExp(r'[0-9]')) ||
                  !password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>_\-]'))) {
                return 'Use at least 8 characters, uppercase, lowercase, a number and a symbol.';
              }
              return null;
            },
          ),
          const SizedBox(height: 8),
          const Text(
            'Requires symbols, uppercase, lowercase and numerals',
            style: TextStyle(fontSize: 11, color: TUi.muted),
          ),
          const SizedBox(height: 16),
          Text('Idle session timeout *', style: _labelStyle()),
          const SizedBox(height: 7),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SizedBox(
                  child: TextFormField(
                    initialValue: '30',
                    keyboardType: TextInputType.number,
                    decoration: _inputDecoration(
                      prefixIcon: const Icon(
                        Icons.timer_outlined,
                        size: 18,
                      ),
                    ),
                    onChanged: (v) {
                      final value = int.tryParse(v);
                      if (value != null) {
                        setState(() => _idleTimeout = value);
                      }
                    },
                    validator: (value) {
                      final minutes = int.tryParse(value ?? '');
                      if (minutes == null ||
                          minutes < 5 ||
                          minutes > 240) {
                        return 'Enter 5–240 minutes';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                height: 44,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: TUi.fieldFill,
                  border: Border.all(color: TUi.controlBorder),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'Minutes',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: TUi.ink,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Range: 5m to 240m. Recommended session expiry limit.',
            style: TextStyle(fontSize: 11, color: TUi.muted),
          ),
          const SizedBox(height: 16),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: mobile ? 12 : 14,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: TUi.fieldFill,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: TUi.border),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.verified_user_outlined,
                  size: 18,
                  color: TUi.accent,
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    'MFA Mandatory for all Tenant Users',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: TUi.ink,
                    ),
                  ),
                ),
                TUi.toggle(
                  value: _mfaMandatory,
                  onChanged: (v) => setState(() => _mfaMandatory = v),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _responsiveFields({
    required bool mobile,
    required List<Widget> children,
  }) {
    if (mobile) {
      return Column(
        children: [
          for (int i = 0; i < children.length; i++) ...[
            children[i],
            if (i != children.length - 1)
              const SizedBox(height: 14),
          ],
        ],
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth < 550 ? 1 : 2;

        if (columns == 1) {
          return Column(
            children: [
              for (int i = 0; i < children.length; i++) ...[
                children[i],
                if (i != children.length - 1)
                  const SizedBox(height: 14),
              ],
            ],
          );
        }

        return Wrap(
          spacing: 12,
          runSpacing: 14,
          children: children.map((child) {
            return SizedBox(
              width: (constraints.maxWidth - 12) / 2,
              child: child,
            );
          }).toList(),
        );
      },
    );
  }

  Widget _card({
    required String title,
    String? subtitle,
    IconData? icon,
    Widget? trailing,
    required Widget child,
  }) {
    return TCard(
      title: title,
      subtitle: subtitle,
      icon: icon,
      trailing: trailing,
      child: child,
    );
  }

  Widget _textField({
    required String label,
    required TextEditingController controller,
    bool readOnly = false,
    bool monospace = false,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: _labelStyle()),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          readOnly: readOnly,
          validator: validator,
          style: TextStyle(
            fontSize: 13,
            color: TUi.ink,
            fontFamily: monospace ? 'monospace' : null,
          ),
          decoration: _inputDecoration(
            filledColor: readOnly ? const Color(0xFFEEF2F6) : null,
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
        TLabel(label, required: true),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 18,
            color: TUi.muted,
          ),
          decoration: _inputDecoration(),
          style: TUi.fieldText,
          items: items
              .map(
                (item) => DropdownMenuItem<String>(
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

  Widget _switchRow({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
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
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: TUi.ink,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 12, color: TUi.muted),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          TUi.toggle(value: value, onChanged: onChanged),
        ],
      ),
    );
  }

  Widget _actionButton(
    String label, {
    required VoidCallback onPressed,
    bool outlined = false,
    IconData? icon,
    double height = 34,
  }) {
    return TButton(
      label,
      icon: icon,
      onPressed: onPressed,
      kind: outlined ? TButtonKind.outline : TButtonKind.primary,
      height: height,
      expand: height > 40,
    );
  }

  InputDecoration _inputDecoration({
    Widget? prefixIcon,
    Widget? suffixIcon,
    Color? filledColor,
  }) {
    return TUi.input(
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      fill: filledColor,
    );
  }

  TextStyle _labelStyle() => TUi.labelStyle;
}