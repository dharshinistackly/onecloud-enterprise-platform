import 'package:flutter/material.dart';

import '../routes/app_routes.dart';
import '../widgets/auth_brand_panel.dart';
import 'login_page.dart' show GoogleLogo, MicrosoftLogo;

/// Shown after the user taps Google / Microsoft / Company SSO on the login
/// page. The provider name arrives as the route argument:
///
///   Navigator.pushNamed(context, AppRoutes.socialLogin, arguments: 'Google');
///
/// Design = the login page: dark brand panel on the left (top on phones),
/// white form with the same colours, type sizes, buttons and real provider
/// logos (GoogleLogo / MicrosoftLogo come from login_page.dart).
class SocialLoginPage extends StatefulWidget {
  const SocialLoginPage({super.key});

  @override
  State<SocialLoginPage> createState() => _SocialLoginPageState();
}

class _SocialLoginPageState extends State<SocialLoginPage> {
  // COLORS (same values as login_page.dart)
  static const Color navy = Color(0xFF10133A);
  static const Color textDark = Color(0xFF111827);
  static const Color textMedium = Color(0xFF667085);
  static const Color textLight = Color(0xFF98A2B3);
  static const Color border = Color(0xFFD9DEE8);
  static const Color background = Color(0xFFF6F7F9);

  bool _isLoading = false;

  // ----------------------------- provider --------------------------------
  String get _provider =>
      ModalRoute.of(context)?.settings.arguments as String? ?? 'Google';

  bool get _isSso => _provider.toLowerCase().contains('sso');

  /// Short name used in titles and buttons.
  String get _name => _isSso ? 'Company SSO' : _provider;

  Widget _logo({double scale = 1}) {
    final p = _provider.toLowerCase();

    Widget logo;
    if (p.contains('google')) {
      logo = const GoogleLogo();
    } else if (p.contains('microsoft')) {
      logo = const MicrosoftLogo();
    } else {
      logo = const Icon(
        Icons.business_outlined,
        size: 18,
        color: Color(0xFF344054),
      );
    }

    return Transform.scale(scale: scale, child: logo);
  }

  // ----------------------------- actions ---------------------------------
  Future<void> _continue() async {
    setState(() => _isLoading = true);

    // TODO: start the real OAuth / SAML flow for [_provider] here.
    await Future<void>.delayed(const Duration(milliseconds: 700));

    if (!mounted) return;
    setState(() => _isLoading = false);

    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.home,
      (route) => false,
    );
  }

  void _back() => Navigator.pop(context);

  // ----------------------------- build -----------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth >= 900) {
              return _desktop(constraints.maxHeight);
            }
            return _mobile();
          },
        ),
      ),
    );
  }

  // DESKTOP - brand panel left, form right (same split as the login page)
  Widget _desktop(double height) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Expanded(
            flex: 51,
            child: AuthBrandPanel(isMobile: false, showGraphic: false),
          ),
          Expanded(
            flex: 49,
            child: Container(
              color: Colors.white,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 40,
                        ),
                        child: Center(child: _form()),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // MOBILE - brand header on top, form below
  Widget _mobile() {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AuthBrandPanel(
            isMobile: true,
            showGraphic: false,
            compactMobile: true,
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(22, 28, 22, 28),
            child: Center(child: _form()),
          ),
        ],
      ),
    );
  }

  // ----------------------------- form ------------------------------------
  Widget _form() {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 440),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _backLink(),
          const SizedBox(height: 16),
          Text(
            _isSso ? 'SINGLE SIGN-ON' : 'SOCIAL SIGN-IN',
            style: const TextStyle(
              color: textLight,
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.1,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Continue with $_name',
            style: const TextStyle(
              color: textDark,
              fontSize: 28,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.8,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _isSso
                ? "Sign in through your organization's identity provider (SAML)."
                : 'Use your $_name account to access OneCloud Enterprise Platform.',
            style: const TextStyle(
              color: textMedium,
              fontSize: 13,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 28),
          _providerCard(),
          const SizedBox(height: 22),
          _primaryButton(),
          const SizedBox(height: 28),
          Container(height: 1, color: const Color(0xFFEAECF0)),
          const SizedBox(height: 16),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              const Text(
                'Want to use a different method? ',
                style: TextStyle(color: textMedium, fontSize: 12),
              ),
              InkWell(
                onTap: _back,
                child: const Text(
                  'Back to sign in',
                  style: TextStyle(
                    color: navy,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _backLink() {
    return InkWell(
      onTap: _back,
      borderRadius: BorderRadius.circular(4),
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.chevron_left, size: 16, color: textMedium),
            Text(
              'Back',
              style: TextStyle(
                color: textMedium,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Same look as the "identity card" on the login password step.
  Widget _providerCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FA),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: border),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: border),
            ),
            child: Center(child: _logo(scale: 1.1)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _isSso ? 'Company SSO (SAML)' : '$_name account',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: textDark,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Secure sign-in. You may be asked to verify (MFA).',
                  style: TextStyle(color: textMedium, fontSize: 12),
                ),
              ],
            ),
          ),
          const Icon(Icons.lock_outline, size: 16, color: textLight),
        ],
      ),
    );
  }

  /// Same button as the login page "Continue" (navy, 47px, radius 7).
  Widget _primaryButton() {
    return SizedBox(
      width: double.infinity,
      height: 47,
      child: FilledButton(
        onPressed: _isLoading ? null : _continue,
        style: FilledButton.styleFrom(
          backgroundColor: navy,
          disabledBackgroundColor: navy.withOpacity(0.65),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
        ),
        child: _isLoading
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Text(
                'Continue with $_name',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
      ),
    );
  }
}