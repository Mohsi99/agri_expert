import 'dart:io';
import 'package:agri_expert/trending_videos/trending_videos_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import '../auth/widgets/upload_field.dart';
import '../provider/user_provider.dart';
import '../provider/video_provider.dart';
import 'Widget/upload_video_field.dart';

class AddVideoScreen extends StatefulWidget {
  const AddVideoScreen({super.key});

  @override
  State<AddVideoScreen> createState() => _AddVideoScreenState();
}

class _AddVideoScreenState extends State<AddVideoScreen> {
  final TextEditingController videoController = TextEditingController();
  final TextEditingController thumbnailController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  VideoPlayerController? _previewController;
  File? _videoFile;

  Widget _buildTextField(String label, TextEditingController controller,
      {double? height, int? maxLines}) {
    return SizedBox(
      height: height,
      child: TextField(
        controller: controller,
        maxLines: maxLines ?? 1,
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
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 12,
          ),
        ),
      ),
    );
  }

  // ✅ NEW: Method to handle video file selection
  void handleVideoSelected(File videoFile) {
    _videoFile = videoFile;
    _previewController?.dispose();
    _previewController = VideoPlayerController.file(_videoFile!)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _previewController?.dispose();
    videoController.dispose();
    thumbnailController.dispose();
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final videoProvider = Provider.of<VideoProvider>(context);

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
            const SizedBox(height: 20),
            // Video preview section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: SizedBox(
                height: 180,
                width: double.infinity,
                child: _previewController != null &&
                        _previewController!.value.isInitialized
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: AspectRatio(
                          aspectRatio: _previewController!.value.aspectRatio,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              VideoPlayer(_previewController!),
                              IconButton(
                                icon: Icon(
                                  _previewController!.value.isPlaying
                                      ? Icons.pause_circle_filled
                                      : Icons.play_circle_fill,
                                  color: Colors.white.withOpacity(0.9),
                                  size: 50,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _previewController!.value.isPlaying
                                        ? _previewController!.pause()
                                        : _previewController!.play();
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          "assets/images/Preview.png",
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                children: [
                  // ✅ UPDATED: Added onVideoSelected callback
                  UploadVideoField(
                    label: "Upload Video",
                    controller: videoController,
                    onVideoSelected: handleVideoSelected,
                  ),
                  const SizedBox(height: 20),
                  UploadImageField(
                    label: "Upload Thumbnail",
                    controller: thumbnailController,
                  ),
                  const SizedBox(height: 20),
                  _buildTextField("Title", titleController),
                  const SizedBox(height: 20),
                  _buildTextField(
                    "Description",
                    descriptionController,
                    height: 115,
                    maxLines: 5,
                  ),
                  const SizedBox(height: 30),
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
                      onPressed: () async {
                        final userProvider =
                            Provider.of<UserProvider>(context, listen: false);

                        if (userProvider.user == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("You must be logged in to upload."),
                            ),
                          );
                          return;
                        }

                        try {
                          await videoProvider.uploadVideo(
                            userId: userProvider.user!.docId,
                            title: titleController.text.trim(),
                            description: descriptionController.text.trim(),
                            thumbnailUrl: thumbnailController.text.trim(),
                            videoUrl: videoController.text.trim(),
                          );

                          if (!mounted) return;

                          showDialog(
                            context: context,
                            barrierDismissible: false,
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
                                        height: 48,
                                        color: const Color(0xFF339D44),
                                      ),
                                      const SizedBox(height: 34),
                                      Text(
                                        "Uploaded",
                                        style: GoogleFonts.raleway(
                                          fontSize: 23.33,
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xFF292929),
                                        ),
                                      ),
                                      const SizedBox(height: 9),
                                      Text(
                                        "Your video has been uploaded successfully.",
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
                                            backgroundColor:
                                                const Color(0xFF339D44),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const TrendingVideosScreen(),
                                              ),
                                            );
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
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Error: $e")),
                          );
                        }
                      },
                      child: videoProvider.isUploading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(
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
            ),
          ],
        ),
      ),
    );
  }
}
