import 'package:flutter/material.dart';

/// ---------------------------------------------------------------------------
/// One place for the app's font, colours and type scale.
///
/// * `MaterialApp(theme: AppTheme.light)` applies [AppFonts.sans] to every
///   `Text` in the app, so pages no longer need `fontFamily: 'Onest'` on each
///   style (pages that already set it keep working).
/// * New / refactored pages should take sizes from [AppType] and colours from
///   [AppColors] so every screen looks the same.
/// ---------------------------------------------------------------------------

class AppFonts {
  AppFonts._();

  /// Body / headings (already registered in pubspec.yaml and used by dialogs).
  static const String sans = 'Onest';

  /// Small upper-case labels ("TOTAL USERS", section captions, uptime...).
  static const String mono = 'monospace';
}

class AppColors {
  AppColors._();

  static const Color ink = Color(0xFF172536);
  static const Color muted = Color(0xFF61758A);
  static const Color hint = Color(0xFF8A9AB0);
  static const Color border = Color(0xFFE1E7EF);
  static const Color background = Color(0xFFF7F9FC);
  static const Color blue = Color(0xFF283BEA);
  static const Color navy = Color(0xFF242C66);
  static const Color green = Color(0xFF16A34A);
  static const Color amber = Color(0xFFD98A12);
  static const Color red = Color(0xFFE74760);
}

/// Type scale: [m] = phone (< 700px wide), [d] = desktop.
class AppType {
  AppType._();

  static const double breadcrumb = 12;
  static const double pageTitleM = 22, pageTitleD = 26;
  static const double pageSubtitle = 13;
  static const double sectionLabel = 11; // mono, letter-spaced
  static const double cardLabel = 10; // mono, upper-case
  static const double statValueM = 28, statValueD = 30;
  static const double delta = 13;
  static const double panelTitle = 16;
  static const double body = 14;
  static const double bodySmall = 12;
  static const double caption = 11;
}

class AppTheme {
  AppTheme._();

  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      fontFamily: AppFonts.sans,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.blue,
        primary: AppColors.blue,
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}