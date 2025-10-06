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
      final fileName = '${DateTime.now().millisecondsSinceEpoch}_${pickedImage.name}';
      await Supabase.instance.client.storage
          .from('user_images')
          .upload(fileName, _imageFile!, fileOptions: const FileOptions(upsert: true));

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
      color: const Color(0xFFB4B4B4),
      strokeWidth: 1.2,
      dashPattern: const [6, 3],
      borderType: BorderType.RRect,
      radius: const Radius.circular(10),
      child: InkWell(
        onTap: isUploading ? null : _pickAndUploadImage,
        child: Container(
          height: 160,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xFFF8F9FB),
            borderRadius: BorderRadius.circular(10),
          ),
          child: isUploading
              ? const CircularProgressIndicator(color: Color(0xFF339D44))
              : _imageFile != null
              ? ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.file(
              _imageFile!,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 160,
            ),
          )
              : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.cloud_upload_outlined, size: 36, color: Color(0xFF339D44)),
              const SizedBox(height: 10),
              Text(
                widget.label,
                style: GoogleFonts.raleway(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF292929),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}