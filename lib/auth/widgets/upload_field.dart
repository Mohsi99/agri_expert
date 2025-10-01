import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';   // ✅ for ImagePicker & ImageSource
import 'package:dotted_border/dotted_border.dart'; // ✅ for DottedBorder & BorderType


class UploadField extends StatefulWidget {
  final String label;

  const UploadField({super.key, required this.label});

  @override
  State<UploadField> createState() => _UploadFieldState();
}

class _UploadFieldState extends State<UploadField> {
  File? _image;
  final ImagePicker _picker = ImagePicker(); // ✅ create instance

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery, // change to ImageSource.camera if needed
    );

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: DottedBorder(
        color: const Color(0xFF339D44),
        strokeWidth: 1.2,
        borderType: BorderType.RRect,
        radius: const Radius.circular(8),
        dashPattern: const [6, 4],
        child: Container(
          height: 60,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _image == null
                  ? Text(
                widget.label,
                style: GoogleFonts.raleway(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF292929),
                ),
              )
                  : Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: FileImage(_image!),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "Image Selected",
                    style: GoogleFonts.raleway(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF292929),
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: _pickImage,
                icon: Image.asset(
                  "assets/icons/Group (2).png",
                  height: 22,
                  color: const Color(0xFF339D44),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}