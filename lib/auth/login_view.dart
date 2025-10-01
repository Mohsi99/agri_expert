import 'package:agri_expert/BottomNavigationBarView/BottomNavigationBarView.dart';
import 'package:agri_expert/auth/forgot_password_screen.dart';
import 'package:agri_expert/auth/sign_up_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F6FB),
      body: SafeArea(
        child: Stack(
          children: [
            // Top Image
            SizedBox(
              height: 483,
              width: double.infinity,
              child: Image.asset(
                "assets/images/Rectangle 9 (1).png", // replace with your asset
                fit: BoxFit.cover,
              ),
            ),

            // Foreground Content
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
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

                        // Email Field
                        _buildTextField("Email", false),
                        const SizedBox(height: 20),

                        // Password Field
                        _buildTextField("Password", true),
                        const SizedBox(height: 20),

                        // Forgot Password
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ForgotPasswordScreen(),
                                  ));
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: const Size(0, 0),
                            ),
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

                        // Login Button
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
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        TabBarNavigationView(),
                                  ));
                            },
                            child: Text(
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

                        // Sign Up Link
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
                                  builder: (context) => SignUpScreen(),
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

  Widget _buildTextField(String label, bool isPassword) {
    return TextField(
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
