import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────
//  Public helpers – call these from your Global Dashboard page
// ─────────────────────────────────────────────────────────────

/// "Export report" button  → 1st popup
Future<ExportOptions?> showExportReportDialog(BuildContext context) {
  return showDialog<ExportOptions>(
    context: context,
    barrierColor: Colors.black54,
    builder: (_) => const ExportReportDialog(),
  );
}

/// Recent activities  "View"  → 2nd popup
Future<void> showRecentActivitiesDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    barrierColor: Colors.black54,
    builder: (_) => const RecentActivitiesDialog(),
  );
}

/// Security alerts  "View all alerts"  → 3rd popup
Future<void> showSecurityAlertsDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    barrierColor: Colors.black54,
    builder: (_) => const SecurityAlertsDialog(),
  );
}

// ─────────────────────────────────────────────────────────────
//  Shared colors / shell
// ─────────────────────────────────────────────────────────────

const Color _navy = Color(0xFF1B2559);
const Color _blue = Color(0xFF1728D8);
const Color _textDark = Color(0xFF111827);
const Color _textMuted = Color(0xFF6B7280);
const Color _border = Color(0xFFE5E7EB);

class _DialogShell extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget? trailing;
  final Widget child;
  final Widget? footer;
  final double maxWidth;

  const _DialogShell({
    required this.title,
    required this.subtitle,
    required this.child,
    this.trailing,
    this.footer,
    this.maxWidth = 420,
  });

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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 16, 12),
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
                            color: _textDark,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          subtitle,
                          style: const TextStyle(
                            fontFamily: 'Onest',
                            fontSize: 11.5,
                            color: _textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (trailing != null) ...[
                    trailing!,
                    const SizedBox(width: 10),
                  ],
                  InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    customBorder: const CircleBorder(),
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFFD1D5DB)),
                      ),
                      child: const Icon(Icons.close,
                          size: 14, color: _textMuted),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: _border),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: child,
              ),
            ),
            if (footer != null) ...[
              const Divider(height: 1, color: _border),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 14),
                child: footer!,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _RangeDropdown extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  const _RangeDropdown({this.onChanged});

  @override
  State<_RangeDropdown> createState() => _RangeDropdownState();
}

class _RangeDropdownState extends State<_RangeDropdown> {
  String _value = 'Last 7 Days';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 26,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFD1D5DB)),
        borderRadius: BorderRadius.circular(6),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _value,
          isDense: true,
          icon: const Icon(Icons.keyboard_arrow_down, size: 14),
          style: const TextStyle(
            fontFamily: 'Onest',
            fontSize: 10.5,
            color: _textDark,
          ),
          items: const ['Today', 'Last 7 Days', 'Last 30 Days']
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: (v) {
            if (v == null) return;
            setState(() => _value = v);
            widget.onChanged?.call(v);
          },
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  1) EXPORT REPORT DIALOG
// ─────────────────────────────────────────────────────────────

enum ExportFormat { pdf, csv, excel }

enum ExportRange { today, last7, last30 }

class ExportOptions {
  final ExportFormat format;
  final ExportRange range;
  final bool includeCharts;
  final bool includeTables;

  const ExportOptions({
    required this.format,
    required this.range,
    required this.includeCharts,
    required this.includeTables,
  });
}

class ExportReportDialog extends StatefulWidget {
  const ExportReportDialog({super.key});

  @override
  State<ExportReportDialog> createState() => _ExportReportDialogState();
}

class _ExportReportDialogState extends State<ExportReportDialog> {
  ExportFormat _format = ExportFormat.pdf;
  ExportRange _range = ExportRange.last30;
  bool _charts = false;
  bool _tables = false;

  @override
  Widget build(BuildContext context) {
    return _DialogShell(
      title: 'Export Global Dashboard Report',
      subtitle: 'Download a detailed summary of platform insights and performance.',
      maxWidth: 440,
      footer: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Cancel',
              style: TextStyle(
                fontFamily: 'Onest',
                fontSize: 12,
                color: _textDark,
              ),
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton.icon(
            onPressed: () => Navigator.of(context).pop(
              ExportOptions(
                format: _format,
                range: _range,
                includeCharts: _charts,
                includeTables: _tables,
              ),
            ),
            icon: const Icon(Icons.download_rounded, size: 16),
            label: const Text(
              'Download Export',
              style: TextStyle(
                fontFamily: 'Onest',
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: _blue,
              foregroundColor: Colors.white,
              elevation: 0,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionLabel('File Format'),
          const SizedBox(height: 8),
          Row(
            children: [
              _formatCard(ExportFormat.pdf, 'PDF Document',
                  Icons.picture_as_pdf_outlined),
              const SizedBox(width: 10),
              _formatCard(ExportFormat.csv, 'CSV (Raw Data)',
                  Icons.description_outlined),
              const SizedBox(width: 10),
              _formatCard(ExportFormat.excel, 'Excel Spreadsheet',
                  Icons.grid_on_rounded),
            ],
          ),
          const SizedBox(height: 18),
          const _SectionLabel('Telemetry & Usage Interval'),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _rangeChip(ExportRange.today, 'Today'),
              _rangeChip(ExportRange.last7, 'Last 7 Days'),
              _rangeChip(ExportRange.last30, 'Last 30 Days'),
            ],
          ),
          const SizedBox(height: 18),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: _border),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(12, 10, 12, 4),
                  child: _SectionLabel('Options'),
                ),
                _optionRow(
                  'Include Charts',
                  'Embed visual graphs in output',
                  _charts,
                  (v) => setState(() => _charts = v),
                ),
                const Divider(height: 1, color: _border),
                _optionRow(
                  'Include Detailed Tables',
                  'Append raw data rows',
                  _tables,
                  (v) => setState(() => _tables = v),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _formatCard(ExportFormat f, String label, IconData icon) {
    final bool sel = _format == f;
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () => setState(() => _format = f),
        child: Container(
          height: 76,
          padding: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: sel ? const Color(0xFFEEF2FF) : Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: sel ? _navy : _border,
              width: sel ? 1.5 : 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 22, color: sel ? _navy : _textMuted),
              const SizedBox(height: 6),
              Text(
                label,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextStyle(
                  fontFamily: 'Onest',
                  fontSize: 10.5,
                  fontWeight: sel ? FontWeight.w600 : FontWeight.w500,
                  color: sel ? _navy : _textMuted,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _rangeChip(ExportRange r, String label) {
    final bool sel = _range == r;
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () => setState(() => _range = r),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: sel ? _navy : const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Onest',
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: sel ? Colors.white : _textDark,
          ),
        ),
      ),
    );
  }

  Widget _optionRow(
    String title,
    String sub,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Onest',
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                    color: _textDark,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  sub,
                  style: const TextStyle(
                    fontFamily: 'Onest',
                    fontSize: 10,
                    color: _textMuted,
                  ),
                ),
              ],
            ),
          ),
          Transform.scale(
            scale: 0.8,
            child: Switch(
              value: value,
              onChanged: onChanged,
              activeTrackColor: _navy,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: 'Onest',
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: _textDark,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  2) RECENT ACTIVITIES DIALOG
// ─────────────────────────────────────────────────────────────

class ActivityItem {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final String time;

  const ActivityItem({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.time,
  });
}

class RecentActivitiesDialog extends StatelessWidget {
  final List<ActivityItem> items;

  const RecentActivitiesDialog({
    super.key,
    this.items = _defaultActivities,
  });

  static const List<ActivityItem> _defaultActivities = [
    ActivityItem(
      icon: Icons.warning_amber_rounded,
      color: Color(0xFFF59E0B),
      title: 'New Tenant Created',
      subtitle: 'by Admin users',
      time: '51 min ago',
    ),
    ActivityItem(
      icon: Icons.warning_amber_rounded,
      color: Color(0xFFF59E0B),
      title: 'License Updated',
      subtitle: 'by Admin users.',
      time: '1 hour ago',
    ),
    ActivityItem(
      icon: Icons.check_circle_outline,
      color: Color(0xFF16A34A),
      title: 'Backup Completed',
      subtitle: 'Daily snapshot of primary database cluster successful.',
      time: 'Yesterday',
    ),
    ActivityItem(
      icon: Icons.info_outline,
      color: Color(0xFF2563EB),
      title: 'User Added',
      subtitle: 'Superadmin granted access to monitoring module.',
      time: '3 hours ago',
    ),
    ActivityItem(
      icon: Icons.warning_amber_rounded,
      color: Color(0xFFF59E0B),
      title: 'License Updated',
      subtitle: 'by Admin users.',
      time: '1 hour ago',
    ),
    ActivityItem(
      icon: Icons.check_circle_outline,
      color: Color(0xFF16A34A),
      title: 'Backup Completed',
      subtitle: 'Daily snapshot of primary database cluster successful.',
      time: 'Yesterday',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return _DialogShell(
      title: 'Recent activities',
      subtitle: 'Track the latest platform activity',
      maxWidth: 400,
      trailing: const _RangeDropdown(),
      child: Column(
        children: [
          for (final a in items)
            Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(a.icon, size: 16, color: a.color),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          a.title,
                          style: const TextStyle(
                            fontFamily: 'Onest',
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                            color: _textDark,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          a.subtitle,
                          style: const TextStyle(
                            fontFamily: 'Onest',
                            fontSize: 10,
                            color: _textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    a.time,
                    style: const TextStyle(
                      fontFamily: 'Onest',
                      fontSize: 9.5,
                      color: _textMuted,
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

// ─────────────────────────────────────────────────────────────
//  3) SECURITY ALERTS DIALOG
// ─────────────────────────────────────────────────────────────

enum AlertLevel { high, info, caution }

class SecurityAlertItem {
  final AlertLevel level;
  final String title;
  final String message;
  final String time;

  const SecurityAlertItem({
    required this.level,
    required this.title,
    required this.message,
    required this.time,
  });
}

class SecurityAlertsDialog extends StatelessWidget {
  final List<SecurityAlertItem> items;

  const SecurityAlertsDialog({
    super.key,
    this.items = _defaultAlerts,
  });

  static const List<SecurityAlertItem> _defaultAlerts = [
    SecurityAlertItem(
      level: AlertLevel.high,
      title: 'High CPU Usage',
      message: 'Database server CPU usage is high',
      time: '1 hour ago',
    ),
    SecurityAlertItem(
      level: AlertLevel.info,
      title: 'Storage Threshold',
      message: 'Storage utilization reached 80%',
      time: '2 hour ago',
    ),
    SecurityAlertItem(
      level: AlertLevel.caution,
      title: 'New Tenant Registration',
      message: 'Techcorp solutions registered',
      time: '2 hour ago',
    ),
    SecurityAlertItem(
      level: AlertLevel.info,
      title: 'Storage Threshold',
      message: 'Storage utilization reached 80%',
      time: '3 hour ago',
    ),
    SecurityAlertItem(
      level: AlertLevel.high,
      title: 'High CPU Usage',
      message: 'Database server CPU usage is high',
      time: '6 hour ago',
    ),
  ];

  static Color _bg(AlertLevel l) {
    switch (l) {
      case AlertLevel.high:
        return const Color(0xFFFBEFD9);
      case AlertLevel.info:
        return const Color(0xFFE6EEFC);
      case AlertLevel.caution:
        return const Color(0xFFFFF7DB);
    }
  }

  static Color _fg(AlertLevel l) {
    switch (l) {
      case AlertLevel.high:
        return const Color(0xFFB45309);
      case AlertLevel.info:
        return const Color(0xFF1D4ED8);
      case AlertLevel.caution:
        return const Color(0xFFD97706);
    }
  }

  static IconData _icon(AlertLevel l) {
    switch (l) {
      case AlertLevel.high:
        return Icons.warning_amber_rounded;
      case AlertLevel.info:
        return Icons.change_history_rounded;
      case AlertLevel.caution:
        return Icons.error_outline_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _DialogShell(
      title: 'Security alerts',
      subtitle: 'Recent security events requiring attention',
      maxWidth: 400,
      trailing: const _RangeDropdown(),
      child: Column(
        children: [
          for (final a in items)
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: _bg(a.level),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 1),
                    child: Icon(_icon(a.level),
                        size: 14, color: _fg(a.level)),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                a.title,
                                style: TextStyle(
                                  fontFamily: 'Onest',
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w600,
                                  color: _fg(a.level),
                                ),
                              ),
                            ),
                            Text(
                              a.time,
                              style: const TextStyle(
                                fontFamily: 'Onest',
                                fontSize: 9.5,
                                color: _textMuted,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          a.message,
                          style: const TextStyle(
                            fontFamily: 'Onest',
                            fontSize: 10,
                            color: _textMuted,
                          ),
                        ),
                      ],
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