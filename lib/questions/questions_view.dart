import 'package:agri_expert/questions/search_questions_screen.dart';
import 'package:agri_expert/questions/widgets/Custom%20TabBar.dart';
import 'package:agri_expert/questions/widgets/QuestionCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  int selectedTab = 0;

  final List<String> tabs = ["All", "Pending", "Answered"];

  final List<QuestionItem> questions = [
    QuestionItem(
      userName: "Fareeha Sadaqat",
      userImage: "assets/images/Ellipse 7.png",
      timeAgo: "10 mins ago",
      questionText: "I have an issue regarding this vehicle",
      image: "assets/images/Rectangle 2.png",
    ),
    QuestionItem(
      userName: "Muhammad Ali Nizami",
      userImage: "assets/images/Ellipse 7 (1).png",
      timeAgo: "15 mins ago",
      questionText:
          "What is the process of purchasing Vehicle from hardware store?",
    ),
    QuestionItem(
      userName: "Masab Mehmood",
      userImage: "assets/images/Ellipse 7.png",
      timeAgo: "16 mins ago",
      questionText:
          "What is the process of purchasing Vehicle from hardware store?",
    ),
    QuestionItem(
      userName: "Muhammad Ali Nizami",
      userImage: "assets/images/Ellipse 7 (1).png",
      timeAgo: "20 mins ago",
      questionText:
          "What is the process of purchasing Vehicle from hardware store?",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        title: Text("Questions",
            style: GoogleFonts.raleway(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF292929),
            )),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchQuestionsScreen(),
                    ));
              },
              icon: Icon(CupertinoIcons.search,
                  size: 24, color: Color(0xff339D44)),
            ),
          )
        ],
      ),
      backgroundColor: const Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Tab Bar
            CustomTabBar(
              tabs: ["All", "Pending", "Answered"],
              onTabSelected: (index) {
                print("Selected Question Tab: $index");
              },
            ),
            const SizedBox(height: 25),

            /// List of Questions
            ListView.builder(
              itemCount: questions.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final q = questions[index];
                return QuestionCard(
                  userName: q.userName,
                  userImage: q.userImage,
                  timeAgo: q.timeAgo,
                  questionText: q.questionText,
                  image: q.image,
                  actionLabel: q.actionLabel,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class QuestionItem {
  final String userName;
  final String userImage;
  final String timeAgo;
  final String questionText;
  final String? image; // optional
  final String actionLabel;

  QuestionItem({
    required this.userName,
    required this.userImage,
    required this.timeAgo,
    required this.questionText,
    this.image,
    this.actionLabel = "Answer",
  });
}
