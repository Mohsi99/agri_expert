import 'package:agri_expert/trending_videos/comment_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

import '../../models/video_model.dart';

class VideoCard extends StatefulWidget {
  final VideoModel video;

  const VideoCard({
    super.key,
    required this.video,
  });

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  late VideoPlayerController _videoController;
  late ChewieController _chewieController;

  @override
  void initState() {
    _videoController =
        VideoPlayerController.networkUrl(Uri.parse(widget.video.videoUrl))
          ..initialize().then((_) {
            _chewieController = ChewieController(
              videoPlayerController: _videoController,
              autoPlay: false,
              looping: false,
            );
            setState(() {});
          });
    super.initState();
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Title + More Icon
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  widget.video.title,
                  style: GoogleFonts.raleway(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF292929),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Icon(
                Icons.more_vert,
                size: 24,
                color: Color(0xFF292929),
              ),
            ],
          ),
        ),

        /// Uploaded Date
        Text(
          "Upload Date: 232",
          style: GoogleFonts.raleway(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),

        const SizedBox(height: 14),

        /// Thumbnail
        Center(
          child: _videoController.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _videoController.value.aspectRatio,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child:  Chewie(controller: _chewieController),),
                )
              : SizedBox(
                  height: 200,
                  child: Center(child: CircularProgressIndicator())),
        ),

        const SizedBox(height: 13),

        /// Views & Comments Row
        Row(
          children: [
            /// Views
            Row(
              children: [
                ImageIcon(
                    AssetImage("assets/icons/ant-design_eye-outlined.png"),
                    size: 18,
                    color: Color(0xffB4B4B4)),
                const SizedBox(width: 4),
                Text(
                  "0 Views",
                  style: GoogleFonts.raleway(
                    fontSize: 9,
                    fontWeight: FontWeight.w400,
                    color: Color(0xffB4B4B4),
                  ),
                ),
              ],
            ),

            const SizedBox(width: 20),

            /// Comments
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CommentsView(videoTitle: widget.video.title),
                    ));
              },
              child: Row(
                children: [
                  ImageIcon(AssetImage("assets/icons/akar-icons_comment.png"),
                      size: 18, color: Color(0xffB4B4B4)),
                  const SizedBox(width: 4),
                  Text(
                    "0 Comments",
                    style: GoogleFonts.raleway(
                      fontSize: 9,
                      fontWeight: FontWeight.w400,
                      color: Color(0xffB4B4B4),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),
      ],
    );
  }
}
