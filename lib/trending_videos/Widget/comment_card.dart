import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../comment_view.dart';

class CommentCard extends StatelessWidget {
  final CommentModel comment;

  const CommentCard({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Profile Image
          CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage(comment.userImage),
          ),
          const SizedBox(width: 12),

          /// Name + Comment Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  comment.userName,
                  style: GoogleFonts.raleway(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF292929),
                  ),
                ),
                Text(
                  comment.date,
                  style: GoogleFonts.raleway(
                    fontSize: 9,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFFB4B4B4),
                  ),
                ),
                const SizedBox(height: 4),

                Text(
                  comment.comment,
                  style: GoogleFonts.raleway(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF555555),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}