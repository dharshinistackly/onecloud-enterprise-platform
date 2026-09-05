import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

// LOGIN PAGE

class _MyAppState extends State<MyApp> {
  // Controllers
  final TextEditingController emailController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  // Password visibility
  bool _isPasswordHidden = true;

  // Form validation
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,

          // BACKGROUND

          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFFCE7F3), // Light Pink
                Color(0xFFD1FAE5), // Light Green
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),

          // SCROLL VIEW

          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                vertical: 40,
                horizontal: 20,
              ),

              child: Center(
                child: Container(
                  width: 450,

                  padding: const EdgeInsets.all(35),

                  // WHITE LOGIN CARD
  

                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius:
                        BorderRadius.circular(25),

                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 25,
                        spreadRadius: 2,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),

                  child: Form(
                    key: _formKey,

                    child: Column(
                      mainAxisSize: MainAxisSize.min,

                      children: [

                        // SHOPPING BAG ICON
                    
                        Container(
                          width: 80,
                          height: 80,

                          decoration: BoxDecoration(
                            color: const Color(0xFFFCE7F3),

                            borderRadius:
                                BorderRadius.circular(20),
                          ),

                          child: const Icon(
                            Icons.shopping_bag_outlined,
                            size: 48,
                            color: Color(0xFFEC4899),
                          ),
                        ),

                        const SizedBox(height: 15),

                        // SHOP EASE TITLE

                        RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: 'Shop',
                                style: TextStyle(
                                  color: Color(0xFF1F2937),
                                  fontSize: 36,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),

                              TextSpan(
                                text: 'Ease',
                                style: TextStyle(
                                  color: Color(0xFFEC4899),
                                  fontSize: 36,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 12),

                        // WELCOME TEXT

                        const Text(
                          'Welcome Back!',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1F2937),
                          ),
                        ),

                        const SizedBox(height: 8),

                        const Text(
                          'Sign in to continue to ShopEase',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFF6B7280),
                          ),
                        ),

                        const SizedBox(height: 30),

                        // EMAIL LABEL

                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Email',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        const SizedBox(height: 8),


                        // EMAIL FIELD

                        TextFormField(
                          controller: emailController,

                          keyboardType:
                              TextInputType.emailAddress,

                          decoration: InputDecoration(
                            hintText: 'Enter your email',

                            prefixIcon: const Icon(
                              Icons.email_outlined,
                              color: Color(0xFF9CA3AF),
                            ),

                            filled: true,

                            fillColor:
                                const Color(0xFFF9FAFB),

                            border:
                                OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(12),

                              borderSide: BorderSide.none,
                            ),

                            enabledBorder:
                                OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(12),

                              borderSide:
                                  const BorderSide(
                                color: Color(0xFFE5E7EB),
                              ),
                            ),

                            focusedBorder:
                                OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(12),

                              borderSide:
                                  const BorderSide(
                                color: Color(0xFFEC4899),
                                width: 2,
                              ),
                            ),
                          ),

                          validator: (value) {
                            if (value == null ||
                                value.isEmpty) {
                              return 'Please enter your email';
                            }

                            if (!value.contains('@')) {
                              return 'Please enter a valid email';
                            }

                            return null;
                          },
                        ),

                        const SizedBox(height: 20),

                        // ==================================================
                        // PASSWORD LABEL
                        // ==================================================

                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Password',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        const SizedBox(height: 8),

                        // PASSWORD FIELD


                        TextFormField(
                          controller: passwordController,

                          obscureText:
                              _isPasswordHidden,

                          decoration: InputDecoration(
                            hintText:
                                'Enter your password',

                            prefixIcon: const Icon(
                              Icons.lock_outline,
                              color: Color(0xFF9CA3AF),
                            ),

                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordHidden
                                    ? Icons
                                        .visibility_outlined
                                    : Icons
                                        .visibility_off_outlined,

                                color:
                                    const Color(0xFF6B7280),
                              ),

                              onPressed: () {
                                setState(() {
                                  _isPasswordHidden =
                                      !_isPasswordHidden;
                                });
                              },
                            ),

                            filled: true,

                            fillColor:
                                const Color(0xFFF9FAFB),

                            border:
                                OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(12),

                              borderSide: BorderSide.none,
                            ),

                            enabledBorder:
                                OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(12),

                              borderSide:
                                  const BorderSide(
                                color: Color(0xFFE5E7EB),
                              ),
                            ),

                            focusedBorder:
                                OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(12),

                              borderSide:
                                  const BorderSide(
                                color: Color(0xFF10B981),
                                width: 2,
                              ),
                            ),
                          ),

                          validator: (value) {
                            if (value == null ||
                                value.isEmpty) {
                              return 'Please enter your password';
                            }

                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }

                            return null;
                          },
                        ),

                        // ==================================================
                        // FORGOT PASSWORD
                        // ==================================================

                        Align(
                          alignment: Alignment.centerRight,

                          child: TextButton(
                            onPressed: () {
                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Forgot Password clicked',
                                  ),
                                ),
                              );
                            },

                            child: const Text(
                              'Forgot Password?',

                              style: TextStyle(
                                color: Color(0xFFEC4899),
                                fontWeight:
                                    FontWeight.w600,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 8),


                        // LOGIN BUTTON
  

                        SizedBox(
                          width: double.infinity,
                          height: 52,

                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!
                                  .validate()) {
                                ScaffoldMessenger.of(
                                  context,
                                ).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Login successful!',
                                    ),
                                  ),
                                );
                              }
                            },

                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xFF10B981),

                              foregroundColor:
                                  Colors.white,

                              elevation: 3,

                              shape:
                                  RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(12),
                              ),
                            ),

                            child: const Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 25),

                        // OR CONTINUE WITH

                        Row(
                          children: [
                            const Expanded(
                              child: Divider(),
                            ),

                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),

                              child: Text(
                                'or continue with',

                                style: TextStyle(
                                  color:
                                      Colors.grey[600],
                                ),
                              ),
                            ),

                            const Expanded(
                              child: Divider(),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // GOOGLE + FACEBOOK BUTTONS
                        

                        Row(
                          children: [

                            // GOOGLE
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(
                                    context,
                                  ).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Google Login clicked',
                                      ),
                                    ),
                                  );
                                },

                                style:
                                    OutlinedButton.styleFrom(
                                  minimumSize:
                                      const Size(
                                    0,
                                    50,
                                  ),

                                  side:
                                      const BorderSide(
                                    color:
                                        Color(0xFFE5E7EB),
                                  ),

                                  shape:
                                      RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(
                                      12,
                                    ),
                                  ),
                                ),

                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,

                                  children: [
                                    Container(
                                      width: 28,
                                      height: 28,

                                      decoration:
                                          const BoxDecoration(
                                        shape:
                                            BoxShape.circle,

                                        color:
                                            Color(0xFFF3F4F6),
                                      ),

                                      child:
                                          const Center(
                                        child: Text(
                                          'G',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight:
                                                FontWeight.bold,
                                            color:
                                                Color(0xFF4285F4),
                                          ),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(
                                      width: 8,
                                    ),

                                    const Text(
                                      'Google',
                                      style: TextStyle(
                                        color:
                                            Color(0xFF374151),
                                        fontWeight:
                                            FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(width: 15),

                            // FACEBOOK
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(
                                    context,
                                  ).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Facebook Login clicked',
                                      ),
                                    ),
                                  );
                                },

                                style:
                                    OutlinedButton.styleFrom(
                                  minimumSize:
                                      const Size(
                                    0,
                                    50,
                                  ),

                                  side:
                                      const BorderSide(
                                    color:
                                        Color(0xFFE5E7EB),
                                  ),

                                  shape:
                                      RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(
                                      12,
                                    ),
                                  ),
                                ),

                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,

                                  children: [
                                    Container(
                                      width: 28,
                                      height: 28,

                                      decoration:
                                          const BoxDecoration(
                                        shape:
                                            BoxShape.circle,

                                        color:
                                            Color(0xFF1877F2),
                                      ),

                                      child:
                                          const Center(
                                        child: Text(
                                          'f',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight:
                                                FontWeight.bold,
                                            color:
                                                Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(
                                      width: 8,
                                    ),

                                    const Text(
                                      'Facebook',
                                      style: TextStyle(
                                        color:
                                            Color(0xFF374151),
                                        fontWeight:
                                            FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 25),

                        // CREATE ACCOUNT

                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.center,

                          children: [
                            const Text(
                              "Don't have an account? ",
                              style: TextStyle(
                                color: Color(0xFF4B5563),
                              ),
                            ),

                            TextButton(
                              onPressed: () {
                                ScaffoldMessenger.of(
                                  context,
                                ).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Create Account clicked',
                                    ),
                                  ),
                                );
                              },

                              child: const Text(
                                'Create Account',

                                style: TextStyle(
                                  color: Color(0xFFEC4899),
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}