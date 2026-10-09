import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────
//  lib/widgets/license_dialogs.dart
//  Platform Administration → License Management popups
//
//  Each helper returns a Map with the entered values, or null
//  if the user cancelled / closed the popup.
// ─────────────────────────────────────────────────────────────

/// "Create License" button
Future<Map<String, dynamic>?> showCreateLicenseDialog(
  BuildContext context, {
  List<String> organizations = const ['123 Inc', 'Acme Corp', 'Globex Ltd'],
}) {
  return showDialog<Map<String, dynamic>>(
    context: context,
    barrierColor: Colors.black54,
    builder: (_) => CreateLicenseDialog(organizations: organizations),
  );
}

/// "Export" button
Future<Map<String, dynamic>?> showExportLicenseDialog(BuildContext context) {
  return showDialog<Map<String, dynamic>>(
    context: context,
    barrierColor: Colors.black54,
    builder: (_) => const ExportLicenseDialog(),
  );
}

/// "Renew" button  (pass the selected rows)
Future<Map<String, dynamic>?> showRenewLicenseDialog(
  BuildContext context, {
  required List<Map<String, String>> licenses,
}) {
  return showDialog<Map<String, dynamic>>(
    context: context,
    barrierColor: Colors.black54,
    builder: (_) => RenewLicenseDialog(licenses: licenses),
  );
}

/// "Suspend" button  (pass the selected rows)
Future<Map<String, dynamic>?> showSuspendLicenseDialog(
  BuildContext context, {
  required List<Map<String, String>> licenses,
}) {
  return showDialog<Map<String, dynamic>>(
    context: context,
    barrierColor: Colors.black54,
    builder: (_) => SuspendLicenseDialog(licenses: licenses),
  );
}

/// "Activate" button  (pass the selected rows)
Future<Map<String, dynamic>?> showActivateLicenseDialog(
  BuildContext context, {
  required List<Map<String, String>> licenses,
}) {
  return showDialog<Map<String, dynamic>>(
    context: context,
    barrierColor: Colors.black54,
    builder: (_) => ActivateLicenseDialog(licenses: licenses),
  );
}

// ─────────────────────────────────────────────────────────────
//  Shared style + helpers
// ─────────────────────────────────────────────────────────────

const Color _ink = Color(0xFF111827);
const Color _muted = Color(0xFF6B7280);
const Color _line = Color(0xFFE5E7EB);
const Color _blue = Color(0xFF334EEA);
const Color _amber = Color(0xFFF59E0B);

const TextStyle _inputStyle = TextStyle(
  fontFamily: 'Onest',
  fontSize: 11,
  color: _ink,
);

const List<String> _months = [
  'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
  'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
];

String _two(int n) => n.toString().padLeft(2, '0');

/// Sep 01,2026
String _fmt(DateTime d) => '${_months[d.month - 1]} ${_two(d.day)},${d.year}';

/// Nov 02, 2026
String _fmtLong(DateTime d) =>
    '${_months[d.month - 1]} ${_two(d.day)}, ${d.year}';

/// Parses "Nov 02, 2024"
DateTime? _parse(String s) {
  final p = s.replaceAll(',', ' ').trim().split(RegExp(r'\s+'));
  if (p.length < 3) return null;
  final m = _months.indexOf(p[0]);
  final d = int.tryParse(p[1]);
  final y = int.tryParse(p[2]);
  if (m < 0 || d == null || y == null) return null;
  return DateTime(y, m + 1, d);
}

DateTime _addMonths(DateTime d, int months) {
  final last = DateTime(d.year, d.month + months + 1, 0).day;
  return DateTime(d.year, d.month + months, d.day > last ? last : d.day);
}

InputDecoration _dec({String? hint, Widget? suffix}) {
  OutlineInputBorder b(Color c) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide(color: c),
      );
  return InputDecoration(
    isDense: true,
    hintText: hint,
    hintStyle: const TextStyle(
      fontFamily: 'Onest',
      fontSize: 11,
      color: Color(0xFF9CA3AF),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 11),
    border: b(_line),
    enabledBorder: b(_line),
    focusedBorder: b(_blue),
    errorBorder: b(Colors.red),
    focusedErrorBorder: b(Colors.red),
    errorStyle: const TextStyle(fontSize: 9, height: 1),
    suffixIcon: suffix,
    suffixIconConstraints: const BoxConstraints(minWidth: 32, minHeight: 32),
  );
}

// ─────────────────────────────────────────────────────────────
//  Building blocks
// ─────────────────────────────────────────────────────────────

class _Shell extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget child;
  final String confirmText;
  final IconData? confirmIcon;
  final VoidCallback onConfirm;
  final double maxWidth;

  const _Shell({
    required this.title,
    required this.child,
    required this.confirmText,
    required this.onConfirm,
    this.subtitle,
    this.confirmIcon,
    this.maxWidth = 440,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      clipBehavior: Clip.antiAlias,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth,
          maxHeight: MediaQuery.of(context).size.height - 48,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 16, 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontFamily: 'Onest',
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: _ink,
                          ),
                        ),
                        if (subtitle != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            subtitle!,
                            style: const TextStyle(
                              fontFamily: 'Onest',
                              fontSize: 11,
                              color: _muted,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    customBorder: const CircleBorder(),
                    child: Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFFD1D5DB)),
                      ),
                      child: const Icon(Icons.close, size: 13, color: _muted),
                    ),
                  ),
                ],
              ),
            ),
            // Flexible lets the form scroll inside the dialog instead of
            // overflowing ("BOTTOM OVERFLOWED BY 31 PIXELS") on short screens.
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
                child: child,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: _ink,
                      side: const BorderSide(color: _line),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 11),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(fontFamily: 'Onest', fontSize: 11.5),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton.icon(
                    onPressed: onConfirm,
                    icon: confirmIcon == null
                        ? const SizedBox.shrink()
                        : Icon(confirmIcon, size: 14),
                    label: Text(
                      confirmText,
                      style: const TextStyle(
                        fontFamily: 'Onest',
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _blue,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
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

class _Label extends StatelessWidget {
  final String text;
  const _Label(this.text);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Text(
          text,
          style: const TextStyle(
            fontFamily: 'Onest',
            fontSize: 10.5,
            fontWeight: FontWeight.w600,
            color: _ink,
          ),
        ),
      );
}

class _Gap extends StatelessWidget {
  const _Gap();
  @override
  Widget build(BuildContext context) => const SizedBox(height: 12);
}

class _Row2 extends StatelessWidget {
  final Widget a;
  final Widget b;
  const _Row2(this.a, this.b);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        if (c.maxWidth < 380) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [a, const SizedBox(height: 12), b],
          );
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: a),
            const SizedBox(width: 12),
            Expanded(child: b),
          ],
        );
      },
    );
  }
}

class _Text extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? hint;
  final TextInputType? keyboardType;
  final bool required;

  const _Text({
    required this.label,
    required this.controller,
    this.hint,
    this.keyboardType,
    this.required = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Label(label),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          style: _inputStyle,
          validator: required
              ? (v) => (v == null || v.trim().isEmpty) ? 'Required' : null
              : null,
          decoration: _dec(hint: hint),
        ),
      ],
    );
  }
}

class _Drop extends StatelessWidget {
  final String label;
  final String? value;
  final String? hint;
  final List<String> items;
  final ValueChanged<String> onChanged;
  final bool required;

  const _Drop({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.hint,
    this.required = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Label(label),
        DropdownButtonFormField<String>(
          value: value,
          isDense: true,
          isExpanded: true,
          style: _inputStyle,
          hint: Text(hint ?? '', style: _inputStyle.copyWith(color: _muted)),
          icon: const Icon(Icons.keyboard_arrow_down, size: 16),
          decoration: _dec(),
          validator:
              required ? (v) => v == null ? 'Required' : null : null,
          items: items
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: (v) {
            if (v != null) onChanged(v);
          },
        ),
      ],
    );
  }
}

class _DateField extends StatelessWidget {
  final String label;
  final DateTime? value;
  final ValueChanged<DateTime> onChanged;
  final bool readOnly;
  final bool longFormat;
  final DateTime? firstDate;

  const _DateField({
    required this.label,
    required this.value,
    required this.onChanged,
    this.readOnly = false,
    this.longFormat = false,
    this.firstDate,
  });

  Future<void> _pick(BuildContext context) async {
    final now = DateTime.now();
    final d = await showDatePicker(
      context: context,
      initialDate: value ?? now,
      firstDate: firstDate ?? DateTime(now.year - 5),
      lastDate: DateTime(now.year + 15),
    );
    if (d != null) onChanged(d);
  }

  @override
  Widget build(BuildContext context) {
    final text = value == null
        ? 'Select date'
        : (longFormat ? _fmtLong(value!) : _fmt(value!));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Label(label),
        InkWell(
          onTap: readOnly ? null : () => _pick(context),
          borderRadius: BorderRadius.circular(6),
          child: InputDecorator(
            decoration: _dec(
              suffix: const Icon(Icons.calendar_today_outlined,
                  size: 13, color: _muted),
            ),
            child: Text(
              text,
              style: _inputStyle.copyWith(
                color: value == null ? _muted : _ink,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Check extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  const _Check({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 18,
      height: 18,
      child: Checkbox(
        value: value,
        onChanged: (v) => onChanged(v ?? false),
        activeColor: _blue,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.compact,
        side: const BorderSide(color: Color(0xFF9CA3AF), width: 1.2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;
  const _StatusBadge(this.status);

  @override
  Widget build(BuildContext context) {
    Color fg;
    Color bg;
    switch (status.toLowerCase()) {
      case 'active':
        fg = const Color(0xFF16A34A);
        bg = const Color(0xFFDCFCE7);
        break;
      case 'expiring':
        fg = const Color(0xFFB45309);
        bg = const Color(0xFFFEF3C7);
        break;
      default: // Rejected / Suspended / Expired
        fg = const Color(0xFFDC2626);
        bg = const Color(0xFFFEE2E2);
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.circle, size: 5, color: fg),
          const SizedBox(width: 4),
          Text(
            status,
            style: TextStyle(
              fontFamily: 'Onest',
              fontSize: 9.5,
              fontWeight: FontWeight.w500,
              color: fg,
            ),
          ),
        ],
      ),
    );
  }
}

/// "Selected License (3)" list used by Renew / Suspend / Activate.
class _SelectedLicenses extends StatelessWidget {
  final List<Map<String, String>> licenses;
  final Set<int> checked;
  final String expiryLabel;
  final ValueChanged<int> onToggle;

  const _SelectedLicenses({
    required this.licenses,
    required this.checked,
    required this.expiryLabel,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    const small = TextStyle(fontFamily: 'Onest', fontSize: 9.5, color: _muted);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Selected License (${licenses.length})',
          style: const TextStyle(
            fontFamily: 'Onest',
            fontSize: 10.5,
            fontWeight: FontWeight.w600,
            color: _ink,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: _line),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            children: [
              for (var i = 0; i < licenses.length; i++) ...[
                if (i > 0) const Divider(height: 1, color: _line),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
                  child: Row(
                    children: [
                      _Check(
                        value: checked.contains(i),
                        onChanged: (_) => onToggle(i),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        flex: 5,
                        child: Text(
                          licenses[i]['key'] ?? '',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: _ink,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(expiryLabel, style: small),
                            const SizedBox(height: 2),
                            Text(
                              licenses[i]['expiry'] ?? '',
                              style: const TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 10,
                                color: _ink,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              licenses[i]['plan'] ?? '',
                              style: const TextStyle(
                                fontFamily: 'Onest',
                                fontSize: 10,
                                color: _ink,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(licenses[i]['seats'] ?? '', style: small),
                          ],
                        ),
                      ),
                      _StatusBadge(licenses[i]['status'] ?? ''),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _InfoNote extends StatelessWidget {
  final String text;
  const _InfoNote(this.text);

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Container(
            width: 14,
            height: 14,
            decoration: const BoxDecoration(
              color: _amber,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.priority_high,
                size: 10, color: Colors.white),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontFamily: 'Onest',
                fontSize: 10.5,
                color: _ink,
              ),
            ),
          ),
        ],
      );
}

class _ErrorText extends StatelessWidget {
  final String? text;
  const _ErrorText(this.text);

  @override
  Widget build(BuildContext context) => text == null
      ? const SizedBox.shrink()
      : Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            text!,
            style: const TextStyle(
              fontFamily: 'Onest',
              fontSize: 10,
              color: Colors.red,
            ),
          ),
        );
}

// ─────────────────────────────────────────────────────────────
//  1) CREATE LICENSE
// ─────────────────────────────────────────────────────────────

class CreateLicenseDialog extends StatefulWidget {
  final List<String> organizations;
  const CreateLicenseDialog({super.key, required this.organizations});

  @override
  State<CreateLicenseDialog> createState() => _CreateLicenseDialogState();
}

class _CreateLicenseDialogState extends State<CreateLicenseDialog> {
  final _formKey = GlobalKey<FormState>();
  final _seats = TextEditingController(text: '50');

  String? _org;
  String _plan = 'Standard';
  String _type = 'Enterprise';
  String _status = 'Active';
  DateTime _start = DateTime.now();
  late DateTime _expiry = _addMonths(DateTime.now(), 12);
  bool _autoRenew = true;
  String? _dateError;

  @override
  void dispose() {
    _seats.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    if (!_expiry.isAfter(_start)) {
      setState(() => _dateError = 'Expiry date must be after start date');
      return;
    }
    Navigator.of(context).pop({
      'organization': _org,
      'plan': _plan,
      'type': _type,
      'seats': int.tryParse(_seats.text.trim()) ?? 0,
      'status': _status,
      'startDate': _start,
      'expiryDate': _expiry,
      'autoRenew': _autoRenew,
    });
  }

  @override
  Widget build(BuildContext context) {
    return _Shell(
      title: 'Create License',
      subtitle: 'Create a new platform license',
      confirmText: 'Create',
      onConfirm: _save,
      maxWidth: 420,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _Drop(
              label: 'Organization',
              value: _org,
              hint: 'Select Organization',
              items: widget.organizations,
              required: true,
              onChanged: (v) => setState(() => _org = v),
            ),
            const _Gap(),
            _Row2(
              _Drop(
                label: 'Organization Plan',
                value: _plan,
                items: const ['Standard', 'Professional', 'Enterprise'],
                onChanged: (v) => setState(() => _plan = v),
              ),
              _Drop(
                label: 'License Type',
                value: _type,
                items: const ['Enterprise', 'Subscription', 'Trial'],
                onChanged: (v) => setState(() => _type = v),
              ),
            ),
            const _Gap(),
            _Row2(
              _Text(
                label: 'Number of Seats',
                controller: _seats,
                keyboardType: TextInputType.number,
                required: true,
              ),
              _Drop(
                label: 'License Status',
                value: _status,
                items: const ['Active', 'Expiring', 'Suspended'],
                onChanged: (v) => setState(() => _status = v),
              ),
            ),
            const _Gap(),
            _Row2(
              _DateField(
                label: 'Start Date',
                value: _start,
                onChanged: (d) => setState(() {
                  _start = d;
                  _dateError = null;
                }),
              ),
              _DateField(
                label: 'Expiry Date',
                value: _expiry,
                firstDate: _start,
                onChanged: (d) => setState(() {
                  _expiry = d;
                  _dateError = null;
                }),
              ),
            ),
            _ErrorText(_dateError),
            const _Gap(),
            Row(
              children: [
                const Expanded(child: _Label('Auto Renewal')),
                Text(
                  _autoRenew ? 'ON' : 'OFF',
                  style: const TextStyle(
                    fontFamily: 'Onest',
                    fontSize: 10.5,
                    fontWeight: FontWeight.w600,
                    color: _ink,
                  ),
                ),
                const SizedBox(width: 4),
                Transform.scale(
                  scale: 0.8,
                  child: Switch(
                    value: _autoRenew,
                    activeTrackColor: _blue,
                    onChanged: (v) => setState(() => _autoRenew = v),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  2) EXPORT OPTIONS
// ─────────────────────────────────────────────────────────────

class ExportLicenseDialog extends StatefulWidget {
  const ExportLicenseDialog({super.key});

  @override
  State<ExportLicenseDialog> createState() => _ExportLicenseDialogState();
}

class _ExportLicenseDialogState extends State<ExportLicenseDialog> {
  static const _columns = [
    'License Key',
    'Organization Plan',
    'License Type',
    'Expiry Date',
    'License Status',
  ];
  static const _formats = [
    ['CSV', 'CSV (Comma-Separated Values)'],
    ['PDF', 'PDF'],
    ['XLSX', 'Excel (XLSX)'],
  ];

  final Set<String> _selected = {};
  DateTime _start = DateTime.now();
  late DateTime _end = _addMonths(DateTime.now(), 12);
  String _format = 'XLSX';
  String? _error;

  void _save() {
    if (_end.isBefore(_start)) {
      setState(() => _error = 'End date must be after start date');
      return;
    }
    Navigator.of(context).pop({
      // empty list = export every column
      'columns': _selected.isEmpty ? _columns : _selected.toList(),
      'startDate': _start,
      'endDate': _end,
      'format': _format,
    });
  }

  @override
  Widget build(BuildContext context) {
    return _Shell(
      title: 'Export Options',
      confirmText: 'Download Export',
      confirmIcon: Icons.download_outlined,
      onConfirm: _save,
      maxWidth: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const _Label('Specific Data'),
          for (final c in _columns)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3.5),
              child: Row(
                children: [
                  _Check(
                    value: _selected.contains(c),
                    onChanged: (v) => setState(() {
                      v ? _selected.add(c) : _selected.remove(c);
                    }),
                  ),
                  const SizedBox(width: 8),
                  Text(c, style: _inputStyle),
                ],
              ),
            ),
          const _Gap(),
          const _Label('Date Range'),
          _Row2(
            _DateField(
              label: 'Start Date',
              value: _start,
              onChanged: (d) => setState(() {
                _start = d;
                _error = null;
              }),
            ),
            _DateField(
              label: 'End Date',
              value: _end,
              onChanged: (d) => setState(() {
                _end = d;
                _error = null;
              }),
            ),
          ),
          _ErrorText(_error),
          const _Gap(),
          const _Label('Select Format'),
          for (final f in _formats)
            InkWell(
              onTap: () => setState(() => _format = f[0]),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    Icon(
                      _format == f[0]
                          ? Icons.radio_button_checked
                          : Icons.radio_button_unchecked,
                      size: 16,
                      color: _format == f[0] ? _blue : _muted,
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.description_outlined,
                        size: 16, color: _muted),
                    const SizedBox(width: 6),
                    Expanded(child: Text(f[1], style: _inputStyle)),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  3) RENEW LICENSE
// ─────────────────────────────────────────────────────────────

class RenewLicenseDialog extends StatefulWidget {
  final List<Map<String, String>> licenses;
  const RenewLicenseDialog({super.key, required this.licenses});

  @override
  State<RenewLicenseDialog> createState() => _RenewLicenseDialogState();
}

class _RenewLicenseDialogState extends State<RenewLicenseDialog> {
  static const _periods = {
    '6 Months': 6,
    '1 Year': 12,
    '2 Years': 24,
    '3 Years': 36,
  };

  late final Set<int> _checked =
      {for (var i = 0; i < widget.licenses.length; i++) i};
  final _reason = TextEditingController();
  String _period = '1 Year';
  String? _error;

  @override
  void dispose() {
    _reason.dispose();
    super.dispose();
  }

  /// Latest current expiry among the checked rows + chosen period.
  DateTime get _newExpiry {
    DateTime base = DateTime.now();
    for (final i in _checked) {
      final d = _parse(widget.licenses[i]['expiry'] ?? '');
      if (d != null && d.isAfter(base)) base = d;
    }
    return _addMonths(base, _periods[_period]!);
  }

  void _save() {
    if (_checked.isEmpty) {
      setState(() => _error = 'Select at least one license');
      return;
    }
    Navigator.of(context).pop({
      'licenses': [for (final i in _checked) widget.licenses[i]['key']],
      'period': _period,
      'newExpiry': _newExpiry,
      'reason': _reason.text.trim(),
    });
  }

  @override
  Widget build(BuildContext context) {
    final n = _checked.length;
    return _Shell(
      title: 'Renew License',
      subtitle: 'Extend the selected license validity period',
      confirmText: 'Renew',
      onConfirm: _save,
      maxWidth: 520,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SelectedLicenses(
            licenses: widget.licenses,
            checked: _checked,
            expiryLabel: 'Current Expiry',
            onToggle: (i) => setState(() {
              _checked.contains(i) ? _checked.remove(i) : _checked.add(i);
              _error = null;
            }),
          ),
          const SizedBox(height: 12),
          _InfoNote('$n license${n == 1 ? '' : 's'} selected for renewal'),
          _ErrorText(_error),
          const _Gap(),
          _Row2(
            _Drop(
              label: 'Renew Period',
              value: _period,
              items: _periods.keys.toList(),
              onChanged: (v) => setState(() => _period = v),
            ),
            _DateField(
              label: 'New Expiry Date',
              value: _newExpiry,
              readOnly: true,
              longFormat: true,
              onChanged: (_) {},
            ),
          ),
          const _Gap(),
          _Text(
            label: 'Renew Reason',
            controller: _reason,
            hint: 'Enter the reason',
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  4) SUSPEND LICENSE
// ─────────────────────────────────────────────────────────────

class SuspendLicenseDialog extends StatefulWidget {
  final List<Map<String, String>> licenses;
  const SuspendLicenseDialog({super.key, required this.licenses});

  @override
  State<SuspendLicenseDialog> createState() => _SuspendLicenseDialogState();
}

class _SuspendLicenseDialogState extends State<SuspendLicenseDialog> {
  late final Set<int> _checked =
      {for (var i = 0; i < widget.licenses.length; i++) i};
  final _reason = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _reason.dispose();
    super.dispose();
  }

  void _save() {
    if (_checked.isEmpty) {
      setState(() => _error = 'Select at least one license');
      return;
    }
    if (_reason.text.trim().isEmpty) {
      setState(() => _error = 'Please enter a suspend reason');
      return;
    }
    Navigator.of(context).pop({
      'licenses': [for (final i in _checked) widget.licenses[i]['key']],
      'reason': _reason.text.trim(),
    });
  }

  @override
  Widget build(BuildContext context) {
    final n = _checked.length;
    return _Shell(
      title: 'Suspend License',
      subtitle: 'You are about to suspend the selected license',
      confirmText: 'Suspend',
      onConfirm: _save,
      maxWidth: 520,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SelectedLicenses(
            licenses: widget.licenses,
            checked: _checked,
            expiryLabel: 'Expiry Date',
            onToggle: (i) => setState(() {
              _checked.contains(i) ? _checked.remove(i) : _checked.add(i);
              _error = null;
            }),
          ),
          const SizedBox(height: 12),
          _InfoNote('$n license${n == 1 ? '' : 's'} selected for suspension'),
          const _Gap(),
          _Text(
            label: 'Suspend Reason',
            controller: _reason,
            hint: 'Enter the reason',
          ),
          _ErrorText(_error),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  5) ACTIVATE LICENSE
// ─────────────────────────────────────────────────────────────

class ActivateLicenseDialog extends StatefulWidget {
  final List<Map<String, String>> licenses;
  const ActivateLicenseDialog({super.key, required this.licenses});

  @override
  State<ActivateLicenseDialog> createState() => _ActivateLicenseDialogState();
}

class _ActivateLicenseDialogState extends State<ActivateLicenseDialog> {
  late final Set<int> _checked =
      {for (var i = 0; i < widget.licenses.length; i++) i};
  final _reason = TextEditingController();
  DateTime _date = DateTime.now();
  String? _error;

  @override
  void dispose() {
    _reason.dispose();
    super.dispose();
  }

  void _save() {
    if (_checked.isEmpty) {
      setState(() => _error = 'Select at least one license');
      return;
    }
    Navigator.of(context).pop({
      'licenses': [for (final i in _checked) widget.licenses[i]['key']],
      'activationDate': _date,
      'reason': _reason.text.trim(),
    });
  }

  @override
  Widget build(BuildContext context) {
    final n = _checked.length;
    return _Shell(
      title: 'Activate License',
      subtitle: 'The license will become available for the organization',
      confirmText: 'Activate',
      onConfirm: _save,
      maxWidth: 520,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SelectedLicenses(
            licenses: widget.licenses,
            checked: _checked,
            expiryLabel: 'Current Expiry',
            onToggle: (i) => setState(() {
              _checked.contains(i) ? _checked.remove(i) : _checked.add(i);
              _error = null;
            }),
          ),
          const SizedBox(height: 12),
          _InfoNote('$n license${n == 1 ? '' : 's'} selected for activation'),
          _ErrorText(_error),
          const _Gap(),
          _DateField(
            label: 'Activation Date',
            value: _date,
            longFormat: true,
            onChanged: (d) => setState(() => _date = d),
          ),
          const _Gap(),
          _Text(
            label: 'Activation Reason',
            controller: _reason,
            hint: 'Enter the reason',
          ),
        ],
      ),
    );
  }
}