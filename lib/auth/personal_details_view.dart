import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../provider/user_provider.dart';
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
  final TextEditingController experienceController = TextEditingController();

  final _formKey = GlobalKey<FormState>();  // Form key for validation

  @override
  void initState() {
    super.initState();
    final user = Provider.of<UserProvider>(context, listen: false).user;
    if (user != null) {
      profileImageUrlController.text = user.profileImageUrl;
      qualificationController.text = user.qualification;
      degreeImageUrlController.text = user.degreeImageUrl;
      addressController.text = user.address;
      contactController.text = user.contact;
      experienceController.text = user.experience;
    }
  }

  Future<void> _saveDetails() async {
    if (!_formKey.currentState!.validate()) return;

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;
    if (user == null) return;

    final updatedUser = user.copyWith(
      profileImageUrl: profileImageUrlController.text.trim(),
      qualification: qualificationController.text.trim(),
      degreeImageUrl: degreeImageUrlController.text.trim(),
      address: addressController.text.trim(),
      contact: contactController.text.trim(),
      experience: experienceController.text.trim(),
    );

    try {
      await userProvider.updateUser(updatedUser);
      if (mounted) _showSuccessDialog(context);
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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Personal Details",
                  style: GoogleFonts.raleway(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF292929),
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  "Enter your personal details",
                  style: GoogleFonts.raleway(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFFB4B4B4),
                  ),
                ),
                const SizedBox(height: 30),

                UploadImageField(
                  label: "Profile Image URL",
                  controller: profileImageUrlController,
                ),
                const SizedBox(height: 20),
                _buildTextField("Qualification", qualificationController, isRequired: true),
                const SizedBox(height: 20),
                UploadImageField(
                  label: "Degree Image URL",
                  controller: degreeImageUrlController,
                ),
                const SizedBox(height: 20),
                _buildTextField("Experience", experienceController, isRequired: true),
                const SizedBox(height: 20),
                _buildTextField("Address", addressController, isRequired: true, maxLines: 6),
                const SizedBox(height: 20),
                _buildTextField("Contact", contactController, isRequired: true),
                const SizedBox(height: 80),
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
                    child: Text(
                      "Save Changes",
                      style: GoogleFonts.raleway(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {bool isRequired = false, int maxLines = 1}) {
    return SizedBox(
      height: 60,
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
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
        validator: (value) {
          if (isRequired && (value == null || value.isEmpty)) {
            return '$label is required';
          }
          return null;  // No validation error
        },
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text("Profile Updated"),
        content: const Text("Your profile details were saved successfully."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context); // Go back to ProfileView
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}