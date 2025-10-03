import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'login_view.dart';
import 'widgets/upload_field.dart';

class PersonalDetailsScreen extends StatefulWidget {
  final String uid;
  const PersonalDetailsScreen({super.key, required this.uid});

  @override
  State<PersonalDetailsScreen> createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
  final TextEditingController profileImageUrlController = TextEditingController();
  final TextEditingController qualificationController = TextEditingController();
  final TextEditingController degreeImageUrlController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  String? expertise;

  Future<void> _saveDetails() async {
    try {
      await FirebaseFirestore.instance.collection("users").doc(widget.uid).update({
        "profileImageUrl": profileImageUrlController.text.trim(),
        "qualification": qualificationController.text.trim(),
        "degreeImageUrl": degreeImageUrlController.text.trim(),
        "address": addressController.text.trim(),
        "contact": contactController.text.trim(),
        "expertise": expertise ?? "",
      });

      _showSuccessDialog(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error saving details: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F6FB),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Personal Details",
                style: GoogleFonts.raleway(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),

              UploadField(
                label: "Profile Image URL",
                controller: profileImageUrlController,
              ),
              const SizedBox(height: 24),

              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: "Choose Expertise",
                  border: OutlineInputBorder(),
                ),
                items: ["Flutter", "React", "UI/UX", "Backend"].map((e) {
                  return DropdownMenuItem(value: e, child: Text(e));
                }).toList(),
                onChanged: (val) => setState(() => expertise = val),
              ),
              const SizedBox(height: 24),

              _buildTextField("Qualification", qualificationController),
              const SizedBox(height: 24),

              UploadField(
                label: "Degree Image URL",
                controller: degreeImageUrlController,
              ),
              const SizedBox(height: 24),

              _buildTextField("Address", addressController),
              const SizedBox(height: 24),

              _buildTextField("Contact", contactController),
              const SizedBox(height: 37),

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
                  onPressed: _saveDetails,
                  child: const Text("Save"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text("Account Created"),
        content: const Text("You can now log in with your account."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
            },
            child: const Text("Login"),
          ),
        ],
      ),
    );
  }
}