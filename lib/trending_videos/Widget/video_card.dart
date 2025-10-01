import 'package:agri_expert/trending_videos/comment_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VideoCard extends StatelessWidget {
  final String title;
  final String thumbnail;
  final String uploadedDate;
  final String views;
  final String comments;

  const VideoCard({
    super.key,
    required this.title,
    required this.thumbnail,
    required this.uploadedDate,
    required this.views,
    required this.comments,
  });

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
                  title,
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
          "Upload Date: $uploadedDate",
          style: GoogleFonts.raleway(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),

        const SizedBox(height: 14),

        /// Thumbnail
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            thumbnail,
            height: 180,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
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
                  "$views Views",
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
                      builder: (context) => CommentsView(videoTitle: title),
                    ));
              },
              child: Row(
                children: [
                  ImageIcon(AssetImage("assets/icons/akar-icons_comment.png"),
                      size: 18, color: Color(0xffB4B4B4)),
                  const SizedBox(width: 4),
                  Text(
                    "$comments Comments",
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
