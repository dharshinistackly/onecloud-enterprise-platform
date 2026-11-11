import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

/// ---------------------------------------------------------------------------
/// Shared look & feel for every Tenant Management page.
///
/// Mirrors the Platform Administration pages so both modules feel identical:
///   breadcrumb  ->  26px title  ->  34px / radius-6 buttons  ->
///   white cards with a #E1E7EF border  ->  mono captions  ->  tinted badges.
///
/// Colours / fonts come from lib/theme/app_theme.dart (AppColors, AppType),
/// so changing the theme there updates this module as well.
/// ---------------------------------------------------------------------------

class TUi {
  TUi._();

  // ---- colours ------------------------------------------------------------
  static const Color bg = AppColors.background;
  static const Color ink = AppColors.ink;
  static const Color muted = AppColors.muted;
  static const Color hint = AppColors.hint;
  static const Color border = AppColors.border; // cards
  static const Color controlBorder = Color(0xFFD8E0E8); // buttons / inputs
  static const Color divider = Color(0xFFE8EDF3);
  static const Color fieldFill = Color(0xFFF8FAFC);
  static const Color blue = AppColors.blue;
  static const Color navy = AppColors.navy;
  static const Color green = AppColors.green;
  static const Color amber = AppColors.amber;
  static const Color red = AppColors.red;
  static const Color accent = Color(0xFF1268C4); // small section icons
  static const Color captionColor = Color(0xFF7C8DA3);
  static const Color buttonText = Color(0xFF253341);

  // ---- layout -------------------------------------------------------------
  static bool isMobile(double width) => width < 700;

  static EdgeInsets pagePadding(bool mobile) => EdgeInsets.fromLTRB(
        mobile ? 16 : 24,
        mobile ? 16 : 20,
        mobile ? 16 : 24,
        28,
      );

  static double titleSize(bool mobile) =>
      mobile ? AppType.pageTitleM : AppType.pageTitleD;

  // ---- decorations --------------------------------------------------------
  static BoxDecoration cardBox({double radius = 12, Color? color}) {
    return BoxDecoration(
      color: color ?? Colors.white,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: border),
    );
  }

  /// Text-field / dropdown decoration used by every form control.
  static InputDecoration input({
    String? hint,
    Widget? prefixIcon,
    Widget? suffixIcon,
    Color? fill,
    bool dense = true,
    double minHeight = 44,
  }) {
    OutlineInputBorder outline(Color color, [double width = 1]) {
      return OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide(color: color, width: width),
      );
    }

    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(fontSize: 13, color: TUi.hint),
      filled: true,
      fillColor: fill ?? fieldFill,
      isDense: dense,
      constraints: BoxConstraints(minHeight: minHeight),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      border: outline(controlBorder),
      enabledBorder: outline(controlBorder),
      disabledBorder: outline(divider),
      focusedBorder: outline(blue, 1.4),
      errorBorder: outline(red),
      focusedErrorBorder: outline(red, 1.4),
      errorStyle: const TextStyle(fontSize: 11, color: red),
    );
  }

  static const TextStyle fieldText = TextStyle(fontSize: 13, color: ink);

  static const TextStyle labelStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: Color(0xFF334155),
  );

  static const TextStyle captionStyle = TextStyle(
    fontFamily: AppFonts.mono,
    fontSize: AppType.sectionLabel,
    letterSpacing: 1.2,
    color: captionColor,
  );

  /// Header text of navy data tables.
  static const TextStyle tableHeader = TextStyle(
    fontFamily: AppFonts.mono,
    fontSize: 11,
    letterSpacing: 0.8,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static const TextStyle tableCell = TextStyle(fontSize: 13, color: ink);

  /// Themed switch (same on every page).
  static Widget toggle({
    required bool value,
    required ValueChanged<bool>? onChanged,
  }) {
    return Switch(
      value: value,
      onChanged: onChanged,
      activeThumbColor: Colors.white,
      activeTrackColor: blue,
      inactiveThumbColor: Colors.white,
      inactiveTrackColor: const Color(0xFFB6BDCC),
      trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}

// ===========================================================================
// BREADCRUMB   Platform Administration / Tenant Management / <page>
// ===========================================================================
class TBreadcrumb extends StatelessWidget {
  /// Everything after "Platform Administration". The last item is the
  /// current page and is drawn darker.
  final List<String> trail;

  /// Optional colour overrides (the branding page has a dark mode).
  final Color? mutedColor;
  final Color? strongColor;

  const TBreadcrumb(this.trail, {super.key, this.mutedColor, this.strongColor});

  @override
  Widget build(BuildContext context) {
    final items = [ ...trail];
    final muted = mutedColor ?? TUi.muted;
    final strong = strongColor ?? TUi.ink;

    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        for (var i = 0; i < items.length; i++) ...[
          Text(
            items[i],
            style: TextStyle(
              fontSize: AppType.breadcrumb,
              color: i == items.length - 1 ? strong : muted,
              fontWeight:
                  i == items.length - 1 ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
          if (i != items.length - 1)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Text(
                '/',
                style: TextStyle(fontSize: AppType.breadcrumb, color: muted),
              ),
            ),
        ],
      ],
    );
  }
}

// ===========================================================================
// PAGE HEADER   title + subtitle on the left, action buttons on the right
// ===========================================================================
class TPageHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final List<Widget> actions;
  final bool mobile;
  final Color? titleColor;
  final Color? subtitleColor;

  const TPageHeader({
    super.key,
    required this.title,
    required this.mobile,
    this.subtitle,
    this.actions = const [],
    this.titleColor,
    this.subtitleColor,
  });

  @override
  Widget build(BuildContext context) {
    final titleBlock = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: TUi.titleSize(mobile),
            fontWeight: FontWeight.w700,
            color: titleColor ?? TUi.ink,
            height: 1.2,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 6),
          Text(
            subtitle!,
            style: TextStyle(
              fontSize: AppType.pageSubtitle,
              height: 1.4,
              color: subtitleColor ?? TUi.muted,
            ),
          ),
        ],
      ],
    );

    if (mobile || actions.isEmpty) return titleBlock;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: titleBlock),
        const SizedBox(width: 16),
        for (var i = 0; i < actions.length; i++) ...[
          if (i > 0) const SizedBox(width: 10),
          actions[i],
        ],
      ],
    );
  }
}

// ===========================================================================
// BUTTON
// ===========================================================================
enum TButtonKind { primary, outline, danger, success }

class TButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback? onPressed;
  final TButtonKind kind;
  final double height;
  final bool loading;

  /// Stretch to the full width of the parent (phone footers).
  final bool expand;

  /// Smaller variant for table rows / bulk bars.
  final bool compact;

  const TButton(
    this.label, {
    super.key,
    required this.onPressed,
    this.icon,
    this.kind = TButtonKind.outline,
    this.height = 34,
    this.loading = false,
    this.expand = false,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6),
    );
    final h = compact ? 30.0 : height;
    final iconSize = compact ? 14.0 : 16.0;
    final fontSize = compact ? 11.0 : 12.0;
    final disabled = onPressed == null || loading;

    final Color accent;
    switch (kind) {
      case TButtonKind.danger:
        accent = TUi.red;
        break;
      case TButtonKind.success:
        accent = TUi.green;
        break;
      case TButtonKind.primary:
        accent = Colors.white;
        break;
      case TButtonKind.outline:
        accent = TUi.buttonText;
        break;
    }

    final content = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (loading)
          SizedBox(
            width: 14,
            height: 14,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: kind == TButtonKind.primary ? Colors.white : TUi.blue,
            ),
          )
        else if (icon != null)
          Icon(icon, size: iconSize),
        if (loading || icon != null) const SizedBox(width: 6),
        Flexible(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );

    final padding = EdgeInsets.symmetric(horizontal: compact ? 10 : 14);

    final Widget button;
    if (kind == TButtonKind.primary) {
      button = ElevatedButton(
        onPressed: disabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: TUi.blue,
          foregroundColor: Colors.white,
          disabledBackgroundColor: TUi.blue.withValues(alpha: 0.55),
          disabledForegroundColor: Colors.white,
          elevation: 0,
          padding: padding,
          minimumSize: Size(0, h),
          shape: shape,
        ),
        child: content,
      );
    } else {
      final tinted = kind != TButtonKind.outline;
      button = OutlinedButton(
        onPressed: disabled ? null : onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: accent,
          backgroundColor: Colors.white,
          padding: padding,
          minimumSize: Size(0, h),
          side: BorderSide(
            color: tinted ? accent.withValues(alpha: 0.45) : TUi.controlBorder,
          ),
          shape: shape,
        ),
        child: content,
      );
    }

    return SizedBox(
      height: h,
      width: expand ? double.infinity : null,
      child: button,
    );
  }
}

// ===========================================================================
// SECTION CARD   white card, light header strip with icon + title
// ===========================================================================
class TCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final Widget? trailing;
  final Widget child;
  final EdgeInsetsGeometry padding;

  const TCard({
    super.key,
    required this.title,
    required this.child,
    this.subtitle,
    this.icon,
    this.trailing,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: TUi.cardBox(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: TUi.fieldFill,
              border: Border(bottom: BorderSide(color: TUi.divider)),
            ),
            child: Row(
              children: [
                if (icon != null) ...[
                  Icon(icon, size: 16, color: TUi.accent),
                  const SizedBox(width: 8),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: TUi.ink,
                        ),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          subtitle!,
                          style: const TextStyle(
                            fontSize: AppType.bodySmall,
                            color: TUi.muted,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (trailing != null) ...[
                  const SizedBox(width: 8),
                  trailing!,
                ],
              ],
            ),
          ),
          Padding(padding: padding, child: child),
        ],
      ),
    );
  }
}

// ===========================================================================
// SMALL PIECES
// ===========================================================================

/// Upper-case mono caption ("TENANT LIST").
class TCaption extends StatelessWidget {
  final String text;
  const TCaption(this.text, {super.key});

  @override
  Widget build(BuildContext context) => Text(text, style: TUi.captionStyle);
}

/// Label above a form control.
class TLabel extends StatelessWidget {
  final String text;
  final bool required;
  const TLabel(this.text, {super.key, this.required = false});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: text,
        style: TUi.labelStyle,
        children: [
          if (required)
            const TextSpan(text: ' *', style: TextStyle(color: TUi.red)),
        ],
      ),
    );
  }
}

enum TTone { success, danger, warning, neutral, info }

/// Status pill with a leading dot - same look as the license status badge.
class TStatusBadge extends StatelessWidget {
  final String label;
  final TTone tone;
  const TStatusBadge(this.label, {super.key, required this.tone});

  @override
  Widget build(BuildContext context) {
    final Color bg;
    final Color fg;
    switch (tone) {
      case TTone.success:
        bg = const Color(0xFFE5F8EF);
        fg = const Color(0xFF00A96B);
        break;
      case TTone.danger:
        bg = const Color(0xFFFFE8EC);
        fg = TUi.red;
        break;
      case TTone.warning:
        bg = const Color(0xFFFFF3D5);
        fg = const Color(0xFFE99500);
        break;
      case TTone.info:
        bg = const Color(0xFFE8EEFF);
        fg = const Color(0xFF3B5BDB);
        break;
      case TTone.neutral:
        bg = const Color(0xFFE5E7EB);
        fg = const Color(0xFF4B5563);
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.circle, size: 6, color: fg),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: fg,
            ),
          ),
        ],
      ),
    );
  }
}

/// Light blue information strip.
class TInfoNote extends StatelessWidget {
  final String text;
  final IconData icon;
  const TInfoNote(this.text, {super.key, this.icon = Icons.info_outline});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5FF),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFD8E5FF)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: TUi.accent),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: AppType.bodySmall,
                height: 1.4,
                color: Color(0xFF334E8A),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Square pagination button (number or chevron).
class TPageButton extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final bool selected;
  final bool enabled;
  final VoidCallback onTap;

  const TPageButton({
    super.key,
    required this.onTap,
    this.text,
    this.icon,
    this.selected = false,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 32,
      height: 32,
      child: OutlinedButton(
        onPressed: enabled ? onTap : null,
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: selected ? TUi.navy : Colors.white,
          foregroundColor: selected ? Colors.white : const Color(0xFF4F5D6B),
          side: BorderSide(
            color: selected ? TUi.navy : const Color(0xFFDDE3E9),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: icon != null
            ? Icon(icon, size: 16)
            : Text(text ?? '', style: const TextStyle(fontSize: 12)),
      ),
    );
  }
}

/// Tappable filter chip that opens a menu (same as the License filters).
class TFilter extends StatelessWidget {
  final String label;
  final String value;
  final List<String> options;
  final ValueChanged<String> onChanged;
  final bool compact;

  const TFilter({
    super.key,
    required this.label,
    required this.value,
    required this.options,
    required this.onChanged,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final isAll = value == 'All';

    return PopupMenuButton<String>(
      tooltip: label,
      offset: const Offset(0, 42),
      onSelected: onChanged,
      itemBuilder: (_) => [
        for (final option in options)
          PopupMenuItem<String>(
            value: option,
            child: Text(
              option == 'All' ? 'All $label' : option,
              style: const TextStyle(fontSize: 13),
            ),
          ),
      ],
      child: Container(
        height: compact ? 36 : 40,
        width: compact ? double.infinity : 150,
        padding: EdgeInsets.symmetric(horizontal: compact ? 8 : 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: TUi.controlBorder),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                isAll ? label : value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: compact ? 12 : 13,
                  color: isAll ? const Color(0xFF5E6873) : TUi.ink,
                ),
              ),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.keyboard_arrow_down,
              size: 16,
              color: Color(0xFF5E6E80),
            ),
          ],
        ),
      ),
    );
  }
}
