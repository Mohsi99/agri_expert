import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dotted_border/dotted_border.dart';

class UploadField extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const UploadField({
    super.key,
    required this.label,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: const Color(0xFF339D44),
      strokeWidth: 1.2,
      borderType: BorderType.RRect,
      radius: const Radius.circular(8),
      dashPattern: const [6, 4],
      child: Container(
        height: 60,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: TextField(
          controller: controller,
          style: GoogleFonts.raleway(
            fontWeight: FontWeight.w500,
            fontSize: 13.33,
            color: const Color(0xFF292929),
          ),
          decoration: InputDecoration(
            hintText: label,
            hintStyle: GoogleFonts.raleway(
              color: const Color(0xFFB4B4B4),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            border: InputBorder.none,
            suffixIcon: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Image.asset(
                "assets/icons/Group (2).png",
                height: 20,
                color: const Color(0xFF339D44),
              ),
            ),
          ),
        ),
      ),
    );
  }
}