import 'package:flutter/material.dart';


class SystemHealthPage extends StatelessWidget {
  const SystemHealthPage({super.key});

  // ---------------------------------------------------------------------
  // Design tokens
  // ---------------------------------------------------------------------
  static const _ink = Color(0xFF172536);
  static const _muted = Color(0xFF61758A);
  static const _hint = Color(0xFF8A9AB0);
  static const _border = Color(0xFFDDE4EC);
  static const _bg = Color(0xFFF7F9FC);
  static const _green = Color(0xFF16A34A);
  static const _amber = Color(0xFFD98A12);
  static const _red = Color(0xFFDC2626);
  static const _mono = 'monospace';

  // ---------------------------------------------------------------------
  // Data
  // ---------------------------------------------------------------------
  static const List<_Service> _services = [
    _Service('Auth Service', 'JWT issuance · SSO · MFA', '99.99%',
        _Health.healthy),
    _Service('API Gateway', 'avg. response 118ms', '99.98%', _Health.healthy),
    _Service('Database Cluster', 'elevated replication lag — investigating',
        '99.91%', _Health.degraded),
    _Service('Message Queue', '0 dead-letter events', '100%', _Health.healthy),
    _Service('Object Storage', 'files & document uploads', '99.99%',
        _Health.healthy),
    _Service('AI Engine', 'Copilot & automation inference', '99.95%',
        _Health.healthy),
  ];

  static const List<_Incident> _incidents = [
    _Incident(
      title: 'Database Cluster — elevated replication lag',
      body:
          'Read replicas are lagging ~2.4s behind primary. No tenant-facing errors detected; monitoring for further drift.',
      meta: 'Started 08:12 UTC · investigating',
      health: _Health.degraded,
    ),
  ];

  int _count(_Health h) => _services.where((s) => s.health == h).length;

  static Color _color(_Health h) {
    switch (h) {
      case _Health.healthy:
        return _green;
      case _Health.degraded:
        return _amber;
      case _Health.failed:
        return _red;
    }
  }

  // ---------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, c) {
            final mobile = c.maxWidth < 700;
            return SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                mobile ? 16 : 24,
                mobile ? 16 : 24,
                mobile ? 16 : 24,
                28,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _heading(mobile),
                  SizedBox(height: mobile ? 14 : 20),
                  _stats(mobile),
                  SizedBox(height: mobile ? 20 : 22),
                  _sectionLabel('MONITORED SERVICES', mobile),
                  SizedBox(height: mobile ? 10 : 12),
                  _serviceList(mobile),
                  SizedBox(height: mobile ? 20 : 22),
                  _sectionLabel('ACTIVE INCIDENTS', mobile),
                  SizedBox(height: mobile ? 10 : 12),
                  ..._incidents.map((i) => _incidentCard(i, mobile)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------
  // Heading
  // ---------------------------------------------------------------------
  Widget _heading(bool mobile) {
    if (mobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Platform Administration / Platform Health Overview',
            style: TextStyle(fontSize: 10, color: _hint),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Platform Health Overview',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: _ink,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                padding: EdgeInsets.zero,
                constraints:
                    const BoxConstraints(minWidth: 30, minHeight: 30),
                icon: const Icon(Icons.sync,
                    size: 22, color: Color(0xFF52616F)),
              ),
            ],
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Text('Platform Administration',
                style: TextStyle(fontSize: 12, color: _muted)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6),
              child: Text('/', style: TextStyle(fontSize: 12, color: _muted)),
            ),
            Text(
              'Platform Health Overview',
              style: TextStyle(
                  fontSize: 12, color: _ink, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            const Expanded(
              child: Text(
                'Platform Health Overview',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: _ink,
                ),
              ),
            ),
            SizedBox(
              height: 32,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.sync, size: 15),
                label: const Text('Refresh',
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF253341),
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: Color(0xFFD8E0E8)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------
  // Stat cards
  // ---------------------------------------------------------------------
  Widget _stats(bool mobile) {
    final healthy = _StatTile(
      value: '${_count(_Health.healthy)}',
      label: 'HEALTHY',
      color: _green,
      mobile: mobile,
    );
    final degraded = _StatTile(
      value: '${_count(_Health.degraded)}',
      label: 'DEGRADED',
      color: _amber,
      mobile: mobile,
    );
    final failed = _StatTile(
      value: '${_count(_Health.failed)}',
      label: 'FAILED',
      color: mobile ? const Color(0xFFE11D48) : const Color(0xFFB42318),
      mobile: mobile,
    );
    final uptime = _UptimeTile(mobile: mobile);

    if (mobile) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(child: healthy),
              const SizedBox(width: 12),
              Expanded(child: degraded),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: failed),
              const SizedBox(width: 12),
              Expanded(child: uptime),
            ],
          ),
        ],
      );
    }

    return Row(
      children: [
        Expanded(child: healthy),
        const SizedBox(width: 16),
        Expanded(child: degraded),
        const SizedBox(width: 16),
        Expanded(child: failed),
        const SizedBox(width: 16),
        Expanded(child: uptime),
      ],
    );
  }

  Widget _sectionLabel(String text, bool mobile) {
    return Text(
      text,
      style: TextStyle(
        fontSize: mobile ? 11 : 14,
        fontWeight: mobile ? FontWeight.w700 : FontWeight.w500,
        color: mobile ? _hint : const Color(0xFF5A6B80),
        letterSpacing: mobile ? .8 : .5,
      ),
    );
  }

  // ---------------------------------------------------------------------
  // Services
  // ---------------------------------------------------------------------
  Widget _serviceList(bool mobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: mobile ? 16 : 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(mobile ? 14 : 10),
        border: Border.all(color: _border),
      ),
      child: Column(
        children: [
          for (var i = 0; i < _services.length; i++) ...[
            _serviceRow(_services[i], mobile),
            if (i != _services.length - 1)
              const Divider(height: 1, thickness: 1, color: Color(0xFFE8EDF3)),
          ],
        ],
      ),
    );
  }

  Widget _serviceRow(_Service s, bool mobile) {
    final dot = Container(
      width: 9,
      height: 9,
      margin: EdgeInsets.only(top: mobile ? 5 : 4),
      decoration: BoxDecoration(color: _color(s.health), shape: BoxShape.circle),
    );

    final info = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          s.name,
          style: TextStyle(
            fontSize: mobile ? 14 : 14,
            fontWeight: mobile ? FontWeight.w700 : FontWeight.w600,
            color: _ink,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          s.detail,
          style: TextStyle(fontSize: mobile ? 11 : 12, color: _muted),
        ),
      ],
    );

    final uptime = Text(
      '${s.uptime} uptime',
      style: TextStyle(
        fontFamily: _mono,
        fontSize: mobile ? 12 : 13,
        color: const Color(0xFF3B4756),
      ),
    );

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: mobile ? 0 : 20,
        vertical: mobile ? 16 : 14,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          dot,
          const SizedBox(width: 14),
          Expanded(child: info),
          const SizedBox(width: 12),
          Padding(
            padding: EdgeInsets.only(top: mobile ? 8 : 6),
            child: uptime,
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------
  // Incidents
  // ---------------------------------------------------------------------
  Widget _incidentCard(_Incident i, bool mobile) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.fromLTRB(mobile ? 16 : 20, 16, mobile ? 16 : 20, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(mobile ? 14 : 10),
        border: Border.all(color: _border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 9,
            height: 9,
            margin: const EdgeInsets.only(top: 5),
            decoration:
                BoxDecoration(color: _color(i.health), shape: BoxShape.circle),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  i.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: _ink,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  i.body,
                  style: TextStyle(
                    fontSize: mobile ? 13 : 12,
                    height: mobile ? 1.5 : 1.4,
                    color: const Color(0xFF4A5A6E),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  i.meta,
                  style: const TextStyle(
                    fontFamily: _mono,
                    fontSize: 11,
                    color: _hint,
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

// ---------------------------------------------------------------------------
// Models
// ---------------------------------------------------------------------------
enum _Health { healthy, degraded, failed }

class _Service {
  final String name, detail, uptime;
  final _Health health;
  const _Service(this.name, this.detail, this.uptime, this.health);
}

class _Incident {
  final String title, body, meta;
  final _Health health;
  const _Incident({
    required this.title,
    required this.body,
    required this.meta,
    required this.health,
  });
}

// ---------------------------------------------------------------------------
// Stat widgets
// ---------------------------------------------------------------------------
class _StatTile extends StatelessWidget {
  final String value, label;
  final Color color;
  final bool mobile;

  const _StatTile({
    required this.value,
    required this.label,
    required this.color,
    required this.mobile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: mobile ? 92 : 89,
      padding: EdgeInsets.symmetric(horizontal: mobile ? 18 : 20, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(mobile ? 14 : 10),
        border: Border.all(color: const Color(0xFFDDE4EC)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: mobile ? 26 : 28,
              fontWeight: FontWeight.w700,
              color: color,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 10,
              letterSpacing: 1,
              color: Color(0xFF7C8DA3),
            ),
          ),
        ],
      ),
    );
  }
}

class _UptimeTile extends StatelessWidget {
  final bool mobile;
  const _UptimeTile({required this.mobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: mobile ? 92 : 89,
      padding: EdgeInsets.symmetric(horizontal: mobile ? 18 : 20, vertical: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(mobile ? 14 : 10),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF2F46F0), Color(0xFF1B2160)],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '99.98%',
            style: TextStyle(
              fontSize: mobile ? 24 : 28,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Aggregate uptime (30d)',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: mobile ? null : 'monospace',
              fontSize: mobile ? 11 : 10,
              fontWeight: FontWeight.w600,
              color: Colors.white.withValues(alpha: .92),
            ),
          ),
        ],
      ),
    );
  }
}