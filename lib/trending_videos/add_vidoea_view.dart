import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../auth/widgets/upload_field.dart';

class AddVideoScreen extends StatelessWidget {
  const AddVideoScreen({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF339D44)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Add Video",
          style: GoogleFonts.raleway(
            fontSize: 23,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF292929),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Thumbnail preview container
            SizedBox(
                height: 180,
                width: double.infinity,
                child: Image.asset("assets/images/Preview.png")),
            const SizedBox(height: 30),

            /// Upload fields
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                children: [
                  Column(
                    children: [
                      const UploadField(label: "Upload Video"),
                      const SizedBox(height: 20),
                      const UploadField(label: "Upload Thumbnail"),
                      const SizedBox(height: 20),

                      /// Text fields
                      _buildTextField("Title"),
                      const SizedBox(height: 20),
                      _buildTextField(
                        "Description",
                      ),
                      const SizedBox(height: 110),

                      /// Post button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF339D44),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
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
                                          "Upoaded",
                                          style: GoogleFonts.raleway(
                                            fontSize: 23.33,
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xFF292929),
                                          ),
                                        ),
                                        const SizedBox(height: 9),
                                        Text(
                                          "Video uploaded",
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
                                              "View Videos",
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
                            "Post",
                            style: GoogleFonts.raleway(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
