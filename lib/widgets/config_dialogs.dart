import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────
//  Public helpers – call from the "Configure" buttons
//  Each returns the saved values (Map) or null if cancelled.
// ─────────────────────────────────────────────────────────────

Future<Map<String, dynamic>?> showSmtpConfigDialog(
  BuildContext context, {
  Map<String, dynamic>? initial,
}) {
  return showDialog<Map<String, dynamic>>(
    context: context,
    barrierColor: Colors.black54,
    builder: (_) => SmtpConfigDialog(initial: initial),
  );
}

Future<Map<String, dynamic>?> showSmsGatewayDialog(
  BuildContext context, {
  Map<String, dynamic>? initial,
}) {
  return showDialog<Map<String, dynamic>>(
    context: context,
    barrierColor: Colors.black54,
    builder: (_) => SmsGatewayDialog(initial: initial),
  );
}

Future<Map<String, dynamic>?> showApiGatewayDialog(
  BuildContext context, {
  Map<String, dynamic>? initial,
}) {
  return showDialog<Map<String, dynamic>>(
    context: context,
    barrierColor: Colors.black54,
    builder: (_) => ApiGatewayDialog(initial: initial),
  );
}

// ─────────────────────────────────────────────────────────────
//  Shared styling + building blocks
// ─────────────────────────────────────────────────────────────

const Color _ink = Color(0xFF111827);
const Color _muted = Color(0xFF6B7280);
const Color _line = Color(0xFFE5E7EB);
const Color _blue = Color(0xFF334EEA);

InputDecoration _dec({Widget? suffix}) {
  OutlineInputBorder b(Color c) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide(color: c),
      );
  return InputDecoration(
    isDense: true,
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

const TextStyle _inputStyle = TextStyle(
  fontFamily: 'Onest',
  fontSize: 11,
  color: _ink,
);

Map<String, TextEditingController> _makeControllers(
  Map<String, String> defaults,
  Map<String, dynamic>? initial,
) {
  return {
    for (final e in defaults.entries)
      e.key: TextEditingController(
        text: (initial?[e.key] ?? e.value).toString(),
      ),
  };
}

class _ConfigShell extends StatelessWidget {
  final String title;
  final String subtitle;
  final GlobalKey<FormState> formKey;
  final Widget child;
  final VoidCallback onSave;
  final double maxWidth;

  const _ConfigShell({
    required this.title,
    required this.subtitle,
    required this.formKey,
    required this.child,
    required this.onSave,
    this.maxWidth = 520,
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
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'Onest',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: _ink,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontFamily: 'Onest',
                      fontSize: 10.5,
                      color: _muted,
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
                child: Form(key: formKey, child: child),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        fontFamily: 'Onest',
                        fontSize: 11.5,
                        color: _ink,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: onSave,
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
                    child: const Text(
                      'Save Configuration',
                      style: TextStyle(
                        fontFamily: 'Onest',
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
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
  final bool required;
  const _Label(this.text, this.required);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text.rich(
        TextSpan(
          text: text,
          style: const TextStyle(
            fontFamily: 'Onest',
            fontSize: 10.5,
            fontWeight: FontWeight.w500,
            color: _ink,
          ),
          children: [
            if (required)
              const TextSpan(
                text: ' *',
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
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
      padding: const EdgeInsets.only(top: 3),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Onest',
          fontSize: 9,
          color: _muted,
        ),
      ),
    );
  }
}

class _Field extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final bool required;
  final bool secret;
  final String? helper;
  final TextInputType? keyboardType;

  const _Field({
    required this.label,
    required this.controller,
    this.required = true,
    this.secret = false,
    this.helper,
    this.keyboardType,
  });

  @override
  State<_Field> createState() => _FieldState();
}

class _FieldState extends State<_Field> {
  late bool _hide = widget.secret;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Label(widget.label, widget.required),
        TextFormField(
          controller: widget.controller,
          obscureText: _hide,
          keyboardType: widget.keyboardType,
          style: _inputStyle,
          validator: widget.required
              ? (v) => (v == null || v.trim().isEmpty) ? 'Required' : null
              : null,
          decoration: _dec(
            suffix: widget.secret
                ? IconButton(
                    padding: EdgeInsets.zero,
                    iconSize: 16,
                    color: _muted,
                    icon: Icon(
                      _hide
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                    onPressed: () => setState(() => _hide = !_hide),
                  )
                : null,
          ),
        ),
        if (widget.helper != null) _Helper(widget.helper!),
      ],
    );
  }
}

class _Drop extends StatelessWidget {
  final String label;
  final String value;
  final List<String> items;
  final ValueChanged<String> onChanged;
  final bool required;

  const _Drop({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.required = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Label(label, required),
        DropdownButtonFormField<String>(
          value: value,
          isDense: true,
          isExpanded: true,
          style: _inputStyle,
          icon: const Icon(Icons.keyboard_arrow_down, size: 16),
          decoration: _dec(),
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

/// Two fields side by side; stacks on narrow screens.
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

class _Gap extends StatelessWidget {
  const _Gap();
  @override
  Widget build(BuildContext context) => const SizedBox(height: 12);
}

class _EnableSwitch extends StatelessWidget {
  final String label;
  final String text;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _EnableSwitch({
    required this.label,
    required this.text,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Label(label, false),
        Row(
          children: [
            Transform.scale(
              scale: 0.8,
              alignment: Alignment.centerLeft,
              child: Switch(
                value: value,
                onChanged: onChanged,
                activeTrackColor: _blue,
              ),
            ),
            Text(
              text,
              style: const TextStyle(
                fontFamily: 'Onest',
                fontSize: 10.5,
                color: _ink,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// "Test Connection" button. Pass [onTest] to run a real check;
/// without it the button only tells you no backend is connected yet.
class _TestButton extends StatefulWidget {
  final Future<bool> Function()? onTest;
  const _TestButton({this.onTest});

  @override
  State<_TestButton> createState() => _TestButtonState();
}

class _TestButtonState extends State<_TestButton> {
  bool _busy = false;
  String? _msg;
  bool _ok = false;

  Future<void> _run() async {
    if (widget.onTest == null) {
      setState(() {
        _msg = 'Test is not connected to a backend yet';
        _ok = false;
      });
      return;
    }
    setState(() {
      _busy = true;
      _msg = null;
    });
    bool ok;
    try {
      ok = await widget.onTest!();
    } catch (_) {
      ok = false;
    }
    if (!mounted) return;
    setState(() {
      _busy = false;
      _ok = ok;
      _msg = ok ? 'Connection successful' : 'Connection failed';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 30,
          child: OutlinedButton.icon(
            onPressed: _busy ? null : _run,
            icon: _busy
                ? const SizedBox(
                    width: 12,
                    height: 12,
                    child: CircularProgressIndicator(strokeWidth: 1.6),
                  )
                : const Icon(Icons.send_outlined, size: 13),
            label: const Text(
              'Test Connection',
              style: TextStyle(
                fontFamily: 'Onest',
                fontSize: 10.5,
                fontWeight: FontWeight.w500,
              ),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: _blue,
              side: const BorderSide(color: _blue),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ),
        if (_msg != null) ...[
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              _msg!,
              style: TextStyle(
                fontFamily: 'Onest',
                fontSize: 10,
                color: _ok ? const Color(0xFF16A34A) : _muted,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  1) SMTP
// ─────────────────────────────────────────────────────────────

class SmtpConfigDialog extends StatefulWidget {
  final Map<String, dynamic>? initial;
  final Future<bool> Function(Map<String, dynamic> values)? onTest;

  const SmtpConfigDialog({super.key, this.initial, this.onTest});

  @override
  State<SmtpConfigDialog> createState() => _SmtpConfigDialogState();
}

class _SmtpConfigDialogState extends State<SmtpConfigDialog> {
  final _formKey = GlobalKey<FormState>();
  late final Map<String, TextEditingController> _c = _makeControllers(
    const {
      'host': 'smtp.stackly.com',
      'port': '587',
      'username': 'noreply@stackly.com',
      'password': 'password123',
      'fromEmail': 'noreply@stackly.com',
      'fromName': 'Stackly Platform',
    },
    widget.initial,
  );
  late String _encryption =
      (widget.initial?['encryption'] ?? 'TLS').toString();

  Map<String, dynamic> _values() => {
        for (final e in _c.entries) e.key: e.value.text.trim(),
        'encryption': _encryption,
      };

  @override
  void dispose() {
    for (final c in _c.values) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _ConfigShell(
      title: 'Configure SMTP',
      subtitle:
          'Set your SMTP server details to enable outgoing email notifications.',
      maxWidth: 440,
      formKey: _formKey,
      onSave: () {
        if (_formKey.currentState!.validate()) {
          Navigator.of(context).pop(_values());
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _Field(label: 'SMTP Host', controller: _c['host']!),
          const _Gap(),
          _Field(
            label: 'Port',
            controller: _c['port']!,
            keyboardType: TextInputType.number,
          ),
          const _Gap(),
          _Field(label: 'User name', controller: _c['username']!),
          const _Gap(),
          _Field(
            label: 'Password',
            controller: _c['password']!,
            secret: true,
          ),
          const _Gap(),
          _Drop(
            label: 'Encryption',
            value: _encryption,
            items: const ['None', 'SSL', 'TLS', 'STARTTLS'],
            onChanged: (v) => setState(() => _encryption = v),
          ),
          const _Gap(),
          _Row2(
            _Field(label: 'From Email', controller: _c['fromEmail']!),
            _Field(label: 'From Name', controller: _c['fromName']!),
          ),
          const _Gap(),
          _TestButton(
            onTest: widget.onTest == null
                ? null
                : () => widget.onTest!(_values()),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  2) SMS GATEWAY
// ─────────────────────────────────────────────────────────────

class SmsGatewayDialog extends StatefulWidget {
  final Map<String, dynamic>? initial;
  final Future<bool> Function(Map<String, dynamic> values)? onTest;

  const SmsGatewayDialog({super.key, this.initial, this.onTest});

  @override
  State<SmsGatewayDialog> createState() => _SmsGatewayDialogState();
}

class _SmsGatewayDialogState extends State<SmsGatewayDialog> {
  final _formKey = GlobalKey<FormState>();
  late final Map<String, TextEditingController> _c = _makeControllers(
    const {
      'gatewayName': 'Stackly Primary',
      'baseUrl': 'https://api.stackly.com/2010-04-01',
      'accountSid': 'ACXXXXXXXXXXXXXXXXXXXX',
      'sender': '+14155552671',
      'timeout': '30',
      'authToken': 'xxxxxxxxxxxxxxxxxxxx',
      'messagingSid': 'MGXXXXXXXXXXXXXXXXXXXXXXXXXX',
    },
    widget.initial,
  );
  late String _provider = (widget.initial?['provider'] ?? 'Stackly').toString();
  late bool _enabled = widget.initial?['enabled'] as bool? ?? true;

  Map<String, dynamic> _values() => {
        for (final e in _c.entries) e.key: e.value.text.trim(),
        'provider': _provider,
        'enabled': _enabled,
      };

  @override
  void dispose() {
    for (final c in _c.values) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _ConfigShell(
      title: 'SMS Gateway Configuration',
      subtitle: 'Configure SMS gateway settings to send SMS from the application',
      formKey: _formKey,
      onSave: () {
        if (_formKey.currentState!.validate()) {
          Navigator.of(context).pop(_values());
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _Row2(
            _Drop(
              label: 'Gateway Provider',
              value: _provider,
              items: const ['Stackly', 'Twilio', 'Vonage', 'AWS SNS'],
              onChanged: (v) => setState(() => _provider = v),
            ),
            _Field(label: 'Gateway Name', controller: _c['gatewayName']!),
          ),
          const _Gap(),
          _Row2(
            _Field(
              label: 'API Base URL',
              controller: _c['baseUrl']!,
              helper: 'Base URL for Stackly API',
            ),
            _Field(
              label: 'Account SID',
              controller: _c['accountSid']!,
              secret: true,
              helper: 'Your Stackly Account SID',
            ),
          ),
          const _Gap(),
          _Row2(
            _Field(
              label: 'From Number / Sender ID',
              controller: _c['sender']!,
              helper: 'Phone number or sender ID to send SMS from',
            ),
            _Field(
              label: 'Connection Timeout (Seconds)',
              controller: _c['timeout']!,
              keyboardType: TextInputType.number,
              helper: 'Timeout for API requests',
            ),
          ),
          const _Gap(),
          _Row2(
            _Field(
              label: 'Auth Token',
              controller: _c['authToken']!,
              secret: true,
              helper: 'Your Stackly Auth Token',
            ),
            _Field(
              label: 'Messaging Service SID (Optional)',
              controller: _c['messagingSid']!,
              required: false,
              helper: 'Your Stackly Messaging Service SID',
            ),
          ),
          const _Gap(),
          _EnableSwitch(
            label: 'Enable Gateway',
            text: 'Enable this SMS gateway',
            value: _enabled,
            onChanged: (v) => setState(() => _enabled = v),
          ),
          const _Gap(),
          _TestButton(
            onTest: widget.onTest == null
                ? null
                : () => widget.onTest!(_values()),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  3) API GATEWAY
// ─────────────────────────────────────────────────────────────

class ApiGatewayDialog extends StatefulWidget {
  final Map<String, dynamic>? initial;
  final Future<bool> Function(Map<String, dynamic> values)? onTest;

  const ApiGatewayDialog({super.key, this.initial, this.onTest});

  @override
  State<ApiGatewayDialog> createState() => _ApiGatewayDialogState();
}

class _ApiGatewayDialogState extends State<ApiGatewayDialog> {
  final _formKey = GlobalKey<FormState>();
  late final Map<String, TextEditingController> _c = _makeControllers(
    const {
      'gatewayName': 'Main API Gateway',
      'baseUrl': 'https://api.stackly.com/V1',
      'apiVersion': 'V1',
      'apiKey': 'xxxxxxxxxxxxxxxxxxxx',
      'apiSecret': 'xxxxxxxxxxxxxxxxxxxx',
      'headerName': 'X-API-Key',
      'timeout': '30',
      'retries': '3',
      'rateLimit': '100',
    },
    widget.initial,
  );
  late String _environment =
      (widget.initial?['environment'] ?? 'Production').toString();
  late String _authType =
      (widget.initial?['authType'] ?? 'API Key').toString();
  late bool _enabled = widget.initial?['enabled'] as bool? ?? true;

  Map<String, dynamic> _values() => {
        for (final e in _c.entries) e.key: e.value.text.trim(),
        'environment': _environment,
        'authType': _authType,
        'enabled': _enabled,
      };

  @override
  void dispose() {
    for (final c in _c.values) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _ConfigShell(
      title: 'API Gateway Configuration',
      subtitle:
          'Configure API Gateway settings to connect and communicate with external services.',
      formKey: _formKey,
      onSave: () {
        if (_formKey.currentState!.validate()) {
          Navigator.of(context).pop(_values());
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _Row2(
            _Field(label: 'Gateway Name', controller: _c['gatewayName']!),
            _Drop(
              label: 'Environment',
              value: _environment,
              items: const ['Production', 'Staging', 'Development'],
              onChanged: (v) => setState(() => _environment = v),
            ),
          ),
          const _Gap(),
          _Row2(
            _Field(
              label: 'Base URL',
              controller: _c['baseUrl']!,
              helper: 'Base URL of the API Gateway',
            ),
            _Field(
              label: 'API Version',
              controller: _c['apiVersion']!,
              helper: 'API version (e.g. v1, v2)',
            ),
          ),
          const _Gap(),
          _Row2(
            _Drop(
              label: 'Authentication Type',
              value: _authType,
              items: const ['API Key', 'Bearer Token', 'Basic Auth', 'OAuth 2.0'],
              onChanged: (v) => setState(() => _authType = v),
            ),
            _Field(
              label: 'API Key',
              controller: _c['apiKey']!,
              secret: true,
            ),
          ),
          const _Gap(),
          _Row2(
            _Field(
              label: 'API Secret',
              controller: _c['apiSecret']!,
              secret: true,
              helper: 'Secret used to authenticate API requests',
            ),
            _Field(
              label: 'Header Name (Optional)',
              controller: _c['headerName']!,
              required: false,
              helper: 'Custom header name for API key (if required)',
            ),
          ),
          const _Gap(),
          _Row2(
            _Field(
              label: 'Request Timeout (Seconds)',
              controller: _c['timeout']!,
              keyboardType: TextInputType.number,
              helper: 'Timeout for API requests',
            ),
            _Field(
              label: 'Retry Attempts',
              controller: _c['retries']!,
              keyboardType: TextInputType.number,
              helper: 'Number of retry attempts on failure',
            ),
          ),
          const _Gap(),
          _Row2(
            _Field(
              label: 'Rate Limit (requests/minute)',
              controller: _c['rateLimit']!,
              keyboardType: TextInputType.number,
              helper: 'Maximum number of requests allowed per minute',
            ),
            _EnableSwitch(
              label: 'Enable Gateway',
              text: 'Enable the API gateway',
              value: _enabled,
              onChanged: (v) => setState(() => _enabled = v),
            ),
          ),
          const _Gap(),
          _TestButton(
            onTest: widget.onTest == null
                ? null
                : () => widget.onTest!(_values()),
          ),
        ],
      ),
    );
  }
}