import 'package:agri_expert/questions/answer_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionCard extends StatelessWidget {
  final String userName;
  final String userImage;
  final String timeAgo;
  final String questionText;
  final String? image;
  final String actionLabel;

  const QuestionCard({
    super.key,
    required this.userName,
    required this.userImage,
    required this.timeAgo,
    required this.questionText,
    this.image,
    this.actionLabel = "Answer",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFFFFFF),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ListTile (User info + Action)
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage(userImage),
            ),
            title: Text(
              userName,
              style: GoogleFonts.raleway(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: Color(0xff292929),
              ),
            ),
            subtitle: Text(
              timeAgo,
              style: GoogleFonts.raleway(
                  fontSize: 9,
                  color: Color(0xffB4B4B4),
                  fontWeight: FontWeight.w400),
            ),
            trailing: TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AnswerScreen(
                          answerItem: AnswerItem(
                              userName: userName,
                              userImage: userImage,
                              questionText: questionText)),
                    ));
              },
              child: Text(
                actionLabel,
                style: GoogleFonts.raleway(
                  fontSize: 11.11,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff339D44),
                ),
              ),
            ),
          ),

          /// Question Text
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              questionText,
              style: GoogleFonts.raleway(
                fontSize: 13.33,
                fontWeight: FontWeight.w500,
                color: Color(0xff292929),
              ),
            ),
          ),

          /// Optional Image
          if (image != null) ...[
            const SizedBox(height: 15),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(image!),
            ),
          ],
        ],
      ),
    );
  }
}
