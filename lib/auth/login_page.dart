import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../routes/app_routes.dart';
import '../widgets/auth_brand_panel.dart';
import 'auth_success_page.dart';

enum SignInStep {
  identity,
  password,
  verification,
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {

  // COLORS

  static const Color navy = Color(0xFF10133A);
  static const Color teal = Color(0xFF31C5C2);

  static const Color textDark = Color(0xFF111827);
  static const Color textMedium = Color(0xFF667085);
  static const Color textLight = Color(0xFF98A2B3);

  static const Color border = Color(0xFFD9DEE8);
  static const Color background = Color(0xFFF6F7F9);

  static const Color fieldFillBlue = Color(0xFFF2F6FF);
  static const Color fieldBorderBlue = Color(0xFFC7D7FE);

  // CONTROLLERS

  final TextEditingController _workspaceController =
      TextEditingController(text: 'acmecorp');

  final TextEditingController _emailController =
      TextEditingController();

  final TextEditingController _passwordController =
      TextEditingController();

  final List<TextEditingController> _otpControllers =
      List.generate(6, (_) => TextEditingController());

  final List<FocusNode> _otpFocusNodes =
      List.generate(6, (_) => FocusNode());

  // STATE

  SignInStep _step = SignInStep.identity;

  bool _obscurePassword = true;
  bool _rememberDevice = false;
  bool _isLoading = false;
  bool _showOtp = false;

  Timer? _otpTimer;
  int _otpSecondsRemaining = 300;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  // INIT

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );

    _animationController.forward();
  }

  // DISPOSE

  @override
  void dispose() {
    _workspaceController.dispose();
    _emailController.dispose();
    _passwordController.dispose();

    for (final controller in _otpControllers) {
      controller.dispose();
    }

    for (final node in _otpFocusNodes) {
      node.dispose();
    }

    _otpTimer?.cancel();

    _animationController.dispose();

    super.dispose();
  }

  // BUILD

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final height = constraints.maxHeight;

            if (width >= 900) {
              return _buildDesktopLayout(
                width,
                height,
              );
            }

            return _buildMobileLayout();
          },
        ),
      ),
    );
  }

  // DESKTOP — black hero on the left, form on the right (centred).

  Widget _buildDesktopLayout(
    double width,
    double height,
  ) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 51,
            child: AuthBrandPanel(
              isMobile: false,
              showGraphic: _step == SignInStep.identity,
            ),
          ),
          Expanded(
            flex: 49,
            child: _buildFormPanel(
              isMobile: false,
            ),
          ),
        ],
      ),
    );
  }

  // MOBILE — hero on top, form below, one scroll.

  Widget _buildMobileLayout() {
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
        _buildFormPanel(
          isMobile: true,
        ),
      ],
    ),
  );
}
  // FORM PANEL

  Widget _buildFormPanel({
    required bool isMobile,
  }) {
    final Widget form = ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 440,
      ),
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: _buildCurrentStep(
          isMobile: isMobile,
        ),
      ),
    );

    if (isMobile) {
      return Container(
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(22, 28, 22, 28),
        child: Center(
          child: form,
        ),
      );
    }

    // Desktop: vertically + horizontally centred, scrolls if the window
    // is too short for the form.
    return Container(
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
                child: Center(
                  child: form,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // STEP SWITCH

  Widget _buildCurrentStep({
    required bool isMobile,
  }) {
    switch (_step) {
      case SignInStep.identity:
        return _buildIdentityStep(isMobile: isMobile);

      case SignInStep.password:
        return _buildPasswordStep();

      case SignInStep.verification:
        return _buildVerificationStep();
    }
  }

  // IDENTITY

  Widget _buildIdentityStep({
    required bool isMobile,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStepIndicator(1),

        const SizedBox(height: 20),

        const Text(
          'Sign in',
          style: TextStyle(
            color: textDark,
            fontSize: 28,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.8,
          ),
        ),

        const SizedBox(height: 8),

        const Text(
          'Enter your workspace and work email to continue.',
          style: TextStyle(
            color: textMedium,
            fontSize: 13,
            height: 1.5,
          ),
        ),

        const SizedBox(height: 28),

        _buildFieldLabel('Workspace'),

        const SizedBox(height: 8),

        _buildWorkspaceField(),

        const SizedBox(height: 7),

        const Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "Don't know your workspace? ",
                style: TextStyle(
                  color: textLight,
                  fontSize: 10,
                ),
              ),
              TextSpan(
                text: 'Find it here',
                style: TextStyle(
                  color: textDark,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        _buildFieldLabel('Work email'),

        const SizedBox(height: 8),

        _buildTextField(
          controller: _emailController,
          hintText: 'you@acmecorp.com',
          keyboardType: TextInputType.emailAddress,
        ),

        const SizedBox(height: 22),

        _buildPrimaryButton(
          text: 'Continue',
          onPressed: _continueFromIdentity,
        ),

        const SizedBox(height: 28),

        _buildDivider(),

        const SizedBox(height: 20),

        _buildSocialButton(
          provider: 'Google',
          icon: const GoogleLogo(),
          onPressed: () {
            _socialLogin('Google');
          },
        ),

        const SizedBox(height: 12),

        _buildSocialButton(
          provider: 'Microsoft',
          icon: const MicrosoftLogo(),
          onPressed: () {
            _socialLogin('Microsoft');
          },
        ),

        const SizedBox(height: 12),

        _buildSocialButton(
          provider: isMobile ? 'Company SSO' : 'Company SSO (SAML)',
          icon: const Icon(
            Icons.business_outlined,
            size: 17,
            color: Color(0xFF344054),
          ),
          onPressed: () {
            _socialLogin('Company SSO (SAML)');
          },
        ),

        const SizedBox(height: 22),

        Container(
          height: 1,
          color: const Color(0xFFEAECF0),
        ),

        const SizedBox(height: 16),

        Center(
          child: Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              const Text(
                'New to One Enterprise? ',
                style: TextStyle(
                  color: textLight,
                  fontSize: 11,
                ),
              ),
              InkWell(
                onTap: _createAccount,
                canRequestFocus: false,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                splashFactory: NoSplash.splashFactory,
                child: const Text(
                  'Create an account',
                  style: TextStyle(
                    color: navy,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // PASSWORD

  Widget _buildPasswordStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTopBackLink(
          onPressed: _goBackOneStep,
        ),

        const SizedBox(height: 16),

        _buildStepIndicator(2),

        const SizedBox(height: 20),

        const Text(
          'Enter your password',
          style: TextStyle(
            color: textDark,
            fontSize: 28,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.8,
          ),
        ),

        const SizedBox(height: 6),

        Text.rich(
          TextSpan(
            children: [
              const TextSpan(
                text: 'Signing in to ',
                style: TextStyle(
                  color: textMedium,
                  fontSize: 13,
                ),
              ),
              TextSpan(
                text: _workspaceController.text.trim(),
                style: const TextStyle(
                  color: textDark,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const TextSpan(
                text: '.',
                style: TextStyle(
                  color: textMedium,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 18),

        _buildIdentityCard(),

        const SizedBox(height: 22),

        _buildFieldLabel('Password'),

        const SizedBox(height: 8),

        _buildPasswordField(),

        const SizedBox(height: 12),

        Row(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: Checkbox(
                    value: _rememberDevice,
                    activeColor: navy,
                    materialTapTargetSize:
                        MaterialTapTargetSize.shrinkWrap,
                    onChanged: (value) {
                      setState(() {
                        _rememberDevice = value ?? false;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'Remember this device for 30 days',
                  style: TextStyle(
                    color: textMedium,
                    fontSize: 12,
                  ),
                ),
              ],
            ),

            const Spacer(),

            TextButton(
              onPressed: _forgotPassword,
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text(
                'Forget password?',
                style: TextStyle(
                  color: navy,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        if (!_showOtp) ...[
          _buildPrimaryButton(
            text: 'Sign in',
            onPressed: _signInWithPassword,
          ),

          const SizedBox(height: 24),

          _buildDivider(),

          const SizedBox(height: 16),

          const Center(
            child: Text(
              'Protected by enterprise password policy · 5 attempts '
              'before lockout',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textLight,
                fontSize: 10.5,
                height: 1.5,
              ),
            ),
          ),
        ],

        if (_showOtp) ...[
          const SizedBox(height: 8),
          _buildVerificationStep(showBackLink: false),
        ],
      ],
    );
  }

  // IDENTITY CARD — full-width bordered card showing who's signing in,
  // with a way to switch accounts. Shown on the password step only.

  Widget _buildIdentityCard() {
    final email = _emailController.text.trim();

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
            width: 34,
            height: 34,
            decoration: const BoxDecoration(
              color: teal,
              shape: BoxShape.circle,
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  email,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: textDark,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                InkWell(
                  onTap: _switchAccount,
                  canRequestFocus: false,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  splashFactory: NoSplash.splashFactory,
                  child: const Text(
                    'Not you? Use a different account',
                    style: TextStyle(
                      color: textLight,
                      fontSize: 10.5,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          InkWell(
            onTap: _switchAccount,
            canRequestFocus: false,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
            child: const Text(
              'Switch',
              style: TextStyle(
                color: navy,
                fontSize: 12,
                fontWeight: FontWeight.w700,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // VERIFICATION

  Widget _buildVerificationStep({bool showBackLink = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showBackLink) ...[
          _buildTopBackLink(
            onPressed: _goBackOneStep,
          ),
          const SizedBox(height: 16),
        ],

        _buildStepIndicator(3),

        const SizedBox(height: 12),

        const Text(
          'Two-factor verification',
          style: TextStyle(
            color: textDark,
            fontSize: 24,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.6,
          ),
        ),

        const SizedBox(height: 8),

        const Text(
          'Enter the 6-digit code from your authenticator app.',
          style: TextStyle(
            color: textMedium,
            fontSize: 13,
            height: 1.5,
          ),
        ),

        const SizedBox(height: 26),

        _buildOtpField(),

        const SizedBox(height: 12),

        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Code expires in ${_formatOtpTime()}  ·  ',
                style: const TextStyle(
                  color: textLight,
                  fontSize: 11,
                ),
              ),
              TextSpan(
                text: 'Resend code',
                style: const TextStyle(
                  color: navy,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = _resendCode,
              ),
              const TextSpan(
                text: '  ·  ',
                style: TextStyle(
                  color: textLight,
                  fontSize: 11,
                ),
              ),
              TextSpan(
                text: 'Use a backup code',
                style: const TextStyle(
                  color: navy,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = _useBackupCode,
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        _buildPrimaryButton(
          text: 'Verify and sign in',
          onPressed: _verifyOtp,
        ),

        const SizedBox(height: 24),

        Container(
          width: double.infinity,
          height: 1,
          color: border,
        ),

        const SizedBox(height: 20),

        Center(
          child: Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                  text: 'Having trouble?  ',
                  style: TextStyle(
                    color: textLight,
                    fontSize: 11,
                  ),
                ),
                TextSpan(
                  text: 'Contact support',
                  style: const TextStyle(
                    color: navy,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = _contactSupport,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // STEP INDICATOR

  Widget _buildStepIndicator(int step) {
    String title;

    if (step == 1) {
      title = 'IDENTIFY';
    } else if (step == 2) {
      title = 'PASSWORD';
    } else {
      title = 'VERIFY';
    }

    return Text(
      'STEP $step OF 3  ·  $title',
      style: const TextStyle(
        color: textLight,
        fontSize: 10,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.1,
      ),
    );
  }

  // FIELD LABEL

  Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        color: textDark,
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  // WORKSPACE FIELD

  Widget _buildWorkspaceField() {
    return SizedBox(
      height: 43,
      child: TextField(
        controller: _workspaceController,
        style: const TextStyle(
          color: textDark,
          fontSize: 13,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: fieldFillBlue,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 11,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: const BorderSide(
              color: fieldBorderBlue,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: const BorderSide(
              color: fieldBorderBlue,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: const BorderSide(
              color: navy,
            ),
          ),
          suffixIcon: Container(
            width: 92,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Color(0xFFF4F6FA),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(7),
                bottomRight: Radius.circular(7),
              ),
              border: Border(
                left: BorderSide(
                  color: border,
                ),
              ),
            ),
            child: const Text(
              '.oneenterprise.io',
              style: TextStyle(
                color: textLight,
                fontSize: 10,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // NORMAL TEXT FIELD

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType? keyboardType,
  }) {
    return SizedBox(
      height: 48,
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: const TextStyle(
          color: textDark,
          fontSize: 13,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: textLight,
            fontSize: 13,
          ),
          filled: true,
          fillColor: fieldFillBlue,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 13,
            vertical: 13,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: const BorderSide(
              color: fieldBorderBlue,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: const BorderSide(
              color: fieldBorderBlue,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: const BorderSide(
              color: navy,
            ),
          ),
        ),
      ),
    );
  }

  // PASSWORD FIELD

  Widget _buildPasswordField() {
    return SizedBox(
      height: 48,
      child: TextField(
        controller: _passwordController,
        obscureText: _obscurePassword,
        style: const TextStyle(
          color: textDark,
          fontSize: 13,
        ),
        decoration: InputDecoration(
          hintText: 'Enter your password',
          hintStyle: const TextStyle(
            color: textLight,
            fontSize: 13,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 13,
            vertical: 13,
          ),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
            icon: Icon(
              _obscurePassword
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              size: 18,
              color: textMedium,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: const BorderSide(
              color: border,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: const BorderSide(
              color: border,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: const BorderSide(
              color: navy,
            ),
          ),
        ),
      ),
    );
  }

  // OTP FIELD

  Widget _buildOtpField() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(6, (index) {
        return Padding(
          padding: EdgeInsets.only(
            right: index == 5 ? 0 : 8,
          ),
          child: SizedBox(
            width: 40,
            height: 46,
            child: TextField(
              controller: _otpControllers[index],
              focusNode: _otpFocusNodes[index],
              autofocus: index == 0,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              maxLength: 1,
              style: const TextStyle(
                color: textDark,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                counterText: '',
                contentPadding: EdgeInsets.zero,
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: border,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: border,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: teal,
                    width: 1.6,
                  ),
                ),
              ),
              onChanged: (value) {
                if (value.length > 1) {
                  final digits = value
                      .replaceAll(
                        RegExp(r'\D'),
                        '',
                      )
                      .split('');

                  for (int i = 0; i < 6; i++) {
                    _otpControllers[i].text =
                        i < digits.length ? digits[i] : '';
                  }

                  final nextEmpty = digits.length.clamp(0, 5);

                  _otpFocusNodes[nextEmpty].requestFocus();

                  setState(() {});
                  return;
                }

                if (value.isNotEmpty && index < 5) {
                  _otpFocusNodes[index + 1].requestFocus();
                } else if (value.isEmpty && index > 0) {
                  _otpFocusNodes[index - 1].requestFocus();
                }

                setState(() {});
              },
            ),
          ),
        );
      }),
    );
  }

  // PRIMARY BUTTON

  Widget _buildPrimaryButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 47,
      child: FilledButton(
        onPressed: _isLoading ? null : onPressed,
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
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
      ),
    );
  }

  // BACK BUTTON

  Widget _buildTopBackLink({
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(4),
      child: const Padding(
        padding: EdgeInsets.symmetric(
          vertical: 4,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.chevron_left,
              size: 16,
              color: textMedium,
            ),
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

  // SOCIAL BUTTON

  Widget _buildSocialButton({
    required String provider,
    required Widget icon,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 46,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: textDark,
          side: const BorderSide(
            color: border,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 22,
              child: Center(
                child: icon,
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  provider,
                  style: const TextStyle(
                    color: textDark,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 22),
          ],
        ),
      ),
    );
  }

  // DIVIDER

  Widget _buildDivider() {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            color: border,
            height: 1,
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 12,
          ),
          child: Text(
            'or continue with',
            style: TextStyle(
              color: textLight,
              fontSize: 10,
            ),
          ),
        ),
        const Expanded(
          child: Divider(
            color: border,
            height: 1,
          ),
        ),
      ],
    );
  }

  // AUTH ACTIONS

  void _continueFromIdentity() {
  final workspace = _workspaceController.text.trim();
  final email = _emailController.text.trim();

  if (workspace.isEmpty) {
    _showMessage('Please enter your workspace.');
    return;
  }

  if (email.isEmpty) {
    _showMessage('Please enter your email.');
    return;
  }

  if (!email.contains('@')) {
    _showMessage('Please enter a valid email address.');
    return;
  }

  final auth = context.read<AuthProvider>();

  if (!auth.hasRegisteredAccount) {
    _showMessage('Please complete signup first.');
    return;
  }

  if (!auth.isWorkspaceValid(workspace)) {
    _showMessage(
      'Workspace not found. Please check your organization code.',
    );
    return;
  }

  if (!auth.isEmailValid(email)) {
    _showMessage(
      'This email is not registered for this workspace.',
    );
    return;
  }

  setState(() {
    _step = SignInStep.password;
  });
}

void _signInWithPassword() {
  final password = _passwordController.text;

  if (password.isEmpty) {
    _showMessage('Please enter your password.');
    return;
  }

  final auth = context.read<AuthProvider>();

  if (!auth.isPasswordValid(password)) {
    _showMessage('Incorrect password. Please try again.');
    return;
  }

  auth.goToTwoFactor();

  setState(() {
    _showOtp = true;
  });

  _startOtpTimer();
}

  Future<void> _verifyOtp() async {
  final otp = _otpControllers.map((c) => c.text).join();

  if (otp.length != 6) {
    _showMessage(
      'Please enter the 6-digit verification code.',
    );
    return;
  }

  if (otp != '123456') {
    _showMessage(
      'Invalid verification code. Use 123456 for demo.',
    );
    return;
  }

  setState(() {
    _isLoading = true;
  });

  await Future.delayed(
    const Duration(milliseconds: 400),
  );

  if (!mounted) return;

  context.read<AuthProvider>().completeAuthentication();

  if (!mounted) return;

  setState(() {
    _isLoading = false;
  });

  final bool isMobile =
      MediaQuery.sizeOf(context).width < 900;

  if (isMobile) {
    await _showMobileAuthSuccessPopup();
    return;
  }

  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => const AuthSuccessPage(),
    ),
  );
}

Future<void> _showMobileAuthSuccessPopup() async {
  if (!mounted) return;

  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black.withValues(alpha: 0.35),
    builder: (dialogContext) {
      return Dialog(
        backgroundColor: Colors.white,
        elevation: 8,
        insetPadding: const EdgeInsets.symmetric(
          horizontal: 32,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 28,
            vertical: 30,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 58,
                height: 58,
                decoration: const BoxDecoration(
                  color: Color(0xFFE7F7EF),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_rounded,
                  color: Color(0xFF20A464),
                  size: 30,
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                "You're in",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textDark,
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Redirecting to your dashboard...',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textMedium,
                  fontSize: 12,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );

  await Future.delayed(
    const Duration(milliseconds: 1800),
  );

  if (!mounted) return;

  Navigator.of(
    context,
    rootNavigator: true,
  ).pop();

  if (!mounted) return;

  Navigator.pushNamedAndRemoveUntil(
    context,
    AppRoutes.home,
    (route) => false,
  );
}

  void _resendCode() {
    for (final controller in _otpControllers) {
      controller.clear();
    }

    _otpFocusNodes.first.requestFocus();

    _startOtpTimer();

    _showMessage(
      'A new verification code has been sent.',
    );
  }

  void _useBackupCode() {
    _showMessage(
      'Enter one of your saved backup codes instead.',
    );
  }

  void _contactSupport() {
    _showMessage(
      'Reach out to support and we\'ll help you sign in.',
    );
  }

  void _goBackOneStep() {
    setState(() {
      if (_step == SignInStep.password) {
        _step = SignInStep.identity;
        _showOtp = false;
        _otpTimer?.cancel();

        for (final controller in _otpControllers) {
          controller.clear();
        }
      } else if (_step == SignInStep.verification) {
        _step = SignInStep.password;
        _showOtp = false;
        _otpTimer?.cancel();

        for (final controller in _otpControllers) {
          controller.clear();
        }
      }
    });

    _restartAnimation();
  }

  void _switchAccount() {
    setState(() {
      _step = SignInStep.identity;
      _showOtp = false;
      _passwordController.clear();
      _otpTimer?.cancel();

      for (final controller in _otpControllers) {
        controller.clear();
      }
    });

    _restartAnimation();
  }

  void _startOtpTimer() {
    _otpTimer?.cancel();

    setState(() {
      _otpSecondsRemaining = 300;
    });

    _otpTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (!mounted) {
          timer.cancel();
          return;
        }

        if (_otpSecondsRemaining <= 0) {
          timer.cancel();
          return;
        }

        setState(() {
          _otpSecondsRemaining--;
        });
      },
    );
  }

  String _formatOtpTime() {
    final minutes = _otpSecondsRemaining ~/ 60;
    final seconds = _otpSecondsRemaining % 60;

    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  void _createAccount() {
    Navigator.pushNamed(
      context,
      AppRoutes.signup,
    );
  }

  void _forgotPassword() {
    Navigator.pushNamed(
      context,
      AppRoutes.forgotPassword,
    );
  }

  void _socialLogin(String provider) {
    Navigator.pushNamed(
      context,
      AppRoutes.socialLogin,
      arguments: provider,
    );
  }

  void _restartAnimation() {
    _animationController
      ..reset()
      ..forward();
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }
}

// GOOGLE LOGO

class GoogleLogo extends StatelessWidget {
  const GoogleLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(18, 18),
      painter: GoogleLogoPainter(),
    );
  }
}

class GoogleLogoPainter extends CustomPainter {
  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    final center = Offset(
      size.width / 2,
      size.height / 2,
    );

    final radius = size.width / 2;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    const colors = [
      Color(0xFF4285F4),
      Color(0xFF34A853),
      Color(0xFFFBBC05),
      Color(0xFFEA4335),
    ];

    const starts = [
      -math.pi / 4,
      math.pi / 4,
      3 * math.pi / 4,
      5 * math.pi / 4,
    ];

    for (int i = 0; i < 4; i++) {
      paint.color = colors[i];

      canvas.drawArc(
        Rect.fromCircle(
          center: center,
          radius: radius - 2,
        ),
        starts[i],
        math.pi / 2,
        false,
        paint,
      );
    }

    final bluePaint = Paint()
      ..color = const Color(0xFF4285F4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    canvas.drawLine(
      Offset(
        size.width * 0.52,
        size.height * 0.5,
      ),
      Offset(
        size.width * 0.95,
        size.height * 0.5,
      ),
      bluePaint,
    );
  }

  @override
  bool shouldRepaint(
    covariant CustomPainter oldDelegate,
  ) {
    return false;
  }
}

// MICROSOFT LOGO

class MicrosoftLogo extends StatelessWidget {
  const MicrosoftLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 16,
      height: 16,
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 1.5,
        mainAxisSpacing: 1.5,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          ColoredBox(
            color: Color(0xFFF25022),
          ),
          ColoredBox(
            color: Color(0xFF7FBA00),
          ),
          ColoredBox(
            color: Color(0xFF00A4EF),
          ),
          ColoredBox(
            color: Color(0xFFFFB900),
          ),
        ],
      ),
    );
  }
}