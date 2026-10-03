import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../widgets/auth_brand_panel.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  // COLORS — kept identical to login_page.dart for a consistent identity.

  static const Color navy = Color(0xFF10133A);
  static const Color teal = Color(0xFF31C5C2);

  static const Color textDark = Color(0xFF111827);
  static const Color textMedium = Color(0xFF667085);
  static const Color textLight = Color(0xFF98A2B3);

  static const Color border = Color(0xFFD9DEE8);
  static const Color background = Color(0xFFF6F7F9);

  final TextEditingController _emailController = TextEditingController();

  bool _isLoading = false;
  bool _linkSent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _sendResetLink() async {
    final email = _emailController.text.trim();

    if (email.isEmpty || !email.contains('@')) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text('Please enter a valid work email.'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(milliseconds: 400));

    if (!mounted) return;

    setState(() {
      _isLoading = false;
      _linkSent = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth >= 900) {
              return SizedBox(
                width: double.infinity,
                height: constraints.maxHeight,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Expanded(
                      flex: 51,
                      child: AuthBrandPanel(isMobile: false),
                    ),
                    Expanded(
                      flex: 49,
                      child: _buildFormPanel(isMobile: false),
                    ),
                  ],
                ),
              );
            }

            return SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const AuthBrandPanel(isMobile: true,showGraphic: false,
                        compactMobile: true,),
                  _buildFormPanel(isMobile: true),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // FORM PANEL — matches the "Forgot your password?" reference screen.

  Widget _buildFormPanel({required bool isMobile}) {
    final Widget form = ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 440),
      child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context),
                  canRequestFocus: false,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  splashFactory: NoSplash.splashFactory,
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.arrow_back,
                        size: 15,
                        color: textMedium,
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Back to sign in',
                        style: TextStyle(
                          color: textMedium,
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                const Text(
                  'PASSWORD RECOVERY',
                  style: TextStyle(
                    color: textLight,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.1,
                  ),
                ),

                const SizedBox(height: 20),

                _linkSent
                    ? _buildSentState()
                    : _buildRequestState(),
              ],
      ),
    );

    if (isMobile) {
      return Container(
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(22, 28, 22, 28),
        child: Center(child: form),
      );
    }

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
                child: Center(child: form),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRequestState() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Forgot your password?',
          style: TextStyle(
            color: textDark,
            fontSize: 28,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.8,
          ),
        ),

        const SizedBox(height: 8),

        const Text(
          "Enter your work email and we'll send you a link to reset it.",
          style: TextStyle(
            color: textMedium,
            fontSize: 13,
            height: 1.5,
          ),
        ),

        const SizedBox(height: 28),

        const Text(
          'Work email',
          style: TextStyle(
            color: textDark,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 8),

        SizedBox(
          height: 43,
          child: TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(
              color: textDark,
              fontSize: 13,
            ),
            decoration: InputDecoration(
              hintText: 'you@acmecorp.com',
              hintStyle: const TextStyle(
                color: textLight,
                fontSize: 13,
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 11,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: const BorderSide(color: border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: const BorderSide(color: border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: const BorderSide(color: navy),
              ),
            ),
          ),
        ),

        const SizedBox(height: 22),

        SizedBox(
          width: double.infinity,
          height: 44,
          child: ElevatedButton(
            onPressed: _isLoading ? null : _sendResetLink,
            style: ElevatedButton.styleFrom(
              backgroundColor: navy,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
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
                : const Text(
                    'Send reset link',
                    style: TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ),

        const SizedBox(height: 20),

        Center(
          child: Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                  text: 'Remembered your password?  ',
                  style: TextStyle(
                    color: textLight,
                    fontSize: 12,
                  ),
                ),
                TextSpan(
                  text: 'Sign in',
                  style: const TextStyle(
                    color: navy,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSentState() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: teal.withOpacity(0.12),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: const Icon(
            Icons.mark_email_read_outlined,
            color: teal,
            size: 24,
          ),
        ),

        const SizedBox(height: 20),

        const Text(
          'Check your inbox',
          style: TextStyle(
            color: textDark,
            fontSize: 24,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.6,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          "We've sent a password reset link to "
          '${_emailController.text.trim()}.',
          style: const TextStyle(
            color: textMedium,
            fontSize: 13,
            height: 1.5,
          ),
        ),

        const SizedBox(height: 24),

        SizedBox(
          width: double.infinity,
          height: 44,
          child: OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              foregroundColor: navy,
              side: const BorderSide(color: border),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Back to sign in',
              style: TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}