import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnswerScreen extends StatelessWidget {
  final AnswerItem answerItem;

  const AnswerScreen({super.key, required this.answerItem});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F6F6),
        appBar: AppBar(
          backgroundColor: const Color(0xFFF6F6F6),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Color(0xFF339D44),
              size: 24,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            "Answer",
            style: GoogleFonts.raleway(
              fontSize: 23.33,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF292929),
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// User Info + Question
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundImage: AssetImage(answerItem.userImage),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          answerItem.userName,
                          style: GoogleFonts.raleway(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF292929),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          answerItem.questionText,
                          style: GoogleFonts.raleway(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF292929),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              /// Answer TextField
              TextField(
                controller: _controller,
                maxLines: 5,
                style: GoogleFonts.raleway(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: const Color(0xFF292929),
                ),
                decoration: InputDecoration(
                  hintText: "Enter your answer",
                  hintStyle: GoogleFonts.raleway(
                    color: const Color(0xFFB4B4B4),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1),
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
                ),
              ),

              const SizedBox(height: 380),

              /// Send Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF339D44),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    String answer = _controller.text.trim();
                    if (answer.isNotEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Answer Sent: $answer")),
                      );
                    }
                  },
                  child: Text(
                    "Send",
                    style: GoogleFonts.raleway(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Model Class
class AnswerItem {
  final String userName;
  final String userImage;
  final String questionText;

  AnswerItem({
    required this.userName,
    required this.userImage,
    required this.questionText,
  });
}
