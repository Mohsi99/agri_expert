import 'package:agri_expert/auth/widgets/upload_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PersonalDetailsScreen extends StatelessWidget {
  const PersonalDetailsScreen({super.key});

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
                  color: const Color(0xFF292929),
                ),
              ),
              const SizedBox(height: 7),
              Text(
                "Enter your personal details",
                style: GoogleFonts.raleway(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFFB4B4B4),
                ),
              ),
              const SizedBox(height: 30),

              // Upload Profile Image
              UploadField(label: "Upload Profile Image"),
              const SizedBox(height: 24),

              // Dropdown Choose Expertise
              _buildDropdownField(
                  "Choose Expertise", ["Flutter", "React", "UI/UX", "Backend"]),
              const SizedBox(height: 24),

              // Qualification
              _buildTextField("Qualification"),
              const SizedBox(height: 24),

              // Upload Latest Degree Image
              UploadField(label: "Upload Profile Image"),
              const SizedBox(height: 24),

              // Address
              _buildTextField(
                "Address",
              ),
              const SizedBox(height: 24),

              // Contact
              _buildTextField("Contact"),
              const SizedBox(height: 37),

              // Next Button
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
                    showDialog(
                      context: context,
                      barrierDismissible: false, // user must tap Login
                      builder: (context) {
                        return Dialog(
                          backgroundColor: const Color(0xffFFFFFF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  "assets/icons/ic_baseline-done-all.png",
                                  // ✅ your tick icon
                                  height: 48,
                                  color: const Color(0xFF339D44),
                                ),
                                const SizedBox(height: 34),
                                Text(
                                  "Account Created",
                                  style: GoogleFonts.raleway(
                                    fontSize: 23.33,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF292929),
                                  ),
                                ),
                                const SizedBox(height: 9),
                                Text(
                                  "You can now access your account",
                                  style: GoogleFonts.raleway(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFFB4B4B4),
                                  ),
                                  textAlign: TextAlign.center,
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
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "Login",
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
                        );
                      },
                    );
                  },
                  child: Text(
                    "Next",
                    style: GoogleFonts.raleway(
                      color: const Color(0xffF4F6FB),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 19),

              // Back Button
              GestureDetector(
                onTap: () {},
                child: Text(
                  "Back",
                  style: GoogleFonts.raleway(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF292929),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Normal Text Field
  Widget _buildTextField(String label) {
    return TextField(
      style: GoogleFonts.raleway(
        fontWeight: FontWeight.w500,
        fontSize: 13.33,
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
    );
  }

  // Upload Field (with icon)
  Widget _buildUploadField(String label) {
    return TextField(
      readOnly: true,
      style: GoogleFonts.raleway(
        fontWeight: FontWeight.w500,
        fontSize: 13.33,
        color: const Color(0xFF292929),
      ),
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Image.asset("assets/icons/Group (2).png",
              height: 24), // your upload icon
        ),
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
    );
  }

  // Dropdown Field
  Widget _buildDropdownField(String label, List<String> items) {
    return DropdownButtonFormField<String>(
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
      items: items.map((e) {
        return DropdownMenuItem(
            value: e,
            child: Text(
              e,
              style: GoogleFonts.raleway(
                fontWeight: FontWeight.w500,
                fontSize: 13.33,
                color: const Color(0xFF292929),
              ),
            ));
      }).toList(),
      onChanged: (value) {},
    );
  }
}
