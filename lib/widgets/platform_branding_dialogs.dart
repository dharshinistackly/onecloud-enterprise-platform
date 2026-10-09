import 'package:flutter/material.dart';

const _dialogBlue = Color(0xFF1B3FE0);
const _dialogInk = Color(0xFF172536);
const _dialogMuted = Color(0xFF61758A);
const _dialogHint = Color(0xFF8A9AB0);
const _dialogBorder = Color(0xFFE1E7EF);
const _dialogFieldBorder = Color(0xFFD8E0E8);

/// ---------------------------------------------------------------------------
/// UPLOAD FILE RESULT
/// ---------------------------------------------------------------------------

class BrandingFileResult {
  final String fileName;

  const BrandingFileResult({
    required this.fileName,
  });
}

/// ---------------------------------------------------------------------------
/// UPLOAD FAVICON DIALOG
/// ---------------------------------------------------------------------------

Future<BrandingFileResult?> showUploadFaviconDialog(
  BuildContext context,
) {
  return showDialog<BrandingFileResult>(
    context: context,
    barrierDismissible: true,
    builder: (_) => const _UploadFaviconDialog(),
  );
}

class _UploadFaviconDialog extends StatefulWidget {
  const _UploadFaviconDialog();

  @override
  State<_UploadFaviconDialog> createState() => _UploadFaviconDialogState();
}

class _UploadFaviconDialogState extends State<_UploadFaviconDialog> {
  String? fileName;

  @override
  Widget build(BuildContext context) {
    return _DialogShell(
      width: 500,
      title: 'Upload Favicon',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _UploadDropZone(
            title: 'Drag & drop your favicon here',
            subtitle:
                'or click to browse files\nICO, PNG format supported • 32x32 or 64x64 pixels recommended',
            icon: Icons.cloud_upload_outlined,
            onTap: () {
              setState(() {
                fileName = 'favicon.png';
              });
            },
          ),
          const SizedBox(height: 16),
          if (fileName != null)
            _SelectedFile(
              fileName: fileName!,
              onRemove: () {
                setState(() {
                  fileName = null;
                });
              },
            ),
        ],
      ),
      footer: [
        _DialogButton(
          text: 'Cancel',
          onPressed: () => Navigator.pop(context),
        ),
        _DialogButton(
          text: 'Upload',
          primary: true,
          onPressed: fileName == null
              ? null
              : () {
                  Navigator.pop(
                    context,
                    BrandingFileResult(fileName: fileName!),
                  );
                },
        ),
      ],
    );
  }
}

/// ---------------------------------------------------------------------------
/// UPLOAD EMAIL HEADER LOGO DIALOG
/// ---------------------------------------------------------------------------

Future<BrandingFileResult?> showUploadEmailLogoDialog(
  BuildContext context,
) {
  return showDialog<BrandingFileResult>(
    context: context,
    barrierDismissible: true,
    builder: (_) => const _UploadEmailLogoDialog(),
  );
}

class _UploadEmailLogoDialog extends StatefulWidget {
  const _UploadEmailLogoDialog();

  @override
  State<_UploadEmailLogoDialog> createState() =>
      _UploadEmailLogoDialogState();
}

class _UploadEmailLogoDialogState extends State<_UploadEmailLogoDialog> {
  String? fileName;

  @override
  Widget build(BuildContext context) {
    return _DialogShell(
      width: 500,
      title: 'Upload Email Header Logo',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _UploadDropZone(
            title: 'Drag & drop your logo here',
            subtitle:
                'or click to browse files\nPNG, JPG, SVG format supported • Max 5MB',
            icon: Icons.cloud_upload_outlined,
            onTap: () {
              setState(() {
                fileName = 'email-header-logo.png';
              });
            },
          ),
          const SizedBox(height: 16),
          if (fileName != null)
            _SelectedFile(
              fileName: fileName!,
              onRemove: () {
                setState(() {
                  fileName = null;
                });
              },
            ),
        ],
      ),
      footer: [
        _DialogButton(
          text: 'Cancel',
          onPressed: () => Navigator.pop(context),
        ),
        _DialogButton(
          text: 'Upload',
          primary: true,
          onPressed: fileName == null
              ? null
              : () {
                  Navigator.pop(
                    context,
                    BrandingFileResult(fileName: fileName!),
                  );
                },
        ),
      ],
    );
  }
}

/// ---------------------------------------------------------------------------
/// LOGIN BACKGROUND
/// ---------------------------------------------------------------------------

class BackgroundImageOption {
  final String name;
  final List<Color> colors;

  const BackgroundImageOption({
    required this.name,
    required this.colors,
  });
}

const brandingBackgroundOptions = [
  BackgroundImageOption(
    name: 'Modern Arch',
    colors: [
      Color(0xFF1E3A6E),
      Color(0xFF3B82C4),
      Color(0xFFB8DDF2),
    ],
  ),
  BackgroundImageOption(
    name: 'Glass Gradient',
    colors: [
      Color(0xFF7553B7),
      Color(0xFF9C8BE0),
      Color(0xFF52B4DB),
    ],
  ),
  BackgroundImageOption(
    name: 'Tech Slate',
    colors: [
      Color(0xFF1A2028),
      Color(0xFF485362),
      Color(0xFF10151C),
    ],
  ),
  BackgroundImageOption(
    name: 'Mist Valley',
    colors: [
      Color(0xFFBEE8DC),
      Color(0xFF71A99B),
      Color(0xFF456B70),
    ],
  ),
  BackgroundImageOption(
    name: 'Loft Studio',
    colors: [
      Color(0xFFE7D6C7),
      Color(0xFF9B8575),
      Color(0xFF47494D),
    ],
  ),
  BackgroundImageOption(
    name: 'Studio Shapes',
    colors: [
      Color(0xFF6B7EA7),
      Color(0xFFB3C6DE),
      Color(0xFF52627C),
    ],
  ),
];

Future<String?> showBackgroundImageDialog(
  BuildContext context, {
  String selected = 'Glass Gradient',
}) {
  return showDialog<String>(
    context: context,
    barrierDismissible: true,
    builder: (_) => _BackgroundImageDialog(
      selected: selected,
    ),
  );
}

class _BackgroundImageDialog extends StatefulWidget {
  final String selected;

  const _BackgroundImageDialog({
    required this.selected,
  });

  @override
  State<_BackgroundImageDialog> createState() =>
      _BackgroundImageDialogState();
}

class _BackgroundImageDialogState extends State<_BackgroundImageDialog> {
  late String selected;

  @override
  void initState() {
    super.initState();
    selected = widget.selected;
  }

  @override
  Widget build(BuildContext context) {
    return _DialogShell(
      width: 620,
      title: 'Change Login Background Image',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'CHOOSE FROM PRESETS',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: _dialogHint,
              letterSpacing: .5,
            ),
          ),
          const SizedBox(height: 10),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: brandingBackgroundOptions.length,
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.45,
            ),
            itemBuilder: (context, index) {
              final option = brandingBackgroundOptions[index];
              final isSelected = selected == option.name;

              return InkWell(
                borderRadius: BorderRadius.circular(7),
                onTap: () {
                  setState(() {
                    selected = option.name;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(
                      color: isSelected
                          ? _dialogBlue
                          : _dialogBorder,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: option.colors,
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                        ),
                      ),
                      if (isSelected)
                        const Positioned(
                          right: 6,
                          top: 6,
                          child: CircleAvatar(
                            radius: 9,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.check,
                              size: 12,
                              color: _dialogBlue,
                            ),
                          ),
                        ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 5,
                          ),
                          color: Colors.black.withOpacity(.35),
                          child: Text(
                            option.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 14),

          InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(7),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 11,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F7FA),
                borderRadius: BorderRadius.circular(7),
                border: Border.all(color: _dialogBorder),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.upload_outlined,
                    size: 17,
                    color: _dialogBlue,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Upload a custom background...',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: _dialogInk,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      footer: [
        _DialogButton(
          text: 'Cancel',
          onPressed: () => Navigator.pop(context),
        ),
        _DialogButton(
          text: 'Save Changes',
          primary: true,
          onPressed: () => Navigator.pop(context, selected),
        ),
      ],
    );
  }
}

/// ---------------------------------------------------------------------------
/// COLOR PICKER
/// ---------------------------------------------------------------------------

Future<Color?> showBrandingColorPickerDialog(
  BuildContext context, {
  required Color initialColor,
}) {
  return showDialog<Color>(
    context: context,
    barrierDismissible: true,
    builder: (_) => _BrandingColorPickerDialog(
      initialColor: initialColor,
    ),
  );
}

class _BrandingColorPickerDialog extends StatefulWidget {
  final Color initialColor;

  const _BrandingColorPickerDialog({
    required this.initialColor,
  });

  @override
  State<_BrandingColorPickerDialog> createState() =>
      _BrandingColorPickerDialogState();
}

class _BrandingColorPickerDialogState
    extends State<_BrandingColorPickerDialog> {
  late Color color;
  late TextEditingController hexController;

  double hue = 0.0;

  @override
  void initState() {
    super.initState();

    color = widget.initialColor;

    hexController = TextEditingController(
      text: _toHex(color),
    );

    hue = HSVColor.fromColor(color).hue;
  }

  @override
  void dispose() {
    hexController.dispose();
    super.dispose();
  }

  void _setColor(Color newColor) {
    setState(() {
      color = newColor;
      hue = HSVColor.fromColor(newColor).hue;
      hexController.text = _toHex(newColor);
    });
  }

  void _updateFromHex(String value) {
    String hex = value.trim().replaceAll('#', '');

    if (hex.length == 6) {
      final parsed = int.tryParse(hex, radix: 16);

      if (parsed != null) {
        _setColor(Color(0xFF000000 | parsed));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final hsv = HSVColor.fromColor(color);

    return _DialogShell(
      width: 430,
      title: 'Colour Picker',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 210,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(
                colors: [
                  HSVColor.fromAHSV(
                    1,
                    hue,
                    1,
                    1,
                  ).toColor(),
                  Colors.white,
                ],
                begin: Alignment.topRight,
                end: Alignment.topLeft,
              ),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.black,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: hsv.saturation * 390,
                  top: (1 - hsv.value) * 190,
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.black54,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          GestureDetector(
            onHorizontalDragUpdate: (details) {
              final box = context.findRenderObject() as RenderBox?;
              if (box == null) return;

              final local =
                  box.globalToLocal(details.globalPosition);

              final value =
                  (local.dx / box.size.width).clamp(0.0, 1.0);

              setState(() {
                hue = value * 360;
                color = HSVColor.fromAHSV(
                  1,
                  hue,
                  hsv.saturation,
                  hsv.value,
                ).toColor();

                hexController.text = _toHex(color);
              });
            },
            child: Container(
              height: 18,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                  colors: [
                    Colors.red,
                    Colors.yellow,
                    Colors.green,
                    Colors.cyan,
                    Colors.blue,
                    Colors.purple,
                    Colors.red,
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 18),

          Row(
            children: [
              Expanded(
                child: _ColorValueField(
                  label: 'HEX',
                  controller: hexController,
                  onChanged: _updateFromHex,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _ColorValueBox(
                  label: 'R',
                  value: color.red.toString(),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _ColorValueBox(
                  label: 'G',
                  value: color.green.toString(),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _ColorValueBox(
                  label: 'B',
                  value: color.blue.toString(),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Container(
            height: 42,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(7),
              border: Border.all(color: _dialogBorder),
            ),
          ),
        ],
      ),
      footer: [
        _DialogButton(
          text: 'Cancel',
          onPressed: () => Navigator.pop(context),
        ),
        _DialogButton(
          text: 'Apply',
          primary: true,
          onPressed: () => Navigator.pop(context, color),
        ),
      ],
    );
  }
}

/// ---------------------------------------------------------------------------
/// PREVIEW PLATFORM BRANDING
/// ---------------------------------------------------------------------------

Future<void> showPlatformBrandingPreviewDialog(
  BuildContext context, {
  required String platformName,
  required String companyName,
  required String tagline,
  required String welcomeMessage,
  required String background,
  required Color primaryColor,
}) {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (_) => _PlatformBrandingPreviewDialog(
      platformName: platformName,
      companyName: companyName,
      tagline: tagline,
      welcomeMessage: welcomeMessage,
      background: background,
      primaryColor: primaryColor,
    ),
  );
}

class _PlatformBrandingPreviewDialog extends StatelessWidget {
  final String platformName;
  final String companyName;
  final String tagline;
  final String welcomeMessage;
  final String background;
  final Color primaryColor;

  const _PlatformBrandingPreviewDialog({
    required this.platformName,
    required this.companyName,
    required this.tagline,
    required this.welcomeMessage,
    required this.background,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(24),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 900,
          maxHeight: 700,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 12, 10, 12),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Preview Platform Branding',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: _dialogInk,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, size: 18),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    gradient: LinearGradient(
                      colors: _previewColors(background),
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                        width: 390,
                        padding: const EdgeInsets.all(26),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.12),
                              blurRadius: 25,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.bolt,
                                color: Colors.white,
                              ),
                            ),

                            const SizedBox(height: 12),

                            Text(
                              companyName.isEmpty
                                  ? 'COMPANY'
                                  : companyName,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                              ),
                            ),

                            const SizedBox(height: 18),

                            Text(
                              welcomeMessage,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: _dialogInk,
                              ),
                            ),

                            const SizedBox(height: 5),

                            Text(
                              tagline,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 11,
                                color: _dialogMuted,
                              ),
                            ),

                            const SizedBox(height: 22),

                            _PreviewField(
                              label: 'Work Email',
                              value: 'user@example.com',
                            ),

                            const SizedBox(height: 12),

                            _PreviewField(
                              label: 'Password',
                              value: '••••••••••',
                              trailing: const Text(
                                'Forgot password?',
                                style: TextStyle(
                                  color: _dialogBlue,
                                  fontSize: 9,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),

                            const SizedBox(height: 15),

                            SizedBox(
                              width: double.infinity,
                              height: 40,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColor,
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(5),
                                  ),
                                ),
                                child: const Text(
                                  'Sign in to Platform →',
                                  style: TextStyle(fontSize: 11),
                                ),
                              ),
                            ),

                            const SizedBox(height: 12),

                            Text(
                              platformName,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 9,
                                color: _dialogHint,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12),
              child: Align(
                alignment: Alignment.centerRight,
                child: _DialogButton(
                  text: 'Close',
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Color> _previewColors(String name) {
    for (final option in brandingBackgroundOptions) {
      if (option.name == name) {
        return option.colors;
      }
    }

    return brandingBackgroundOptions[1].colors;
  }
}

/// ---------------------------------------------------------------------------
/// SAVE SUCCESS DIALOG
/// ---------------------------------------------------------------------------

Future<void> showBrandingSaveSuccessDialog(
  BuildContext context,
) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (_) => _DialogShell(
      width: 330,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: const BoxDecoration(
              color: Color(0xFFE8F7ED),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check,
              color: Color(0xFF2DA65A),
              size: 22,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Changes saved successfully',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: _dialogInk,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Your platform branding settings have been updated.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: _dialogMuted,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: _dialogBlue,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: const Text(
                'Done',
                style: TextStyle(fontSize: 11),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

/// ---------------------------------------------------------------------------
/// VALIDATION ERROR DIALOG
/// ---------------------------------------------------------------------------

Future<void> showBrandingValidationErrorDialog(
  BuildContext context, {
  required List<String> errors,
}) {
  return showDialog<void>(
    context: context,
    builder: (_) => _DialogShell(
      width: 400,
      title: 'Validation Error',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Please correct the following fields before saving:',
            style: TextStyle(
              fontSize: 12,
              color: _dialogMuted,
            ),
          ),
          const SizedBox(height: 14),
          ...errors.map(
            (error) => Padding(
              padding: const EdgeInsets.only(bottom: 9),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 16,
                    color: Color(0xFFE11D48),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      error,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFFE11D48),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      footer: [
        _DialogButton(
          text: 'OK',
          primary: true,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    ),
  );
}

/// ---------------------------------------------------------------------------
/// COMMON DIALOG SHELL
/// ---------------------------------------------------------------------------

class _DialogShell extends StatelessWidget {
  final String? title;
  final Widget child;
  final List<Widget>? footer;
  final double width;

  const _DialogShell({
    this.title,
    required this.child,
    this.footer,
    this.width = 500,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(9),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: width,
          maxHeight: MediaQuery.of(context).size.height * .88,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (title != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        title!,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: _dialogInk,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close, size: 17),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        minWidth: 32,
                        minHeight: 32,
                      ),
                    ),
                  ],
                ),
              ),
            if (title != null) const Divider(height: 1),

            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: child,
              ),
            ),

            if (footer != null) ...[
              const Divider(height: 1),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: footer!,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// COMMON BUTTON
/// ---------------------------------------------------------------------------

class _DialogButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool primary;

  const _DialogButton({
    required this.text,
    required this.onPressed,
    this.primary = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: SizedBox(
        height: 34,
        child: primary
            ? ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _dialogBlue,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            : OutlinedButton(
                onPressed: onPressed,
                style: OutlinedButton.styleFrom(
                  foregroundColor: _dialogInk,
                  backgroundColor: Colors.white,
                  side: const BorderSide(
                    color: _dialogFieldBorder,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// UPLOAD DROP ZONE
/// ---------------------------------------------------------------------------

class _UploadDropZone extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const _UploadDropZone({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 32,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: _dialogBlue,
            style: BorderStyle.solid,
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: const BoxDecoration(
                color: Color(0xFFEAF0FF),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: _dialogBlue,
                size: 19,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: _dialogInk,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 9,
                height: 1.4,
                color: _dialogHint,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// SELECTED FILE
/// ---------------------------------------------------------------------------

class _SelectedFile extends StatelessWidget {
  final String fileName;
  final VoidCallback onRemove;

  const _SelectedFile({
    required this.fileName,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7FA),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: _dialogBorder),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.insert_drive_file_outlined,
            size: 18,
            color: _dialogMuted,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              fileName,
              style: const TextStyle(
                fontSize: 11,
                color: _dialogInk,
              ),
            ),
          ),
          IconButton(
            onPressed: onRemove,
            icon: const Icon(Icons.close, size: 16),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(
              minWidth: 28,
              minHeight: 28,
            ),
          ),
        ],
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// COLOR VALUE FIELD
/// ---------------------------------------------------------------------------

class _ColorValueField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const _ColorValueField({
    required this.label,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w600,
            color: _dialogMuted,
          ),
        ),
        const SizedBox(height: 5),
        SizedBox(
          height: 36,
          child: TextField(
            controller: controller,
            onChanged: onChanged,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
            ),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 8,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(
                  color: _dialogFieldBorder,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// ---------------------------------------------------------------------------
/// COLOR VALUE BOX
/// ---------------------------------------------------------------------------

class _ColorValueBox extends StatelessWidget {
  final String label;
  final String value;

  const _ColorValueBox({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w600,
            color: _dialogMuted,
          ),
        ),
        const SizedBox(height: 5),
        Container(
          height: 36,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: _dialogFieldBorder),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            value,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
            ),
          ),
        ),
      ],
    );
  }
}


/// ---------------------------------------------------------------------------
/// FULL-SCREEN VERSIONS (mobile)
///
/// On phones the "Preview" and "Change Image" actions open a full page with a
/// back arrow and Cancel / Save buttons (as in the design). On desktop /
/// tablet they keep using the pop-up dialogs above.
/// ---------------------------------------------------------------------------

bool _isPhone(BuildContext context) => MediaQuery.of(context).size.width < 700;

/// Returns `true` when the user pressed **Save** on the mobile preview page.
Future<bool?> openBrandingPreview(
  BuildContext context, {
  required String platformName,
  required String companyName,
  required String tagline,
  required String welcomeMessage,
  required String background,
  required Color primaryColor,
  String footerText = '',
  String copyrightText = '',
}) async {
  if (_isPhone(context)) {
    return Navigator.of(context, rootNavigator: true).push<bool>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => _BrandingPreviewPage(
          platformName: platformName,
          companyName: companyName,
          tagline: tagline,
          welcomeMessage: welcomeMessage,
          background: background,
          primaryColor: primaryColor,
          footerText: footerText,
          copyrightText: copyrightText,
        ),
      ),
    );
  }

  await showPlatformBrandingPreviewDialog(
    context,
    platformName: platformName,
    companyName: companyName,
    tagline: tagline,
    welcomeMessage: welcomeMessage,
    background: background,
    primaryColor: primaryColor,
  );
  return null;
}

/// Returns the selected preset name, or `null` when cancelled.
Future<String?> openBackgroundImagePicker(
  BuildContext context, {
  String selected = 'Glass Gradient',
}) {
  if (_isPhone(context)) {
    return Navigator.of(context, rootNavigator: true).push<String>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => _BackgroundImagePage(selected: selected),
      ),
    );
  }

  return showBackgroundImageDialog(context, selected: selected);
}

/// Shared frame: back arrow + title, scrollable body, Cancel / primary footer.
class _FullPageFrame extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget body;
  final String primaryText;
  final VoidCallback onPrimary;

  const _FullPageFrame({
    required this.title,
    required this.body,
    required this.primaryText,
    required this.onPrimary,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: _dialogFieldBorder),
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        size: 18,
                        color: _dialogInk,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(
                            title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: _dialogInk,
                            ),
                          ),
                        ),
                        if (subtitle != null) ...[
                          const SizedBox(height: 3),
                          Text(
                            subtitle!,
                            style: const TextStyle(
                              fontSize: 11,
                              color: _dialogMuted,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: _dialogBorder),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
                child: body,
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: _dialogBorder)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 46,
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: _dialogInk,
                          side: const BorderSide(color: _dialogFieldBorder),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: 46,
                      child: ElevatedButton(
                        onPressed: onPrimary,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _dialogBlue,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: Text(
                          primaryText,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---- Preview Platform Branding (full page) ---------------------------------

class _BrandingPreviewPage extends StatelessWidget {
  final String platformName;
  final String companyName;
  final String tagline;
  final String welcomeMessage;
  final String background;
  final Color primaryColor;
  final String footerText;
  final String copyrightText;

  const _BrandingPreviewPage({
    required this.platformName,
    required this.companyName,
    required this.tagline,
    required this.welcomeMessage,
    required this.background,
    required this.primaryColor,
    required this.footerText,
    required this.copyrightText,
  });

  List<Color> get _colors {
    for (final option in brandingBackgroundOptions) {
      if (option.name == background) return option.colors;
    }
    return brandingBackgroundOptions[1].colors;
  }

  @override
  Widget build(BuildContext context) {
    // "Welcome to X. Please authenticate to continue." -> title + subtitle
    final cut = welcomeMessage.indexOf('. ');
    final welcomeTitle = cut == -1
        ? welcomeMessage
        : welcomeMessage.substring(0, cut);
    final welcomeSub = cut == -1
        ? 'Please authenticate to continue.'
        : welcomeMessage.substring(cut + 2);

    return _FullPageFrame(
      title: 'Preview Platform Branding',
      primaryText: 'Save',
      onPrimary: () => Navigator.of(context).pop(true),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'LOGIN PAGE PREVIEW',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: _dialogHint,
              letterSpacing: .8,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  for (final c in _colors)
                    Color.lerp(c, const Color(0xFF0B1330), .7)!,
                ],
              ),
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.12),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: Colors.white.withOpacity(.2),
                      ),
                    ),
                    child: const Text(
                      'Powered by Stackly',
                      style: TextStyle(fontSize: 9, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Column(
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 22,
                                  height: 22,
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: const Icon(
                                    Icons.bolt,
                                    size: 14,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  companyName.isEmpty
                                      ? 'COMPANY'
                                      : companyName.split(' ').first
                                          .toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              'ENTERPRISE SOFTWARE',
                              style: TextStyle(
                                fontSize: 6,
                                letterSpacing: .8,
                                color: _dialogHint,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),
                      Center(
                        child: Text(
                          welcomeTitle,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: _dialogInk,
                          ),
                        ),
                      ),
                      const SizedBox(height: 3),
                      Center(
                        child: Text(
                          welcomeSub,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 10,
                            color: _dialogMuted,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      const _PreviewField(
                        label: 'Work Email',
                        value: 'renu.kapoor@oracle.com',
                      ),
                      const SizedBox(height: 10),
                      _PreviewField(
                        label: 'Password',
                        value: 'password1234',
                        trailing: Text(
                          'Forgot password?',
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: const Icon(
                              Icons.check,
                              size: 9,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Expanded(
                            child: Text(
                              'Remember this device (30 days)',
                              style: TextStyle(
                                fontSize: 9,
                                color: _dialogMuted,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE5F8EF),
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: const Text(
                              'MFA Active',
                              style: TextStyle(
                                fontSize: 8,
                                color: Color(0xFF00A96B),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        height: 36,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: const Text(
                            'Sign in to Platform →',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Center(
                        child: Text(
                          'OR SINGLE SIGN-ON',
                          style: TextStyle(
                            fontSize: 8,
                            letterSpacing: .6,
                            color: _dialogHint,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        height: 34,
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: Icon(
                            Icons.info,
                            size: 13,
                            color: primaryColor,
                          ),
                          label: const Text(
                            'Authenticate via Oracle Okta SSO',
                            style: TextStyle(
                              fontSize: 10,
                              color: _dialogInk,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: _dialogFieldBorder,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Center(
                        child: Text(
                          '"$tagline"',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 9,
                            fontStyle: FontStyle.italic,
                            color: _dialogMuted,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  '$footerText $copyrightText'.trim(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 8,
                    height: 1.4,
                    color: Colors.white.withOpacity(.75),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---- Change Login Background Image (full page) -----------------------------

class _BackgroundImagePage extends StatefulWidget {
  final String selected;

  const _BackgroundImagePage({required this.selected});

  @override
  State<_BackgroundImagePage> createState() => _BackgroundImagePageState();
}

class _BackgroundImagePageState extends State<_BackgroundImagePage> {
  late String _selected = widget.selected;

  BackgroundImageOption get _option => brandingBackgroundOptions.firstWhere(
        (o) => o.name == _selected,
        orElse: () => brandingBackgroundOptions[1],
      );

  @override
  Widget build(BuildContext context) {
    return _FullPageFrame(
      title: 'Change Login Background Image',
      subtitle: 'Choose a preset, or upload your own image.',
      primaryText: 'Save Changes',
      onPrimary: () => Navigator.of(context).pop(_selected),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'CHOOSE FROM PRESETS',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: _dialogHint,
              letterSpacing: .8,
            ),
          ),
          const SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: brandingBackgroundOptions.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.55,
            ),
            itemBuilder: (context, index) {
              final option = brandingBackgroundOptions[index];
              final on = option.name == _selected;

              return InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () => setState(() => _selected = option.name),
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: on ? _dialogBlue : _dialogBorder,
                      width: on ? 2 : 1,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: option.colors,
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 5,
                          ),
                          color: Colors.black.withOpacity(.35),
                          child: Text(
                            option.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 14),
          InkWell(
            onTap: () {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  const SnackBar(
                    content: Text('Choose a PNG or JPG up to 10MB'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
            },
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F7FA),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _dialogBorder),
              ),
              child: const Row(
                children: [
                  Icon(Icons.image_outlined, size: 16, color: _dialogBlue),
                  SizedBox(width: 8),
                  Text(
                    'Upload a custom background...',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: _dialogInk,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'SELECTED PREVIEW',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: _dialogHint,
              letterSpacing: .8,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 190,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(
                colors: _option.colors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            _selected,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: _dialogInk,
            ),
          ),
          const SizedBox(height: 2),
          const Text(
            'Default Gradient System',
            style: TextStyle(fontSize: 10, color: _dialogMuted),
          ),
        ],
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// PREVIEW FIELD
/// ---------------------------------------------------------------------------

class _PreviewField extends StatelessWidget {
  final String label;
  final String value;
  final Widget? trailing;

  const _PreviewField({
    required this.label,
    required this.value,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 9,
                color: _dialogMuted,
              ),
            ),
            const Spacer(),
            if (trailing != null) trailing!,
          ],
        ),
        const SizedBox(height: 5),
        Container(
          height: 38,
          width: double.infinity,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: _dialogFieldBorder),
          ),
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 10,
              color: _dialogInk,
            ),
          ),
        ),
      ],
    );
  }
}

/// ---------------------------------------------------------------------------
/// HEX
/// ---------------------------------------------------------------------------

String _toHex(Color color) {
  return '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
}