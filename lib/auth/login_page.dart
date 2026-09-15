import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../routes/app_routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with TickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController =
      TextEditingController();

  final TextEditingController _passwordController =
      TextEditingController();

  final TextEditingController _otpController =
      TextEditingController();

  late AnimationController _animationController;

  late Animation<double> _fadeAnimation;

  bool _obscurePassword = true;
  bool _isOtpStep = false;
  bool _isLoading = false;
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _otpController.dispose();
    _animationController.dispose();

    super.dispose();
  }

  void _login() {
    if (_isOtpStep) {
      _verifyOtp();
    } else {
      _continueToOtp();
    }
  }

  void _continueToOtp() {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty) {
      _showMessage(
        'Please enter your email',
        isError: true,
      );
      return;
    }

    if (!email.contains('@')) {
      _showMessage(
        'Please enter a valid email',
        isError: true,
      );
      return;
    }

    if (password.isEmpty) {
      _showMessage(
        'Please enter your password',
        isError: true,
      );
      return;
    }

    if (password.length < 6) {
      _showMessage(
        'Password must contain at least 6 characters',
        isError: true,
      );
      return;
    }

    setState(() {
      _isOtpStep = true;
      _otpController.clear();
    });

    _showMessage(
      'OTP sent successfully. Demo OTP: 123456',
    );
  }

  void _verifyOtp() {
    final otp = _otpController.text.trim();

    if (otp.isEmpty) {
      _showMessage(
        'Please enter the OTP',
        isError: true,
      );
      return;
    }

    if (otp.length != 6) {
      _showMessage(
        'OTP must contain 6 digits',
        isError: true,
      );
      return;
    }

    if (otp != '123456') {
      _showMessage(
        'Invalid OTP. Use 123456 for demo',
        isError: true,
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    context.read<AuthProvider>().completeAuthentication();

    Future.delayed(
      const Duration(milliseconds: 400),
      () {
        if (!mounted) {
          return;
        }

        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.home,
          (route) => false,
        );
      },
    );
  }

  void _resendOtp() {
    if (!_isOtpStep) {
      return;
    }

    _otpController.clear();

    _showMessage(
      'A new OTP has been sent. Demo OTP: 123456',
    );
  }

  void _openSocialLogin(String provider) {
    Navigator.pushNamed(
      context,
      AppRoutes.socialLogin,
      arguments: provider,
    );
  }

  void _showMessage(
    String message, {
    bool isError = false,
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: isError
              ? const Color(0xFFD92D20)
              : const Color(0xFF1677C8),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F9FD),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: _buildResponsiveBody(
                    constraints.maxWidth,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildResponsiveBody(double width) {
    if (width < 850) {
      return _buildMobileLayout(width);
    }

    return _buildDesktopLayout(width);
  }

  Widget _buildDesktopLayout(double width) {
    final horizontalPadding = width >= 1200 ? 42.0 : 24.0;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: 28,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 54,
            child: Padding(
              padding: const EdgeInsets.only(
                right: 30,
              ),
              child: _buildLeftPanel(
                width,
              ),
            ),
          ),
          Expanded(
            flex: 46,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 470,
                ),
                child: _buildLoginCard(
                  isMobile: false,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(double width) {
    final horizontalPadding = width < 500 ? 16.0 : 24.0;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        horizontalPadding,
        22,
        horizontalPadding,
        30,
      ),
      child: Column(
        children: [
          _buildMobileLogo(),

          const SizedBox(height: 24),

          _buildLoginCard(
            isMobile: true,
          ),
        ],
      ),
    );
  }

  Widget _buildLeftPanel(double width) {
    final logoWidth = width >= 1200 ? 390.0 : 330.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLargeLogo(
          logoWidth,
        ),

        const SizedBox(height: 36),

        const Text(
          'Everything your',
          style: TextStyle(
            color: Color(0xFF0B3158),
            fontSize: 42,
            fontWeight: FontWeight.w800,
            height: 1.05,
            letterSpacing: -1.3,
          ),
        ),

        const Text(
          'enterprise needs.',
          style: TextStyle(
            color: Color(0xFF1677C8),
            fontSize: 42,
            fontWeight: FontWeight.w800,
            height: 1.05,
            letterSpacing: -1.3,
          ),
        ),

        const SizedBox(height: 18),

        const Text(
          'OneCloud brings enterprise services, people, '
          'workflows and intelligence together in one '
          'powerful platform.',
          style: TextStyle(
            color: Color(0xFF587895),
            fontSize: 15,
            height: 1.7,
          ),
        ),

        const SizedBox(height: 30),

        _buildFeature(
          icon: Icons.cloud_done_rounded,
          title: 'Unified Cloud Platform',
          subtitle: 'Enterprise services connected in one place.',
          iconColor: const Color(0xFF1677C8),
        ),

        const SizedBox(height: 16),

        _buildFeature(
          icon: Icons.security_rounded,
          title: 'Enterprise Security',
          subtitle: 'Secure authentication and controlled access.',
          iconColor: const Color(0xFF00A58A),
        ),

        const SizedBox(height: 16),

        _buildFeature(
          icon: Icons.auto_awesome_rounded,
          title: 'Smart Operations',
          subtitle: 'Powerful tools for modern enterprise teams.',
          iconColor: const Color(0xFF7657E8),
        ),

        const SizedBox(height: 30),

        _buildEnterpriseBadge(),
      ],
    );
  }

  Widget _buildMobileLogo() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFD8EAF7),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1677C8)
                .withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Image.asset(
        'assets/onecloud_logo.png',
        width: 300,
        height: 105,
        fit: BoxFit.contain,
        errorBuilder: (
          context,
          error,
          stackTrace,
        ) {
          return _logoFallback();
        },
      ),
    );
  }

  Widget _buildLargeLogo(double width) {
    return Container(
      width: width,
      constraints: const BoxConstraints(
        maxWidth: 400,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFD5E9F8),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1677C8)
                .withValues(alpha: 0.08),
            blurRadius: 25,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Image.asset(
        'assets/onecloud_logo.png',
        width: width - 36,
        height: 115,
        fit: BoxFit.contain,
        errorBuilder: (
          context,
          error,
          stackTrace,
        ) {
          return _logoFallback();
        },
      ),
    );
  }

  Widget _logoFallback() {
    return const Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.cloud,
            color: Color(0xFF1677C8),
            size: 48,
          ),
          SizedBox(height: 6),
          Text(
            'OneCloud',
            style: TextStyle(
              color: Color(0xFF0B3158),
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeature({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color iconColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: iconColor.withValues(
              alpha: 0.10,
            ),
            shape: BoxShape.circle,
            border: Border.all(
              color: iconColor.withValues(
                alpha: 0.18,
              ),
            ),
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 23,
          ),
        ),

        const SizedBox(width: 14),

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Color(0xFF173F64),
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Color(0xFF6D88A2),
                  fontSize: 11.5,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEnterpriseBadge() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 13,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(
          alpha: 0.82,
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFD4E8F6),
        ),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.verified_user_outlined,
            color: Color(0xFF1677C8),
            size: 20,
          ),

          SizedBox(width: 10),

          Expanded(
            child: Text(
              'Secure enterprise access powered by OneCloud',
              style: TextStyle(
                color: Color(0xFF4C6D88),
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          Icon(
            Icons.check_circle,
            color: Color(0xFF10A37F),
            size: 18,
          ),
        ],
      ),
    );
  }

  Widget _buildLoginCard({
    required bool isMobile,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        isMobile ? 22 : 32,
        isMobile ? 26 : 30,
        isMobile ? 22 : 32,
        isMobile ? 24 : 27,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFE0EBF4),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0B3158)
                .withValues(alpha: 0.10),
            blurRadius: 35,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [

            const Center(
              child: Text(
                'Welcome Back!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF0B3158),
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.6,
                ),
              ),
            ),

            const SizedBox(height: 6),

            const Center(
              child: Text(
                'Login to your OneCloud Enterprise account',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF7791A9),
                  fontSize: 12.5,
                ),
              ),
            ),

            const SizedBox(height: 25),

            _buildFieldLabel(
              'Email Address',
              const Color(0xFF1677C8),
            ),

            const SizedBox(height: 7),

            TextFormField(
              controller: _emailController,
              keyboardType:
                  TextInputType.emailAddress,
              textInputAction:
                  TextInputAction.next,
              decoration: _inputDecoration(
                hint: 'Enter your email',
                icon: Icons.person_outline,
                iconColor:
                    const Color(0xFF1677C8),
              ),
            ),

            const SizedBox(height: 16),

            Row(
              crossAxisAlignment:
                  CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: _buildFieldLabel(
                    'Password',
                    const Color(0xFF7657E8),
                  ),
                ),

                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.forgotPassword,
                    );
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets
                        .symmetric(
                      horizontal: 4,
                      vertical: 2,
                    ),
                    minimumSize: Size.zero,
                    tapTargetSize:
                        MaterialTapTargetSize
                            .shrinkWrap,
                  ),
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Color(0xFF1677C8),
                      fontSize: 11.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 7),

            TextFormField(
              controller: _passwordController,
              obscureText: _obscurePassword,
              textInputAction:
                  TextInputAction.done,
              onFieldSubmitted: (_) {
                _login();
              },
              decoration: _inputDecoration(
                hint: 'Enter your password',
                icon: Icons.lock_outline,
                iconColor:
                    const Color(0xFF7657E8),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _obscurePassword =
                          !_obscurePassword;
                    });
                  },
                  icon: Icon(
                    _obscurePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: const Color(0xFF71869A),
                    size: 20,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 8),

            _buildRememberMe(),

            if (_isOtpStep) ...[
              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: _buildFieldLabel(
                      'OTP Verification',
                      const Color(0xFFEC4899),
                    ),
                  ),

                  TextButton(
                    onPressed: _isLoading
                        ? null
                        : _resendOtp,
                    style: TextButton.styleFrom(
                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 2,
                      ),
                      minimumSize: Size.zero,
                      tapTargetSize:
                          MaterialTapTargetSize
                              .shrinkWrap,
                    ),
                    child: const Text(
                      'Resend OTP',
                      style: TextStyle(
                        color: Color(0xFF1677C8),
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 7),

              TextFormField(
                controller: _otpController,
                keyboardType:
                    TextInputType.number,
                maxLength: 6,
                autofocus: true,
                decoration: _inputDecoration(
                  hint: 'Enter 6-digit OTP',
                  icon:
                      Icons.verified_user_outlined,
                  iconColor:
                      const Color(0xFFEC4899),
                ).copyWith(
                  counterText: '',
                ),
              ),

              const SizedBox(height: 8),

              _buildOtpInfo(),
            ],

            const SizedBox(height: 14),

            _buildLoginButton(),

            const SizedBox(height: 20),

            _buildDivider(),

            const SizedBox(height: 16),

            _buildSocialButtons(),

            const SizedBox(height: 19),

            _buildCreateAccount(),

            const SizedBox(height: 14),

            _buildSecureAccess(),
          ],
        ),
      ),
    );
  }


  Widget _buildFieldLabel(
    String text,
    Color color,
  ) {
    return Row(
      children: [
        Container(
          width: 3,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius:
                BorderRadius.circular(4),
          ),
        ),

        const SizedBox(width: 7),

        Flexible(
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xFF243B53),
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
    required Color iconColor,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        color: Color(0xFF9BAFC0),
        fontSize: 12.5,
      ),
      prefixIcon: Icon(
        icon,
        color: iconColor,
        size: 20,
      ),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: const Color(0xFFF8FBFE),
      contentPadding:
          const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 15,
      ),
      border: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color(0xFFD8E5EF),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color(0xFFD8E5EF),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(12),
        borderSide: BorderSide(
          color: iconColor,
          width: 1.6,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color(0xFFD92D20),
        ),
      ),
      focusedErrorBorder:
          OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color(0xFFD92D20),
          width: 1.6,
        ),
      ),
    );
  }

  Widget _buildRememberMe() {
    return Row(
      children: [
        SizedBox(
          width: 30,
          height: 30,
          child: Checkbox(
            value: _rememberMe,
            activeColor:
                const Color(0xFF1677C8),
            materialTapTargetSize:
                MaterialTapTargetSize
                    .shrinkWrap,
            onChanged: (value) {
              setState(() {
                _rememberMe =
                    value ?? false;
              });
            },
          ),
        ),

        const SizedBox(width: 4),

        const Expanded(
          child: Text(
            'Remember me',
            style: TextStyle(
              color: Color(0xFF6D8195),
              fontSize: 11.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOtpInfo() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 9,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F8FD),
        borderRadius:
            BorderRadius.circular(9),
        border: Border.all(
          color: const Color(0xFFD7EAF7),
        ),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.info_outline,
            color: Color(0xFF1677C8),
            size: 17,
          ),

          SizedBox(width: 7),

          Expanded(
            child: Text(
              'Demo OTP: 123456',
              style: TextStyle(
                color: Color(0xFF52718D),
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          Icon(
            Icons.verified,
            color: Color(0xFF10A37F),
            size: 16,
          ),
        ],
      ),
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF075EA8),
              Color(0xFF1677C8),
            ],
          ),
          borderRadius:
              BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF1677C8)
                  .withValues(alpha: 0.20),
              blurRadius: 14,
              offset: const Offset(0, 7),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed:
              _isLoading ? null : _login,
          style: ElevatedButton.styleFrom(
            backgroundColor:
                Colors.transparent,
            disabledBackgroundColor:
                Colors.transparent,
            shadowColor:
                Colors.transparent,
            foregroundColor: Colors.white,
            disabledForegroundColor:
                Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(12),
            ),
          ),
          child: _isLoading
              ? const SizedBox(
                  width: 21,
                  height: 21,
                  child:
                      CircularProgressIndicator(
                    strokeWidth: 2.3,
                    color: Colors.white,
                  ),
                )
              : FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisSize:
                        MainAxisSize.min,
                    children: [
                      Text(
                        _isOtpStep
                            ? 'Verify OTP'
                            : 'Login',
                        style:
                            const TextStyle(
                          fontSize: 14.5,
                          fontWeight:
                              FontWeight.w800,
                        ),
                      ),

                      const SizedBox(width: 9),

                      const Icon(
                        Icons
                            .arrow_forward_rounded,
                        size: 19,
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            color: Color(0xFFE0E8EF),
          ),
        ),

        const Padding(
          padding:
              EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Text(
            'OR',
            style: TextStyle(
              color: Color(0xFF9AAABD),
              fontSize: 9.5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),

        const Expanded(
          child: Divider(
            color: Color(0xFFE0E8EF),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialButtons() {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 310) {
          return Column(
            children: [
              _buildSocialButton(
                icon: Icons.g_mobiledata,
                label: 'Google',
                color: const Color(0xFFEA4335),
                onPressed: () {
                  _openSocialLogin('Google');
                },
              ),

              const SizedBox(height: 9),

              _buildSocialButton(
                icon: Icons.facebook,
                label: 'Facebook',
                color: const Color(0xFF1877F2),
                onPressed: () {
                  _openSocialLogin(
                    'Facebook',
                  );
                },
              ),
            ],
          );
        }

        return Row(
          children: [
            Expanded(
              child: _buildSocialButton(
                icon: Icons.g_mobiledata,
                label: 'Google',
                color:
                    const Color(0xFFEA4335),
                onPressed: () {
                  _openSocialLogin('Google');
                },
              ),
            ),

            const SizedBox(width: 9),

            Expanded(
              child: _buildSocialButton(
                icon: Icons.facebook,
                label: 'Facebook',
                color:
                    const Color(0xFF1877F2),
                onPressed: () {
                  _openSocialLogin(
                    'Facebook',
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      height: 45,
      width: double.infinity,
      child: OutlinedButton(
        onPressed:
            _isOtpStep ? null : onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor:
              const Color(0xFF334155),
          backgroundColor: Colors.white,
          side: BorderSide(
            color: color.withValues(
              alpha: 0.25,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(10),
          ),
          padding:
              const EdgeInsets.symmetric(
            horizontal: 8,
          ),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisSize:
                MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: color,
                size: 22,
              ),

              const SizedBox(width: 6),

              Text(
                label,
                style: const TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCreateAccount() {
    return Center(
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          const Text(
            "Don't have an account? ",
            style: TextStyle(
              color: Color(0xFF71869A),
              fontSize: 11.5,
            ),
          ),

          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.signup,
              );
            },
            child: const Text(
              'Create Account',
              style: TextStyle(
                color: Color(0xFF1677C8),
                fontSize: 11.5,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecureAccess() {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration:
                const BoxDecoration(
              color: Color(0xFF10A37F),
              shape: BoxShape.circle,
            ),
          ),

          const SizedBox(width: 6),

          const Flexible(
            child: Text(
              'Secure Enterprise Access',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Color(0xFF7D9AB2),
                fontSize: 9.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}