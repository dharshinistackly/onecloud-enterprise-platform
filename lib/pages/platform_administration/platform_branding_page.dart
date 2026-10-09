import 'package:flutter/material.dart';

import 'package:one_cloud_enterprise/routes/app_routes.dart';
import 'package:one_cloud_enterprise/widgets/platform_branding_dialogs.dart';

/// Platform Branding
///
/// Content-only page.
/// No header / sidebar is included here.
///
/// Mobile  : below 900px
/// Desktop : 900px and above
class PlatformBrandingPage extends StatefulWidget {
  const PlatformBrandingPage({super.key});

  @override
  State<PlatformBrandingPage> createState() =>
      _PlatformBrandingPageState();
}

// ---------------------------------------------------------------------------
// DESIGN TOKENS
// ---------------------------------------------------------------------------

const _ink = Color(0xFF172536);
const _muted = Color(0xFF61758A);
const _hint = Color(0xFF8A9AB0);
const _border = Color(0xFFE1E7EF);
const _bg = Color(0xFFF7F9FC);
const _blue = Color(0xFF1B3FE0);
const _fieldBorder = Color(0xFFD8E0E8);
const _headerFill = Color(0xFFF8FAFC);
const _danger = Color(0xFFE11D48);
const _success = Color(0xFF2DA65A);

class _PlatformBrandingPageState
    extends State<PlatformBrandingPage> {
  // -------------------------------------------------------------------------
  // INITIAL VALUES
  // -------------------------------------------------------------------------

  static const _initial = {
    'platform': 'Java Enterprise Suite',
    'company': 'Oracle Corporation',
    'tagline': 'Empowering Enterprise Intelligence',
    'footer': 'System Maintained by IT Dept.',
    'copyright': '© 2024 platform branding. All rights reserved.',
    'welcome':
        'Welcome to Java Enterprise Suite. Please authenticate to continue.',
    'primary': '#1976D2',
    'secondary': '#FFFFFF',
    'accent': '#4CAF50',
  };

  late final Map<String, TextEditingController> _c = {
    for (final e in _initial.entries)
      e.key: TextEditingController(text: e.value),
  };

  bool _dark = false;

  String _lastSaved = '2 mins ago';

  String _faviconName = 'No file chosen';
  String _emailLogoName = 'No file chosen';

  String _selectedBackground = 'Glass Gradient';

  @override
  void initState() {
    super.initState();

    for (final key in ['primary', 'secondary', 'accent']) {
      _c[key]!.addListener(_refresh);
    }
  }

  void _refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    for (final controller in _c.values) {
      controller.dispose();
    }

    super.dispose();
  }

  // -------------------------------------------------------------------------
  // CANCEL
  // -------------------------------------------------------------------------

  void _cancel() {
    setState(() {
      _c.forEach((key, controller) {
        controller.text = _initial[key]!;
      });

      _dark = false;

      _faviconName = 'No file chosen';
      _emailLogoName = 'No file chosen';

      _selectedBackground = 'Glass Gradient';
    });
  }

  // -------------------------------------------------------------------------
  // SAVE
  // -------------------------------------------------------------------------

  Future<void> _save() async {
    final errors = _validate();

    if (errors.isNotEmpty) {
      await showBrandingValidationErrorDialog(
        context,
        errors: errors,
      );

      return;
    }

    setState(() {
      _lastSaved = 'just now';
    });

    await showBrandingSaveSuccessDialog(context);

    // After the "Changes saved" pop-up is closed, redirect to the
    // Super Admin Dashboard (home page).
    if (!mounted) return;
    _goHome();
  }

  /// Leaves this page and lands on the home page (Super Admin Dashboard).
  void _goHome() {
    final navigator = Navigator.of(context);
    var atHome = false;

    navigator.popUntil((route) {
      atHome = route.settings.name == AppRoutes.home;
      return atHome || route.isFirst;
    });

    if (!atHome) {
      navigator.pushReplacementNamed(AppRoutes.home);
    }
  }

  // -------------------------------------------------------------------------
  // VALIDATION
  // -------------------------------------------------------------------------

  List<String> _validate() {
    final errors = <String>[];

    if (_c['platform']!.text.trim().isEmpty) {
      errors.add('Platform Name is required.');
    }

    if (_c['company']!.text.trim().isEmpty) {
      errors.add('Company Name is required.');
    }

    if (_c['tagline']!.text.trim().isEmpty) {
      errors.add('Tagline is required.');
    }

    if (_hex(_c['primary']!.text) == null) {
      errors.add('Primary Color must be a valid HEX value.');
    }

    if (_hex(_c['secondary']!.text) == null) {
      errors.add('Secondary Color must be a valid HEX value.');
    }

    if (_hex(_c['accent']!.text) == null) {
      errors.add('Accent Color must be a valid HEX value.');
    }

    if (_c['welcome']!.text.length > 250) {
      errors.add('Welcome Message cannot exceed 250 characters.');
    }

    return errors;
  }

  // -------------------------------------------------------------------------
  // PREVIEW
  // -------------------------------------------------------------------------

  Future<void> _preview() async {
    // Phone: full-screen page with Cancel / Save. Desktop: pop-up.
    final saveRequested = await openBrandingPreview(
      context,
      platformName: _c['platform']!.text,
      companyName: _c['company']!.text,
      tagline: _c['tagline']!.text,
      welcomeMessage: _c['welcome']!.text,
      background: _selectedBackground,
      primaryColor: _hex(_c['primary']!.text) ?? _blue,
      footerText: _c['footer']!.text,
      copyrightText: _c['copyright']!.text,
    );

    if (saveRequested == true && mounted) {
      await _save();
    }
  }

  // -------------------------------------------------------------------------
  // FAVICON
  // -------------------------------------------------------------------------

  Future<void> _openFaviconDialog() async {
    final result = await showUploadFaviconDialog(context);

    if (result == null) return;

    setState(() {
      _faviconName = result.fileName;
    });
  }

  // -------------------------------------------------------------------------
  // EMAIL LOGO
  // -------------------------------------------------------------------------

  Future<void> _openEmailLogoDialog() async {
    final result = await showUploadEmailLogoDialog(context);

    if (result == null) return;

    setState(() {
      _emailLogoName = result.fileName;
    });
  }

  // -------------------------------------------------------------------------
  // BACKGROUND
  // -------------------------------------------------------------------------

  Future<void> _openBackgroundDialog() async {
    final result = await openBackgroundImagePicker(
      context,
      selected: _selectedBackground,
    );

    if (result == null) return;

    setState(() {
      _selectedBackground = result;
    });
  }

  // -------------------------------------------------------------------------
  // COLOR PICKER
  // -------------------------------------------------------------------------

  Future<void> _openColorPicker(String key) async {
    final initialColor =
        _hex(_c[key]!.text) ?? _blue;

    final result = await showBrandingColorPickerDialog(
      context,
      initialColor: initialColor,
    );

    if (result == null) return;

    _c[key]!.text = _toHex(result);

    setState(() {});
  }

  // -------------------------------------------------------------------------
  // HEX
  // -------------------------------------------------------------------------

  static Color? _hex(String value) {
    final valueWithoutHash =
        value.trim().replaceFirst('#', '');

    if (valueWithoutHash.length != 6) {
      return null;
    }

    final number =
        int.tryParse(valueWithoutHash, radix: 16);

    if (number == null) {
      return null;
    }

    return Color(0xFF000000 | number);
  }

  static String _toHex(Color color) {
    return '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
  }

  // -------------------------------------------------------------------------
  // BUILD
  // -------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final mobile =
                constraints.maxWidth < 900;

            return SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                mobile ? 16 : 24,
                mobile ? 16 : 24,
                mobile ? 16 : 24,
                28,
              ),
              child: mobile
                  ? _mobile()
                  : _desktop(),
            );
          },
        ),
      ),
    );
  }

  // =========================================================================
  // MOBILE
  // =========================================================================

  Widget _mobile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Platform Administration / Platform Branding',
          style: TextStyle(
            fontSize: 10,
            color: _hint,
          ),
        ),

        const SizedBox(height: 8),

        const Text(
          'Platform Branding',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: _ink,
          ),
        ),

        const SizedBox(height: 16),

        _card(
          title: 'Platform Identity',
          trailing: const Text(
            'Basic Info',
            style: TextStyle(
              fontSize: 10,
              color: _hint,
            ),
          ),
          child: Column(
            children: [
              _field(
                'Platform Name',
                'platform',
              ),

              const SizedBox(height: 14),

              _field(
                'Company Name',
                'company',
              ),

              const SizedBox(height: 14),

              _field(
                'Tagline',
                'tagline',
              ),
            ],
          ),
        ),

        // -------------------------------------------------------------------
        // VISUAL ASSETS
        // -------------------------------------------------------------------

        _card(
          title: 'Visual Assets',
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Row(
                children: const [
                  Expanded(
                    child: _Label('Company Logo'),
                  ),
                  Text(
                    'PNG, SVG up to 5MB',
                    style: TextStyle(
                      fontSize: 10,
                      color: _hint,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              _logoDropZone(
                height: 110,
                compact: true,
              ),

              const SizedBox(height: 16),

              const _Label('Favicon'),

              const SizedBox(height: 8),

              _faviconRow(),

              const SizedBox(height: 6),

              Text(
                _faviconName,
                style: const TextStyle(
                  fontSize: 9,
                  color: _hint,
                ),
              ),

              const SizedBox(height: 16),

              const _Label(
                'Email Header Logo',
              ),

              const SizedBox(height: 8),

              _fileRow(),
            ],
          ),
        ),

        // -------------------------------------------------------------------
        // FOOTER
        // -------------------------------------------------------------------

        _card(
          title: 'Footer & Copyright',
          child: Column(
            children: [
              _field(
                'Footer Text',
                'footer',
                maxLength: 200,
                counterBelow: true,
              ),

              const SizedBox(height: 12),

              _field(
                'Copyright Text',
                'copyright',
              ),
            ],
          ),
        ),

        // -------------------------------------------------------------------
        // LOGIN BACKGROUND
        // -------------------------------------------------------------------

        _card(
          title: 'Login Background',
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: _Label('Preview'),
                  ),
                  _link(
                    'Change Image',
                    _openBackgroundDialog,
                  ),
                ],
              ),

              const SizedBox(height: 10),

              _loginPreview(
                height: 180,
                rounded: true,
              ),

              const SizedBox(height: 8),

              Text(
                _selectedBackground,
                style: const TextStyle(
                  fontSize: 10,
                  color: _hint,
                ),
              ),
            ],
          ),
        ),

        // -------------------------------------------------------------------
        // WELCOME
        // -------------------------------------------------------------------

        _card(
          title: 'Welcome Message',
          child: _field(
            'Welcome Message',
            'welcome',
            maxLines: 3,
            maxLength: 250,
            minHeight: 84,
          ),
        ),

        // -------------------------------------------------------------------
        // SECURITY
        // -------------------------------------------------------------------

        _card(
          title: 'Security & Rules',
          child: _rules(mobile: true),
        ),

        // -------------------------------------------------------------------
        // THEME
        // -------------------------------------------------------------------

        _card(
          title: 'Theme Configuration',
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: _themeButton(
                      'Light mode',
                      false,
                      true,
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: _themeButton(
                      'Dark mode',
                      true,
                      true,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              _colorField(
                'Primary Color',
                'primary',
              ),

              const SizedBox(height: 14),

              _colorField(
                'Secondary Color',
                'secondary',
              ),

              const SizedBox(height: 14),

              _colorField(
                'Accent Color',
                'accent',
              ),

              const SizedBox(height: 14),

              Text(
                'Last saved: $_lastSaved',
                style: const TextStyle(
                  fontSize: 10,
                  color: _hint,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 4),

        Row(
          children: [
            Expanded(
              child: _btn(
                'Preview',
                onTap: _preview,
                outlined: true,
              ),
            ),

            const SizedBox(width: 10),

            Expanded(
              child: _btn(
                'Save',
                onTap: _save,
                primary: true,
                icon: Icons.save_outlined,
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),

        SizedBox(
          width: double.infinity,
          child: _btn(
            'Cancel',
            onTap: _cancel,
          ),
        ),
      ],
    );
  }

  // =========================================================================
  // DESKTOP
  // =========================================================================

  Widget _desktop() {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Text(
              'Platform Administration',
              style: TextStyle(
                fontSize: 12,
                color: _muted,
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 6),
              child: Text(
                '/',
                style: TextStyle(
                  fontSize: 12,
                  color: _muted,
                ),
              ),
            ),
            Text(
              'Platform Branding',
              style: TextStyle(
                fontSize: 12,
                color: _ink,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),

        Row(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            const Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    'Platform Branding',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: _ink,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Configure your enterprise platform to create a consistent and recognizable brand experience.',
                    style: TextStyle(
                      fontSize: 13,
                      color: _ink,
                    ),
                  ),
                ],
              ),
            ),

            _btn(
              'Cancel',
              onTap: _cancel,
              height: 40,
            ),

            const SizedBox(width: 10),

            _btn(
              'Preview',
              onTap: _preview,
              outlined: true,
              height: 40,
            ),

            const SizedBox(width: 10),

            _btn(
              'Save Changes',
              onTap: _save,
              primary: true,
              icon: Icons.save_outlined,
              height: 40,
            ),
          ],
        ),

        const SizedBox(height: 20),

        Row(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 63,
              child: _desktopMain(),
            ),

            const SizedBox(width: 20),

            Expanded(
              flex: 37,
              child: _desktopSide(),
            ),
          ],
        ),
      ],
    );
  }

  // =========================================================================
  // DESKTOP MAIN
  // =========================================================================

  Widget _desktopMain() {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        _card(
          title: 'Platform Identity',
          big: true,
          trailing: Container(
            padding:
                const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF2F6),
              borderRadius:
                  BorderRadius.circular(4),
            ),
            child: const Text(
              'Basic Info',
              style: TextStyle(
                fontSize: 11,
                color: _muted,
              ),
            ),
          ),
          child: Column(
            children: [
              _field(
                'Platform Name',
                'platform',
              ),

              const SizedBox(height: 14),

              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _field(
                      'Company Name',
                      'company',
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: _field(
                      'Tagline',
                      'tagline',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // -------------------------------------------------------------------
        // VISUAL ASSETS
        // -------------------------------------------------------------------

        _card(
          title: 'Visual Assets',
          big: true,
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Icon(
                              Icons.image_outlined,
                              size: 14,
                              color: _ink,
                            ),
                            SizedBox(width: 6),
                            Expanded(
                              child: _Label(
                                'Company Logo',
                              ),
                            ),
                            Text(
                              'PNG, SVG up to 5MB',
                              style: TextStyle(
                                fontSize: 10,
                                color: _hint,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),

                        _logoDropZone(
                          height: 160,
                          compact: false,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        const _Label('Favicon'),

                        const SizedBox(height: 8),

                        _faviconRow(),

                        const SizedBox(height: 6),

                        Text(
                          _faviconName,
                          style: const TextStyle(
                            fontSize: 9,
                            color: _hint,
                          ),
                        ),

                        const SizedBox(height: 22),

                        const _Label(
                          'Email Header Logo',
                        ),

                        const SizedBox(height: 8),

                        _fileRow(),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _field(
                      'Footer Text',
                      'footer',
                      maxLines: 2,
                      maxLength: 200,
                      minHeight: 64,
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: _field(
                      'Copyright Text',
                      'copyright',
                      maxLines: 2,
                      minHeight: 64,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // -------------------------------------------------------------------
        // THEME
        // -------------------------------------------------------------------

        _card(
          title: 'Theme Configuration',
          big: true,
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'Theme',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: _ink,
                    ),
                  ),

                  const SizedBox(width: 16),

                  Container(
                    padding:
                        const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEEF1F5),
                      borderRadius:
                          BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize:
                          MainAxisSize.min,
                      children: [
                        _themeButton(
                          'Light mode',
                          false,
                          false,
                        ),
                        _themeButton(
                          'Dark mode',
                          true,
                          false,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _colorField(
                      'Primary Color',
                      'primary',
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: _colorField(
                      'Secondary Color',
                      'secondary',
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: _colorField(
                      'Accent Color',
                      'accent',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        Row(
          children: [
            const Icon(
              Icons.history,
              size: 15,
              color: _muted,
            ),

            const SizedBox(width: 10),

            Text(
              'Last saved: $_lastSaved',
              style: const TextStyle(
                fontSize: 12,
                color: _muted,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // =========================================================================
  // DESKTOP SIDE
  // =========================================================================

  Widget _desktopSide() {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        _card(
          title: 'Login Background',
          big: true,
          trailing: _link(
            'Change Image',
            _openBackgroundDialog,
          ),
          bodyPadding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              _loginPreview(
                height: 300,
                rounded: false,
              ),

              Padding(
                padding:
                    const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    _field(
                      'Welcome Message',
                      'welcome',
                      maxLines: 3,
                      maxLength: 250,
                      minHeight: 72,
                    ),

                    const SizedBox(height: 6),

                    Text(
                      'Background: $_selectedBackground',
                      style: const TextStyle(
                        fontSize: 10,
                        color: _hint,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // -------------------------------------------------------------------
        // SECURITY
        // -------------------------------------------------------------------

        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFFEEF3FA),
            borderRadius:
                BorderRadius.circular(14),
            border: Border.all(
              color: _border,
            ),
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Row(
                children: const [
                  Icon(
                    Icons.shield_outlined,
                    size: 20,
                    color: _muted,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Security & Rules',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF5A6B80),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              _rules(mobile: false),
            ],
          ),
        ),
      ],
    );
  }

  // =========================================================================
  // CARD
  // =========================================================================

  Widget _card({
    required String title,
    required Widget child,
    Widget? trailing,
    bool big = false,
    EdgeInsets? bodyPadding,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(
        bottom: 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(big ? 12 : 10),
        border: Border.all(
          color: _border,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            decoration: const BoxDecoration(
              color: _headerFill,
              border: Border(
                bottom: BorderSide(
                  color: _border,
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: big ? 18 : 15,
                      fontWeight: big
                          ? FontWeight.w500
                          : FontWeight.w700,
                      color: _ink,
                    ),
                  ),
                ),

                if (trailing != null)
                  trailing,
              ],
            ),
          ),

          Padding(
            padding:
                bodyPadding ??
                    const EdgeInsets.all(16),
            child: child,
          ),
        ],
      ),
    );
  }

  // =========================================================================
  // RULES
  // =========================================================================

  Widget _rules({
    required bool mobile,
  }) {
    Widget item(
      IconData icon,
      String text,
    ) {
      return Padding(
        padding:
            const EdgeInsets.only(bottom: 12),
        child: Row(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              size: 16,
              color: _muted,
            ),

            const SizedBox(width: 10),

            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: mobile ? 12 : 13,
                  height: 1.35,
                  color:
                      const Color(0xFF4A5A6E),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget heading(String text) {
      return Padding(
        padding:
            const EdgeInsets.only(bottom: 10),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 11,
            fontWeight: mobile
                ? FontWeight.w600
                : FontWeight.w700,
            letterSpacing: .8,
            color: mobile ? _hint : _ink,
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        if (!mobile)
          heading('VALIDATION RULES'),

        item(
          Icons.check_circle_outline,
          'Images: PNG, JPG, SVG max 5MB. Background max 10MB.',
        ),

        item(
          Icons.check_circle_outline,
          'Text fields max 100 chars; Messages max 250 chars.',
        ),

        item(
          Icons.check_circle_outline,
          'Colors must be valid hex values.',
        ),

        const Divider(
          height: 20,
          color: Color(0xFFD5DCE6),
        ),

        heading('SECURITY HANDLING'),

        item(
          Icons.gpp_maybe_outlined,
          'Super Admin (RBAC) access only.',
        ),

        item(
          Icons.history,
          'All changes logged to Audit Trail.',
        ),
      ],
    );
  }

  // =========================================================================
  // FIELD
  // =========================================================================

  Widget _field(
    String label,
    String key, {
    int maxLines = 1,
    int? maxLength,
    double? minHeight,
    bool counterBelow = false,
  }) {
    final controller = _c[key]!;

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        _Label(label),

        const SizedBox(height: 6),

        ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: minHeight ?? 44,
          ),
          child: TextField(
            controller: controller,
            maxLines: maxLines,
            minLines: maxLines,
            maxLength: maxLength,
            onChanged: (_) => setState(() {}),
            style: const TextStyle(
              fontSize: 14,
              color: _ink,
            ),
            buildCounter: (
              context, {
              required currentLength,
              required isFocused,
              maxLength,
            }) {
              if (maxLength == null ||
                  counterBelow) {
                return null;
              }

              return Text(
                '$currentLength/$maxLength',
                style: const TextStyle(
                  fontSize: 10,
                  color: _hint,
                ),
              );
            },
            decoration: InputDecoration(
              isDense: true,
              contentPadding:
                  const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 13,
              ),
              enabledBorder:
                  OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(6),
                borderSide:
                    const BorderSide(
                  color: _fieldBorder,
                ),
              ),
              focusedBorder:
                  OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(6),
                borderSide:
                    const BorderSide(
                  color: _blue,
                ),
              ),
            ),
          ),
        ),

        if (counterBelow &&
            maxLength != null)
          Padding(
            padding:
                const EdgeInsets.only(top: 4),
            child: Text(
              '${controller.text.length}/$maxLength',
              style: const TextStyle(
                fontSize: 10,
                color: _hint,
              ),
            ),
          ),
      ],
    );
  }

  // =========================================================================
  // COLOR FIELD
  // =========================================================================

  Widget _colorField(
    String label,
    String key,
  ) {
    final color =
        _hex(_c[key]!.text);

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        _Label(label),

        const SizedBox(height: 6),

        Row(
          children: [
            InkWell(
              onTap: () => _openColorPicker(key),
              borderRadius:
                  BorderRadius.circular(6),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color:
                      color ?? Colors.white,
                  borderRadius:
                      BorderRadius.circular(6),
                  border: Border.all(
                    color: color == null
                        ? _danger
                        : _fieldBorder,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 10),

            Expanded(
              child: SizedBox(
                height: 40,
                child: TextField(
                  controller: _c[key],
                  onChanged: (_) =>
                      setState(() {}),
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 13,
                  ),
                  decoration:
                      InputDecoration(
                    isDense: true,
                    contentPadding:
                        const EdgeInsets
                            .symmetric(
                      horizontal: 12,
                      vertical: 11,
                    ),
                    enabledBorder:
                        OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(6),
                      borderSide:
                          BorderSide(
                        color: color == null
                            ? _danger
                            : _fieldBorder,
                      ),
                    ),
                    focusedBorder:
                        OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(6),
                      borderSide:
                          const BorderSide(
                        color: _blue,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // =========================================================================
  // COMPANY LOGO
  // =========================================================================

  Widget _logoDropZone({
    required double height,
    required bool compact,
  }) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF6F8FB),
        borderRadius:
            BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFFB8C4D2),
        ),
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisSize:
            MainAxisSize.min,
        children: [
          if (!compact)
            const Padding(
              padding:
                  EdgeInsets.only(right: 6),
              child: Icon(
                Icons.bolt,
                color: Color(0xFF2F6FE4),
                size: 30,
              ),
            ),

          const Text(
            'SYNERGY',
            style: TextStyle(
              fontSize: 18,
              fontWeight:
                  FontWeight.w800,
              color: Color(0xFF4F46E5),
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================================
  // FAVICON
  // =========================================================================

  Widget _faviconRow() {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xFFF1F4F8),
            borderRadius:
                BorderRadius.circular(8),
            border: Border.all(
              color: _fieldBorder,
            ),
          ),
          child: const Icon(
            Icons.image_outlined,
            size: 18,
            color: _hint,
          ),
        ),

        const SizedBox(width: 12),

        _btn(
          'Upload Favicon',
          onTap: _openFaviconDialog,
          outlined: true,
          height: 34,
        ),
      ],
    );
  }

  // =========================================================================
  // EMAIL HEADER LOGO
  // =========================================================================

  Widget _fileRow() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 44,
            padding:
                const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            alignment:
                Alignment.centerLeft,
            decoration: BoxDecoration(
              color:
                  const Color(0xFFF4F6F9),
              borderRadius:
                  BorderRadius.circular(6),
              border: Border.all(
                color: _fieldBorder,
              ),
            ),
            child: Text(
              _emailLogoName,
              style: const TextStyle(
                fontSize: 13,
                color: _hint,
              ),
              overflow:
                  TextOverflow.ellipsis,
            ),
          ),
        ),

        const SizedBox(width: 12),

        _btn(
          'Upload File',
          onTap: _openEmailLogoDialog,
          outlined: true,
          height: 34,
        ),
      ],
    );
  }

  // =========================================================================
  // LOGIN PREVIEW
  // =========================================================================

  Widget _loginPreview({
    required double height,
    required bool rounded,
  }) {
    final option =
        brandingBackgroundOptions.firstWhere(
      (item) =>
          item.name == _selectedBackground,
      orElse: () =>
          brandingBackgroundOptions[1],
    );

    return ClipRRect(
      borderRadius:
          BorderRadius.circular(
        rounded ? 10 : 0,
      ),
      child: Container(
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: option.colors,
          ),
        ),
        alignment: Alignment.center,
        child: Container(
          width: height * .65,
          padding:
              const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color:
                const Color(0xFFF1F4F9),
            borderRadius:
                BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize:
                MainAxisSize.min,
            children: [
              _bar(
                const Color(0xFFD6DCE6),
                6,
                width: 46,
                left: true,
              ),

              const SizedBox(height: 8),

              _bar(
                const Color(0xFFD6DCE6),
                10,
              ),

              const SizedBox(height: 6),

              _bar(
                const Color(0xFFD6DCE6),
                10,
              ),

              const SizedBox(height: 10),

              _bar(
                _hex(
                      _c['primary']!.text,
                    ) ??
                    _blue,
                14,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bar(
    Color color,
    double height, {
    double? width,
    bool left = false,
  }) {
    final box = Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius:
            BorderRadius.circular(3),
      ),
    );

    return left
        ? Align(
            alignment:
                Alignment.centerLeft,
            child: box,
          )
        : box;
  }

  // =========================================================================
  // LINK
  // =========================================================================

  Widget _link(
    String text,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight:
              FontWeight.w600,
          color: _blue,
        ),
      ),
    );
  }

  // =========================================================================
  // THEME BUTTON
  // =========================================================================

  Widget _themeButton(
    String label,
    bool dark,
    bool mobile,
  ) {
    final selected =
        _dark == dark;

    final icon = dark
        ? Icons.dark_mode_outlined
        : Icons.light_mode_outlined;

    final child = Row(
      mainAxisAlignment:
          MainAxisAlignment.center,
      mainAxisSize:
          MainAxisSize.min,
      children: [
        if (!mobile) ...[
          Icon(
            icon,
            size: 14,
            color:
                selected ? _ink : _hint,
          ),
          const SizedBox(width: 6),
        ],

        Text(
          label,
          style: TextStyle(
            fontSize:
                mobile ? 13 : 12,
            fontWeight: selected
                ? FontWeight.w600
                : FontWeight.w500,
            color:
                selected ? _ink : _hint,
          ),
        ),
      ],
    );

    return InkWell(
      onTap: () {
        setState(() {
          _dark = dark;
        });
      },
      borderRadius:
          BorderRadius.circular(6),
      child: Container(
        height: mobile ? 42 : 30,
        padding:
            EdgeInsets.symmetric(
          horizontal:
              mobile ? 0 : 12,
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected
              ? Colors.white
              : (mobile
                  ? const Color(
                      0xFFF1F4F8,
                    )
                  : Colors.transparent),
          borderRadius:
              BorderRadius.circular(6),
          border: mobile
              ? Border.all(
                  color: selected
                      ? _fieldBorder
                      : const Color(
                          0xFFE6EBF1,
                        ),
                )
              : null,
        ),
        child: child,
      ),
    );
  }

  // =========================================================================
  // BUTTON
  // =========================================================================

  Widget _btn(
    String label, {
    required VoidCallback onTap,
    bool primary = false,
    bool outlined = false,
    IconData? icon,
    double height = 44,
  }) {
    final shape =
        RoundedRectangleBorder(
      borderRadius:
          BorderRadius.circular(6),
    );

    final text = Text(
      label,
      style: TextStyle(
        fontSize:
            height <= 34 ? 11 : 13,
        fontWeight:
            FontWeight.w600,
      ),
    );

    if (primary) {
      return SizedBox(
        height: height,
        child: ElevatedButton.icon(
          onPressed: onTap,
          icon: Icon(
            icon ?? Icons.check,
            size: 17,
          ),
          label: text,
          style:
              ElevatedButton.styleFrom(
            backgroundColor: _blue,
            foregroundColor:
                Colors.white,
            elevation: 0,
            shape: shape,
          ),
        ),
      );
    }

    return SizedBox(
      height: height,
      child: OutlinedButton(
        onPressed: onTap,
        style:
            OutlinedButton.styleFrom(
          foregroundColor: outlined
              ? _blue
              : _ink,
          backgroundColor:
              Colors.white,
          padding:
              const EdgeInsets.symmetric(
            horizontal: 18,
          ),
          side: BorderSide(
            color: outlined
                ? _blue
                : _fieldBorder,
          ),
          shape: shape,
        ),
        child: text,
      ),
    );
  }
}

// =============================================================================
// SMALL LABEL
// =============================================================================

class _Label extends StatelessWidget {
  final String text;

  const _Label(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: _ink,
      ),
    );
  }
}