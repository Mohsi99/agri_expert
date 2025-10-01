import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchQuestionsScreen extends StatefulWidget {
  const SearchQuestionsScreen({super.key});

  @override
  State<SearchQuestionsScreen> createState() => _SearchQuestionsScreenState();
}

class _SearchQuestionsScreenState extends State<SearchQuestionsScreen> {
  final TextEditingController _searchController = TextEditingController();

  // Dummy Questions List (replace with backend later)
  final List<QuestionSearchItem> allQuestions = [
    QuestionSearchItem(
      userName: "Muhammad Ali Nizami",
      userImage: "assets/images/Ellipse 7.png",
      questionText:
          "What is the process of purchasing Vehicle from hardware store?",
    ),
    QuestionSearchItem(
      userName: "Masab Mehmood",
      userImage: "assets/images/Ellipse 7 (1).png",
      questionText:
          "What is the process of purchasing Vehicle from hardware store?",
    ),
  ];

  String query = "";

  @override
  Widget build(BuildContext context) {
    List<QuestionSearchItem> filtered = allQuestions
        .where(
            (q) => q.questionText.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(

        backgroundColor: const Color(0xFFF6F6F6),
        automaticallyImplyLeading: false,
        title: Text(
          "Questions",
          style: GoogleFonts.raleway(
            fontSize: 23.33,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF292929),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.close, size: 24, color: Color(0xFF339D44)),
            ),
          )
        ],
      ),
      backgroundColor: const Color(0xFFF6F6F6),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _searchController,
              onChanged: (val) {
                setState(() {
                  query = val;
                });
              },
              style: GoogleFonts.raleway(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: const Color(0xFF292929),
              ),
              decoration: InputDecoration(
                hintText: "Search Questions",
                hintStyle: GoogleFonts.raleway(
                  color: const Color(0xFFB4B4B4),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
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
            const SizedBox(height: 20),

            /// Questions List
            if (filtered.isEmpty)
              Expanded(
                child: Center(
                  child: Text(
                    "No Search Results Found",
                    style: GoogleFonts.raleway(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFFB4B4B4),
                    ),
                  ),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final q = filtered[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 18.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage(q.userImage),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  q.userName,
                                  style: GoogleFonts.raleway(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF292929),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  q.questionText,
                                  style: GoogleFonts.raleway(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF292929),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "Answer",
                            style: GoogleFonts.raleway(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF339D44),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Model Class
class QuestionSearchItem {
  final String userName;
  final String userImage;
  final String questionText;

  QuestionSearchItem({
    required this.userName,
    required this.userImage,
    required this.questionText,
  });
}
