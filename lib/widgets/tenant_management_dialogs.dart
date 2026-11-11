import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'dashboard_dialogs.dart' show ExportFormat;



const Color _ink = AppColors.ink;
const Color _muted = AppColors.muted;
const Color _hint = AppColors.hint;
const Color _line = AppColors.border;
const Color _control = Color(0xFFD8E0E8);
const Color _fill = Color(0xFFF8FAFC);
const Color _blue = AppColors.blue;
const Color _green = Color(0xFF16A05C);
const Color _red = Color(0xFFE02F3A);

// ═════════════════════════════════════════════════════════════
//  PUBLIC API
// ═════════════════════════════════════════════════════════════

/// Enable / Disable confirmation. Returns true when confirmed.
///
/// [count] > 1 is used for bulk actions ("4 selected tenants").
Future<bool?> showTenantStatusDialog({
  required BuildContext context,
  required String tenantName,
  required String tenantDescription,
  required bool enable,
  int count = 1,
}) {
  final many = count > 1;
  final noun = many ? 'tenants' : 'tenant';

  return showDialog<bool>(
    context: context,
    barrierColor: Colors.black54,
    builder: (_) => _ConfirmDialog(
      icon: enable ? Icons.check_circle_outline : Icons.block,
      tone: enable ? _green : _red,
      title: enable
          ? (many ? 'Enable Tenants' : 'Enable Tenant')
          : (many ? 'Disable Tenants' : 'Disable Tenant'),
      subtitle: enable
          ? 'Are you sure you want to enable ${many ? 'these' : 'this'} $noun?'
          : 'Are you sure you want to disable ${many ? 'these' : 'this'} $noun?',
      note: enable
          ? 'Once enabled, ${many ? 'the tenants' : 'the tenant'} will be able to access the platform.'
          : 'The ${many ? 'tenants' : 'tenant'} will not be able to access the platform after ${many ? 'they are' : 'it is'} disabled.',
      confirmLabel: enable
          ? (many ? 'Enable Tenants' : 'Enable Tenant')
          : (many ? 'Disable Tenants' : 'Disable Tenant'),
      confirmIcon: enable ? Icons.check_circle_outline : Icons.block,
      tenantName: tenantName,
      tenantDescription: tenantDescription,
      bulk: many,
    ),
  );
}

/// Generic confirmation with the same look (used for restore etc.).
Future<bool?> showTenantConfirmDialog({
  required BuildContext context,
  required String title,
  required String subtitle,
  required String confirmLabel,
  String? note,
  IconData icon = Icons.help_outline,
  IconData? confirmIcon,
  Color tone = _blue,
}) {
  return showDialog<bool>(
    context: context,
    barrierColor: Colors.black54,
    builder: (_) => _ConfirmDialog(
      icon: icon,
      tone: tone,
      title: title,
      subtitle: subtitle,
      note: note,
      confirmLabel: confirmLabel,
      confirmIcon: confirmIcon,
    ),
  );
}

/// "Discard unsaved changes?" popup. Returns true when Reset is pressed.
Future<bool> showResetChangesDialog(
  BuildContext context, {
  String title = 'Reset changes?',
  String message = 'Discard unsaved changes and restore the last saved settings.',
  String buttonLabel = 'Reset',
}) async {
  final result = await showDialog<bool>(
    context: context,
    barrierColor: Colors.black54,
    builder: (ctx) => _Shell(
      maxWidth: 360,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(22, 22, 22, 22),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: _ink,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: const TextStyle(fontSize: 13, height: 1.45, color: _muted),
            ),
            const SizedBox(height: 18),
            _Btn(
              buttonLabel,
              fill: _blue,
              height: 44,
              expand: true,
              onPressed: () => Navigator.of(ctx).pop(true),
            ),
          ],
        ),
      ),
    ),
  );
  return result == true;
}

/// "Tenant Created Successfully" popup.
Future<void> showTenantCreatedDialog(
  BuildContext context, {
  required String tenantName,
  String title = 'Tenant Created Successfully',
  String? message,
}) {
  return showDialog<void>(
    context: context,
    barrierColor: Colors.black54,
    barrierDismissible: false,
    builder: (ctx) => _Shell(
      maxWidth: 380,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(22, 24, 22, 22),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 52,
                height: 52,
                decoration: const BoxDecoration(
                  color: Color(0xFFE5F8EF),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, size: 26, color: _green),
              ),
            ),
            const SizedBox(height: 14),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: _ink,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              message ?? '$tenantName has been successfully created.',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 13, height: 1.4, color: _muted),
            ),
            const SizedBox(height: 20),
            _Btn(
              'Done',
              fill: _blue,
              height: 44,
              expand: true,
              onPressed: () => Navigator.of(ctx).pop(),
            ),
          ],
        ),
      ),
    ),
  );
}

/// Small "Refreshing..." card. Closes itself after [duration].
Future<void> showTenantRefreshingDialog(
  BuildContext context, {
  Duration duration = const Duration(milliseconds: 900),
}) async {
  final navigator = Navigator.of(context, rootNavigator: true);

  showDialog<void>(
    context: context,
    barrierColor: Colors.black45,
    barrierDismissible: false,
    builder: (_) => const PopScope(
      canPop: false,
      child: Center(child: _RefreshingCard()),
    ),
  );

  await Future<void>.delayed(duration);
  if (navigator.mounted) navigator.pop();
}

// ── Export ───────────────────────────────────────────────────

const List<String> tenantExportColumns = [
  'Tenant Name',
  'Tenant ID',
  'Domain',
  'Subscription Plan',
  'Status',
  'Region',
  'Storage Used',
  'Created On',
  'Last Backup',
  'Actions',
];

class TenantExportOptions {
  final bool selectedOnly;
  final ExportFormat format;
  final List<String> columns;

  const TenantExportOptions({
    required this.selectedOnly,
    required this.format,
    required this.columns,
  });
}

Future<TenantExportOptions?> showExportTenantsDialog(
  BuildContext context, {
  required int totalCount,
  required int selectedCount,
}) {
  return showDialog<TenantExportOptions>(
    context: context,
    barrierColor: Colors.black54,
    builder: (_) => _ExportTenantsDialog(
      totalCount: totalCount,
      selectedCount: selectedCount,
    ),
  );
}

// ── Configure ────────────────────────────────────────────────

class TenantConfigResult {
  final String plan;
  final String region;
  final int storageGb;
  final bool active;

  const TenantConfigResult({
    required this.plan,
    required this.region,
    required this.storageGb,
    required this.active,
  });
}

Future<TenantConfigResult?> showConfigureTenantDialog(
  BuildContext context, {
  required String tenantName,
  required String plan,
  required String region,
  required int storageGb,
  required bool active,
  List<String> plans = const ['Enterprise', 'Professional', 'Standard'],
  List<String> regions = const [
    'India (Asia South)',
    'United States (US East)',
    'United Kingdom (Europe West)',
    'Singapore (Asia Southeast)',
  ],
}) {
  return showDialog<TenantConfigResult>(
    context: context,
    barrierColor: Colors.black54,
    builder: (_) => _ConfigureTenantDialog(
      tenantName: tenantName,
      plan: plan,
      region: region,
      storageGb: storageGb,
      active: active,
      plans: plans,
      regions: regions,
    ),
  );
}

// ── Backup ───────────────────────────────────────────────────

class TenantBackupOptions {
  final String type;
  final String location;
  const TenantBackupOptions({required this.type, required this.location});
}

Future<TenantBackupOptions?> showBackupTenantDialog(
  BuildContext context, {
  required String tenantName,
}) {
  return showDialog<TenantBackupOptions>(
    context: context,
    barrierColor: Colors.black54,
    builder: (_) => _BackupTenantDialog(tenantName: tenantName),
  );
}

// ═════════════════════════════════════════════════════════════
//  TOAST
// ═════════════════════════════════════════════════════════════

enum TenantToastType { success, danger, info }

OverlayEntry? _activeToast;

/// Top banner: white card, coloured border, icon + title + message.
void showTenantToast(
  BuildContext context, {
  required String title,
  required String message,
  TenantToastType type = TenantToastType.success,
  IconData? icon,
  Duration duration = const Duration(seconds: 3),
}) {
  final overlay = Overlay.maybeOf(context, rootOverlay: true);
  if (overlay == null) return;

  _activeToast?.remove();
  _activeToast = null;

  late final OverlayEntry entry;
  entry = OverlayEntry(
    builder: (_) => _ToastView(
      title: title,
      message: message,
      type: type,
      icon: icon,
      duration: duration,
      onDone: () {
        if (entry.mounted) entry.remove();
        if (identical(_activeToast, entry)) _activeToast = null;
      },
    ),
  );

  _activeToast = entry;
  overlay.insert(entry);
}

/// Picks title / tone for a plain message (used by the page helpers).
void showTenantMessageToast(BuildContext context, String message) {
  final lower = message.toLowerCase();
  final bad = lower.contains('fail') ||
      lower.contains('error') ||
      lower.contains('invalid') ||
      lower.contains('please') ||
      lower.contains('required');

  showTenantToast(
    context,
    title: bad ? 'Action Needed' : 'Success',
    message: message,
    type: bad ? TenantToastType.danger : TenantToastType.success,
    icon: bad ? Icons.error_outline : Icons.check_circle_outline,
  );
}

class _ToastView extends StatefulWidget {
  final String title;
  final String message;
  final TenantToastType type;
  final IconData? icon;
  final Duration duration;
  final VoidCallback onDone;

  const _ToastView({
    required this.title,
    required this.message,
    required this.type,
    required this.icon,
    required this.duration,
    required this.onDone,
  });

  @override
  State<_ToastView> createState() => _ToastViewState();
}

class _ToastViewState extends State<_ToastView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 220),
  );
  bool _closing = false;

  @override
  void initState() {
    super.initState();
    _c.forward();
    Future<void>.delayed(widget.duration, _close);
  }

  Future<void> _close() async {
    if (_closing || !mounted) return;
    _closing = true;
    await _c.reverse();
    widget.onDone();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color tone;
    final IconData defaultIcon;
    switch (widget.type) {
      case TenantToastType.success:
        tone = _green;
        defaultIcon = Icons.check_circle_outline;
        break;
      case TenantToastType.danger:
        tone = _red;
        defaultIcon = Icons.error_outline;
        break;
      case TenantToastType.info:
        tone = _blue;
        defaultIcon = Icons.info_outline;
        break;
    }

    final top = MediaQuery.of(context).padding.top + 16;

    return Positioned(
      top: top,
      left: 16,
      right: 16,
      child: Align(
        alignment: Alignment.topCenter,
        child: FadeTransition(
          opacity: _c,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, -0.35),
              end: Offset.zero,
            ).animate(CurvedAnimation(parent: _c, curve: Curves.easeOut)),
            child: Material(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: _close,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: tone.withValues(alpha: 0.55)),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x22000000),
                          blurRadius: 18,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(7),
                      child: IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(width: 4, color: tone),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  12,
                                  12,
                                  14,
                                  12,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      widget.icon ?? defaultIcon,
                                      size: 20,
                                      color: tone,
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            widget.title,
                                            style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w700,
                                              color: _ink,
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            widget.message,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              height: 1.35,
                                              color: _muted,
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
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════
//  SHARED BUILDING BLOCKS
// ═════════════════════════════════════════════════════════════

class _Shell extends StatelessWidget {
  final double maxWidth;
  final Widget child;

  const _Shell({required this.child, this.maxWidth = 440});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: SingleChildScrollView(child: child),
      ),
    );
  }
}

/// Icon tile + title/subtitle + close button.
class _Header extends StatelessWidget {
  final IconData? icon;
  final Color tone;
  final String title;
  final String? subtitle;
  final VoidCallback onClose;

  const _Header({
    required this.title,
    required this.onClose,
    this.icon,
    this.tone = _blue,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (icon != null) ...[
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: tone.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: tone.withValues(alpha: 0.18)),
            ),
            child: Icon(icon, size: 22, color: tone),
          ),
          const SizedBox(width: 12),
        ],
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    height: 1.2,
                    fontWeight: FontWeight.w700,
                    color: _ink,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    subtitle!,
                    style: const TextStyle(
                      fontSize: 12,
                      height: 1.35,
                      color: _muted,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        InkWell(
          onTap: onClose,
          customBorder: const CircleBorder(),
          child: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFB6C2D1)),
            ),
            child: const Icon(Icons.close, size: 14, color: _muted),
          ),
        ),
      ],
    );
  }
}

class _Btn extends StatelessWidget {
  final String label;
  final IconData? icon;
  final Color? fill; // null => outlined
  final double height;
  final bool expand;
  final VoidCallback? onPressed;

  const _Btn(
    this.label, {
    required this.onPressed,
    this.icon,
    this.fill,
    this.height = 40,
    this.expand = false,
  });

  @override
  Widget build(BuildContext context) {
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    );

    final content = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[Icon(icon, size: 16), const SizedBox(width: 7)],
        Flexible(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );

    final Widget button = fill == null
        ? OutlinedButton(
            onPressed: onPressed,
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF253341),
              backgroundColor: Colors.white,
              side: const BorderSide(color: _control),
              minimumSize: Size(expand ? 0 : 88, height),
              padding: const EdgeInsets.symmetric(horizontal: 18),
              shape: shape,
            ),
            child: content,
          )
        : ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: fill,
              foregroundColor: Colors.white,
              disabledBackgroundColor: fill!.withValues(alpha: 0.45),
              disabledForegroundColor: Colors.white,
              elevation: 0,
              minimumSize: Size(expand ? 0 : 88, height),
              padding: const EdgeInsets.symmetric(horizontal: 18),
              shape: shape,
            ),
            child: content,
          );

    return SizedBox(
      height: height,
      width: expand ? double.infinity : null,
      child: button,
    );
  }
}

/// Right-aligned Cancel + primary action. Wraps on very narrow phones.
class _Actions extends StatelessWidget {
  final String confirmLabel;
  final IconData? confirmIcon;
  final Color confirmColor;
  final VoidCallback? onConfirm;
  final VoidCallback onCancel;

  const _Actions({
    required this.confirmLabel,
    required this.onConfirm,
    required this.onCancel,
    this.confirmIcon,
    this.confirmColor = _blue,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        alignment: WrapAlignment.end,
        children: [
          _Btn('Cancel', onPressed: onCancel),
          _Btn(
            confirmLabel,
            icon: confirmIcon,
            fill: confirmColor,
            onPressed: onConfirm,
          ),
        ],
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String text;
  final bool required;
  const _FieldLabel(this.text, {this.required = false});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Color(0xFF334155),
        ),
        children: [
          if (required)
            const TextSpan(text: ' *', style: TextStyle(color: _red)),
        ],
      ),
    );
  }
}

class _Helper extends StatelessWidget {
  final String text;
  const _Helper(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Text(
        text,
        style: const TextStyle(fontSize: 11, height: 1.3, color: _hint),
      ),
    );
  }
}

InputDecoration _dec({String? hint}) {
  OutlineInputBorder b(Color c, [double w = 1]) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide(color: c, width: w),
      );

  return InputDecoration(
    isDense: true,
    hintText: hint,
    hintStyle: const TextStyle(fontSize: 13, color: _hint),
    filled: true,
    fillColor: Colors.white,
    constraints: const BoxConstraints(minHeight: 44),
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    border: b(_control),
    enabledBorder: b(_control),
    focusedBorder: b(_blue, 1.4),
    errorBorder: b(_red),
    focusedErrorBorder: b(_red, 1.4),
    errorStyle: const TextStyle(fontSize: 11, color: _red),
  );
}

class _Drop extends StatelessWidget {
  final String value;
  final List<String> items;
  final ValueChanged<String> onChanged;

  const _Drop({
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: items.contains(value) ? value : null,
      isExpanded: true,
      icon: const Icon(
        Icons.keyboard_arrow_down_rounded,
        size: 18,
        color: _muted,
      ),
      style: const TextStyle(fontSize: 13, color: _ink),
      dropdownColor: Colors.white,
      decoration: _dec(),
      items: [
        for (final item in items)
          DropdownMenuItem(
            value: item,
            child: Text(item, overflow: TextOverflow.ellipsis),
          ),
      ],
      onChanged: (v) {
        if (v != null) onChanged(v);
      },
    );
  }
}

class _RadioDot extends StatelessWidget {
  final bool selected;
  final bool enabled;
  const _RadioDot({required this.selected, this.enabled = true});

  @override
  Widget build(BuildContext context) {
    final color = !enabled
        ? const Color(0xFFCBD5E1)
        : (selected ? _blue : const Color(0xFF9AA8BA));

    return Container(
      width: 18,
      height: 18,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: color, width: 1.6),
      ),
      child: selected
          ? Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            )
          : null,
    );
  }
}

class _Box extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final String label;
  final bool bold;
  final bool? tri;

  const _Box({
    required this.value,
    required this.onChanged,
    required this.label,
    this.bold = false,
    this.tri,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(4),
      onTap: () => onChanged(!value),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [
            SizedBox(
              width: 18,
              height: 18,
              child: Checkbox(
                value: tri == null ? value : null,
                tristate: tri != null,
                onChanged: (v) => onChanged(!value),
                activeColor: _blue,
                side: const BorderSide(color: Color(0xFF9AA8BA), width: 1.4),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
            const SizedBox(width: 9),
            Expanded(
              child: Text(
                label,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
                  color: _ink,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════
//  ENABLE / DISABLE (+ generic confirm)
// ═════════════════════════════════════════════════════════════

class _ConfirmDialog extends StatelessWidget {
  final IconData icon;
  final Color tone;
  final String title;
  final String subtitle;
  final String? note;
  final String confirmLabel;
  final IconData? confirmIcon;
  final String? tenantName;
  final String? tenantDescription;
  final bool bulk;

  const _ConfirmDialog({
    required this.icon,
    required this.tone,
    required this.title,
    required this.subtitle,
    required this.confirmLabel,
    this.note,
    this.confirmIcon,
    this.tenantName,
    this.tenantDescription,
    this.bulk = false,
  });

  @override
  Widget build(BuildContext context) {
    final initial = (tenantName ?? '').trim().isEmpty
        ? '?'
        : tenantName!.trim().characters.first.toUpperCase();

    return _Shell(
      maxWidth: 440,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _Header(
              icon: icon,
              tone: tone,
              title: title,
              subtitle: subtitle,
              onClose: () => Navigator.of(context).pop(false),
            ),
            if (note != null) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: tone.withValues(alpha: 0.07),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: tone.withValues(alpha: 0.18)),
                ),
                child: Text(
                  note!,
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.4,
                    color: tone,
                  ),
                ),
              ),
            ],
            if (tenantName != null) ...[
              const SizedBox(height: 16),
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Color(0xFF2F5BEA),
                      shape: BoxShape.circle,
                    ),
                    child: bulk
                        ? const Icon(
                            Icons.apartment_outlined,
                            size: 20,
                            color: Colors.white,
                          )
                        : Text(
                            initial,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tenantName!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: _ink,
                          ),
                        ),
                        if ((tenantDescription ?? '').isNotEmpty) ...[
                          const SizedBox(height: 2),
                          Text(
                            tenantDescription!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              color: _muted,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 20),
            _Actions(
              confirmLabel: confirmLabel,
              confirmIcon: confirmIcon,
              confirmColor: tone,
              onCancel: () => Navigator.of(context).pop(false),
              onConfirm: () => Navigator.of(context).pop(true),
            ),
          ],
        ),
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════
//  REFRESHING
// ═════════════════════════════════════════════════════════════

class _RefreshingCard extends StatelessWidget {
  const _RefreshingCard();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      elevation: 6,
      child: Container(
        width: 150,
        padding: const EdgeInsets.symmetric(vertical: 22),
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(
                strokeWidth: 2.6,
                color: Color(0xFF5B6B80),
              ),
            ),
            SizedBox(height: 12),
            Text(
              'Refreshing...',
              style: TextStyle(fontSize: 12, color: _muted),
            ),
          ],
        ),
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════
//  EXPORT TENANTS
// ═════════════════════════════════════════════════════════════

class _ExportTenantsDialog extends StatefulWidget {
  final int totalCount;
  final int selectedCount;

  const _ExportTenantsDialog({
    required this.totalCount,
    required this.selectedCount,
  });

  @override
  State<_ExportTenantsDialog> createState() => _ExportTenantsDialogState();
}

class _ExportTenantsDialogState extends State<_ExportTenantsDialog> {
  bool selectedOnly = false;
  ExportFormat format = ExportFormat.excel;
  late final Set<String> columns = {...tenantExportColumns};

  bool get hasSelection => widget.selectedCount > 0;
  bool get allColumns => columns.length == tenantExportColumns.length;

  Widget _section(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12.5,
          fontWeight: FontWeight.w700,
          color: _ink,
        ),
      ),
    );
  }

  Widget _scopeRow({
    required bool value,
    required String title,
    required String subtitle,
    bool enabled = true,
  }) {
    final selected = selectedOnly == value;

    return InkWell(
      onTap: enabled ? () => setState(() => selectedOnly = value) : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            _RadioDot(selected: selected, enabled: enabled),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: enabled ? _ink : _hint,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 11, color: _muted),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _formatOption(
    ExportFormat value,
    String title,
    String subtitle,
    IconData icon,
    Color tone,
  ) {
    final selected = format == value;

    return InkWell(
      onTap: () => setState(() => format = value),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 1),
              child: _RadioDot(selected: selected),
            ),
            const SizedBox(width: 8),
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: tone,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Icon(icon, size: 14, color: Colors.white),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: _ink,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 10.5,
                      height: 1.3,
                      color: _muted,
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

  Widget _columnList(List<String> names) {
    return Column(
      children: [
        for (final name in names)
          _Box(
            value: columns.contains(name),
            label: name,
            onChanged: (v) => setState(() {
              if (v) {
                columns.add(name);
              } else {
                columns.remove(name);
              }
            }),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final half = (tenantExportColumns.length / 2).ceil();
    final left = tenantExportColumns.sublist(0, half);
    final right = tenantExportColumns.sublist(half);

    final formats = [
      _formatOption(
        ExportFormat.excel,
        'Excel (.xlsx)',
        'Recommended for data analysis',
        Icons.grid_on,
        const Color(0xFF1D8F4E),
      ),
      _formatOption(
        ExportFormat.csv,
        'CSV (.csv)',
        'Lightweight file format',
        Icons.description_outlined,
        const Color(0xFF64748B),
      ),
      _formatOption(
        ExportFormat.pdf,
        'PDF (.pdf)',
        'Formatted report for sharing',
        Icons.picture_as_pdf_outlined,
        _red,
      ),
    ];

    return _Shell(
      maxWidth: 520,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _Header(
              icon: Icons.download_outlined,
              title: 'Export Tenants',
              subtitle: 'Export tenant data in your preferred format.',
              onClose: () => Navigator.of(context).pop(),
            ),
            _section('Export Scope'),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _line),
              ),
              child: Column(
                children: [
                  _scopeRow(
                    value: false,
                    title: 'All Tenants',
                    subtitle:
                        'Export data of all tenants (${widget.totalCount} tenants)',
                  ),
                  const Divider(height: 1, color: _line),
                  _scopeRow(
                    value: true,
                    enabled: hasSelection,
                    title: 'Selected Tenants',
                    subtitle: hasSelection
                        ? 'Export data of only selected tenants (${widget.selectedCount})'
                        : 'Export data of only selected tenants',
                  ),
                ],
              ),
            ),
            _section('File Format'),
            LayoutBuilder(
              builder: (context, c) {
                final wide = c.maxWidth >= 440;

                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: _line),
                  ),
                  child: wide
                      ? IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              for (int i = 0; i < formats.length; i++) ...[
                                if (i > 0)
                                  const VerticalDivider(
                                    width: 1,
                                    color: _line,
                                  ),
                                Expanded(child: formats[i]),
                              ],
                            ],
                          ),
                        )
                      : Column(
                          children: [
                            for (int i = 0; i < formats.length; i++) ...[
                              if (i > 0)
                                const Divider(height: 1, color: _line),
                              formats[i],
                            ],
                          ],
                        ),
                );
              },
            ),
            _section('Export Columns'),
            Container(
              padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _line),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Box(
                    value: allColumns,
                    label: 'Select All',
                    bold: true,
                    onChanged: (v) => setState(() {
                      if (v) {
                        columns.addAll(tenantExportColumns);
                      } else {
                        columns.clear();
                      }
                    }),
                  ),
                  const Divider(height: 8, color: _line),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _columnList(left)),
                      const SizedBox(width: 12),
                      Expanded(child: _columnList(right)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _Actions(
              confirmLabel: 'Export',
              confirmIcon: Icons.download_outlined,
              onCancel: () => Navigator.of(context).pop(),
              onConfirm: columns.isEmpty
                  ? null
                  : () => Navigator.of(context).pop(
                        TenantExportOptions(
                          selectedOnly: selectedOnly && hasSelection,
                          format: format,
                          columns: [
                            for (final c in tenantExportColumns)
                              if (columns.contains(c)) c,
                          ],
                        ),
                      ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════
//  CONFIGURE TENANT
// ═════════════════════════════════════════════════════════════

class _ConfigureTenantDialog extends StatefulWidget {
  final String tenantName;
  final String plan;
  final String region;
  final int storageGb;
  final bool active;
  final List<String> plans;
  final List<String> regions;

  const _ConfigureTenantDialog({
    required this.tenantName,
    required this.plan,
    required this.region,
    required this.storageGb,
    required this.active,
    required this.plans,
    required this.regions,
  });

  @override
  State<_ConfigureTenantDialog> createState() => _ConfigureTenantDialogState();
}

class _ConfigureTenantDialogState extends State<_ConfigureTenantDialog> {
  final _formKey = GlobalKey<FormState>();
  late String plan = widget.plan;
  late String region = widget.regions.firstWhere(
    (r) => r == widget.region || r.startsWith('${widget.region} ('),
    orElse: () => widget.regions.first,
  );
  late final TextEditingController storage = TextEditingController(
    text: '${widget.storageGb}',
  );
  late bool active = widget.active;

  @override
  void dispose() {
    storage.dispose();
    super.dispose();
  }

  String? _validateStorage(String? v) {
    final n = int.tryParse((v ?? '').trim());
    if (n == null) return 'Enter a valid storage limit';
    if (n <= 0) return 'Storage must be greater than 0';
    if (n > 100000) return 'Storage limit is too large';
    return null;
  }

  void _save() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    Navigator.of(context).pop(
      TenantConfigResult(
        plan: plan,
        region: region,
        storageGb: int.parse(storage.text.trim()),
        active: active,
      ),
    );
  }

  Widget _statusOption(bool value, String title, String subtitle) {
    final selected = active == value;

    return InkWell(
      borderRadius: BorderRadius.circular(6),
      onTap: () => setState(() => active = value),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 1),
              child: _RadioDot(selected: selected),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: _ink,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 11.5, color: _muted),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _Shell(
      maxWidth: 440,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Header(
                title: 'Configure Tenant',
                subtitle: 'Update the key settings for ${widget.tenantName}.',
                onClose: () => Navigator.of(context).pop(),
              ),
              const SizedBox(height: 18),
              const _FieldLabel('Subscription Plan', required: true),
              const SizedBox(height: 6),
              _Drop(
                value: plan,
                items: widget.plans,
                onChanged: (v) => setState(() => plan = v),
              ),
              const _Helper('Defines feature access and usage limits.'),
              const SizedBox(height: 14),
              const _FieldLabel('Region', required: true),
              const SizedBox(height: 6),
              _Drop(
                value: region,
                items: widget.regions,
                onChanged: (v) => setState(() => region = v),
              ),
              const _Helper('Select the primary region for this tenant.'),
              const SizedBox(height: 14),
              const _FieldLabel('Storage Limit', required: true),
              const SizedBox(height: 6),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: storage,
                      keyboardType: TextInputType.number,
                      validator: _validateStorage,
                      style: const TextStyle(fontSize: 13, color: _ink),
                      decoration: _dec().copyWith(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(6),
                          ),
                          borderSide: BorderSide(color: _control),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(6),
                          ),
                          borderSide: BorderSide(color: _control),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(6),
                          ),
                          borderSide: BorderSide(color: _blue, width: 1.4),
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(6),
                          ),
                          borderSide: BorderSide(color: _red),
                        ),
                        focusedErrorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(6),
                          ),
                          borderSide: BorderSide(color: _red, width: 1.4),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 56,
                    height: 44,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: _fill,
                      borderRadius: BorderRadius.horizontal(
                        right: Radius.circular(6),
                      ),
                      border: Border(
                        top: BorderSide(color: _control),
                        right: BorderSide(color: _control),
                        bottom: BorderSide(color: _control),
                      ),
                    ),
                    child: const Text(
                      'GB',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: _muted,
                      ),
                    ),
                  ),
                ],
              ),
              const _Helper('Maximum storage allowed for this tenant.'),
              const SizedBox(height: 14),
              const _FieldLabel('Status'),
              const SizedBox(height: 4),
              _statusOption(true, 'Active', 'Tenant can access the platform'),
              _statusOption(
                false,
                'Inactive',
                'Tenant access will be restricted',
              ),
              const SizedBox(height: 18),
              _Actions(
                confirmLabel: 'Save Changes',
                onCancel: () => Navigator.of(context).pop(),
                onConfirm: _save,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════
//  BACKUP TENANT
// ═════════════════════════════════════════════════════════════

class _BackupTenantDialog extends StatefulWidget {
  final String tenantName;
  const _BackupTenantDialog({required this.tenantName});

  @override
  State<_BackupTenantDialog> createState() => _BackupTenantDialogState();
}

class _BackupTenantDialogState extends State<_BackupTenantDialog> {
  static const Map<String, String> _types = {
    'Full Backup': 'Creates a complete backup of all tenant data.',
    'Incremental Backup':
        'Backs up only the data changed since the last backup.',
    'Differential Backup':
        'Backs up the data changed since the last full backup.',
  };

  static const Map<String, String> _locations = {
    'Cloud Storage (Default)':
        'Backup will be stored in the configured cloud storage.',
    'Secondary Region':
        'Backup will be copied to the secondary region vault.',
    'Local Storage': 'Backup will be stored on the local vault.',
  };

  String type = 'Full Backup';
  String location = 'Cloud Storage (Default)';

  @override
  Widget build(BuildContext context) {
    return _Shell(
      maxWidth: 440,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _Header(
              icon: Icons.storage_outlined,
              title: 'Backup Tenant',
              subtitle: 'Create a backup for ${widget.tenantName}.',
              onClose: () => Navigator.of(context).pop(),
            ),
            const SizedBox(height: 18),
            const _FieldLabel('Backup Type', required: true),
            const SizedBox(height: 6),
            _Drop(
              value: type,
              items: _types.keys.toList(),
              onChanged: (v) => setState(() => type = v),
            ),
            _Helper(_types[type]!),
            const SizedBox(height: 14),
            const _FieldLabel('Storage Location', required: true),
            const SizedBox(height: 6),
            _Drop(
              value: location,
              items: _locations.keys.toList(),
              onChanged: (v) => setState(() => location = v),
            ),
            _Helper(_locations[location]!),
            const SizedBox(height: 20),
            _Actions(
              confirmLabel: 'Start Backup',
              confirmIcon: Icons.storage_outlined,
              onCancel: () => Navigator.of(context).pop(),
              onConfirm: () => Navigator.of(context).pop(
                TenantBackupOptions(type: type, location: location),
              ),
            ),
          ],
        ),
      ),
    );
  }
}