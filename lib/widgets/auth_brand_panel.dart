import 'dart:math' as math;

import 'package:flutter/material.dart';

class AuthBrandPanel extends StatelessWidget {
  final bool isMobile;
  final bool showGraphic;
  final bool compactMobile;
  final bool showHeadline;
  final Color? backgroundColor;
  final bool showSignInButton;
  final VoidCallback? onSignIn;

  const AuthBrandPanel({
    super.key,
    required this.isMobile,
    this.showGraphic = true,
    this.compactMobile = false,
    this.showHeadline = true,
    this.backgroundColor,
    this.showSignInButton = false,
    this.onSignIn,
  });

  static const Color _bg = Color(0xFF02040B);
  static const Color _blue = Color(0xFF2F6BFF);
  static const Color _muted = Color(0xFF9AA3B8);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double panelWidth = constraints.maxWidth;
        final double hPad = isMobile ? 24 : 40;

        final double contentWidth = math.max(
          200.0,
          panelWidth - (hPad * 2),
        );

        final double titleSize =
            (panelWidth * 0.062).clamp(22.0, 46.0).toDouble();

        final double graphicWidth = math.min(
          contentWidth,
          isMobile ? 360.0 : 470.0,
        );

        final Widget tagline = Text(
          'CLOUD PLATFORM  ·  HRMS  ·  CRM  ·  ERP  ·  FINANCE  ·  AI',
          style: TextStyle(
            color: _muted,
            fontFamily: 'monospace',
            fontSize: isMobile ? 8.5 : 10,
            fontWeight: FontWeight.w500,
            letterSpacing: isMobile ? 1.2 : 1.6,
            height: 1.6,
          ),
        );

        final TextStyle titleStyle = TextStyle(
          color: Colors.white,
          fontFamily: 'Onest',
          fontSize: titleSize,
          fontWeight: FontWeight.w600,
          height: 1.0,
          letterSpacing: -0.3,
        );

        final Widget header = Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _StacklyLogo(
              height: isMobile ? 30 : 36,
            ),
            SizedBox(height: isMobile ? 18 : 30),
            // On mobile keep the tagline on ONE line (scale down if needed)
            if (isMobile)
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: tagline,
              )
            else
              tagline,
            if (showHeadline) ...[
              SizedBox(height: isMobile ? 10 : 16),
              Text('One identity.', style: titleStyle),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Infinite',
                      style: titleStyle.copyWith(color: _blue),
                    ),
                    TextSpan(
                      text: ' Potential.',
                      style: titleStyle,
                    ),
                  ],
                ),
              ),
            ],
          ],
        );

        final Widget graphic = Center(
          child: _HeroGraphic(
            width: graphicWidth,
            compact: isMobile,
          ),
        );

        final Widget footer = _BrandFooter(
          isMobile: isMobile,
        );

        if (isMobile) {
          if (compactMobile) {
            return Container(
              width: double.infinity,
              height: 203.4,
              color: backgroundColor ?? _bg,
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _StacklyLogo(height: 30),
                  const SizedBox(height: 15),
                  const Text(
                    'CLOUD PLATFORM  ·  HRMS  ·  CRM  ·  ERP  ·  FINANCE  ·  AI',
                    maxLines: 3,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      color: _muted,
                      fontFamily: 'monospace',
                      fontSize: 9.5,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.14,
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'One identity.',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Onest',
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      height: 1.0,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Infinite',
                          style: TextStyle(
                            color: _blue,
                            fontFamily: 'Onest',
                            fontSize: 26,
                            fontWeight: FontWeight.w600,
                            height: 1.0,
                            letterSpacing: -0.26,
                          ),
                        ),
                        TextSpan(
                          text: ' Potential.',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Onest',
                            fontSize: 26,
                            fontWeight: FontWeight.w600,
                            height: 1.0,
                            letterSpacing: -0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }

          return Container(
            width: double.infinity,
            height: constraints.maxHeight,
            color: backgroundColor ?? _bg,
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                header,
                const Spacer(),
                graphic,
                if (showSignInButton) ...[
                  const Spacer(),
                  Center(
                    child: SizedBox(
                      width: contentWidth * 0.78,
                      height: 44,
                      child: ElevatedButton(
                        onPressed: onSignIn,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1728D8),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'SIGN IN',
                          style: TextStyle(
                            fontFamily: 'Onest',
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.6,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 42),
                footer,
                if (showSignInButton) ...[
                  const Spacer(),
                  const Text(
                    'SecureScalableFuture-Ready',
                    style: TextStyle(
                      color: Color(0xFF8C95AD),
                      fontFamily: 'Onest',
                      fontSize: 10,
                    ),
                  ),
                ],
              ],
            ),
          );
        }

        return Container(
          width: double.infinity,
          color: backgroundColor ?? _bg,
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  hPad,
                  34,
                  hPad,
                  28,
                ),
                child: Column(
                  mainAxisAlignment: showGraphic
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    header,
                    if (showGraphic) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 24,
                        ),
                        child: graphic,
                      ),
                      footer,
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _StacklyLogo extends StatelessWidget {
  final double height;

  const _StacklyLogo({
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/stackly_logo_light.png',
      height: height,
      fit: BoxFit.contain,
      alignment: Alignment.centerLeft,
      errorBuilder: (context, error, stackTrace) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: height,
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  height * 0.28,
                ),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF2F6BFF),
                    Color(0xFF52D6FF),
                  ],
                ),
              ),
              child: Icon(
                Icons.bolt_rounded,
                color: Colors.white,
                size: height * 0.66,
              ),
            ),
            SizedBox(
              width: height * 0.32,
            ),
            Text(
              'STACKLY',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Onest',
                fontSize: height * 0.56,
                fontWeight: FontWeight.w600,
                letterSpacing: height * 0.07,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _BrandFooter extends StatelessWidget {
  final bool isMobile;

  const _BrandFooter({
    required this.isMobile,
  });

  static const Color _blue = Color(0xFF2F6BFF);
  static const Color _muted = Color(0xFF9AA3B8);

  @override
  Widget build(BuildContext context) {
    const List<String> labels = [
      'Secure',
      'Scalable',
      'Future-Ready',
    ];

    final Widget items = Wrap(
      spacing: isMobile ? 16 : 28,
      runSpacing: 6,
      crossAxisAlignment: WrapCrossAlignment.end,
      children: [
        for (int i = 0; i < labels.length; i++)
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isMobile) ...[
                Container(
                  width: 22,
                  height: 2,
                  color: i == 0
                      ? _blue
                      : Colors.transparent,
                ),
                const SizedBox(height: 7),
              ],
              Text(
                labels[i],
                style: TextStyle(
                  color: (i == 0 && !isMobile)
                      ? Colors.white.withValues(alpha: 0.85)
                      : _muted,
                  fontFamily: 'Onest',
                  fontSize: isMobile ? 10 : 10.5,
                  letterSpacing: 0.4,
                ),
              ),
            ],
          ),
      ],
    );

    if (isMobile) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(child: items),
          const SizedBox(width: 12),
          const Text(
            'BUILT FOR\nA BRIGHTER\nTOMORROW',
            textAlign: TextAlign.right,
            style: TextStyle(
              color: _muted,
              fontFamily: 'monospace',
              fontSize: 7.5,
              letterSpacing: 1.2,
              height: 1.35,
            ),
          ),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: items,
        ),
        const SizedBox(width: 16),
        const Text(
          'BUILT FOR\nA BRIGHTER\nTOMORROW',
          textAlign: TextAlign.right,
          style: TextStyle(
            color: _muted,
            fontFamily: 'monospace',
            fontSize: 8.5,
            letterSpacing: 1.6,
            height: 1.55,
          ),
        ),
      ],
    );
  }
}

class _Geo {
  final bool compact;

  const _Geo(this.compact);

  double get baseW => 340;
  double get baseH => compact ? 270 : 330;

  double get cx => 170;
  double get cy => compact ? 135 : 165;

  double get dx => compact ? 112 : 113;
  double get dy => compact ? 76 : 96;

  double get rx => compact ? 152 : 150;
  double get ry => compact ? 112 : 150;

  double get cardW => 108;
  double get cardH => compact ? 86 : 92;
}

class _HeroGraphic extends StatelessWidget {
  final double width;
  final bool compact;

  const _HeroGraphic({
    required this.width,
    required this.compact,
  });

  @override
  Widget build(BuildContext context) {
    final _Geo geo = _Geo(compact);
    final double scale = width / geo.baseW;

    return SizedBox(
      width: width,
      height: geo.baseH * scale,
      child: FittedBox(
        fit: BoxFit.contain,
        child: SizedBox(
          width: geo.baseW,
          height: geo.baseH,
          child: _GraphicCanvas(
            geo: geo,
          ),
        ),
      ),
    );
  }
}

class _GraphicCanvas extends StatelessWidget {
  final _Geo geo;

  const _GraphicCanvas({
    required this.geo,
  });

  static const Color _blue = Color(0xFF2F6BFF);

  @override
  Widget build(BuildContext context) {
    Widget card({
      required double sx,
      required double sy,
      required IconData icon,
      required String title,
      required String subtitle,
    }) {
      return Positioned(
        left: geo.cx +
            (sx * geo.dx) -
            (geo.cardW / 2),
        top: geo.cy +
            (sy * geo.dy) -
            (geo.cardH / 2),
        width: geo.cardW,
        height: geo.cardH,
        child: _FeatureCard(
          icon: icon,
          title: title,
          subtitle: subtitle,
          compact: geo.compact,
        ),
      );
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned.fill(
          child: CustomPaint(
            painter: _RingPainter(geo),
          ),
        ),
        card(
          sx: -1,
          sy: -1,
          icon: Icons.groups_2_outlined,
          title: 'People',
          subtitle: 'Manage users & teams',
        ),
        card(
          sx: 1,
          sy: -1,
          icon: Icons.view_in_ar_outlined,
          title: 'Applications',
          subtitle: 'Integrate & manage',
        ),
        card(
          sx: -1,
          sy: 1,
          icon: Icons.shield_outlined,
          title: 'Security',
          subtitle: 'Protect every access',
        ),
        card(
          sx: 1,
          sy: 1,
          icon: Icons.bar_chart_rounded,
          title: 'Analytics',
          subtitle: 'Turn data into insights',
        ),
        Positioned(
          left: geo.cx - 28,
          top: geo.cy - 28,
          width: 56,
          height: 56,
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF12224F),
                  Color(0xFF070C22),
                ],
              ),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: const Color(0xFF4A86FF),
                width: 1.4,
              ),
              boxShadow: [
                BoxShadow(
                  color: _blue.withValues(alpha: 0.65),
                  blurRadius: 26,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: const Text(
              '1E',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Onest',
                fontSize: 22,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.3,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool compact;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.compact,
  });

  static const Color _blue = Color(0xFF2F6BFF);

  @override
  Widget build(BuildContext context) {
    final double pad = compact ? 9 : 10;

    return Container(
      padding: EdgeInsets.all(pad),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0E1630),
            Color(0xFF070B1C),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _blue.withValues(alpha: 0.38),
        ),
        boxShadow: [
          BoxShadow(
            color: _blue.withValues(alpha: 0.18),
            blurRadius: 18,
          ),
        ],
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.topLeft,
        child: SizedBox(
          width: 108 - (pad * 2),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: _blue.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: _blue.withValues(alpha: 0.35),
                  ),
                ),
                child: Icon(
                  icon,
                  size: 13,
                  color: const Color(0xFF6FA1FF),
                ),
              ),
              SizedBox(
                height: compact ? 6 : 8,
              ),
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Onest',
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Color(0xFF8C95AD),
                  fontFamily: 'Onest',
                  fontSize: 8.5,
                  height: 1.25,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  final _Geo geo;

  _RingPainter(this.geo);

  @override
  void paint(Canvas canvas, Size size) {
    final Offset c = Offset(
      geo.cx,
      geo.cy,
    );

    final Rect ring = Rect.fromCenter(
      center: c,
      width: geo.rx * 2,
      height: geo.ry * 2,
    );

    final Rect glowRect = Rect.fromCircle(
      center: c,
      radius: geo.rx * 1.5,
    );

    canvas.drawCircle(
      c,
      geo.rx * 1.5,
      Paint()
        ..shader = RadialGradient(
          colors: [
            const Color(0xFF2F6BFF).withValues(alpha: 0.20),
            const Color(0xFF2F6BFF).withValues(alpha: 0.0),
          ],
        ).createShader(glowRect),
    );

    final Paint line = Paint()
      ..color = const Color(0xFF6F86C7).withValues(alpha: 0.45)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    for (final double sx in [-1.0, 1.0]) {
      for (final double sy in [-1.0, 1.0]) {
        canvas.drawLine(
          c,
          Offset(
            c.dx + sx * geo.dx,
            c.dy + sy * geo.dy,
          ),
          line,
        );
      }
    }

    canvas.drawOval(
      ring.inflate(12),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1
        ..color = const Color(0xFF2F6BFF).withValues(alpha: 0.30),
    );

    canvas.drawOval(
      ring,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 24
        ..color = const Color(0xFF1F5BFF).withValues(alpha: 0.35)
        ..maskFilter = const MaskFilter.blur(
          BlurStyle.normal,
          16,
        ),
    );

    canvas.drawOval(
      ring,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 11
        ..color = const Color(0xFF2F7BFF).withValues(alpha: 0.75)
        ..maskFilter = const MaskFilter.blur(
          BlurStyle.normal,
          6,
        ),
    );

    canvas.drawOval(
      ring,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 5
        ..shader = const SweepGradient(
          colors: [
            Color(0xFF52D6FF),
            Color(0xFF2F6BFF),
            Color(0xFF5B3DF5),
            Color(0xFF2F6BFF),
            Color(0xFF52D6FF),
          ],
          stops: [
            0.0,
            0.25,
            0.5,
            0.75,
            1.0,
          ],
        ).createShader(ring),
    );

    canvas.drawOval(
      ring.deflate(3.2),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2
        ..color = Colors.white.withValues(alpha: 0.75),
    );
  }

  @override
  bool shouldRepaint(
    covariant _RingPainter oldDelegate,
  ) {
    return oldDelegate.geo.compact != geo.compact;
  }
}