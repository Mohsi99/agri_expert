import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../provider/user_provider.dart';
import 'forgot_password_screen.dart';
import 'sign_up_view.dart';
import '../BottomNavigationBarView/BottomNavigationBarView.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _loading = false;

  Future<void> _login() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      _showMessage("Please enter email & password");
      return;
    }

    setState(() {
      _loading = true;
    });

    try {
      await Provider.of<UserProvider>(context, listen: false).login(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Navigate to main app screen after login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const TabBarNavigationView()),
      );
    } catch (e) {
      _showMessage(e.toString());
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F6FB),
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: 483,
              width: double.infinity,
              child: Image.asset(
                "assets/images/Rectangle 9 (1).png",
                fit: BoxFit.cover,
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 250),
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xffF4F6FB),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome Again!",
                          style: GoogleFonts.raleway(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF292929),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Login to Access Your Account",
                          style: GoogleFonts.raleway(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFFB4B4B4),
                          ),
                        ),
                        const SizedBox(height: 30),

                        _buildTextField("Email", false, _emailController),
                        const SizedBox(height: 20),
                        _buildTextField("Password", true, _passwordController),
                        const SizedBox(height: 20),

                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const ForgotPasswordScreen(),
                                  ));
                            },
                            child: Text(
                              "Forgot Password?",
                              style: GoogleFonts.raleway(
                                fontSize: 13.33,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF339D44),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF339D44),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: _loading ? null : _login,
                            child: _loading
                                ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                                : Text(
                              "Login",
                              style: GoogleFonts.raleway(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 23),

                        Text(
                          "Don’t have an account?",
                          style: GoogleFonts.raleway(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF292929),
                          ),
                        ),
                        const SizedBox(height: 12),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const SignUpScreen(),
                                ));
                          },
                          child: Text(
                            "Sign Up",
                            style: GoogleFonts.raleway(
                              fontSize: 27,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF339D44),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label, bool isPassword, TextEditingController controller) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      style: GoogleFonts.raleway(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        color: const Color(0xFF292929),
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.raleway(
          color: const Color(0xFFB4B4B4),
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFB4B4B4)),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF339D44)),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}