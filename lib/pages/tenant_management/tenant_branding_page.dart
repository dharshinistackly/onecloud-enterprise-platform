import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'tenant_ui.dart';
import '../../widgets/tenant_management_dialogs.dart';

class TenantBrandingPage extends StatefulWidget {
  const TenantBrandingPage({super.key});

  @override
  State<TenantBrandingPage> createState() =>
      _TenantBrandingPageState();
}

class _TenantBrandingPageState extends State<TenantBrandingPage> {
  static const Color primaryBlue = Color(0xFF1976D2);
  static const Color accentGreen = Color(0xFF4CAF50);

  final _formKey = GlobalKey<FormState>();

  final _companyController =
      TextEditingController(text: 'Oracle Corporation');
  final _taglineController =
      TextEditingController(text: 'Empowering Enterprise Intelligence');
  final _welcomeController = TextEditingController(
    text: 'Welcome to Java Enterprise Suite. Please authenticate to continue.',
  );
  final _footerController =
      TextEditingController(text: 'System Maintained by IT Dept.');
  final _copyrightController = TextEditingController(
    text: '© 2024 platform branding. All rights reserved.',
  );

  final _primaryHexController =
      TextEditingController(text: '#1976D2');
  final _secondaryHexController =
      TextEditingController(text: '#FFFFFF');
  final _accentHexController =
      TextEditingController(text: '#4CAF50');

  String _selectedTenant = 'ABZ TECH';
  bool _darkMode = false;
  bool _isSaving = false;

  Color _primaryColor = primaryBlue;
  Color _secondaryColor = Colors.white;
  Color _accentColor = accentGreen;

  Uint8List? _logoBytes;
  Uint8List? _faviconBytes;
  Uint8List? _backgroundBytes;

  String? _logoName;
  String? _faviconName;
  String? _backgroundName;

  // Demo defaults. Connect these values to your API/backend later.
  final List<String> _tenants = [
    'ABZ TECH',
    'ABC Technologies Pvt. Ltd.',
    'Java Enterprise Suite',
  ];

  @override
  void dispose() {
    _companyController.dispose();
    _taglineController.dispose();
    _welcomeController.dispose();
    _footerController.dispose();
    _copyrightController.dispose();
    _primaryHexController.dispose();
    _secondaryHexController.dispose();
    _accentHexController.dispose();
    super.dispose();
  }

  Color get _pageColor => _darkMode ? const Color(0xFF111827) : TUi.bg;

  Color get _cardColor => _darkMode ? const Color(0xFF1F2937) : Colors.white;

  Color get _mainTextColor => _darkMode ? Colors.white : TUi.ink;

  Color get _inputColor =>
      _darkMode ? const Color(0xFF273449) : TUi.fieldFill;

  Color get _lineColor => _darkMode ? const Color(0xFF3A475A) : TUi.border;

  Color get _controlLine =>
      _darkMode ? const Color(0xFF3A475A) : TUi.controlBorder;

  Color get _stripColor =>
      _darkMode ? const Color(0xFF243040) : TUi.fieldFill;

  Color get _dividerColor =>
      _darkMode ? const Color(0xFF3A475A) : TUi.divider;

  void _showMessage(String message) {
    if (!mounted) return;
    showTenantMessageToast(context, message);
  }

  Color _parseHex(String value, Color fallback) {
    try {
      String hex = value.trim().replaceAll('#', '');

      if (hex.length == 6) {
        hex = 'FF$hex';
      }

      if (hex.length != 8) return fallback;

      return Color(int.parse(hex, radix: 16));
    } catch (_) {
      return fallback;
    }
  }

  String _hex(Color color) =>
      '#${color.toARGB32().toRadixString(16).substring(2).toUpperCase()}';

  Future<void> _pickImage(String type) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
        withData: true,
      );

      if (result == null || result.files.isEmpty) return;

      final file = result.files.first;
      final bytes = file.bytes;

      if (bytes == null) {
        _showMessage('Could not read the image. Please try another file.');
        return;
      }

      if (bytes.length > 5 * 1024 * 1024) {
        _showMessage('Please select an image smaller than 5 MB.');
        return;
      }

      setState(() {
        switch (type) {
          case 'logo':
            _logoBytes = bytes;
            _logoName = file.name;
            break;
          case 'favicon':
            _faviconBytes = bytes;
            _faviconName = file.name;
            break;
          case 'background':
            _backgroundBytes = bytes;
            _backgroundName = file.name;
            break;
        }
      });

      _showMessage('${file.name} selected successfully.');
    } catch (e) {
      _showMessage('Unable to select the image. Please try again.');
    }
  }

  void _removeImage(String type) {
    setState(() {
      switch (type) {
        case 'logo':
          _logoBytes = null;
          _logoName = null;
          break;
        case 'favicon':
          _faviconBytes = null;
          _faviconName = null;
          break;
        case 'background':
          _backgroundBytes = null;
          _backgroundName = null;
          break;
      }
    });
  }

  void _updateColor(String type, String value) {
    if (!RegExp(r'^#?([0-9a-fA-F]{6})$').hasMatch(value.trim())) {
      return;
    }

    final color = _parseHex(value, Colors.white);

    setState(() {
      switch (type) {
        case 'primary':
          _primaryColor = color;
          _primaryHexController.value = TextEditingValue(
            text: value.startsWith('#') ? value : '#$value',
            selection: TextSelection.collapsed(
              offset: value.length + (value.startsWith('#') ? 0 : 1),
            ),
          );
          break;
        case 'secondary':
          _secondaryColor = color;
          _secondaryHexController.value = TextEditingValue(
            text: value.startsWith('#') ? value : '#$value',
            selection: TextSelection.collapsed(
              offset: value.length + (value.startsWith('#') ? 0 : 1),
            ),
          );
          break;
        case 'accent':
          _accentColor = color;
          _accentHexController.value = TextEditingValue(
            text: value.startsWith('#') ? value : '#$value',
            selection: TextSelection.collapsed(
              offset: value.length + (value.startsWith('#') ? 0 : 1),
            ),
          );
          break;
      }
    });
  }

  Future<void> _chooseColor(String type) async {
    final colors = <Color>[
      const Color(0xFF1976D2),
      const Color(0xFF3347FF),
      const Color(0xFF673AB7),
      const Color(0xFF009688),
      const Color(0xFF4CAF50),
      const Color(0xFFE65100),
      const Color(0xFFEF4444),
      const Color(0xFF111827),
      Colors.white,
      const Color(0xFFF3F4F6),
    ];

    final selected = await showDialog<Color>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choose a color'),
        content: Wrap(
          spacing: 12,
          runSpacing: 12,
          children: colors.map((color) {
            return InkWell(
              onTap: () => Navigator.pop(context, color),
              child: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: color,
                  border: Border.all(color: TUi.border),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const SizedBox.shrink(),
              ),
            );
          }).toList(),
        ),
      ),
    );

    if (selected == null) return;

    final hex = _hex(selected);

    setState(() {
      switch (type) {
        case 'primary':
          _primaryColor = selected;
          _primaryHexController.text = hex;
          break;
        case 'secondary':
          _secondaryColor = selected;
          _secondaryHexController.text = hex;
          break;
        case 'accent':
          _accentColor = selected;
          _accentHexController.text = hex;
          break;
      }
    });
  }

  Future<void> _resetDefaults() async {
    if (!await showResetChangesDialog(context)) return;
    if (!mounted) return;
    setState(() {
      _selectedTenant = 'ABZ TECH';
      _companyController.text = 'Oracle Corporation';
      _taglineController.text =
          'Empowering Enterprise Intelligence';
      _welcomeController.text =
          'Welcome to Java Enterprise Suite. Please authenticate to continue.';
      _footerController.text = 'System Maintained by IT Dept.';
      _copyrightController.text =
          '© 2024 platform branding. All rights reserved.';

      _primaryColor = primaryBlue;
      _secondaryColor = Colors.white;
      _accentColor = accentGreen;

      _primaryHexController.text = '#1976D2';
      _secondaryHexController.text = '#FFFFFF';
      _accentHexController.text = '#4CAF50';

      _darkMode = false;

      _logoBytes = null;
      _faviconBytes = null;
      _backgroundBytes = null;
      _logoName = null;
      _faviconName = null;
      _backgroundName = null;
    });

    _showMessage('Branding defaults restored.');
  }

  Future<void> _cancel() async {
    await _resetDefaults();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) {
      _showMessage('Please correct the highlighted fields.');
      return;
    }

    setState(() => _isSaving = true);

    // Frontend-only demonstration.
    // Persist the fields and image bytes using your backend/API later.
    await Future<void>.delayed(const Duration(milliseconds: 400));

    if (!mounted) return;

    setState(() => _isSaving = false);
    _showMessage('Branding settings validated successfully.');
  }

  void _preview() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          insetPadding: const EdgeInsets.all(16),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 650),
            child: SingleChildScrollView(
              child: _loginPreview(
                fullPreview: true,
                onClose: () => Navigator.pop(dialogContext),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final mobile = TUi.isMobile(constraints.maxWidth);

        return Container(
          color: _pageColor,
          child: SingleChildScrollView(
            padding: TUi.pagePadding(mobile),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TBreadcrumb(
                    const ['Tenant Management', 'Tenant Branding'],
                    mutedColor: _mutedColorForTheme(),
                    strongColor: _mainTextColor,
                  ),
                  const SizedBox(height: 8),
                  _header(mobile),
                  SizedBox(height: mobile ? 18 : 22),
                  _tenantSelector(mobile),
                  const SizedBox(height: 16),
                  _brandInformation(mobile),
                  const SizedBox(height: 16),
                  _visualAssets(mobile),
                  const SizedBox(height: 16),
                  if (mobile) ...[
                    _loginBackgroundCard(),
                    const SizedBox(height: 16),
                    _welcomeMessageCard(),
                  ],
                  if (!mobile) ...[
                    _themeSettings(mobile),
                    const SizedBox(height: 16),
                  ],
                  if (mobile) ...[
                    _themeSettings(mobile),
                    const SizedBox(height: 16),
                  ],
                  _footerInformation(mobile),
                  if (mobile) ...[
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: _button(
                            'Preview',
                            onPressed: _preview,
                            outlined: true,
                            icon: Icons.visibility_outlined,
                            height: 46,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _button(
                            'Save',
                            onPressed: _save,
                            icon: Icons.save_outlined,
                            height: 46,
                            loading: _isSaving,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: _button(
                        'Cancel',
                        onPressed: _cancel,
                        outlined: true,
                        height: 44,
                      ),
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

  Widget _header(bool mobile) {
    return TPageHeader(
      title: 'Tenant Branding',
      subtitle: 'Configure and manage branding for individual tenants.',
      mobile: mobile,
      titleColor: _mainTextColor,
      subtitleColor: _mutedColorForTheme(),
      actions: [
        _button(
          'Preview',
          onPressed: _preview,
          outlined: true,
          icon: Icons.preview_outlined,
        ),
        _button(
          'Reset',
          onPressed: _resetDefaults,
          outlined: true,
          icon: Icons.refresh,
        ),
        _button(
          'Save',
          onPressed: _save,
          icon: Icons.save_outlined,
          loading: _isSaving,
        ),
      ],
    );
  }

  Widget _tenantSelector(bool mobile) {
    if (mobile) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: _cardColor,
        border: Border.all(color: _lineColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            Icons.apartment_outlined,
            size: 18,
            color: _darkMode ? Colors.white70 : TUi.accent,
          ),
          const SizedBox(width: 10),
          _label('Select Tenant'),
          const SizedBox(width: 20),
          SizedBox(
            width: 300,
            child: _dropdown(
              value: _selectedTenant,
              items: _tenants,
              onChanged: (value) => setState(() => _selectedTenant = value!),
            ),
          ),
        ],
      ),
    );
  }

  Widget _brandInformation(bool mobile) {
    return _section(
      title: 'Brand Information',
      icon: Icons.badge_outlined,
      badge: 'Basic Info',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (mobile) ...[
            _dropdown(
              label: 'Tenant Name',
              value: _selectedTenant,
              items: _tenants,
              onChanged: (value) =>
                  setState(() => _selectedTenant = value!),
            ),
            const SizedBox(height: 14),
          ],
          _responsiveFields(
            mobile: mobile,
            children: [
              _textInput(
                'Company Name',
                _companyController,
                requiredField: true,
              ),
              _textInput('Tagline', _taglineController),
            ],
          ),
        ],
      ),
    );
  }

  Widget _visualAssets(bool mobile) {
    return _section(
      title: 'Visual Assets',
      icon: Icons.image_outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!mobile)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _logoUpload()),
                const SizedBox(width: 16),
                Expanded(child: _loginBackgroundCard()),
              ],
            )
          else
            _logoUpload(),
          const SizedBox(height: 14),
          _faviconUpload(),
        ],
      ),
    );
  }

  Widget _logoUpload() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.image_outlined, size: 15, color: _mainTextColor),
            const SizedBox(width: 6),
            Expanded(child: _label('Company Logo')),
            Text(
              'PNG, JPG, SVG up to 5 MB',
              style: const TextStyle(fontSize: 11, color: TUi.muted),
            ),
          ],
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () => _pickImage('logo'),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: double.infinity,
            height: 145,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _darkMode
                  ? const Color(0xFF273449)
                  : TUi.fieldFill,
              border: Border.all(
                color: _lineColor,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: _logoBytes != null
                ? Image.memory(_logoBytes!, fit: BoxFit.contain)
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.cloud_upload_outlined,
                          size: 32,
                          color: _mutedColorForTheme(),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Click to upload company logo',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: _mainTextColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Choose an image from your device',
                          style: TextStyle(
                            fontSize: 11,
                            color: TUi.muted,
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
        if (_logoName != null)
          _selectedFileRow(
            _logoName!,
            onRemove: () => _removeImage('logo'),
          ),
      ],
    );
  }

  Widget _faviconUpload() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label('Favicon'),
        const SizedBox(height: 7),
        Row(
          children: [
            Container(
              width: 42,
              height: 42,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _inputColor,
                border: Border.all(color: _controlLine),
                borderRadius: BorderRadius.circular(8),
              ),
              child: _faviconBytes != null
                  ? Image.memory(_faviconBytes!, fit: BoxFit.contain)
                  : Icon(
                      Icons.language,
                      color: _mutedColorForTheme(),
                    ),
            ),
            const SizedBox(width: 10),
            _button(
              'Upload Favicon',
              onPressed: () => _pickImage('favicon'),
              outlined: true,
              icon: Icons.upload_outlined,
            ),
            if (_faviconBytes != null)
              IconButton(
                tooltip: 'Remove favicon',
                onPressed: () => _removeImage('favicon'),
                icon: const Icon(Icons.delete_outline, size: 18),
              ),
          ],
        ),
        if (_faviconName != null)
          Text(
            _faviconName!,
            style: const TextStyle(fontSize: 11, color: TUi.muted),
          ),
      ],
    );
  }

  Widget _loginBackgroundCard() {
    return _section(
      title: 'Login Background',
      icon: Icons.wallpaper_outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: _label('Preview')),
              TextButton.icon(
                onPressed: () => _pickImage('background'),
                icon: const Icon(Icons.image_outlined, size: 15),
                label: const Text('Change Image'),
                style: TextButton.styleFrom(
                  foregroundColor: TUi.blue,
                  textStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          _loginPreview(),
          if (_backgroundName != null)
            _selectedFileRow(
              _backgroundName!,
              onRemove: () => _removeImage('background'),
            ),
        ],
      ),
    );
  }

  Widget _loginPreview({
    bool fullPreview = false,
    VoidCallback? onClose,
  }) {
    return Container(
      width: double.infinity,
      height: fullPreview ? 400 : 155,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: _darkMode
            ? const Color(0xFF101A33)
            : const Color(0xFF244E84),
        borderRadius: BorderRadius.circular(9),
        image: _backgroundBytes == null
            ? null
            : DecorationImage(
                image: MemoryImage(_backgroundBytes!),
                fit: BoxFit.cover,
              ),
        gradient: _backgroundBytes == null
            ? const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF203D73),
                  Color(0xFF5D9FD6),
                  Color(0xFFB5E2F0),
                ],
              )
            : null,
      ),
      child: Stack(
        children: [
          if (_backgroundBytes == null)
            Positioned(
              top: 18,
              left: 20,
              right: 20,
              child: Container(
                height: 1,
                color: Colors.white.withValues(alpha: 0.12),
              ),
            ),
          Center(
            child: Container(
              width: fullPreview ? 270 : 112,
              padding: EdgeInsets.all(fullPreview ? 22 : 10),
              decoration: BoxDecoration(
                color: _darkMode
                    ? const Color(0xFF172033)
                    : const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.12),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_logoBytes != null)
                    Image.memory(
                      _logoBytes!,
                      height: fullPreview ? 38 : 18,
                      fit: BoxFit.contain,
                    )
                  else
                    Text(
                      _companyController.text.isEmpty
                          ? 'YOUR COMPANY'
                          : _companyController.text.toUpperCase(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: fullPreview ? 14 : 8,
                        fontWeight: FontWeight.w800,
                        color: _primaryColor,
                      ),
                    ),
                  SizedBox(height: fullPreview ? 18 : 7),
                  Container(
                    height: fullPreview ? 12 : 7,
                    decoration: BoxDecoration(
                      color: _darkMode
                          ? const Color(0xFF344155)
                          : const Color(0xFFE0E7EF),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    height: fullPreview ? 12 : 7,
                    decoration: BoxDecoration(
                      color: _darkMode
                          ? const Color(0xFF344155)
                          : const Color(0xFFE0E7EF),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  SizedBox(height: fullPreview ? 15 : 5),
                  Container(
                    height: fullPreview ? 36 : 12,
                    decoration: BoxDecoration(
                      color: _primaryColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (fullPreview)
            Positioned(
              left: 12,
              right: 12,
              bottom: 12,
              child: Text(
                _welcomeController.text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  shadows: [Shadow(blurRadius: 4, color: Colors.black54)],
                ),
              ),
            ),
          if (onClose != null)
            Positioned(
              right: 4,
              top: 4,
              child: IconButton(
                onPressed: onClose,
                icon: const Icon(Icons.close, color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }

  Widget _welcomeMessageCard() {
    return _section(
      title: 'Welcome Message',
      icon: Icons.chat_bubble_outline,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _label('Welcome Message'),
          const SizedBox(height: 7),
          TextFormField(
            controller: _welcomeController,
            maxLines: 3,
            maxLength: 250,
            onChanged: (_) => setState(() {}),
            decoration: _decoration(hint: 'Enter welcome message'),
            validator: (value) =>
                value == null || value.trim().isEmpty
                    ? 'Welcome message is required'
                    : null,
          ),
        ],
      ),
    );
  }

  Widget _themeSettings(bool mobile) {
    return _section(
      title: 'Theme Configuration',
      icon: Icons.palette_outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: _modeButton(
                  'Light mode',
                  selected: !_darkMode,
                  onPressed: () => setState(() => _darkMode = false),
                  icon: Icons.light_mode_outlined,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _modeButton(
                  'Dark mode',
                  selected: _darkMode,
                  onPressed: () => setState(() => _darkMode = true),
                  icon: Icons.dark_mode_outlined,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (!mobile)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _colorField(
                    'Primary Color',
                    _primaryColor,
                    _primaryHexController,
                    'primary',
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: _colorField(
                    'Secondary Color',
                    _secondaryColor,
                    _secondaryHexController,
                    'secondary',
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: _colorField(
                    'Accent Color',
                    _accentColor,
                    _accentHexController,
                    'accent',
                  ),
                ),
              ],
            )
          else
            Column(
              children: [
                _colorField(
                  'Primary Color',
                  _primaryColor,
                  _primaryHexController,
                  'primary',
                ),
                const SizedBox(height: 14),
                _colorField(
                  'Secondary Color',
                  _secondaryColor,
                  _secondaryHexController,
                  'secondary',
                ),
                const SizedBox(height: 14),
                _colorField(
                  'Accent Color',
                  _accentColor,
                  _accentHexController,
                  'accent',
                ),
              ],
            ),
          const SizedBox(height: 12),
          const Text(
            'Changes update the login preview immediately.',
            style: TextStyle(fontSize: 11, color: TUi.muted),
          ),
        ],
      ),
    );
  }

  Widget _colorField(
    String label,
    Color color,
    TextEditingController controller,
    String type,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label(label),
        const SizedBox(height: 7),
        Row(
          children: [
            InkWell(
              onTap: () => _chooseColor(type),
              borderRadius: BorderRadius.circular(7),
              child: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: color,
                  border: Border.all(color: _lineColor),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Icon(
                  Icons.colorize,
                  size: 16,
                  color: color.computeLuminance() > 0.5
                      ? Colors.black54
                      : Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: TextFormField(
                controller: controller,
                style: TextStyle(
                  fontSize: 12,
                  color: _mainTextColor,
                ),
                onChanged: (value) => _updateColor(type, value),
                decoration: _decoration(hint: '#1976D2'),
                validator: (value) =>
                    _parseHex(value ?? '', Colors.transparent) ==
                            Colors.transparent
                        ? 'Use #RRGGBB'
                        : null,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _footerInformation(bool mobile) {
    return _section(
      title: 'Footer & Copyright',
      icon: Icons.short_text,
      badge: mobile ? null : 'Basic Info',
      child: _responsiveFields(
        mobile: mobile,
        children: [
          _textInput(
            'Footer Text',
            _footerController,
            maxLength: 200,
          ),
          _textInput(
            'Copyright Text',
            _copyrightController,
            maxLength: 200,
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
            if (i < children.length - 1) const SizedBox(height: 14),
          ],
        ],
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Wrap(
          spacing: 14,
          runSpacing: 14,
          children: children.map((child) {
            return SizedBox(
              width: (constraints.maxWidth - 14) / 2,
              child: child,
            );
          }).toList(),
        );
      },
    );
  }

  Widget _section({
    required String title,
    IconData? icon,
    String? badge,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: _cardColor,
        border: Border.all(color: _lineColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: _stripColor,
              border: Border(bottom: BorderSide(color: _dividerColor)),
            ),
            child: Row(
              children: [
                if (icon != null) ...[
                  Icon(
                    icon,
                    size: 16,
                    color: _darkMode ? Colors.white70 : TUi.accent,
                  ),
                  const SizedBox(width: 8),
                ],
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: _mainTextColor,
                    ),
                  ),
                ),
                if (badge != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _darkMode
                          ? const Color(0xFF344155)
                          : const Color(0xFFE8EEFF),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      badge,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: _darkMode
                            ? Colors.white70
                            : const Color(0xFF3B5BDB),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: child,
          ),
        ],
      ),
    );
  }

  Widget _textInput(
    String label,
    TextEditingController controller, {
    bool requiredField = false,
    int? maxLength,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label(label, requiredField: requiredField),
        const SizedBox(height: 7),
        TextFormField(
          controller: controller,
          maxLength: maxLength,
          style: TextStyle(fontSize: 13, color: _mainTextColor),
          decoration: _decoration(hint: 'Enter $label'),
          validator: requiredField
              ? (value) =>
                  value == null || value.trim().isEmpty
                      ? '$label is required'
                      : null
              : null,
        ),
      ],
    );
  }

  Widget _dropdown({
    String? label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          _label(label),
          const SizedBox(height: 6),
        ],
        DropdownButtonFormField<String>(
          value: value,
          isExpanded: true,
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 18,
            color: _mutedColorForTheme(),
          ),
          dropdownColor: _darkMode ? const Color(0xFF273449) : Colors.white,
          style: TextStyle(fontSize: 13, color: _mainTextColor),
          decoration: _decoration(),
          items: items.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item, overflow: TextOverflow.ellipsis),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _modeButton(
    String title, {
    required bool selected,
    required VoidCallback onPressed,
    required IconData icon,
  }) {
    return SizedBox(
      height: 40,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: selected
              ? (_darkMode ? const Color(0xFF344155) : const Color(0xFFF1F5FF))
              : _cardColor,
          foregroundColor: selected && !_darkMode ? TUi.blue : _mainTextColor,
          side: BorderSide(color: selected ? TUi.blue : _controlLine),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 16),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _button(
    String label, {
    required VoidCallback onPressed,
    bool outlined = false,
    IconData? icon,
    double height = 34,
    bool loading = false,
  }) {
    if (!outlined) {
      return TButton(
        label,
        icon: icon,
        onPressed: onPressed,
        kind: TButtonKind.primary,
        height: height,
        loading: loading,
        expand: height > 40,
      );
    }

    return SizedBox(
      height: height,
      width: height > 40 ? double.infinity : null,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: _darkMode ? Colors.white : TUi.buttonText,
          backgroundColor: _darkMode ? const Color(0xFF1F2937) : Colors.white,
          side: BorderSide(color: _controlLine),
          padding: const EdgeInsets.symmetric(horizontal: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 16),
              const SizedBox(width: 6),
            ],
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _selectedFileRow(
    String name, {
    required VoidCallback onRemove,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle_outline,
            size: 16,
            color: TUi.green,
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              name,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12, color: _mutedColorForTheme()),
            ),
          ),
          IconButton(
            tooltip: 'Remove image',
            onPressed: onRemove,
            icon: const Icon(Icons.close, size: 16),
            visualDensity: VisualDensity.compact,
          ),
        ],
      ),
    );
  }

  Widget _label(String text, {bool requiredField = false}) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: _darkMode ? Colors.white : const Color(0xFF334155),
            ),
          ),
          if (requiredField)
            const TextSpan(
              text: ' *',
              style: TextStyle(color: TUi.red),
            ),
        ],
      ),
    );
  }

  InputDecoration _decoration({String? hint}) {
    OutlineInputBorder outline(Color color, [double width = 1]) {
      return OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide(color: color, width: width),
      );
    }

    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: _mutedColorForTheme(), fontSize: 13),
      filled: true,
      fillColor: _inputColor,
      isDense: true,
      constraints: const BoxConstraints(minHeight: 44),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      counterStyle: TextStyle(fontSize: 11, color: _mutedColorForTheme()),
      border: outline(_controlLine),
      enabledBorder: outline(_controlLine),
      focusedBorder: outline(TUi.blue, 1.4),
      errorBorder: outline(TUi.red),
      focusedErrorBorder: outline(TUi.red, 1.4),
      errorStyle: const TextStyle(fontSize: 11, color: TUi.red),
    );
  }

  Color _mutedColorForTheme() => _darkMode ? Colors.white60 : TUi.muted;
}