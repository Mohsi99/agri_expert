import 'package:agri_expert/auth/login_view.dart';
import 'package:agri_expert/auth/personal_details_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F6FB),
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: 250,
              width: double.infinity,
              child: Image.asset(
                "assets/images/Rectangle 9 (1).png",
                fit: BoxFit.cover,
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 104),
                child: Container(
                  margin: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    color: const Color(0xffF4F6FB),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 45),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Create Account",
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
                        const SizedBox(height: 24),
                        _buildTextField("Muhammad Wajahat", false),
                        const SizedBox(height: 16),
                        _buildTextField("Email", false),
                        const SizedBox(height: 16),
                        _buildTextField("Password", true),
                        const SizedBox(height: 16),
                        _buildTextField("Confirm Password", true),
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
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => PersonalDetailsScreen(),));
                            },
                            child: Text(
                              "Next",
                              style: GoogleFonts.raleway(
                                color: Color(0xffF4F6FB),
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 23),

                              Text(
                                "Already have an account?",
                                style: GoogleFonts.raleway(
                                  fontSize: 13.33,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF292929),
                                ),
                              ),
                              SizedBox(height: 20,),

                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
                                },
                                child: Text(
                                  "Login",
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
        fontSize: 13.33,
        color: const Color(0xFF292929),
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.raleway(
          color: const Color(0xFFB4B4B4), // floating label color
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
  }}
