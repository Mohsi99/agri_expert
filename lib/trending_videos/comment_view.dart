import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../questions/widgets/Custom TabBar.dart';
import 'Widget/comment_card.dart';

class CommentsView extends StatelessWidget {
  final String videoTitle;

  const CommentsView({super.key, required this.videoTitle});

  @override
  Widget build(BuildContext context) {
    /// Dummy Comments
    final List<CommentModel> comments = [
      CommentModel(
        date: "11/10/2021",
        userName: "Masab Mehmood",
        userImage: "assets/images/Ellipse 7.png",
        comment:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elitPulvinar ante id netus sit congue justo.Pulvinar ante id netus sit congue justo..",
      ),
      CommentModel(
        date: "11/10/2021",

        userName: "Gusti Ilham Tauhid",
        userImage: "assets/images/Ellipse 7 (1).png",
        comment:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elitPulvinar ante id netus sit congue justo.Pulvinar ante id netus sit congue justo..",
      ),
      CommentModel(
        date: "11/10/2021",

        userName: "Dazzy",
        userImage: "assets/images/Ellipse 7.png",
        comment:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elitPulvinar ante id netus sit congue justo.Pulvinar ante id netus sit congue justo..",
      ),
      CommentModel(
        date: "11/10/2021",

        userName: "Gusti Ilham Tauhid",
        userImage: "assets/images/Ellipse 7.png",
        comment:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elitPulvinar ante id netus sit congue justo.Pulvinar ante id netus sit congue justo..",
      ),
      CommentModel(
        date: "11/10/2021",

        userName: "Masab Mehmood",
        userImage: "assets/images/Ellipse 7 (1).png",
        comment:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elitPulvinar ante id netus sit congue justo.Pulvinar ante id netus sit congue justo..",
      ),
      CommentModel(
        date: "11/10/2021",

        userName: "Dazzy",
        userImage: "assets/images/Ellipse 7.png",
        comment:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elitPulvinar ante id netus sit congue justo.Pulvinar ante id netus sit congue justo..",
      ),
      CommentModel(
        date: "11/10/2021",

        userName: "Masab Mehmood",
        userImage: "assets/images/Ellipse 7 (1).png",
        comment:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elitPulvinar ante id netus sit congue justo.Pulvinar ante id netus sit congue justo..",
      ),




    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xff339D44)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Text(
              "Comments",
              style: GoogleFonts.raleway(
                fontSize: 23,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF292929),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "(23)",
              style: GoogleFonts.raleway(
                fontSize: 23,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF339D44),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// TabBar
              CustomTabBar(
                tabs: ["All", "Most Recent","Recent"],
                onTabSelected: (index) {
                  print("Selected Comment Tab: $index");
                },
              ),
              const SizedBox(height: 30),
        
              /// Rich Text (Video Title)
              RichText(
                text: TextSpan(
                  style: GoogleFonts.raleway(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF292929),
                  ),
                  children: [
                    const TextSpan(
                      text: "Video : ",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, color: Color(0xff339D44)),
                    ),
                    TextSpan(
                      text: videoTitle,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
        
              /// Comments List
              ListView.builder(
                shrinkWrap: true,
        
                physics: NeverScrollableScrollPhysics(),
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  return CommentCard(comment: comments[index]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CommentModel {
  final String userName;
  final String userImage;
  final String comment;
  final String date;

  CommentModel({
    required this.userName,
    required this.userImage,
    required this.comment,
    required this.date,
  });
}
