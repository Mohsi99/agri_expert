import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UploadImageField extends StatefulWidget {
  final String label;
  final TextEditingController controller;

  const UploadImageField({
    super.key,
    required this.label,
    required this.controller,
  });

  @override
  State<UploadImageField> createState() => _UploadImageFieldState();
}

class _UploadImageFieldState extends State<UploadImageField> {
  bool isUploading = false;
  File? _imageFile;

  Future<void> _pickAndUploadImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage == null) return;

    setState(() => isUploading = true);
    _imageFile = File(pickedImage.path);

    try {
      final fileName =
          '${DateTime.now().millisecondsSinceEpoch}_${pickedImage.name}';
      await Supabase.instance.client.storage.from('user_images').upload(
          fileName, _imageFile!,
          fileOptions: const FileOptions(upsert: true));

      final publicUrl = Supabase.instance.client.storage
          .from('user_images')
          .getPublicUrl(fileName);

      widget.controller.text = publicUrl;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Image uploaded successfully")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Upload failed: $e")),
      );
    } finally {
      setState(() => isUploading = false);
    }
  }

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
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
        ),
        child: TextField(
          controller: widget.controller,
          readOnly: true,
          style: GoogleFonts.raleway(
            fontWeight: FontWeight.w500,
            fontSize: 13.33,
            color: const Color(0xFF292929),
          ),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
            hintText: widget.label,
            hintStyle: GoogleFonts.raleway(
              color: const Color(0xFFB4B4B4),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            border: InputBorder.none,
            suffixIcon: isUploading
                ? const Padding(
                    padding: EdgeInsets.all(14.0),
                    child: SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Color(0xFF339D44),
                      ),
                    ),
                  )
                : InkWell(
                    onTap: _pickAndUploadImage,
                    child: Padding(
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
      ),
    );
  }
}
