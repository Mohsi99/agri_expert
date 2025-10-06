import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../provider/user_provider.dart';
import '../services/user_services.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  String? selectedImagePath;
  bool isUploading = false;

  @override
  void initState() {
    super.initState();
    final user = Provider.of<UserProvider>(context, listen: false).user;
    nameController = TextEditingController(text: user?.name ?? "");
    emailController = TextEditingController(text: user?.email ?? "");
    selectedImagePath = user?.profileImageUrl;
  }

  Future<void> _pickImage(ImageSource source, UserProvider userProvider) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: source);
    if (picked == null) return;
    setState(() => isUploading = true);
    final file = File(picked.path);
    try {
      final fileName = '${DateTime.now().millisecondsSinceEpoch}_${picked.name}';
      await Supabase.instance.client.storage.from('user_images').upload(fileName, file);
      final publicUrl = Supabase.instance.client.storage.from('user_images').getPublicUrl(fileName);
      final updatedUser = userProvider.user!.copyWith(profileImageUrl: publicUrl);
      await UserServices().updateUser(updatedUser);
      userProvider.setUser(updatedUser);
      setState(() => selectedImagePath = publicUrl);
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Upload failed: $e")));
    } finally {
      setState(() => isUploading = false);
    }
  }

  void _showImageOptionsSheet(UserProvider userProvider) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Choose Image",
                  style: GoogleFonts.raleway(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF292929),
                  )),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => _pickImage(ImageSource.camera, userProvider),
                    child: Column(
                      children: const [
                        Icon(Icons.camera_alt, size: 40, color: Color(0xFF339D44)),
                        SizedBox(height: 8),
                        Text("Camera", style: TextStyle(color: Color(0xFF292929))),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _pickImage(ImageSource.gallery, userProvider),
                    child: Column(
                      children: const [
                        Icon(Icons.photo_library, size: 40, color: Color(0xFF339D44)),
                        SizedBox(height: 8),
                        Text("Gallery", style: TextStyle(color: Color(0xFF292929))),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  ImageProvider getImageProvider(String? path) {
    if (path == null || path.isEmpty) {
      return const AssetImage("assets/images/Ellipse 7.png");
    } else if (path.startsWith("http")) {
      return NetworkImage(path);
    } else {
      return FileImage(File(path));
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xff339D44)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Edit Profile",
            style: GoogleFonts.raleway(
              fontSize: 23,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF292929),
            )),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: getImageProvider(selectedImagePath),
                ),
                Positioned(
                  bottom: 2,
                  right: 4,
                  child: GestureDetector(
                    onTap: () => _showImageOptionsSheet(userProvider),
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xff339D44),
                      ),
                      child: const Icon(Icons.edit, color: Colors.white, size: 18),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            _buildTextField(controller: nameController, label: "Name", isPassword: false, enabled: true),
            const SizedBox(height: 18),
            _buildTextField(controller: emailController, label: "Email", isPassword: false, enabled: false),
            const SizedBox(height: 200),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF339D44),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () async {
                  final updatedUser = userProvider.user?.copyWith(
                    name: nameController.text,
                    profileImageUrl: selectedImagePath,
                  );
                  if (updatedUser != null) {
                    await UserServices().updateUser(updatedUser);
                    userProvider.setUser(updatedUser);
                    Navigator.pop(context);
                  }
                },
                child: isUploading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text("Save Changes",
                    style: GoogleFonts.raleway(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required bool isPassword,
    required bool enabled,
  }) {
    return TextField(
      controller: controller,
      enabled: enabled,
      obscureText: isPassword,
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
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
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