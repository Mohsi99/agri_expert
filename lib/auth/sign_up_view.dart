import 'package:agri_expert/auth/personal_details_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../provider/user_provider.dart';
import '../models/user_model.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool _loading = false;

  Future<void> _signUp(BuildContext context) async {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }

    setState(() => _loading = true);

    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      await userProvider.signUp(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      UserModel? createdUser = userProvider.user;
      if (createdUser != null && mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => PersonalDetailsScreen(uid: createdUser.docId),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("User creation failed")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      setState(() => _loading = false);
    }
  }

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
                  decoration: const BoxDecoration(
                    color: Color(0xffF4F6FB),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 45),
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
                        const SizedBox(height: 24),
                        _buildTextField("Name", false, controller: nameController),
                        const SizedBox(height: 16),
                        _buildTextField("Email", false, controller: emailController),
                        const SizedBox(height: 16),
                        _buildTextField("Password", true, controller: passwordController),
                        const SizedBox(height: 16),
                        _buildTextField("Confirm Password", true, controller: confirmPasswordController),
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
                            onPressed: _loading ? null : () => _signUp(context),
                            child: _loading
                                ? const CircularProgressIndicator(color: Colors.white)
                                : Text(
                              "Next",
                              style: GoogleFonts.raleway(
                                color: const Color(0xffF4F6FB),
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
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

  Widget _buildTextField(String label, bool isPassword,
      {required TextEditingController controller}) {
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